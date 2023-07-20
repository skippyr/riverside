setopt promptsubst
export VIRTUAL_ENV_DISABLE_PROMPT=1

__riverside_t()
{
	Get_Separator()
	{
		for i in {1..${COLUMNS}}; do
			[[ $(( i % 2 )) -eq 0 ]] && printf "%%F{3}⩟%%f" || printf "%%F{1}⩣%%f"
		done
	}

	Get_Virtual_Environment()
	{
		[[ ${VIRTUAL_ENV} ]] && echo "%f(${VIRTUAL_ENV##*/}) "
	}

	Get_Directory()
	{
		typeset -a d=("${(s./.)PWD/${HOME}/~}")
		[[ ${#d} > 1 ]] && for i in {1..$((${#d} - 1))}; do
			[[ "${d[i]}" == .* ]] && d[i]=${d[i][1,2]} || d[i]=${d[i][1]}
		done
		echo ${(j./.)d}
	}

	Get_Changes()
	{
		[[ $(git status --porcelain 2>/dev/null) ]] && echo "%F{3}✗"
	}

	Get_Branch()
	{
		typeset -r b=$(git branch --show-current 2>/dev/null)
		[[ ${b} ]] && echo " $(Get_Changes)%F{4}git:(%F{1}${b}%F{4})"
	}

	echo "$(Get_Separator)%F{8}:: %F{3}%n%F{1}@%F{2}%m %F{8}::"\
	     "$(Get_Virtual_Environment)%F{6}$(Get_Directory)$(Get_Branch)"\
	     "%(?..%F{4}[%F{1}%?%F{4}])"
}

PROMPT='$(__riverside_t)
%F{3}⤗ %f '

