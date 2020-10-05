pull() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gpl";
 else
  $(runPullRequest true);
 fi

 spacer;
}

# $1: boolean (verbose)
runPullRequest() {
 local icon;

 $(runFetchRequest);
 local branch=$(onBranch);

 if ! $(hasOrigin); then
  prompt $surprisedIcon "Oh no, branch does not exist on remote repository" $1;
  echo false;
  return;
 fi

 local behind=$(originBehindCount);

 if [ $behind -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with [$(identity origin/$branch)], no pull is needed" $2;
  echo false;
  return;
 fi 

 prompt $(getDeliveryIcon $behind) "Receiving [$behind package$(plural $behind)] from remote branch" $1;

 if ! $(run "git pull origin $branch"); then
  echo false;
  return;
 fi

 if $(isBehindOrigin); then
  prompt $boomIcon "Failed to receive packages from remote branch" $1;
  echo false;
  return;
 fi
 
 prompt $tadaIcon "Successfully received [$behind package$(plural $behind)]" $1;
 echo true;
}

