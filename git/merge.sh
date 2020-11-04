merge() {
 spacer;

 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gm <branch>";
 else
  $(runMergeRequest $1 true);
 fi

 spacer;
}

mergeMaster() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gmm";
 else
  $(merge master true);
 fi

 spacer;
}

# $1: string  (branch to merge)
# $2: boolean (verbose)
runMergeRequest() {
 local target;

 if $(hasChanges); then
  prompt $constructionIcon "Branch has work in progress" $2;
  echo false;
  return;
 fi

 if $(hasLocalBranch $1); then
  target=$1;
 elif $(hasRemoteBranch $1); then
  target="origin/$1";
 else
  prompt $surprisedIcon "Branch does not exist" $2;
  echo false;
  return
 fi

 if [ $(localBehindCount $target) -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with branch _($(identity $target)]" $2;
  echo false;
  return;
 fi

 if ! $(run "git merge $target"); then
  echo false;
  return;
 fi
 
 prompt $tadaIcon "Successfully merged _($(identity $target))]" $2;
 echo true;
}
