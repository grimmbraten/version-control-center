commit() { 
 spacer;

 if ! $(isValidCommit $@); then
  invalid "gc <description> [body]";
 else
  $(runCommitRequest $1 "$2" true);
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

commitUndo() {
 spacer;

 if [ ! -z $1 ]; then
  invalid "gcu";
 else
  $(runCommitUndoRequest true);
 fi

 spacer;
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

# $1: string  (label)
# $2: string  (description)
# $3: boolean (verbose)
runCommitRequest() {
 if [ $(onBranch) = master ]; then
  prompt $lockIcon "Branch [master] is protected from changes" $3;
  echo false;
  return;
 fi

 local staged=$(stagedCount);

 if [ $staged -eq 0 ]; then
  prompt $telescopeIcon "No package ready to be sealed" $3;
  echo false;
  return;
 fi
 
 local label=$(addEmoji $1);

 if [ -z $label ]; then
  label=$1;
 fi
 
 if [ -z $2 ]; then
  if ! $(run "git commit -m \"$label\""); then
   echo false;
   return;
  fi
 else
  if ! $(run "git commit -m \"$label\" -m \"$(capitalize $2)\""); then
   echo false;
   return;
  fi
 fi
 
 if [[ "$3" = true && $(changeCount) -gt 0 ]]; then
  mention "$(git -c color.status=always status --short)\n";
 fi

 prompt $tadaIcon "Successfully sealed package with [$staged] file$(plural $staged)" $3;
 prompt $packageIcon "[$(identity)]" $3;
 prompt $(getEmojiForConsole $1) "$(trim "$(split $1 ":" 2)")" $3;

 if [ ! -z $2 ]; then
  prompt $descriptionIcon "$2" $3;
 fi

 echo true;
}

# $1: boolean (verbose)
runCommitUndoRequest() {
 local identity=$(identity);

 local before=$(stagedCount);

 if ! $(run "git reset --soft HEAD~1"); then
  echo false;
  return;
 fi

 local after=$(stagedCount);
 local undone=$(($after - $before));
 
 if [ "$1" = true ]; then
  mention "$(git -c color.status=always status --short)\n";
 fi

 prompt $tadaIcon "Successfully unsealed package with [$undone] file$(plural $undone)" $3;
 echo true;
}

# $1: string  (label)
# $2: string  (description)
# $3: boolean (verbose)
runCommitRenameRequest() {
 if ( $(hasRemoteBranch) && [ $(originAheadCount) -eq 0 ] ) || [ $(masterAheadCount) -eq 0 ]; then
  prompt $surprisedIcon "Unable to rename package after it has been delivered" $3;
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
 
 prompt $tadaIcon "Successfully relabeled package _($(identity)]" $3;
 echo true;
}

addEmoji() { 
 local type=$(split $1 ":" 1);
 local description=$(split $1 ":" 2);

 if [ $type != $description ]; then
  while read line; do
   if $(contains $line $type); then
    echo "$(split $(split $line "-" 1) "=" 2) $(trim $description)";
    return;
   fi
  done <$types/commit.txt
 fi

 echo "";
}

getEmojiForConsole() {
 local type=$(split $1 ":" 1);

 while read line; do
  if $(contains $line $type); then
   echo "\\$(split $line "-" 2)";
   return;
  fi
 done <$types/commit.txt

 echo $bookmarkIcon;
}

isValidCommit() {
 if [[ ! -z $3 || -z $1 ]]; then
  echo false;
 else
  echo true;
 fi
}