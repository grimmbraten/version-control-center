reset-tracked() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
 elif ! $(confirmIdentity "reset all *tracked. changes #(this action can not be reverted)"); then
  echo false;
  return;
 fi

 local changes=$(bundled-leafs);
 prompt $leafsIcon "Shaking off *$changes. file$(pluralize $changes) from $(toLower $(plant-name $(leafs)))";

 if ! $(run "git reset --hard"); then
  error "Failed to prune *tracked. changes";
  echo false;
  return;
 fi

 successfully "Pruned *$changes. file$(pluralize $changes)";
 echo true;
}