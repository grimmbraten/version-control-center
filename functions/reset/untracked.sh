reset-untracked() {
 if ! $(noArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 if ! $(confirmIdentity "reset all **untracked.. changes ##(this action can not be reverted).."); then
  echo false;
  return;
 fi
 
 # store total count of unstaged changes
 local changes=$(unstaged);

 prompt $leafs "Shaking off **$changes.. file$(pluralize $changes) containing changes from $(toLower $(plant-name $(changes)))";

 # reset unstaged changes
 if ! $(run "git clean -df"); then
  error "Failed to prune **untracked.. changes";
  echo false;
  return;
 fi

 successfully "Pruned **$changes.. file$(pluralize $changes)";
 echo true;
}