push() {
 # Check that function was called with no arguments
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # Abort script if no remote origin exists
 if ! $(remote-exists $(growing-plant)); then
  prompt $construction $remoteOriginDoesNotExist;
  echo false;
  return;
 fi

 # Abort script if no local changes were found
 local changes=$(local-ahead-of-remote);
 if $(isZero $changes); then
  successfully "Nothing to push";
  echo false;
  return;
 fi

 # Abort script if local branch is behind its remote origin
 local behind=$(local-behind-remote);
 if ! $(isZero $behind); then
  prompt $alert "Branch is *$behind. package$(pluralize $behind) behind remote origin";
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $changes) "Delivering *$changes. package$(pluralize $changes)";

 # Execute git push command
 if ! $(run "git push origin $(growing-plant)"); then  
  echo false;
  return;   
 fi

 # Inform if push was unsuccessful
 if ! $(isZero $(local-ahead-of-remote)); then
  error "Failed to deliver package$(pluralize $changes)"; 
  echo false;
  return;
 fi 

 #TODO Add time to end of prompt to inform about the command duration
 successfully "Delivered package$(pluralize $changes)";
 echo true;
}