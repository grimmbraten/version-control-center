checkout() {
 spacer;

 if [ -z $1 ]; then
  missing "What branch do you want to checkout?";
 elif [ ! -z $2 ]; then
  invalid "gch <branch>";
 else
  $(runCheckoutRequest $1 true);
 fi

 spacer;
}

checkoutMaster() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gchm";
 else
  $(runCheckoutRequest master true);
 fi

 spacer;
}

checkoutPrevious() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gchp";
  return;
 fi

 local branch=$(git rev-parse --symbolic-full-name @{-1});  
 branch=${branch#"refs/heads/"};

 $(runCheckoutRequest $branch true);

 spacer;
}

runCheckoutRequest() {
 local target=$1;
 local verbose=$2;
 local branch=$(onBranch);

 if $(hasChanges); then
  $(runSaveRequest $current);  
 fi

 if $(hasBranch $target); then
  if ! $(run "git checkout $target"); then
   echo false;
   return;
  fi
 elif $(hasOrigin $target); then
  if ! $(run "git checkout -b $target origin/$target"); then
   echo false;
   return;
  fi
 else
  prompt $disappointed "That branch does not exist" $verbose;
  echo false;
  return
 fi

 local index=$(getStashIndexByName $target);

 if [ ! -z $index ]; then
  if $(runApplyRequest $index); then
   $(runDropRequest $index);
  fi
 fi

 prompt $tada "Successfully switched branch from [$branch] to [$target]" $verbose;
 echo true;
}

checkoutCreateBranch() {
 spacer;

 if [ -z $1 ]; then
  missing "What do you want to name the new branch to?";
 elif [ ! -z $2 ]; then
  invalid "gchb <branch>";
 else
  $(runCheckoutCreateBranchRequest $1 true);
 fi

 spacer;
}

runCheckoutCreateBranchRequest() {
 local branch=$1;
 local verbose=$2;

 local type=$(split $branch '/' 1);

 if ! $(existsInFile $type $types/branch.txt); then
  prompt $construction "$type is not a valid branch type, enter [gbp] to display all allowed types" $verbose;
  return;
 fi

 if $(hasChanges); then
  prompt $construction "Branch contains changes, please [stash] or [bundle] them before checking out" $verbose;
  echo false;
  return;
 fi

 if [[ $(hasBranch $branch) || $(hasOrigin $branch) ]]; then
  prompt $alarm "Branch already exists" $verbose;
  echo false;
  return;
 fi

 if ! $(run "git checkout -b $branch"); then
  echo false;
  return;
 fi

 prompt $tada "Successfully created a new branch" $verbose;
 echo true;
}