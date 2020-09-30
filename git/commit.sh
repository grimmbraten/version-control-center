commit() { 
 spacer;

 if ! $(isValidCommit $@); then
  invalid "gc <description> [body]";
 else
  if $(runCommitRequest $1 "$2" true); then
   runStatusRequest;
  fi
 fi

 spacer;
}

commitPush() {
 spacer;

 if ! $(isValidCommit $@); then
  invalid "gcp <description> [body]";
 else
  if ( $(runCommitRequest $1 "$2" true) && ! $(runPushRequest true) ); then
   $(runCommitUndoRequest true);
  fi
 fi
 
 spacer;
}

commitAll() {
 spacer;

 if ! $(isValidCommit $@); then
  invalid "gca <description> [body]";
 else
  if ( $(runStageRequest . true) && ! $(runCommitRequest $1 "$2" true) ); then
   $(runUnstageRequest "" true);
  fi
 fi

 spacer;
}

commitAllPush() {
 spacer;

 if ! $(isValidCommit $@); then
  invalid "gcap <description> [body]";
 else
  if ( $(runStageRequest . true) && ! $(runCommitRequest $1 "$2" true) ); then
   $(runUnstageRequest "" true);
   return;
  fi
  
  if ! $(runPushRequest true); then
   $(runCommitUndoRequest true);
  fi
 fi

 spacer;
}

# $1: string(description), $2: string(body), $3 boolean(verbose)
runCommitRequest() {
 if [ $(onBranch) = master ]; then
  prompt $lock "Master is protected from direct changes, please create a new branch _(permission denied)]" $3;
  echo false;
  return;
 fi

 local before=$(stagedCount);
 local description=$(addEmoji $1);

 if [ -z $description ]; then
  prompt $thinking "Could not find a matching commit type, please use [gct] to view all valid commit types" $3;
  echo false;
  return;
 fi
 
 if [ -z $2 ]; then
  if ! $(run "git commit -m \"$description\""); then
   echo false;
   return;
  fi
 else
  if ! $(run "git commit -m \"$description\" -m \"$2\""); then
   echo false;
   return;
  fi
 fi

 local after=$(stagedCount);
 
 local changeCount=$(($before - $after));

 if [ $changeCount -eq 0 ]; then
  prompt $disappointed "There are no packages ready to be assigned an identity" $3;
  echo false;
  return;
 fi

 prompt $package "Assigned [$(identity)] to package containing [$changeCount] file$(plural $changeCount)" $3;
 echo true;
}

commitUndo() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gcu";
 else
  if $(runCommitUndoRequest true); then
   runStatusRequest;
  fi  
 fi

 spacer;
}

# $1: boolean(verbose)
runCommitUndoRequest() {
 local identity=$(identity);

 if ! $(run "git reset --soft HEAD~1"); then
  echo false;
  return;
 fi

 local stagedCount=$(stagedCount);
 prompt $package "Unassigned [$identity] from package containing [$stagedCount] file$(plural $stagedCount)" $1;
 echo true;
}

commitRename() {
 spacer;

 if ! $(isValidCommit $@); then
  invalid "gcr <description> [body]";
 else
  $(runCommitRenameRequest $1 "$2" true);
 fi

 spacer;
}

# $1: string(description), $2: string(body), $3: boolean(verbose)
runCommitRenameRequest() {
 if ( $(hasOrigin) && [ $(originAheadCount) -eq 0 ] ) || [ $(masterAheadCount) -eq 0 ]; then
  prompt $disappointed "Package description can not be changed after it has been delivered" $3;
  echo false;
  return;
 fi
 
 if [ -z $2 ]; then
  if ! $(run "git commit --amend -m \"$(addEmoji $1)\""); then
   echo false;
   return;
  fi
 else
  if ! $(run "git commit --amend -m \"$(addEmoji $1)\" -m \"$2\""); then
   echo false;
   return;
  fi
 fi
 
 prompt $package "Changed [$(identity)] package description" $3;
 echo true;
}

addEmoji() {
 local type=$(split $1 ":" 1);
 local description=$(split $1 ":" 2);

 if [ $type != $description ]; then
  while read line; do
   if $(contains $line $type); then
    echo "$(split $line "=" 2) $(capitalize "$(trim $description)")";
    return;
   fi
  done <$types/commit.txt
 fi

 echo "";
}

isValidCommit() {
 if [[ ! -z $3 || -z $1 ]]; then
  echo false;
 else
  echo true;
 fi
}