__define_git_completion () {
eval "
    _git_$2_shortcut () {
        COMP_LINE=\"git $2\${COMP_LINE#$1}\"
        let COMP_POINT+=$((4+${#2}-${#1}))
        COMP_WORDS=(git $2 \"\${COMP_WORDS[@]:1}\")
        let COMP_CWORD+=1

        local cur words cword prev
        _get_comp_words_by_ref -n =: cur words cword prev
        _git_$2
    }
"
}

__git_shortcut () {
    type _git_$2_shortcut &>/dev/null || __define_git_completion $1 $2
    alias $1="git $2 $3 $4 $5 $6"
    complete -o default -o nospace -F _git_$2_shortcut $1
}

alias git='git --no-pager'
alias gs='git status'
alias gl1mh='gl1 master..HEAD'

type __git_shortcut >/dev/null 2>&1
if [ "x$?" = "x0" ]; then
  __git_shortcut ga   add
  __git_shortcut gd   diff
  __git_shortcut gdc  diff --cached
  __git_shortcut gdh  diff HEAD HEAD^
  __git_shortcut gc   commit
  __git_shortcut gl   log --name-status
  __git_shortcut gl1  log --oneline
  __git_shortcut gba  branch -a
  __git_shortcut gco  checkout
  __git_shortcut gp   push
  __git_shortcut gfa  fetch --all --prune
  __git_shortcut gfo  fetch --prune origin
  __git_shortcut gsa  stash apply
fi