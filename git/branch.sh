branches() {
 if [ -z $1 ]; then
  git branch -v | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
 else
  invalid "gb";
 fi
}

branchOrigins() {
 if [ -z $1 ]; then
  git branch -r -vv | cut -c 3- | awk '$3 !~/\[/ { print $1 }';
 else
  invalid "gbo";
 fi
}

branchRename() {
 if [ -z $1 ]; then
  missing "What should the branch be renamed to?";
 elif [ ! -z $2 ]; then
  invalid "gbr <name>";
 else
  $(runBranchRenameRequest $1 true);
 fi
}

runBranchRenameRequest() {
 local name=$1;
 local output=$2;

 if ! $(existsInFile $name branch.txt); then
  prompt $construction "$name is not a valid branch prefix, enter [gbp] to display all allowed prefixes" $output;
  return;
 fi

 if $(hasBranch $1) || $(hasOrigin $1); then
  prompt $construction "Branch already exists" $output;
  echo false;
  return;
 fi

 local branch=$(onBranch);

 if ! $(run "git branch -m $1"); then
  echo false;
  return;
 fi

 if $(hasOrigin $branch); then
  #TODO: check if question can be function can be better
  if $(question "Rename branch found in tracked destination?"); then
   if ! $(runPushUpstreamRequest none true); then    
    echo false;
    return;
   fi
  
   if ! $(runDeleteBranchOriginRequest $branch true); then    
    echo false;
    return;
   fi

   prompt $tada "Successfully renamed branch and origin without any issues" $output;
   echo true;
   return;
  fi
 fi

 prompt $tada "Successfully renamed branch without any issues" $output;
 echo true;
}

deleteBranch() {
 local branch=$(onBranch);

 if [[ "$1" = master || ( -z $1 && $branch = master ) ]]; then
  prompt $lock "Master is protected from being deleted _(permission deined)]";
 elif ( [ -z $1 ] && $(question "Do you want to delete branch from tracked destination?") ); then
  $(processDeleteBranchRequest $branch true);
 else
  $(processDeleteBranchRequest $1 true);
 fi
}

runDeleteBranchRequest() {
 local branch=$1;
 local output=$2;
 local localBranch=$(onBranch);

 if [ $branch = $localBranch ]; then
  $(runCheckoutRequest master);
 fi

 if ! $(run "git branch -D $branch"); then
  if [ $branch = $localBranch ]; then
   $(runCheckoutRequest $branch);
  fi

  echo false;
  return;
 fi  

 if ! ( $(hasOrigin $branch) && ! $(question "Do you also want to delete branch from tracked destination?") ); then
  prompt $tada "Successfully deleted [$branch] without any issues" $output;
  echo true;
  return;
 fi

 if ! $(runDeleteBranchOriginRequest $branch true); then  
  echo false;
  return;
 fi

 $(runFetchRequest);

 prompt $tada "Successfully deleted [$branch] and [origin/$branch] without any issues" $output;
 echo true;
}

deleteBranchOrigin() {
 local branch=$(onBranch);

 if [[ "$1" = master || ( -z $1 && $branch = master ) ]]; then
  prompt $lock "Master is protected from being deleted _(permission deined)]";
 elif ( [ -z $1 ] && $(question "Do you want to delete branch from tracked destination") ); then
  $(runDeleteBranchOriginRequest $branch true);
 else
  $(runDeleteBranchOriginRequest $1 true);
 fi
}

runDeleteBranchOriginRequest() {
 local branch=$1;
 local output=$2;
 
 if ! $(hasOrigin $branch); then
  prompt $dissapointed "Branch does not exist in tracked destination" $output;
  echo false;
  return;
 fi

 if ! $(run "git push origin --delete $branch"); then
  echo false;
  return;
 fi

 $(runFetchRequest);

 prompt $tada "Successfully deleted [origin/$branch] without any issues" $output;
 echo true;
}
