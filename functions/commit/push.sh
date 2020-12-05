commit-push() {
 if ! $(isCalledWithOneOrTwoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if ( $(commit $1 "$2") && ! $(push) ); then
  $(commit-undo);
 fi
}

commit-all-push() {
 if ! $(isCalledWithOneOrTwoArguments $@); then
  invalid;
  echo false;
  return;
 fi

 if ( $(stage .) && ! $(commit $1 "$2") ); then
  $(unstage "");
  echo false;
  return;
 fi
  
 if ! $(push); then
  $(commit-undo);
  echo false;
 else
  echo true;
 fi
}