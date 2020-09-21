merge() {
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
}

mergeMaster() {
 local flag="none";

 if [ ! -z $1 ]; then
  if [ ! -z $2 ]; then
   invalid "gmm [flag]";
   return;
  fi

  flag=$1;
 fi

 $(merge master $flag true);
}

runMergeRequest() {
 local target;
 local branch=$1;
 local flag=$2;
 local output=$3;

 $(runFetchRequest);

 if $(hasBranch $branch); then
  target=$branch;
 elif $(hasOrigin $branch); then
  target="origin/$branch";
 else
  prompt $dissapointed "That branch does not exist" $output;
  echo false;
  return
 fi
 
 if [ $(behindCount $branch) -eq 0 ]; then
  prompt $tada "Branch is already [up to date] with [$target]" $output;
  echo false;
  return;
 fi

 if ( $(hasUnstagedChanges) && [ "$flag" != "-force" ] ); then
  prompt $construction "Branch contains changes, please [stash] or [bundle] them before checking out" $output;
  echo false;
  return;
 fi

 if ! $(run "git merge $target"); then
  echo false;
  return;
 fi
 
 prompt $tada "Successfully merged [$target] without any issues" $output;
 echo true;
}
