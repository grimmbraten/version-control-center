merge() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gm <branch>";
  echo false;
  return;
 fi

 local target;

 if $(hasChanges); then
  prompt $constructionIcon "Branch has work in progress";
  echo false;
  return;
 fi

 if $(hasLocalBranch $1); then
  target=$1;
 elif $(hasRemoteBranch $1); then
  target="origin/$1";
 else
  prompt $surprisedIcon "Branch does not exist";
  echo false;
  return
 fi

 if [ $(localBehindCount $target) -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with branch _($(identity $target)]";
  echo false;
  return;
 fi

 if ! $(run "git merge $target"); then
  echo false;
  return;
 fi
 
 prompt $tadaIcon "Successfully merged _($(identity $target))]";
 echo true;
}

merge-master() {
 if [ ! -z $1 ]; then
  invalid "gmm";
 else
  $(merge master);
 fi
}