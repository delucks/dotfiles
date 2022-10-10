#!/usr/bin/env python
'''This uses subprocess to restart spotifyd and adjust Pulseaudio volume remotely'''
from http.server import HTTPServer, BaseHTTPRequestHandler
import subprocess


INDEX_HEAD = '''
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>spotifyd remote control</title>
  <meta name="description" content="spotifyd remote control">
  <meta name="author" content="delucks">
  <style>
  button {
    width: 100%;
    height: 300px;
    font-size: 30px;
  }
  </style>
</head>
'''

INDEX_PAGE = '''
<body>
  <h1>spotifyd Remote Control</h1>
  <p>{message}</p>
  <p>
    <form action="/restart" method="GET">
      <button>Restart <pre>spotifyd</pre></button>
    </form>
  </p>
  <p>
    <form action="/up" method="GET">
      <button>Increase volume 5%</button>
    </form>
  </p>
  <p>
    <form action="/down" method="GET">
      <button>Decrease volume 5%</button>
    </form>
  </p>
</body>
</html>
'''


def find_current_sink() -> str:
    p = subprocess.run(['pactl', 'list', 'short', 'sinks'], capture_output=True)
    sinks = p.stdout.decode('utf8').splitlines()
    target = [s for s in sinks if 'RUNNING' in s]
    if target:
        return target[0].split()[0]
    else:
        return sinks[-1].split()[0]


class SpotifydRequestHandler(BaseHTTPRequestHandler):
    def write_resp(self, message: str):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(bytes(INDEX_HEAD + INDEX_PAGE.format(message=message or ''), 'utf8'))

    def do_GET(self):
        path = self.path.rstrip('?')
        if path == '/restart':
            subprocess.run(['systemctl', '--user', 'restart', 'spotifyd'])
            self.write_resp('Restarted!')
        elif path in ['/up', '/down']:
            sink_id = find_current_sink()
            operation = '+5%' if path == '/up' else '-5%'
            subprocess.run(['pactl', '--', 'set-sink-volume', sink_id, operation])
            self.write_resp(f'Volume set {operation}')
        else:
            # index page
            self.write_resp('Welcome')


httpd = HTTPServer(('0.0.0.0', 9876), SpotifydRequestHandler)
httpd.serve_forever()
