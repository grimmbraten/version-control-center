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
 if ! $(hasRemoteBranch); then
  prompt $constructionIcon "Local branch _($(identity))] does not yet have a remote origin" $1;
  echo false;
  return;
 fi

 local onBranch=$(onBranch);
 local ahead=$(localAheadCount); 

 if [ $ahead -eq 0 ]; then
  prompt $tadaIcon "Local branch _($(identity))] is already [up to date] with remote origin _($(identity origin/$onBranch))]" $1;
  echo false;
  return;
 fi

 local behind=$(localBehindCount);

 if [ $behind -gt 0 ]; then
  prompt $alert "Local branch _($(identity))] is [$behind package$(plural $behind)] behind] remote origin _($(identity origin/$onBranch))]" $1;
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $ahead) "Delivering [$ahead package$(plural $ahead)] to remote origin _($(identity origin/$onBranch))]" $1;

 local previousIdentity=$(identity origin/$onBranch);

 if ! $(run "git push origin $onBranch"); then  
  echo false;
  return;   
 fi

 if [ ! $(originAheadCount) -eq 0 ]; then
  prompt $boomIcon "Failed to deliver packages, something went wrong along the way" $1; 
  echo false;
  return;
 fi 

 prompt $tadaIcon "Successfully delivered local branch _($(identity))] into remote origin _($previousIdentity)] without any issues" $1;
 echo true;
}

# $1: boolean (verbose)
runPushUpstreamRequest() {
 local onBranch=$(onBranch);

 if $(hasRemoteBranch); then
  prompt $telescopeIcon "Detected remote origin _($(identity origin/$onBranch))]" $1;
  #TODO: Create a question prompt asking if the user wants to use regular push instead
  #echo $(runPushRequest true);
  return;
 fi

 local ahead=$(masterAheadCount);

 if [ $ahead -eq 0 ]; then
  prompt $(getDeliveryIcon $ahead) "Creating a new remote origin for local branch _($(identity))]" $1;
 else  
  prompt $(getDeliveryIcon $ahead) "Delivering [$ahead package$(plural $ahead)] into new remote origin" $1;
 fi

 if ! $(run "git push --set-upstream origin $onBranch"); then
  echo false;
  return;   
 fi

 prompt $tadaIcon "Successfully delivered _($(identity))] into a new remote branch _$(identity origin/$onBranch))] without any issues" $1;
 echo true;
}