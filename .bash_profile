# Load shell dotfiles
# -----------------------------------------------------------------------------

# ~/.extra can be used for settings you don’t want to commit,
# Use it to configure your PATH, thus it being first in line
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
  [ -r "$file" ] && source "$file";
done;
unset file;

# Help sublimelinter etc with finding PATHS
case $- in
  *i*) source ~/.extra;
esac;



# Completions
# -----------------------------------------------------------------------------

# Bash completion
if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Homebrew completion
if which brew > /dev/null; then
  source `brew --repository`/Library/Contributions/brew_bash_completion.sh;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;



# Shell options
# http://ss64.com/bash/shopt.html
# -----------------------------------------------------------------------------

# Autocorrect typos in path names when using the `cd` command
shopt -s cdspell;

# Check the window size after each command and, if necessary, update
# the values of `LINES` and `COLUMNS`
shopt -s checkwinsize;

# Save all lines of a multiple-line command in the same history entry
shopt -s cmdhist;

# Include filenames beginning with a "." in the filename expansion
shopt -s dotglob;

# Use extended pattern matching features
shopt -s extglob;

# Append to the history file, rather then overwriting it
shopt -s histappend;

# Do not attempt to search the PATH for possible completions when
# completion is attempted on an empty line
shopt -s no_empty_cmd_completion;

# Match filenames in a case-insensitive fashion when performing
# filename expansion
shopt -s nocaseglob;



# Third party app hooks
# -----------------------------------------------------------------------------

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm";
