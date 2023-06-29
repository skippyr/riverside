setopt promptsubst
export VIRTUAL_ENV_DISABLE_PROMPT="1"

function _riverside::separator {
  for i in $(seq 1 ${COLUMNS}); do
    [[ $((i % 2)) -eq 0 ]] &&
      printf "%%F{yellow}⩟%%f" ||
      printf "%%F{red}⩣%%f"
  done
}

function _riverside::venv {
  typeset -r venv=${VIRTUAL_ENV##*/}
  [[ -n ${venv} ]] &&
    echo "(${venv}) "
}

function _riverside::pwd {
  typeset -a pwd=("${(s./.)PWD/${HOME}/~}")
  [[ ${#pwd} > 1 ]] &&
  for splits_iterator in {1..$((${#pwd} - 1))}; do
    [[ "${pwd[splits_iterator]}" == .* ]] &&
      pwd[splits_iterator]="${pwd[splits_iterator][1,2]}" ||
      pwd[splits_iterator]="${pwd[splits_iterator][1]}"
  done
  echo "${(j./.)pwd}"
}

function _riverside::git_changes {
  [[ -n $(git status --porcelain 2>/dev/null) ]] &&
    echo " %F{yellow}✗%f"
}

function _riverside::git {
  typeset -r branch=$(git branch --show-current 2>/dev/null)
  [[ -n ${branch} ]] &&
    echo " %F{blue}git:(%F{red}${branch}%F{blue})%f" ||
}

PROMPT='$(_riverside::separator)
%F{8}:: %F{yellow}%n%F{red}@%F{green}%m%f %F{8}::%f $(_riverside::venv)%F{cyan}$(_riverside::pwd)%f$(_riverside::git_changes)$(_riverside::git)%(?.. %F{8}[%F{red}%?%F{8}]%f)
%F{yellow}⤗ %f '
