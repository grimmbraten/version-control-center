status() {
 if [ -z $1 ]; then
  invalid "gs";
  return;
 fi

 git status --short;

 if [ "$1" = true ]; then
  local changes=$(changeCount);
  
  if [ $changes -gt 0 ]; then
   spacer;
  fi
  
  prompt $(getBranchIcon $changes) "$(getBranchIconName $changes) with [$changes] file$(plural $changes) _($(unstagedCount)/$(stagedCount))]";
 fi
}

status-detailed() {
 if [ -z $1 ]; then
  git status;
 else
  invalid "gsd";
 fi
}