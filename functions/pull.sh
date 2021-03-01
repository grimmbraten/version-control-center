# pull changes from remote origin
pull() {
 if ! $(noArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # check if working branch has remote origin
 if ! $(remote-branch-exists); then
  prompt $leafs $ROM;
  echo false;
  return;
 fi

 local behind=$(behind-local);

 # check if local branch is up to date with remote origin
 if $(isZero $behind); then
  prompt $(plant-icon) "$(plant-name) is already $upToDateWithRemote $URL";
  echo false;
  return;
 fi 

 prompt $(getDeliveryIcon $behind) "Receiving **$behind.. plant anatomy and morphology update$(pluralize $behind)";

 # pull down remote changes to working branch
 if ! $(run "git pull origin $(working-branch)"); then
  echo false;
  return;
 fi

 prompt $(plant-icon) "$(plant-name) is now $upToDateWithRemote $URL";
 echo true;
}