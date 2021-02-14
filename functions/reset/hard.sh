reset() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  echo false;
  return;
 elif ! $(confirmIdentity "reset [all] changes _(this action can not be reverted)]"); then
  echo false;
  return;
 fi

 local changes=$(changes);
 prompt $leafs "Shaking off *$changes. file$(pluralize $changes) from $(toLower $(plant-name $changes))";

 if ! $(reset-untracked); then
  error "Failed to prune *untracked. changes";
  echo false;
  return;
 fi

 if ! $(reset-tracked); then
  error "Failed to prune *tracked. changes";
  echo false;
  return;
 fi

 successfully "Pruned *$changes. file$(pluralize $changes)";
 echo true;
}