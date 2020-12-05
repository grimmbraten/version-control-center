plant-origin-exists() {
 if [ $(trim $(git branch -a | egrep remotes/origin/$1 | wc -l)) -eq 1 ]; then;
  echo true;
 else
  echo false;
 fi
}

plant-origin-ahead() {
 if [ -z $1 ]; then
  echo $(git rev-list --right-only --count $(growing-plant)...origin/$(growing-plant));
 else
  echo 0;
 fi
}

plant-origin-behind() {
 local plant=$(growing-plant);

 if $(plant-origin-exists $plant); then
  echo $(git rev-list --left-only --count $plant...origin/$(growing-plant));
 else
  echo 0;
 fi
}