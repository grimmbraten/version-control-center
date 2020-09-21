status() {
 if [ -z $1 ]; then
  runStatusRequest true;
 else
  invalid "gs";
 fi 
}

statusDetailed() {
 local ahead;
 local behind;

 if [ -z $1 ]; then
  spacer && git status && spacer;
 else
  invalid "gsd";
 fi
}

runStatusRequest() {
 local icon;
 local message;

 if ! $1; then
  git status --short && spacer;
  return;
 fi

 if $(hasOrigin); then
  ahead=$(originAheadCount);
  behind=$(originBehindCount);
 else
  ahead=$(masterAheadCount);
  behind=$(masterBehindCount);
 fi

 local changes=$(changeCount);

 if [ $changes -gt 20 ]; then
  icon=$evergreen;
  message="Your branch has aged into a rugged evergreen";
 elif [ $changes -gt 10 ]; then
  icon=$tree;
  message="Your branch has grown into a majestic tree";
 else
  icon=$plant; 
  message="Your branch has sprouted into a small plant";
 fi

 if [ $changes -eq 0 ]; then
  prompt $seedling "Your branch is a delicate seedling _( $behind - $ahead )]" true;
 else
  prompt $icon " $message with [$changes] file$(plural $changes) _( $(unstagedCount) / $(stagedCount) )]" true;
  spacer && git status --short;
 fi
}