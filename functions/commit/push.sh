# commit staged changes and push to remote origin
commit-push() {
 if ! $(threeArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # undo commit if commit succeeded but push failed
 if ( $(commit $1 "$2") && ! $(push) ); then
  $(commit-undo);
 fi
}

# commit all changes and push to remote origin
commit-all-push() {
 if ! $(threeArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # unstage if stage succeeded but commit failed
 if ( $(stage .) && ! $(commit $1 "$2") ); then
  $(unstage "");
  echo false;
  return;
 fi
  
 # undo commit if push failed
 if ! $(push); then
  $(commit-undo);
  echo false;
 else
  echo true;
 fi
}