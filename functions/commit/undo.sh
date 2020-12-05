commit-undo() {
 if ! $(isCalledWithNoArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 local before=$(bundled-leafs);

 if ! $(run "git reset --soft HEAD~1"); then
  echo false;
  return;
 fi

 local after=$(bundled-leafs);
 local undone=$(($after - $before));
 
 $(status-list true);

 successfully "Unsealed package with *$undone. file$(pluralize $undone)";
 echo true;
}