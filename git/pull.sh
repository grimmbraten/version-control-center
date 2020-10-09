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
 $(runFetchRequest);
 local branch=$(onBranch);

 if ! $(hasRemoteBranch); then
  prompt $constructionIcon "Local branch _($(identity))] does not have a remote branch" $1;
  echo false;
  return;
 fi

 local behind=$(originBehindCount);

 if [ $behind -eq 0 ]; then
  prompt $tadaIcon "Local branch _($(identity))] is already [up to date] with remote branch _($(identity origin/$branch))]" $1;
  echo false;
  return;
 fi 

 prompt $(getDeliveryIcon $behind) "Receiving [$behind package$(plural $behind)] from remote branch" $1;

 local previousIdentity=$(identity);

 if ! $(run "git pull origin $branch"); then
  echo false;
  return;
 fi

 if $(isBehindOrigin); then
  prompt $boomIcon "Failed to receive packages, something went wrong along the way" $1;
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully received _($(identity))] into _($previousIdentity)] without any issues" $1;
 echo true;
}

