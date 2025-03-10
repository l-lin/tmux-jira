#!/usr/bin/env bash
#
# Interactively view the JIRA issues.
# Must have https://github.com/ankitpokhrel/jira-cli to work.
#

if ! type jira >/dev/null 2>&1; then
  return
fi
if ! type fzf >/dev/null 2>&1; then
  return
fi

# Use a cache, because jira is slow.
# You can always call <C-r> to reload the content.
cache_dir="${XDG_CACHE_HOME:-${HOME}/.cache}/tmux-jira/"
cache_file="${cache_dir}/jira.tmp"

mkdir -p "${cache_dir}"

jira_cmd='jira sprint list --current -s~done --order-by status --plain --columns id,assignee,status,summary'
reload_cmd="${jira_cmd} | tee ${cache_file}"

# 1st call to fetch JIRA issues.
if [ ! -e "${cache_file}" ]; then
  eval "${jira_cmd}" > "${cache_file}"
fi

cat "${cache_file}" \
  | fzf \
    --no-reverse \
    --header-lines 1 \
    --preview-window 'top:70%:border-bottom:hidden' \
    --preview 'jira issue view {1}' \
    --bind '?:toggle-preview' \
    --bind 'alt-p:toggle-preview-wrap' \
    --bind "alt-a:execute(jira issue assign {1} $(jira me))+reload(${reload_cmd})" \
    --bind 'alt-c:execute(jira issue comment add {1})' \
    --bind "alt-e:execute(jira issue edit {1})+reload(${reload_cmd})" \
    --bind "alt-m:execute(jira issue move {1})+reload(${reload_cmd})" \
    --bind 'ctrl-b:execute(jira open {1})' \
    --bind "ctrl-r:reload(${reload_cmd})" \
    --bind "alt-u:execute(jira issue assign {1} x)+reload(${reload_cmd})" \
    --bind 'ctrl-y:execute-silent(echo -n {1} | xsel -b)' \
    --bind "enter:execute(jira issue view {1})" \
    --header 'A-a: assign to me | A-c: add comment | A-e: edit | A-m: move | C-b: open | C-r: reload | A-u: unassign | C-y: yank id | ?: toggle preview'
