status() {
 spacer;

 if [ -z $1 ]; then
  runStatusRequest true;
 else
  invalid "gs";
 fi

 spacer;
}

statusDetailed() {
 if [ -z $1 ]; then
  spacer && git status && spacer;
 else
  invalid "gsd";
 fi
}

# $1: boolean (verbose)
runStatusRequest() {
 git status --short;

 if [ "$1" = true ]; then
  local changes=$(changeCount);

  spacer;
  prompt $(getBranchIcon $changes) "$(getBranchIconName $changes) with [$changes file$(plural $changes)] _($(unstagedCount)/$(stagedCount))]" true;
 fi
}