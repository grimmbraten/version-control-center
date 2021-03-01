# delete passed branch from local and/or remote origin
branch-delete() {
 if ! $(oneArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # prompt the user that the master branch is always protected
 if $(protected-branch $1); then
  echo false;
  return;
 fi
 
 # store the branch has for the passed branch
 local hash=$(branch-hash $1);

 # checkout master branch if branch to be deleted is current branch
 if [ $1 = $(working-branch) ]; then
  $(checkout-master);
 fi

 if ! $(run "git branch -D $1"); then
  error "Failed to burn $(plant-name)) ##($hash)..";
  echo false;
  return;
 fi  

 if $(remote-branch-exists $1); then
  if $(question "Do you want to delete the remote origin?"); then
   if ! $(branch-delete-origin $1); then  
    echo false;
    return;
   fi
  fi
 fi

 prompt $fire "Burned down local $(toLower $(plant-name)) ##($hash)..";
 echo true;
}

# delete remote origin for passed branch
branch-delete-origin() {
 if ! $(oneArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 # prompt the user that the master branch is always protected
 if $(protected-branch $1); then
  echo false;
  return;
 fi

 # check if branch actually exists on remote origin
 if ! $(remote-branch-exists $1); then
  prompt $telescope $ROM;
  echo false;
  return;
 fi

 # delete branch from remote origin
 if ! $(run "git push origin --delete $1"); then
  echo false;
  return;
 fi

 prompt $fire "Burned down $(toLower $(plant-name origin/$1)) ##($(branch-hash origin/$1))..";
 echo true;
}