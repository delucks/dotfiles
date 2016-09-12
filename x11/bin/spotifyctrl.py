#!/usr/bin/env python2
import dbus

'''
control the spotify desktop client via python-dbus
example:
    from spotifyctrl import SpotifyController
    sc = SpotifyController()
    sc.next()
'''
class SpotifyController(object):
    def __init__(self):
        self.bus = dbus.SessionBus()
        self.player = self.bus.get_object('org.mpris.MediaPlayer2.spotify', '/org/mpris/MediaPlayer2')
        self.properties_manager = dbus.Interface(self.player, 'org.freedesktop.DBus.Properties')

    def toggle(self):
        self.player.PlayPause()

    def stop(self):
        self.player.Stop()

    def previous(self):
        self.player.Previous()

    def next(self):
        self.player.Next()

    def stop(self):
        self.player.Stop()

    # the real meat
    def get_metadata(self):
        meta = self.properties_manager.Get('org.mpris.MediaPlayer2.Player', 'Metadata')
        meta['xesam:artist'] = meta['xesam:artist'][0] # remove the unnecessary array
        return meta

    # this is just for pretty-printing
    def now_playing(self):
        meta = self.get_metadata()
        return dict((k, v) for k, v in meta.iteritems() if ('album' in k or 'title' in k or 'artist' in k))

'''
interactive use
'''
def main():
    import argparse
    p = argparse.ArgumentParser(description='interact with spotify from python')
    p.add_argument('-t', '--toggle', action='store_true')
    p.add_argument('-n', '--next', action='store_true')
    p.add_argument('-p', '--previous', action='store_true')
    p.add_argument('-s', '--stop', action='store_true')
    p.add_argument('-m', '--dump-metadata', action='store_true')
    args = p.parse_args()
    sc = SpotifyController()
    if args.toggle:
        sc.toggle()
    elif args.next:
        sc.next()
    elif args.previous:
        sc.previous()
    elif args.stop:
        sc.stop()
    elif args.dump_metadata:
        meta = sc.get_metadata()
        for item in meta:
            print '{},{}'.format(item, meta[item])
    else:
        now = sc.now_playing()
        for item in now:
            print now[item]

if (__name__ == '__main__'):
    main()
