plant-exists() {
 if [ -n "$(git show-ref refs/heads/$1)" ]; then;
  echo true;
 else
  echo false;
 fi
}

plant-ahead() {
 if $(plant-exists $1); then
  echo $(git rev-list --right-only --count $1...$(growing-plant));
 else
  echo 0;
 fi
}

plant-behind() {
 if $(plant-exists $1); then
  echo $(git rev-list --left-only --count $1...$(growing-plant));
 else
  echo 0;
 fi
}