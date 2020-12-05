stash() {
 if $(isCalledWithNoArguments $@); then
  git stash list;
 else
  invalid;
 fi
}