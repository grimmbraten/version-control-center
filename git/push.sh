push() {
 if [ ! -z $1 ]; then
  invalid "gp";
  
 else
  $(runPushRequest true);
 fi
}

#TODO: Make prompts more intuitive (use steps) checking, delivering, success
runPushRequest() {
 local verbose=$1;
 local branch=$(onBranch);
 local icon;

 if ! $(hasOrigin); then
  prompt $construction "Branch does not have a tracked destination" $verbose;
  echo false;
  return;
 fi

 local ahead=$(originAheadCount);
 local behind=$(originBehindCount);

 if [ $ahead -lt 1 ]; then
  prompt $disappointed "There are no packages ready for delivery _($behind package$(plural $behind)/$ahead package$(plural $ahead))]" $verbose;
  echo false;
  return;
 fi

 if [ $behind -gt 0 ]; then
  if ! $(confirmIdentity "deliver [$ahead] package$(plural $ahead) from local branch which is behind its tracked destination _($behind package$(plural $behind)/$ahead package$(plural $ahead))]"); then  
   echo false;
   return;
  fi
 fi

 if [ $ahead -gt 15 ]; then
  icon=$ship;
 elif [ $ahead -gt 5 ]; then
  icon=$truck;
 else
  icon=$car;
 fi

 prompt $icon "Delivering [$ahead] package$(plural $ahead) to tracked destination" $verbose;

 if ! $(run "git push origin $branch"); then  
  echo false;
  return;   
 fi

 if [ ! $(originAheadCount) -eq 0 ]; then
  prompt $boom "Failed to deliver packages to tracked destination" $verbose; 
  echo false;
  return;
 fi 

 prompt $tada "Successfully delivered [$ahead] package$(plural $ahead)" $verbose;
 echo true;
}

pushUpstream() {
 local flag="none";

 if [ ! -z $1 ]; then
  if [ ! -z $2 ]; then
   invalid "gpu [flag]";
   return;
  fi

  flag=$1;
 fi

 $(runPushUpstreamRequest $flag true);
}

runPushUpstreamRequest() {
 local flag=$1;
 local verbose=$2;
 local branch=$(onBranch);
 local icon;

 if $(hasOrigin); then
  prompt $construction "Branch already has a tracked destination" $verbose;
  echo false;
  return;
 fi

 local ahead=$(masterAheadCount);

 if ( [ $ahead -eq 0 ] && [[ "$flag" != "-force" || "$flag" != "-f" ]] ); then
  local behind=$(masterBehindCount); 
  
  prompt $disappointed "There are no packages ready for delivery _($behind package$(plural $behind)/$ahead package$(plural $ahead))]" $verbose;
  echo false;
  return;
 fi

 if [ $ahead -gt 15 ]; then
  icon=$ship;
 elif [ $ahead -gt 5 ]; then
  icon=$truck;
 else
  icon=$car;
 fi

 prompt $icon "Delivering [$ahead] package$(plural $ahead)] and tracks destination" $verbose;

 if ! $(run "git push --set-upstream origin $branch"); then
  echo false;
  return;   
 fi

 prompt $tada "Successfully delivered [$ahead] package$(plural $ahead) and tracked destination" $verbose;
 echo true;
}