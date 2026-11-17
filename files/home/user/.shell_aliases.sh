# .shell_aliases.sh - Custom shell aliases for convenience and system management

# Check if the shell is interactive
[[ $- != *i* ]] && return

# Flush file system buffers with 'sync' and drop cached data from memory
alias drop_caches='/usr/bin/sudo sh -c "sync && echo 3 > /proc/sys/vm/drop_caches && echo Caches cleared"'

alias my_public_ipv4='dig @resolver1.opendns.com A myip.opendns.com +short -4'
alias my_public_ipv6='dig @resolver1.opendns.com AAAA myip.opendns.com +short -6'

# pipe text output to clipboard (can be pasted using Ctrl v)
alias clipboard='xsel -ib'

alias upgrade_system_packages='/usr/bin/sudo apt clean && /usr/bin/sudo apt update && /usr/bin/sudo apt upgrade -y && /usr/bin/sudo apt autoremove --purge -y && /usr/bin/sudo apt clean'

# sudo with preserved user's PATH
# ## this is useful when running commands with elevated priviledges with the executable in the user's home directory
alias sudo_keep_path='sudo env "PATH=$PATH"'

# aliases to send traffic through a man-in-the-middle proxy or the tor network
alias proxy_on='export http_proxy=http://localhost:8080; export https_proxy=http://localhost:8080'
alias proxy_tor_on='export http_proxy=socks5h://localhost:9050; export https_proxy=socks5h://localhost:9050'
alias proxy_status="env | grep -i 'http_proxy\|https_proxy'"
alias proxy_off='unset http_proxy; unset https_proxy'

# ---- eza aliases: begin ----

# Everyday listing
# alias ls='eza --group-directories-first --icons=never'  # left off so plain ls stays untouched
alias l.='eza -d .[!.]* --icons=never'                                        # only dotfiles
alias l1='eza -1a --group-directories-first --icons=never'                    # single column
alias ll='eza -l --header --smart-group --time-style=relative --group-directories-first --icons=never'
alias la='ll -a'                                                             # long format incl. hidden

# Sorting
alias lss='eza -a1 --group-directories-first --icons=never --sort=size --reverse'      # largest first
alias lsm='eza -a1 --group-directories-first --icons=never --sort=modified --reverse'  # newest first
alias lrecent='eza -l --header --sort=modified --time-style=relative'                 # newest at bottom
alias lchanged='eza -la --header --changed --sort=changed --reverse --group-directories-first' # newest ctime first
alias lstype='eza -la --sort=type --group-directories-first --icons=never'             # sort by file type

# Trees (depth-limited)
alias lst='eza -aT -L 5 -I .git --group-directories-first --icons=never'                    # full tree, 5 levels
alias lt='eza -lT -L 3 -I .git --group-directories-first --icons=never'                     # long tree, 3 levels
alias ltdev="eza -aT -L 4 -I '.git|.hg|.svn|node_modules|vendor|.venv|venv|__pycache__|*.pyc|.pytest_cache|.mypy_cache|.ruff_cache|.tox|.nox|.coverage|htmlcov|*.egg-info|.eggs|.ipynb_checkpoints|dist|build|target|.bundle|.yardoc|CMakeFiles|CMakeCache.txt|cmake-build-*|compile_commands.json|*.o|*.a|*.so|*.obj|.cache|.next|.nuxt|.output|coverage|.turbo|.parcel-cache|.pnpm-store|.svelte-kit|.angular|.terraform|.gradle|.DS_Store' --group-directories-first --icons=never" # development tree, excludes generated directories

# Ops (metadata only)
alias luid='eza -ln --header --group-directories-first'                     # numeric UID/GID
alias lino='eza -li --header'                                               # inode numbers
alias lm='eza -lM --header --icons=never'                                    # mount information

# ---- eza aliases: end ----
