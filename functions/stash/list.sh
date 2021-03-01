# list all local stashes
stash() {
 if $(noArguments $@); then
  git stash list;
 else
  invalid;
 fi
}