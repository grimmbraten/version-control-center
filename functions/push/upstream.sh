# push commits to new remote origin and set upstream
push-upstream() {
 if ! $(noArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # check if a remote origin already exists
 if $(remote-branch-exists $(working-branch)); then
  prompt $telescope $ROE;
  #TODO: Create a question prompt asking if the user wants to use regular push instead
  #echo $(runPushRequest true);
  return;
 fi

 # store total count of commits ahead of remote master
 local changes=$(local-ahead-of-master); 

 prompt $crane " Building remote origin";
 
 if ! $(isZero $changes); then
  prompt $(getDeliveryIcon $changes) "Delivering **$changes.. package$(pluralize $changes)";
 fi

 # push branch to new remote origin and set upstream
 if ! $(run "git push --set-upstream origin $(working-branch)"); then
  #TODO: echo failed prompt
  echo false;
  return;   
 fi
 
 if ! $(isZero $changes); then
  successfully "Delivered package$(pluralize $changes)";
 else
  successfully "Built remote origin";
 fi

 #TODO: Add a prompt to output branch url so that the user can visit the remote origin easily
 # https://github.com/GITHUB_USERNAME/PROJECT_NAME/tree/BRANCH_NAME
 
 echo true;  
}