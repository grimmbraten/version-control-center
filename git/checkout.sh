checkout() {
 spacer;

 if [[ -z $1 || ! -z $2 ]]; then
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
 $(runCheckoutRequest ${branch#"refs/heads/"} true);

 spacer;
}

checkoutCreateBranch() {
 spacer;

 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gchb <branch>";
 else
  $(runCheckoutCreateBranchRequest $1 true);
 fi

 spacer;
}

# $1: string  (branch to checkout)
# $2: boolean (verbose)
runCheckoutRequest() {
 local toIdentity;
 local fromIdentity=$(identity);

 if $(hasChanges); then
  $(runSaveRequest $(onBranch));  
 fi

 if $(hasBranch $1); then
  toIdentity=$(identity $1);

  if ! $(run "git checkout $1"); then
   echo false;
   return;
  fi
 elif $(hasOrigin $1); then
  toIdentity=$(identity origin/$1);

  if ! $(run "git checkout -b $1 origin/$1"); then
   echo false;
   return;
  fi
 else
  prompt $surprisedIcon "Oh no, that branch does not exist" $2;
  echo false;
  return
 fi

 local index=$(getStashIndexByName $1);

 if [ ! -z $index ]; then
  if $(runApplyRequest $index); then
   $(runDropRequest $index);
  fi
 fi

 prompt $tadaIcon "Successfully checked out [$toIdentity] from [$fromIdentity]" $2;
 echo true;
}

# $1: string  (branch to create)
# $2: boolean (verbose)
runCheckoutCreateBranchRequest() {
 local type=$(split $1 '/' 1);

 if ! $(existsInFile $type $types/branch.txt); then
  prompt $skepticIcon "Hmm, [$type] is not a valid branch type" $2;
  return;
 fi

 if $(hasChanges); then
  prompt $constructionIcon "You are on a work in progress branch, please [commit or stash] before you checkout" $2;
  echo false;
  return;
 fi

 if $(hasBranch $1); then
  prompt $surprisedIcon "Oh no, a branch with that name already exists" $2;
  echo false;
  return;
 fi

 if ! $(run "git checkout -b $(capitalize $1)"); then
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully created branch without any issues" $2;
 echo true;
}