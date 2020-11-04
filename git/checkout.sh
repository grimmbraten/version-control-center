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

 if $(hasLocalBranch $1); then
  toIdentity=$(identity $1);

  if ! $(run "git checkout $1"); then
   echo false;
   return;
  fi
 elif $(hasRemoteBranch $1); then
  toIdentity=$(identity origin/$1);

  if ! $(run "git checkout -b $1 origin/$1"); then
   echo false;
   return;
  fi
 else
  prompt $surprisedIcon "Branch does not exist" $2;
  echo false;
  return
 fi

 local index=$(getStashIndexByName $1);

 if [ ! -z $index ]; then
  if $(runApplyRequest $index); then
   $(runDropRequest $index);
  fi
 fi

 prompt $tadaIcon "Successfully checked out _($toIdentity)]" $2;
 echo true;
}

# $1: string  (branch to create)
# $2: boolean (verbose)
runCheckoutCreateBranchRequest() {
 local type=$(split $1 '/' 1);

 if ! $(existsInFile $type $types/branch.txt); then
  prompt $alert "[$type] is not a valid prefix" $2;
  return;
 fi

 if $(hasBranch $1); then
  prompt $surprisedIcon "Branch already exists" $2;
  echo false;
  return;
 fi

 if ! $(run "git checkout -b $1"); then
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully created branch" $2;
 echo true;
}