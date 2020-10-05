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

 if ! $(hasOrigin); then
  prompt $surprisedIcon "Oh no, branch does not exist on remote repository" $1;
  echo false;
  return;
 fi

 local ahead=$(aheadCount); 

 if [ $ahead -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with [$(identity origin/$onBranch)] _(push is not needed)]" $2;
  echo false;
  return;
 fi

 local behind=$(behindCount);

 if [ $behind -gt 0 ]; then
  prompt $alert "Branch is [$behind package$(plural $behind)] behind] remote branch _(please pull before you push)]" $1;
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

 prompt $tadaIcon "Successfully delivered [$ahead package$(plural $ahead)] without any issues" $1;
 echo true;
}

# $1: boolean (verbose)
runPushUpstreamRequest() {
 local onBranch=$(onBranch);

 if $(hasOrigin); then
  prompt $telescopeIcon "Detected an already existing remote branch, using normal push instead" $1;
  echo $(runPushRequest true);
  return;
 fi

 local ahead=$(masterAheadCount);

 if [ $ahead -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with [$(identity origin/master)] _(push upstream is not needed)]" $1;
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $ahead) "Delivering [$ahead package$(plural $ahead)] and creating a new remote branch" $1;

 if ! $(run "git push --set-upstream origin $onBranch"); then
  echo false;
  return;   
 fi

 prompt $tadaIcon "Successfully delivered [$ahead package$(plural $ahead)] without any issues" $1;
 echo true;
}