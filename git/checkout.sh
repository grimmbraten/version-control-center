checkout() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gch <branch>";
  echo false;
  return;
 fi

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
  prompt $surprisedIcon "Branch does not exist";
  echo false;
  return
 fi

 local index=$(getStashIndexByName $1);

 if [ ! -z $index ]; then
  if $(runApplyRequest $index); then
   $(runDropRequest $index);
  fi
 fi

 prompt $tadaIcon "Successfully checked out _($toIdentity)]";
 echo true;
}

checkout-master() {
 if [ ! -z $1 ]; then
  invalid "gchm";
 else
  $(checkout master);
 fi
}

checkout-previous() {
 if [ ! -z $1 ]; then
  invalid "gchp";
 else
  local branch=$(git rev-parse --symbolic-full-name @{-1});  
  $(checkout ${branch#"refs/heads/"});
 fi
}

checkout-branch() {
 if [[ -z $1 || ! -z $2 ]]; then
  invalid "gchb <branch>";
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

 if ! $(run "git checkout -b $1"); then
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully created branch";
 echo true;
}