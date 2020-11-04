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
 if ! $(hasRemoteBranch); then
  prompt $constructionIcon "Branch does not have a remote origin" $1;
  echo false;
  return;
 fi

 local branch=$(onBranch);
 local behind=$(localBehindCount);

 if [ $behind -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with remote origin" $1;
  echo false;
  return;
 fi 

 prompt $(getDeliveryIcon $behind) "Receiving [$behind] package$(plural $behind)" $1;

 if ! $(run "git pull origin $onBranch"); then
  echo false;
  return;
 fi

 if $(isBehindOrigin); then
  prompt $boomIcon "Failed to receive package$(plural $behind)" $1;
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully received package$(plural $behind)" $1;
 echo true;
}

