merge() {
 spacer;

 local flag="none";

 if [ -z $1 ]; then
  missing "Which branch do you want to merge?";
  return;
 elif [ $1 = $(onBranch) ]; then
  invalid "gm <branch> [flag]";
  return;
 fi

 if [ ! -z $2 ]; then
  if [ ! -z $3 ]; then
   invalid "gm <branch> [flag]";
   return;
  fi

  flag=$2;
 fi

 $(runMergeRequest $1 $flag true);

 spacer;
}

mergeMaster() {
 spacer;

 local flag="none";

 if [ ! -z $1 ]; then
  if [ ! -z $2 ]; then
   invalid "gmm [flag]";
   return;
  fi

  flag=$1;
 fi

 $(merge master $flag true);

 spacer;
}

runMergeRequest() {
 local target;
 local branch=$1;
 local flag=$2;
 local verbose=$3;

 $(runFetchRequest);

 if $(hasBranch $branch); then
  target=$branch;
 elif $(hasOrigin $branch); then
  target="origin/$branch";
 else
  prompt $disappointed "That branch does not exist" $verbose;
  echo false;
  return
 fi
 
 if [ $(behindCount $branch) -eq 0 ]; then
  prompt $tada "Branch is already [up to date] with [$target]" $verbose;
  echo false;
  return;
 fi

 if ( $(hasUnstagedChanges) && [ "$flag" != "-force" ] ); then
  prompt $construction "Branch contains changes, please [stash] or [bundle] them before checking out" $verbose;
  echo false;
  return;
 fi

 if ! $(run "git merge $target"); then
  echo false;
  return;
 fi
 
 prompt $tada "Successfully merged [$target] without any issues" $verbose;
 echo true;
}
