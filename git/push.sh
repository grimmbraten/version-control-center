push() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gp";
  
 else
  $(runPushRequest true);
 fi

 spacer;
}

pushUpstream() {
 spacer;

 if [ ! -z $1 ]; then  
  invalid "gpu";
 else
  $(runPushUpstreamRequest true);
 fi

 spacer;
}

# $1: boolean (verbose)
runPushRequest() {
 local onBranch=$(onBranch);

 if ! $(hasRemoteBranch); then
  prompt $constructionIcon "Local branch _($(identity))] does not have a remote branch" $1;
  echo false;
  return;
 fi

 local ahead=$(localAheadCount); 

 if [ $ahead -eq 0 ]; then
  prompt $tadaIcon "Local branch _($(identity))] is already [up to date] with remote branch _($(identity origin/$onBranch))]" $1;
  echo false;
  return;
 fi

 local behind=$(localBehindCount);

 if [ $behind -gt 0 ]; then
  prompt $alert "Local branch _($(identity))] is [$behind package$(plural $behind)] behind] remote branch _($(identity origin/$onBranch))]" $1;
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $ahead) "Delivering [$ahead package$(plural $ahead)] to remote branch" $1;

 if ! $(run "git push origin $onBranch"); then  
  echo false;
  return;   
 fi

 if [ ! $(originAheadCount) -eq 0 ]; then
  prompt $boomIcon "Failed to deliver packages, something went wrong along the way" $1; 
  echo false;
  return;
 fi 

 prompt $tadaIcon "Successfully delivered _($(identity))] into _($(identity origin/$onBranch))] without any issues" $1;
 echo true;
}

# $1: boolean (verbose)
runPushUpstreamRequest() {
 local onBranch=$(onBranch);

 if $(hasRemoteBranch); then
  prompt $telescopeIcon "Detected existing remote branch _($(identity origin/$onBranch))], switching to use regular push" $1;
  echo $(runPushRequest true);
  return;
 fi

 local ahead=$(masterAheadCount);

 if [ $ahead -eq 0 ]; then
  prompt $tadaIcon "Local branch _($(identity))] is already [up to date] with remote branch _($(identity origin/$branch))]" $1;
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $ahead) "Delivering [$ahead package$(plural $ahead)] to remote _($(identity) -> $(repositoryUrl))]" $1;

 if ! $(run "git push --set-upstream origin $onBranch"); then
  echo false;
  return;   
 fi

 prompt $tadaIcon "Successfully delivered _($(identity))] into a new remote branch without any issues" $1;
 echo true;
}