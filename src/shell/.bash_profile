#!/bin/bash

source_bash_files() {
  declare -r CURRENT_DIRECTORY="$(pwd)"
  declare -r -a FILES_TO_SOURCE=(
    "bash_aliases"
    "bash_autocomplete"
    "bash_exports"
    "bash_functions"
    "bash_options"
    "bash_path"
    "bash_prompt"
    # For local settings that should
    # not be under version control.   
    "bash.local"
  )

  local file=""
  local i=""

  for i in ${!FILES_TO_SOURCE[*]}; do
    file="$HOME/.${FILES_TO_SOURCE[$i]}"

    [ -r "$file" ] \
        && . "$file"
  done

  cd "$CURRENT_DIRECTORY"
}

source_bash_files
unset -f source_bash_files
