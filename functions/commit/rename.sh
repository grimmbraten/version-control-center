# change title of latest commit
commit-rename() {
 if ! $(threeArguments $@); then
  invalid;
  echo false;
  return;
 fi

 # check if remote branch exists and that local is not ahead of remote
 if ( $(remote-branch-exists $(working-branch)) && $(local-ahead-of-remote) -eq 0 ); then
  prompt $telescope "Package has already been delivered";
  echo false;
  return;
 fi
 
 if $(isEmpty $2); then
  # change title of latest commit
  if ! $(run "git commit --amend -m \"$1\""); then
   echo false;
   return;
  fi
 else
  # change title and description of latest commit
  if ! $(run "git commit --amend -m \"$1\" -m \"$2\""); then
   echo false;
   return;
  fi
 fi
 
 successfully "Relabeled package ##($(branch-hash)..";
 echo true;
}