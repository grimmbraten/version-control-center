# undo latest commit
commit-undo() {
 if ! $(noArguments $@); then
  invalid;
  echo false;
  return;
 fi
 
 # store total count of staged files before undo
 local before=$(staged);

 # undo latest commit
 if ! $(run "git reset --soft HEAD~1"); then
  echo false;
  return;
 fi

 # store total count of staged files after undo
 local after=$(staged);

 # # calculate total count of files undone from latest commit
 local undone=$(($after - $before));
 
 # prompt file changes
 $(status-list true);

 successfully "Unsealed package with **$undone.. file$(pluralize $undone)";
 echo true;
}