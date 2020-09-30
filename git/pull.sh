pull() {
 if [ ! -z $1 ]; then
  invalid "gpl";
 else
  $(runPullRequest true);
 fi
}

runPullRequest() {
 local icon;
 local verbose=$1;

 local branch=$(onBranch);

 if ! $(hasOrigin); then
  prompt $construction "Branch does not have a tracked destination" $verbose;
  echo false;
  return;
 fi

 if ! $(isBehindOrigin); then
  local ahead=$(originAheadCount);

  prompt $tada "Branch is [up to date] with tracked destination _($behind package$(plural $behind)/$ahead package$(plural $ahead))]" $verbose;
  echo false;
  return;
 fi 

 local behind=$(originBehindCount);

 if [ $behind -gt 15 ]; then
  icon=$ship;
 elif [ $behind -gt 5 ]; then
  icon=$truck;
 else
  icon=$car;
 fi

 prompt $icon "Receiving [$behind] package$(plural $behind) from tracked destination" $verbose;

 if ! $(run "git pull origin $branch"); then
  echo false;
  return;
 fi

 if $(isBehindOrigin); then
  prompt $boom "Failed to receive packages from tracked exporter" $verbose;
  echo false;
  return;
 fi
 
 prompt $tada "Successfully received [$behind] package$(plural $behind)" $verbose;
 echo true;
}

