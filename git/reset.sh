reset() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gr";
 elif $(confirmIdentity "reset [all] changes _(this action can not be reverted)]"); then
  $(runResetRequest true);
 fi

 spacer;
}

resetTracked() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "grt";
 elif $(confirmIdentity "reset all [tracked] changes _(this action can not be reverted)]"); then
  $(runResetTrackedRequest true);
 fi

 spacer;
}

resetUntracked() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gru";
 elif $(confirmIdentity "reset all [untracked] changes _(this action can not be reverted)]"); then
  $(runResetUntrackedRequest true);
 fi

 spacer;
}

# $1: boolean (verbose)
runResetRequest() {
 local changes=$(changeCount);
 prompt $leafsIcon "Shaking off [$changes file$(plural $changes)] containing changes from $(toLower $(getBranchIconName $changes))" $1;

 if ! $(runResetUntrackedRequest); then
  prompt $boomIcon "Failed to reset [untracked] changes from branch" $1;
  echo false;
  return;
 fi

 if ! $(runResetTrackedRequest); then
  prompt $boomIcon "Failed to reset [tracked] changes from branch" $1;
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully pruned off [$changes file$(plural $changes)] without any issues" $1;
 echo true;
}

# $1: boolean (verbose)
runResetTrackedRequest() {
 local changes=$(stagedCount);
 prompt $leafsIcon "Shaking off [$changes file$(plural $changes)] containing changes from $(toLower $(getBranchIconName $(changeCount)))" $1;

 if ! $(run "git reset --hard"); then
  prompt $boomIcon "Failed to reset [tracked] changes from branch" $1;
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully pruned off [$changes file$(plural $changes)] without any issues" $1;
 echo true;
}

# $1: boolean (verbose)
runResetUntrackedRequest() {
 local changes=$(unstagedCount);
 prompt $leafsIcon "Shaking off [$changes file$(plural $changes)] containing changes from $(toLower $(getBranchIconName $(changeCount)))" $1;

 if ! $(run "git clean -df"); then
  prompt $boomIcon "Failed to reset [untracked] changes from branch" $1;
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully pruned off [$changes file$(plural $changes)] without any issues" $1;
 echo true;
}