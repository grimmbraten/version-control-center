push() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if ! $(plant-origin-exists $(growing-plant)); then
  prompt $constructionIcon $remoteOriginDoesNotExist;
  echo false;
  return;
 fi

 local changes=$(plant-origin-behind $(growing-plant)); 

 if $(zero $changes); then
  successfully $isUpToDateWithRemoteOrigin;
  echo false;
  return;
 fi

 local behind=$(plant-behind);

 if ! $(zero $behind); then
  prompt $alert "Branch is *$behind. package$(pluralize $behind) behind remote origin";
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $changes) "Delivering *$changes. package$(pluralize $changes)";

 if ! $(run "git push origin $(growing-plant)"); then  
  echo false;
  return;   
 fi

 if ! $(zero $(plant-origin-ahead)); then
  error "Failed to deliver package$(pluralize $changes)"; 
  echo false;
  return;
 fi 

 #TODO Add time to end of prompt to inform about the command duration
 successfully "Delivered package$(pluralize $changes)";
 echo true;
}