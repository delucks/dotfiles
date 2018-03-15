# Consdensed config for ipython
c = get_config()
c.InteractiveShellApp.exec_lines = ['''rehashx''']
c.BaseIPythonApplication.profile = 'default'
c.TerminalIPythonApp.display_banner = True
c.InteractiveShell.autoindent = True
c.InteractiveShell.automagic = True
import sys
c.InteractiveShell.banner1 = '   _           __  __           \n  (_)__  __ __/ /_/ /  ___  ___ \n / / _ \/ // / __/ _ \/ _ \/ _ \ \n/_/ .__/\_, /\__/_//_/\___/_//_/\n /_/   /___/      Version {0}\n\n'.format(sys.version.split()[0])
c.InteractiveShell.color_info = True
c.InteractiveShell.colors = 'Linux'
c.InteractiveShell.separate_in = ''
c.InteractiveShell.separate_out = ''
c.InteractiveShell.separate_out2 = ''
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.editor = 'vim'
c.HistoryAccessor.enabled = True
c.IPCompleter.omit__names = 0
