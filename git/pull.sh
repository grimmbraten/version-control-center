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
  prompt $constructionIcon "Local branch _($(identity))] does not yet have a remote origin" $1;
  echo false;
  return;
 fi

 local branch=$(onBranch);
 local behind=$(originBehindCount);

 if [ $behind -eq 0 ]; then
  prompt $tadaIcon "Local branch _($(identity))] is already [up to date] with remote origin _($(identity origin/$branch))]" $1;
  echo false;
  return;
 fi 

 prompt $(getDeliveryIcon $behind) "Receiving [$behind package$(plural $behind)] from remote origin _($(identity))]" $1;

 if ! $(run "git pull origin $onBranch"); then
  echo false;
  return;
 fi

 if $(isBehindOrigin); then
  prompt $boomIcon "Failed to receive packages, something went wrong along the way" $1;
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully received package$(plural $behind) from remote origin" $1;
 echo true;
}

