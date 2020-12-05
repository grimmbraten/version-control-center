checkout-new-branch() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 if $(plant-exists $1); then
  prompt $(plant-icon $(packages-ahead-of-master $(plant-breed $1))) "$(plant-name $(packages-ahead-of-master $(plant-breed $1))) already exists";
  echo false;
  return;
 fi

 if ! $(run "git checkout -b $1"); then
  echo false;
  return;
 fi

 prompt $(plant-icon 0) "Planted a new $(toLower $(plant-name 0))";
 echo true;
}