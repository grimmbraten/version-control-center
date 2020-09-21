commit() {
 if [ -z $1 ]; then
  missing "What description do you want for the package?";
 elif [ ! -z $2 ]; then
  invalid "gc <description>";
 elif $(runCommitRequest $1 true); then
  runStatusRequest;
 fi
}

commitPush() {
 if [ -z $1 ]; then
  missing "What description do you want for the package?";
  return;
 elif [ ! -z $2 ]; then
  invalid "gcp <description>";
  return;
 fi

 if ( $(runCommitRequest $1 true) && ! $(runPushRequest true) ); then
  $(runCommitUndoRequest true);
  return;
 fi
}

commitAll() {
 if [ -z $1 ]; then
  missing "What description do you want for the package?";
  return;
 elif [ ! -z $2 ]; then
  invalid "gca <description>";
  return;
 fi

 if ( $(stageAll true) && ! $(runCommitRequest $1 true) ); then
  $(unstageAll true);
 fi
}

commitAllPush() {
 if [ -z $1 ]; then
  missing "What description do you want for the package?";
  return;
 elif [ ! -z $2 ]; then
  invalid "gcap <description>";
  return;
 fi

 if ( $(stageAll true) && ! $(runCommitRequest $1 true) ); then
  $(unstageAll true);
 fi

 if ! $(runPushRequest true); then
  $(runCommitUndoRequest true);
  return;
 fi
}

runCommitRequest() {
 local description=$1;
 local output=$2;

 if [ $(onBranch) = master ]; then
  prompt $lock "Master is protected from direct changes, please create a new branch _(permission deined)]" $output;
  echo false;
  return;
 fi

 local before=$(stagedCount);

 #TODO: Improve commit to follow commit standards with subject, body etc.
 if ! $(run "git commit -m \"$1\""); then
  echo false;
  return;
 fi

 local after=$(stagedCount);
 local changes=$(($before - $after));

 if [ $changes -eq 0 ]; then
  prompt $dissapointed "There are no packages ready to be assigned an identity" $output;
  echo false;
  return;
 fi

 prompt $package "Assigned [$(identity)] to package containing [$changes] file$(plural $changes)" $output;
 echo true;
}

commitUndo() {
 if [ ! -z $1 ]; then
  invalid "gcu";
  return;
 fi

 if $(runCommitUndoRequest true); then
  runStatusRequest;
 fi   
}

runCommitUndoRequest() {
 local output=$1;
 local identity=$(identity);

 if ! $(run "git reset --soft HEAD~1"); then
  echo false;
  return;
 fi

 local staged=$(stagedCount);
 
 prompt $package "Unassigned [$identity] from package containing [$staged] file$(plural $staged)" $output;
 echo true;
}

commitRename() {
 if [ -z $1 ]; then
  missing "What description for the package do you want to use instead?";
  return;
 elif [ ! -z $2 ]; then
  invalid "gcr <description>";
  return;
 fi

 $(runCommitRenameRequest $1 true);  
}

runCommitRenameRequest() {
 local description=$1;
 local output=$2;

 if $(hasOrigin); then
  if [ $(originAheadCount) -eq 0 ]; then
   prompt $dissapointed "Package description can not be changed after it has been delivered" $output;
   echo false;
   return;
  fi
 else
  if [ $(masterAheadCount) -eq 0 ]; then
   prompt $dissapointed "Package description can not be changed after it has been delivered" $output;
   echo false;
   return;
  fi
 fi

 if ! $(run "git commit --amend -m \"$description\""); then
  echo false;
  return;
 fi

 prompt $package "Changed [$(identity)] package description" $output;
 echo true;
}