forest-ahead() {
 if ( $(plant-exists $1) || $(plant-origin-exists $1) ); then
  echo $(git rev-list --right-only --count $1...origin/master);
 else
  echo 0;
 fi
}

forest-behind() {
 if ( $(plant-exists $1) || $(plant-origin-exists $1) ); then
  echo $(git rev-list --left-only --count $1...origin/master);
 else
  echo 0;
 fi
}