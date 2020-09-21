reset() {
 if [ ! -z $1 ]; then
  invalid "gr";
 elif $(confirmIdentity "reset [all] changes"); then
  $(runResetRequest true);
 fi
}

runResetRequest() {
 local output=$1;

 if ! $(runResetUntrackedRequest); then
  prompt $dissapointed "Failed to reset [untracked] changes on working branch" $output;
  echo false;
  return;
 fi

 if ! $(runResetTrackedRequest); then
  prompt $dissapointed "Failed to reset [tracked] changes on working branch" $output;
  echo false;
  return;
 fi

 prompt $tada "Successfully reset all [tracked] and [untracked] changes without any issues" $output;
 echo true;
}

resetTracked() {
 if [ ! -z $1 ]; then
  invalid "grt";
 elif $(confirmIdentity "reset all [tracked] changes"); then
  $(runResetTrackedRequest true);
 fi
}

runResetTrackedRequest() {
 local output=$1;

 if ! $(run "git reset --hard"); then
  echo false;
  return;
 fi

 prompt $tada "Successfully reset all [tracked] changes without any issues" $output;
 echo true;
}

resetUntracked() {
 if [ ! -z $1 ]; then
  invalid "gru";
 elif $(confirmIdentity "reset all [untracked] changes"); then
  $(runResetUntrackedRequest true);
 fi
}

runResetUntrackedRequest() {
 local output=$1;

 if ! $(run "git clean -df"); then
  echo false;
  return;
 fi

 prompt $tada "Successfully reset all [untracked] changes without any issues" $output;
 echo true;
}