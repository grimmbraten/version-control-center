merge() {
 local target;

 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 if $(has-changes); then
  prompt $construction $hasWorkInProgress;
  echo false;
  return;
 fi

 if $(local-exists $1); then
  target=$1;
 elif $(remote-exists $1); then
  target="origin/$1";
 else
  prompt $telescope $branchDoesNotExist;
  echo false;
  return
 fi

 if [ $(behind-local $target) -eq 0 ]; then
  successfully "Already *up to date. with $target #($(plant-breed $target)";
  echo false;
  return;
 fi

 if ! $(run "git merge $target"); then
  echo false;
  return;
 fi
 
 successfully "Merged #($(plant-breed $target))";
 echo true;
}