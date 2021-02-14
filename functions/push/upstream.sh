push-upstream() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if $(remote-exists $(growing-plant)); then
  prompt $telescope $remoteOriginAlreadyExists;
  #TODO: Create a question prompt asking if the user wants to use regular push instead
  #echo $(runPushRequest true);
  return;
 fi

 local changes=$(packages-ahead-of-master); 

 prompt $crane " Building remote origin";
 
 if ! $(isZero $changes); then
  prompt $(getDeliveryIcon $changes) "Delivering *$changes. package$(pluralize $changes)";
 fi

 if ! $(run "git push --set-upstream origin $(growing-plant)"); then
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