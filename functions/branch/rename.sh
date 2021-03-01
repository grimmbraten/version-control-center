# rename working branch on local and/or remote origin
branch-rename() {
 if ! $(oneArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if $(protected-branch $1); then
  echo false;
  return;
 fi

 # check if passed name is available on local machine
 if $(local-branch-exists $1); then
  prompt $(plant-icon $1) $BE;
  echo false;
  return;
 fi

 # check if passed name is available on remote origin
 if $(remote-branch-exists $1); then
  prompt $(plant-icon $1) $BE;
  echo false;
  return;
 fi

 # store name current working branch
 local name=$(working-branch);

 # rename working branch on local machine
 if ! $(run "git branch -m $1"); then
  error "Failed to rename $name";
  echo false;
  return;
 fi

 if $(remote-branch-exists $name); then
  if $(question "Do you want to rename the remote origin?"); then
   # push renamed branch to remote origin
   if ! $(push-upstream); then    
    echo false;
    return;
   fi
  
   # delete remote old branch
   if ! $(branch-delete-origin $name); then    
    echo false;
    return;
   fi
  fi
 fi
 
 successfully "Renamed $name ##($(branch-hash))..";
 echo true;
}