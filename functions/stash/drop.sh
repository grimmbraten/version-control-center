# drop stash by passed index/name
stash-drop() {
 if ! $(oneArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 local index=$1;
 local stash="stash@{$1}";

 # check if index is a number
 if ! $(isNaN $index); then
  index=$(parseInt $1);
  stash=$1;
 fi

 # store total count of local stashes
 local stashes=$(stashes);

 # check that passed index is within the scope of total count of local stashes
 if [ $index -gt $(($stashes - 1)) ]; then
  prompt $telescope "**$stash.. does not exist";
  return;
 fi

 # drop changes from selected local stash
 if ! $(run "git stash drop $stash"); then
  echo false;
  return;
 fi

 successfully "Dropped **$stash..";
 echo true;
}