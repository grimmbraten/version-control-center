reset-tracked() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
 elif ! $(confirmIdentity "reset all *tracked. changes #(this action can not be reverted)"); then
  echo false;
  return;
 fi

 local changes=$(staged);
 prompt $leafs "Shaking off *$changes. file$(pluralize $changes) from $(toLower $(plant-name $(changes)))";

 if ! $(run "git reset --hard"); then
  error "Failed to prune *tracked. changes";
  echo false;
  return;
 fi

 successfully "Pruned *$changes. file$(pluralize $changes)";
 echo true;
}