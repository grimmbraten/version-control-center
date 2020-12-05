stash-drop() {
 if ! $(isCalledWithOneArgument $@); then
  invalid;
  echo false;
  return;
 fi
 
 local index;
 local stash;

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

 if ! $(run "git stash drop $stash"); then
  echo false;
  return;
 fi

 successfully "Dropped *$stash";
 echo true;
}