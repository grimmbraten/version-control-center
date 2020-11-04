branches() {
 spacer;

 if [ -z $1 ]; then
  git branch -v | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
 else
  invalid "gb";
 fi

 spacer;
}

branchOrigins() {
 spacer;

 if [ -z $1 ]; then
  git branch -r -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
 else
  invalid "gbo";
 fi
 
 spacer;
}

branchRename() {
 spacer;

 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gbr <name>";
 else
  $(runBranchRenameRequest $1 true);
 fi

 spacer;
}

deleteBranch() {
 spacer;

 if [ ! -z $2 ]; then
  invalid "gbd [name]";
 elif [ $1 = master ]; then
  prompt $lockIcon "Branch [master] is protected" true;
 elif [ $1 = $(onBranch) ]; then
  $(processDeleteBranchRequest $(onBranch) true);
 else
  $(processDeleteBranchRequest $1 true);
 fi

 spacer;
}

deleteBranchOrigin() {
 spacer;
 
 if [[ -z $1 && ! -z $2 ]]; then
  invalid "gbdo <name>";
 elif [ $1 = master ]; then
  prompt $lockIcon "Branch [master] branch is protected" true;
 else
  $(runDeleteBranchOriginRequest $1 true);
 fi
 
 spacer;
}

# $1: string  (new name for branch)
# $2: boolean (verbose)
runBranchRenameRequest() { 
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

 local branch=$(onBranch);

 if ! $(run "git branch -m $1"); then
  echo false;
  return;
 fi

 if $(hasRemoteBranch $branch); then
  if $(question "Do you want to delete the remote branch?"); then
   if ! $(runPushUpstreamRequest true); then    
    echo false;
    return;
   fi
  
   if ! $(runDeleteBranchOriginRequest $branch true); then    
    echo false;
    return;
   fi
  fi
 fi

 prompt $tadaIcon "Successfully renamed _($(identity))]" $2;
 echo true;
}

# $1: string  (branch to delete)
# $2: boolean (verbose)
runDeleteBranchRequest() {
 local identity=$(identity $1);

 if [ $1 = $(onBranch) ]; then
  $(runCheckoutRequest master);
 fi

 if ! $(run "git branch -D $1"); then
  prompt $boomIcon "Failed to delete _($identity)]" $2;
  echo false;
  return;
 fi  

 if $(hasRemoteBranch $1); then
  if $(question "Do you want to delete the remote branch?"); then
   if ! $(runDeleteBranchOriginRequest $1 true); then  
    echo false;
    return;
   fi
  fi
 fi

 prompt $tadaIcon "Successfully deleted _($identity)]" $2;
 echo true;
}

# $1: string  (branch to delete)
# $2: boolean (verbose)
runDeleteBranchOriginRequest() {
 if ! $(hasRemoteBranch $1); then
  prompt $surprisedIcon "Remote origin does not exist" $2;
  echo false;
  return;
 fi

 if ! $(run "git push origin --delete $1"); then
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully deleted _($(identity origin/$1))]" $2;
 echo true;
}
