merge() {
 local target;

 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi

 if $(has-leafs); then
  prompt $constructionIcon $hasWorkInProgress;
  echo false;
  return;
 fi

 if $(plant-exists $1); then
  target=$1;
 elif $(plant-origin-exists $1); then
  target="origin/$1";
 else
  prompt $seeNoEvilIcon $branchDoesNotExist;
  echo false;
  return
 fi

 if [ $(plant-behind $target) -eq 0 ]; then
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