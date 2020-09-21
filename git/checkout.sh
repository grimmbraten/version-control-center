checkout() {
 if [ -z $1 ]; then
  missing "What branch do you want to checkout?";
 elif [ ! -z $2 ]; then
  invalid "gch <branch>";
 else
  $(runCheckoutRequest $1 true);
 fi
}

checkoutMaster() {
 if [ ! -z $1 ]; then
  invalid "gchm";
 else
  $(runCheckoutRequest master true);
 fi
}

checkoutPrevious() {
 if [ ! -z $1 ]; then
  invalid "gchp";
  return;
 fi

 local branch=$(git rev-parse --symbolic-full-name @{-1});  
 branch=${branch#"refs/heads/"};

 $(runCheckoutRequest $branch true);
}

runCheckoutRequest() {
 local target=$1;
 local output=$2;
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
  prompt $dissapointed "That branch does not exist" $output;
  echo false;
  return
 fi

 local index=$(getStashIndexByName $target);

 if [ ! -z $index ]; then
  if $(runApplyRequest $index); then
   $(runDropRequest $index);
  fi
 fi

 prompt $tada "Successfully switched branch from [$branch] to [$target]" $output;
 echo true;
}

checkoutCreateBranch() {
 if [ -z $1 ]; then
  missing "What do you want to name the new branch to?";
 elif [ ! -z $2 ]; then
  invalid "gchb <branch>";
 else
  $(runCheckoutCreateBranchRequest $1 true);
 fi
}

runCheckoutCreateBranchRequest() {
 local branch=$1;
 local output=$2;

 if $(hasChanges); then
  prompt $construction "Branch contains changes, please [stash] or [bundle] them before checking out" $output;
  echo false;
  return;
 fi

 if $(hasBranch $branch) || $(hasOrigin $branch); then
  prompt $alarm "Branch already exists" $output;
  echo false;
  return;
 fi

 if ! $(run "git checkout -b $branch"); then
  echo false;
  return;
 fi

 prompt $tada "Successfully created a new branch" $output;
 echo true;
}