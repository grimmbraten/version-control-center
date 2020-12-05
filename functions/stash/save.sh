stash-save() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi
 
 if ! $(has-leafs); then
  prompt $telescopeIcon "Branch does not have any changes";
  echo false;
  return;
 fi

 if ! $(run "git stash save -u $1"); then
  echo false;
  return;
 fi
 
 local changes=$(leafs);

 successfully "Stashed *$changes. file$(pluralize $changes)";
 echo true;
}