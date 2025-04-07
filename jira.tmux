#!/usr/bin/env bash

key_binding_option='@tmux-jira-key-binding'
key_binding_option_default='C-j'
width_option='@tmux-jira-width'
width_option_default='90%'
height_option='@tmux-jira-height'
height_option_default='90%'
query_option='@tmux-jira-query'
query_option_default=''
copy_cmd_option='@tmux-jira-copy-cmd'
copy_cmd_option_default='pbcopy'

get_tmux_option() {
	local option="${1}"
	local default_value="${2}"

	option_value=$(tmux show-option -gqv "$option")

	if [ -z "${option_value}" ]; then
		echo "${default_value}"
	else
		echo "${option_value}"
	fi
}

key_binding=$(get_tmux_option "${key_binding_option}" "${key_binding_option_default}")
width=$(get_tmux_option "${width_option}" "${width_option_default}")
height=$(get_tmux_option "${height_option}" "${height_option_default}")
query=$(get_tmux_option "${query_option}" "${query_option_default}")
copy_cmd=$(get_tmux_option "${copy_cmd_option}" "${copy_cmd_option_default}")

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux bind-key "${key_binding}" \
  popup -w "${width}" -h "${height}" -E \
  "${script_dir}/jira-issues.sh '${query}' '${copy_cmd}' 2> /tmp/jira.log"
