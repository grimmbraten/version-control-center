reset() {
 if [ ! -z $1 ]; then
  invalid "gr";
  echo false;
  return;
 elif ! $(confirmIdentity "reset [all] changes _(this action can not be reverted)]"); then
  echo false;
  return;
 fi

 local changes=$(changeCount);
 prompt $leafsIcon "Shaking off [$changes] file$(plural $changes) from $(toLower $(getBranchIconName $changes))";

 if ! $(runResetUntrackedRequest); then
  prompt $boomIcon "Failed to prune [untracked] changes";
  echo false;
  return;
 fi

 if ! $(runResetTrackedRequest); then
  prompt $boomIcon "Failed to prune [tracked] changes";
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully pruned [$changes] file$(plural $changes)";
 echo true;
}

reset-tracked() {
 if [ ! -z $1 ]; then
  invalid "grt";
 elif ! $(confirmIdentity "reset all [tracked] changes _(this action can not be reverted)]"); then
  echo false;
  return;
 fi

 local changes=$(stagedCount);
 prompt $leafsIcon "Shaking off [$changes] file$(plural $changes) from $(toLower $(getBranchIconName $(changeCount)))";

 if ! $(run "git reset --hard"); then
  prompt $boomIcon "Failed to prune [tracked] changes";
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully pruned [$changes] file$(plural $changes)";
 echo true;
}

reset-untracked() {
 if [ ! -z $1 ]; then
  invalid "gru";
  echo false;
  return;
 elif ! $(confirmIdentity "reset all [untracked] changes _(this action can not be reverted)]"); then
  echo false;
  return;
 fi
 
 local changes=$(unstagedCount);
 prompt $leafsIcon "Shaking off [$changes file$(plural $changes)] containing changes from $(toLower $(getBranchIconName $(changeCount)))";

 if ! $(run "git clean -df"); then
  prompt $boomIcon "Failed to prune [untracked] changes";
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully pruned [$changes] file$(plural $changes)";
 echo true;
}