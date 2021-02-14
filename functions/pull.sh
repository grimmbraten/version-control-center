pull() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if ! $(remote-exists); then
  prompt $leafs $remoteOriginDoesNotExist;
  echo false;
  return;
 fi

 local behind=$(behind-local);

 if $(isZero $behind); then
  prompt $(plant-icon) "$(plant-name) is already $upToDateWithRemote $mutedRepoUrl";
  echo false;
  return;
 fi 

 prompt $(getDeliveryIcon $behind) "Receiving **$behind.. plant anatomy and morphology update$(pluralize $behind)";

 if ! $(run "git pull origin $(growing-plant)"); then
  echo false;
  return;
 fi

 if $(local-behind-remote); then
  error "Failed to update plant$(pluralize $behind)";
  echo false;
  return;
 fi

 prompt $(plant-icon) "$(plant-name) is now $upToDateWithRemote $mutedRepoUrl";
 echo true;
}