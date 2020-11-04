push() {
 if [ ! -z $1 ]; then
  invalid "gp";
  echo false;
  return;
 fi

 if ! $(hasRemoteBranch); then
  prompt $constructionIcon "Branch does not have a remote origin";
  echo false;
  return;
 fi

 local branch=$(onBranch);
 local ahead=$(localAheadCount); 

 if [ $ahead -eq 0 ]; then
  prompt $tadaIcon "Branch is already [up to date] with remote origin";
  echo false;
  return;
 fi

 local behind=$(localBehindCount);

 if [ $behind -gt 0 ]; then
  prompt $alert "Branch is [$behind] package$(plural $behind) behind remote origin";
  echo false;
  return;
 fi

 prompt $(getDeliveryIcon $ahead) "Delivering [$ahead] package$(plural $ahead)";

 if ! $(run "git push origin $branch"); then  
  echo false;
  return;   
 fi

 if [ ! $(originAheadCount) -eq 0 ]; then
  prompt $boomIcon "Failed to deliver package$(plural $ahead)"; 
  echo false;
  return;
 fi 

 prompt $tadaIcon "Successfully delivered package$(plural $ahead)";
 echo true;
}

push-upstream() {
 if [ ! -z $1 ]; then  
  invalid "gpu";
  echo false;
  return;
 fi

 local branch=$(onBranch);

 if $(hasRemoteBranch); then
  prompt $telescopeIcon "Branch already has a remote origin";
  #TODO: Create a question prompt asking if the user wants to use regular push instead
  #echo $(runPushRequest true);
  return;
 fi

 local changes=$(masterBehindCount); 

 prompt $buildingConstructionIcon " Building remote origin";
 
 if [ $changes -gt 0 ]; then
  prompt $(getDeliveryIcon $changes) "Delivering [$changes] package$(plural $changes)";
 fi

 if ! $(run "git push --set-upstream origin $branch"); then
  echo false;
  return;   
 fi
 
 if [ $changes -gt 0 ]; then
  prompt $tadaIcon "Successfully delivered package$(plural $changes)";
 else
  prompt $tadaIcon "Successfully built remote origin";
 fi

 #TODO: Add a prompt to output branch url so that the user can visit the remote origin easily
 # https://github.com/GITHUB_USERNAME/PROJECT_NAME/tree/BRANCH_NAME
 
 echo true;  
}