# .shell_functions.sh - Custom shell functions for convenience and system management

# Check if the shell is interactive
[[ $- != *i* ]] && return

function upgrade_system_packages {
    (
        set -e
        export DEBIAN_FRONTEND=noninteractive

        # Fix any previously interrupted installs
        sudo -E apt install -y --fix-broken

        sudo -E apt update
        sudo -E apt full-upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
        sudo -E apt autoremove --purge -y
        sudo -E apt autoclean

        if [ -f /var/run/reboot-required ]; then
            printf '\n\033[0;31m[!] A reboot is required to finish updates.\033[0m\n'
        fi
    )
}

# a locked-down firefox instance running inside a sandbox
function safefox {
    /usr/bin/firejail --name=safe-firefox --apparmor --seccomp --private --private-dev --private-tmp --protocol=inet firefox --new-instance --no-remote --safe-mode --private-window $1
}

# locked down zsh shell with no network access
function sandbox_shell_no_network {
    /usr/bin/firejail --name=sandbox_shell_no_network --net=none /bin/zsh
}

# locked down zsh shell with no network access and no access to some system directories
function sandbox_shell_paranoid_mode {
    /usr/bin/firejail --name=sandbox_shell_paranoid_mode --noprofile  --apparmor --net=none --private --private-dev --private-etc --nonewprivs --seccomp /bin/zsh
}

# prevents any commands from being written to persistent history for the rest of the shell session
function history_off {
    unset HISTFILE
    echo "(╯︵╰,)╭🕶️  Privacy mode enabled — history disabled for this session."
}
