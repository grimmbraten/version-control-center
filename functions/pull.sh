pull() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if ! $(plant-origin-exists); then
  prompt $seeNoEvilIcon $remoteOriginDoesNotExist;
  echo false;
  return;
 fi

 local behind=$(plant-behind);

 if $(zero $behind); then
  #TODO Replace branch with actual name of plant
  successfully "Branch is [up to date] with remote origin";
  echo false;
  return;
 fi 

 prompt $(getDeliveryIcon $behind) "Receiving *$behind. package$(pluralize $behind)";

 if ! $(run "git pull origin $(growing-plant)"); then
  echo false;
  return;
 fi

 if $(plant-origin-behind); then
  error "Failed to receive package$(pluralize $behind)";
  echo false;
  return;
 fi

 successfully "Received package$(pluralize $behind)";
 echo true;
}