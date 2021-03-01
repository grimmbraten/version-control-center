# reset all changes
reset() {
 if ! $(noArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # prompt user to confirm action
 if ! $(confirmIdentity "reset **all.. changes ##(this action can not be reverted).."); then
  echo false;
  return;
 fi

 # store total count of changes
 local changes=$(changes);

 prompt $leafs "Shaking off **$changes.. file$(pluralize $changes) from $(toLower $(plant-name $changes))";

 # reset untracked files
 if ! $(reset-untracked); then
  error "Failed to prune **untracked.. changes";
  echo false;
  return;
 fi

 # reset tracked files
 if ! $(reset-tracked); then
  error "Failed to prune **tracked.. changes";
  echo false;
  return;
 fi

 successfully "Pruned **$changes.. file$(pluralize $changes)";
 echo true;
}