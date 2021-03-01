# create and checkout a new branch
checkout-new-branch() {
 if ! $(oneArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # check that branch does not already exist on local machine
 if $(local-branch-exists $1); then
  prompt $(plant-icon $(local-ahead-of-master $(branch-hash $1))) "$(plant-name $(local-ahead-of-master $(branch-hash $1))) already exists";
  echo false;
  return;
 fi

 # check that branch does not already exist on remote origin
 if $(remote-branch-exists $1); then
  prompt $(plant-icon $(remote-ahead-of-master $(branch-hash origin/$1))) "$(plant-name $(remote-ahead-of-master $(branch-hash origin/$1))) already exists";
  echo false;
  return;
 fi

 # create and checkout new branch
 if ! $(run "git checkout -b $1"); then
  echo false;
  return;
 fi

 prompt $(plant-icon) "Planted a new $(toLower $(plant-name))";
 echo true;
}