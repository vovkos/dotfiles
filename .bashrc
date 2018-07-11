# if not running interactively, don't do anything

if [[ $- != *i* ]]; then
	return
fi

# aliases

alias ls="ls --color=auto"
alias emacs="emacs -nw"

# prompt

PS1="[\u@\h \W]\$ "

# tmux

if [[ "$TMUX" == "" ]]; then
	# find an unattached session...

	TMUX_SESSION_ID=

	IFS=$'\n'
	for SESSION in `tmux ls`; do
		TMUX_SESSION_ID=`echo $SESSION | grep -v \(attached\) | cut -d : -f 1`

		if [[ "$TMUX_SESSION_ID" != "" ]]; then
			break
		fi
	done

	# if found, attach to it; otherwise, start a new one

	if [[ "$TMUX_SESSION_ID" != "" ]]; then
		exec tmux attach -t $TMUX_SESSION_ID
	else
		exec tmux new
	fi
fi
