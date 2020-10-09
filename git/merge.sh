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
  prompt $constructionIcon "You are on a work in progress branch, please [commit or stash] before you merge" $2;
  echo false;
  return;
 fi

 if $(hasLocalBranch $1); then
  target=$1;
 elif $(hasRemoteBranch $1); then
  target="origin/$1";
 else
  prompt $surprisedIcon "Oh no, that branch does not exist" $2;
  echo false;
  return
 fi

 if [ $(localBehindCount $target) -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with [$(identity $target)], no merge is needed" $2;
  echo false;
  return;
 fi

 if ! $(run "git merge $target"); then
  echo false;
  return;
 fi
 
 prompt $tadaIcon "Successfully merged [$(identity $target)] into [$(identity)] without any issues" $2;
 echo true;
}
