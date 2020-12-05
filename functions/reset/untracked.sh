reset-untracked() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  echo false;
  return;
 elif ! $(confirmIdentity "reset all *untracked. changes #(this action can not be reverted)"); then
  echo false;
  return;
 fi
 
 local changes=$(unbundled-leafs);
 prompt $leafsIcon "Shaking off *$changes. file$(pluralize $changes) containing changes from $(toLower $(plant-name $(leafs)))";

 if ! $(run "git clean -df"); then
  error "Failed to prune *untracked. changes";
  echo false;
  return;
 fi

 successfully "Pruned *$changes. file$(pluralize $changes)";
 echo true;
}