if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Created by `pipx` on 2024-01-20 00:28:35
set PATH $PATH /home/diego/.local/bin

alias publicip='wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'
alias syncthingweb='kitty sh -c "firefox http://127.0.0.1:8080"'
alias syncdrive='grive -s ~/Desktop/GoodNotes'
alias vncstart='x11vnc -display :0 -rfbauth ~/.vnc/passwd'
