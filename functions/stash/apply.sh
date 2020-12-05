stash-apply() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi
 
 local index;
 local stash;

 if $(hasUnstagedChanges); then
  prompt $constructionIcon $hasWorkInProgress;
  echo false;
  return;
 fi

 if ! $(isNaN $1); then
  index=$1;
  stash="stash@{$1}";
 else
  stash=$1;
  index=$(parseInt $1);
 fi

 local count=$(seeds);

 if [ $index -gt $(($count - 1)) ]; then
  prompt $telescopeIcon "*$stash. does not exist";
  return;
 fi

 if ! $(run "git stash apply $stash"); then
  echo false;
  return;
 fi

 local changes=$(leafs);
 successfully "Applied *$changes. stashed file$(pluralize $changes)";
 echo true;
}