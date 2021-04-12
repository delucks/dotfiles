;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "delucks"
      user-mail-address "ping@jamieluck.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default: (setq doom-theme 'doom-one)

;; The third option: change the color scheme depending on time of day
;; For dark themes: 'doom-challenger-deep 'doom-outrun-electric 'doom-horizon
(defun time-of-day-theme ()
  (let* ((light-theme 'doom-solarized-light)
         (dark-theme 'doom-horizon)
         (start-time-light-theme 6)
         (end-time-light-theme 18)
         (hour (string-to-number (substring (current-time-string) 11 13)))
         (next-theme (if (member hour (number-sequence start-time-light-theme end-time-light-theme))
                         light-theme dark-theme)))
    (when (not (equal doom-theme next-theme))
      (setq doom-theme next-theme)
      (load-theme next-theme))))

(run-with-timer 0 900 'time-of-day-theme)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.



;; Here's my vimrc's full plugin block. Let's see what's built in and what's needed

;; call plug#begin('~/.vim/plugins')
;; Plug 'fatih/vim-go', { 'for': 'go' }                  " enables gofmt on :w
;; Plug 'vim-airline/vim-airline'                        " draws buffers in tabline and colorizes the statusline
;; Plug 'ctrlpvim/ctrlp.vim'                             " fast fuzzy find buffer menu
;; Plug 'deris/vim-shot-f'                               " highlights the first match of a character in a line for f/t commands
;; Plug 'mhinz/vim-signify'                              " display version control hints
;; Plug 'junegunn/limelight.vim'                         " syntax highlight only the current paragraph
;; Plug 'tpope/vim-fugitive'                             " I only use :Gblame but that is useful
;; Plug 'benmills/vimux'                                 " send commands to tmux
;; Plug 'PotatoesMaster/i3-vim-syntax'
;; Plug 'gleam-lang/gleam.vim'
;; Plug 'saltstack/salt-vim'
;; if executable("elixir")
;;   Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }  " better support
;; endif
;; call plug#end()

;; Keybinds I miss
;; nmap S :%s//g<LEFT><LEFT>
;; nmap <expr>  M  ':%s/' . @/ . '//g<LEFT><LEFT>'
;; nmap <Leader>v <plug>(signify-next-hunk)
;; nmap <Leader>V <plug>(signify-prev-hunk)
;; nmap <Leader>h <C-W><C-H>
;; nmap <Leader>j <C-W><C-J>
;; nmap <Leader>k <C-W><C-K>
;; nmap <Leader>l <C-W><C-L>
;; nmap <Leader>p :r!xclip --clipboard primary -o <CR>
