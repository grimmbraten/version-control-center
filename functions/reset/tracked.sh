reset-tracked() {
 if ! $(noArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 if ! $(confirmIdentity "reset all **tracked.. changes ##(this action can not be reverted).."); then
  echo false;
  return;
 fi

 # store total count of staged changes
 local changes=$(staged);

 prompt $leafs "Shaking off **$changes.. file$(pluralize $changes) from $(toLower $(plant-name $(changes)))";

 # reset tracked changes
 if ! $(run "git reset --hard"); then
  error "Failed to prune **tracked.. changes";
  echo false;
  return;
 fi

 successfully "Pruned **$changes.. file$(pluralize $changes)";
 echo true;
}