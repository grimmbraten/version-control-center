pull() {
 if [ ! -z $1 ]; then
  invalid "gpl";
  echo false;
  return;
 fi

 if ! $(hasRemoteBranch); then
  prompt $constructionIcon "Branch does not have a remote origin";
  echo false;
  return;
 fi

 local branch=$(onBranch);
 local behind=$(localBehindCount);

 if [ $behind -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with remote origin";
  echo false;
  return;
 fi 

 prompt $(getDeliveryIcon $behind) "Receiving [$behind] package$(plural $behind)";

 if ! $(run "git pull origin $onBranch"); then
  echo false;
  return;
 fi

 if $(isBehindOrigin); then
  prompt $boomIcon "Failed to receive package$(plural $behind)";
  echo false;
  return;
 fi

 prompt $tadaIcon "Successfully received package$(plural $behind)";
 echo true;
}