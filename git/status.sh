status() {
 if [ ! -z $1 ]; then
  invalid "gs";
  return;
 fi

 git status --short;

 local changes=$(changeCount);
  
 if [ $changes -gt 0 ]; then
  spacer;
 fi
  
 prompt $(getBranchIcon $changes) "$(getBranchIconName $changes) with [$changes] file$(plural $changes) _($(unstagedCount)/$(stagedCount))]";
}

status-detailed() {
 if [ -z $1 ]; then
  git status;
 else
  invalid "gsd";
 fi
}