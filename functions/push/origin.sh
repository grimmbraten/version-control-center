# push commits to remote origin
push() {
 if ! $(noArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # abort script if no remote origin exists
 if ! $(remote-branch-exists $(working-branch)); then
  prompt $construction $ROM;
  echo false;
  return;
 fi

 # store total count of local commits ahead of remote origin
 local changes=$(local-ahead-of-remote);

 # abort script if no local changes were found
 if $(isZero $changes); then
  successfully "Nothing to push";
  echo false;
  return;
 fi

 # store total count of remote commits ahead of local branch
 local behind=$(local-behind-remote);

 # abort script if local branch is behind its remote origin
 if ! $(isZero $behind); then
  prompt $alert "Branch is **$behind.. package$(pluralize $behind) behind remote origin";
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $changes) "Delivering **$changes.. package$(pluralize $changes)";

 # push commits to remote origin
 if ! $(run "git push origin $(working-branch)"); then  
  echo false;
  return;   
 fi

 # prompt user if push was unsuccessful
 if ! $(isZero $(local-ahead-of-remote)); then
  error "Failed to deliver package$(pluralize $changes)"; 
  echo false;
  return;
 fi 

 #TODO add time to end of prompt to inform about the command duration
 successfully "Delivered package$(pluralize $changes)";
 echo true;
}