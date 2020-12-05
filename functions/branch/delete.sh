branch-delete() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 if [ $1 = master ]; then
  protected "master";
  echo false;
  return;
 fi
 
 local breed=$(plant-breed $1);

 if [ $1 = $(growing-plant) ]; then
  $(checkout-master);
 fi

 local ahead=$(forest-behind $1);

 if ! $(run "git branch -D $1"); then
  #Todo replace "plant" with actual plant name
  error "Failed to burn plant #($breed)";
  echo false;
  return;
 fi  

 if $(plant-origin-exists $1); then
  if $(question "Do you want to delete the remote origin?"); then
   if ! $(branch-delete-origin $1); then  
    echo false;
    return;
   fi
  fi
 fi

 prompt $fireIcon "Burned down $(toLower $(plant-name $ahead)) #($breed)";
 echo true;
}

branch-delete-origin() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi
 
 if [ $1 = master ]; then
  protected "master";
  echo false;
  return;
 fi

 local ahead=$(packages-ahead-of-master $1);

 if ! $(plant-origin-exists $1); then
  prompt $seeNoEvilIcon $remoteOriginDoesNotExist;
  echo false;
  return;
 fi

 if ! $(run "git push origin --delete $1"); then
  echo false;
  return;
 fi

 prompt $fireIcon "Burned down $(toLower $(plant-name $ahead)) #($(plant-breed origin/$1))";
 echo true;
}