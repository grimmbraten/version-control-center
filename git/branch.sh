branch() {
 if [ -z $1 ]; then
  git branch -v | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
 else
  invalid "gb";
 fi
}

branch-origins() {
 if [ -z $1 ]; then
  git branch -r -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
 else
  invalid "gbo";
 fi
}

branch-rename() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gbr <name>";
  echo false;
  return;
 fi

 local type=$(split $1 '/' 1);

 if ! $(existsInFile $type $types/branch.txt); then
  prompt $alert "[$type] is not a valid prefix";
  return;
 fi

 if $(hasBranch $1); then
  prompt $surprisedIcon "Branch already exists";
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

 prompt $tadaIcon "Successfully renamed _($(identity))]";
 echo true;
}

branch-delete() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gbd [name]";
  echo false;
  return;
 elif [ $1 = master ]; then
  prompt $lockIcon "Branch [master] is protected" true;
  echo false;
  return;
 fi
 
 local identity=$(identity $1);

 if [ $1 = $(onBranch) ]; then
  $(runCheckoutRequest master);
 fi

 if ! $(run "git branch -D $1"); then
  prompt $boomIcon "Failed to delete _($identity)]";
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

 prompt $tadaIcon "Successfully deleted _($identity)]";
 echo true;
}

branch-delete-origin() {
 if [[ -z $1 && ! -z $2 ]]; then
  invalid "gbdo <name>";
  echo false;
  return;
 elif [ $1 = master ]; then
  prompt $lockIcon "Branch [master] branch is protected" true;
  echo false;
  return;
 fi

 if ! $(hasRemoteBranch $1); then
  prompt $surprisedIcon "Remote origin does not exist";
  echo false;
  return;
 fi

 if ! $(run "git push origin --delete $1"); then
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully deleted _($(identity origin/$1))]";
 echo true;
}