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

 local branch=$(onBranch);
 local ahead=$(localAheadCount); 

 if [ $ahead -eq 0 ]; then
  prompt $tadaIcon "Local branch _($(identity))] is already [up to date] with remote origin _($(identity origin/$branch))]" $1;
  echo false;
  return;
 fi

 local behind=$(localBehindCount);

 if [ $behind -gt 0 ]; then
  prompt $alert "Local branch _($(identity))] is [$behind package$(plural $behind)] behind] remote origin _($(identity origin/$branch))]" $1;
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $ahead) "Delivering [$ahead package$(plural $ahead)] to remote origin _($(identity origin/$branch))]" $1;

 local previousIdentity=$(identity origin/$branch);

 if ! $(run "git push origin $branch"); then  
  echo false;
  return;   
 fi

 if [ ! $(originAheadCount) -eq 0 ]; then
  prompt $boomIcon "Failed to deliver packages, something went wrong along the way" $1; 
  echo false;
  return;
 fi 

 prompt $tadaIcon "Successfully delivered local branch _($(identity))] to remote origin" $1;
 echo true;
}

# $1: boolean (verbose)
runPushUpstreamRequest() {
 local branch=$(onBranch);

 if $(hasRemoteBranch); then
  prompt $telescopeIcon "Detected remote origin _($(identity origin/$branch))]" $1;
  #TODO: Create a question prompt asking if the user wants to use regular push instead
  #echo $(runPushRequest true);
  return;
 fi

 local changes=$(masterBehindCount); 

 prompt $buildingConstructionIcon " Creating remote origin for local branch _($(identity))]" $1;
 
 if [ $changes -gt 0 ]; then
  prompt $(getDeliveryIcon $changes) "Delivering [$changes package$(plural $changes)] to remote origin" $1;
 fi

 if ! $(run "git push --set-upstream origin $branch"); then
  echo false;
  return;   
 fi
 
 if [ $changes -gt 0 ]; then
  prompt $tadaIcon "Successfully delivered package$(plural $changes) to remote origin _$(identity origin/$branch))]" $1;
 else
  prompt $tadaIcon "Successfully created remote origin _$(identity origin/$branch))]" $1;
 fi
 
 echo true;
}