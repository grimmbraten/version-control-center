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
  prompt $constructionIcon "Branch does not have a remote origin" $1;
  echo false;
  return;
 fi

 local branch=$(onBranch);
 local ahead=$(localAheadCount); 

 if [ $ahead -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with remote origin" $1;
  echo false;
  return;
 fi

 local behind=$(localBehindCount);

 if [ $behind -gt 0 ]; then
  prompt $alert "Branch is [$behind] package$(plural $behind) behind remote origin" $1;
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $ahead) "Delivering [$ahead] package$(plural $ahead)" $1;

 if ! $(run "git push origin $branch"); then  
  echo false;
  return;   
 fi

 if [ ! $(originAheadCount) -eq 0 ]; then
  prompt $boomIcon "Failed to deliver package$(plural $ahead)" $1; 
  echo false;
  return;
 fi 

 prompt $tadaIcon "Successfully delivered package$(plural $ahead)" $1;
 echo true;
}

# $1: boolean (verbose)
runPushUpstreamRequest() {
 local branch=$(onBranch);

 if $(hasRemoteBranch); then
  prompt $telescopeIcon "Branch already has a remote origin" $1;
  #TODO: Create a question prompt asking if the user wants to use regular push instead
  #echo $(runPushRequest true);
  return;
 fi

 local changes=$(masterBehindCount); 

 prompt $buildingConstructionIcon " Building remote origin" $1;
 
 if [ $changes -gt 0 ]; then
  prompt $(getDeliveryIcon $changes) "Delivering [$changes] package$(plural $changes)" $1;
 fi

 if ! $(run "git push --set-upstream origin $branch"); then
  echo false;
  return;   
 fi
 
 if [ $changes -gt 0 ]; then
  prompt $tadaIcon "Successfully delivered package$(plural $changes)" $1;
 else
  prompt $tadaIcon "Successfully built remote origin" $1;
 fi

 #TODO: Add a prompt to output branch url so that the user can visit the remote origin easily
 # https://github.com/GITHUB_USERNAME/PROJECT_NAME/tree/BRANCH_NAME
 
 echo true;
}