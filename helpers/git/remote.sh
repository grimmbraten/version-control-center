# check if passed branch exists on remote
remote-exists() {
 if [ $(trim $(git branch -a | egrep remotes/origin/$1 | wc -l)) -eq 1 ]; then;
  echo true;
 else
  echo false;
 fi
}

# check if current/passed remote branch is ahead of its local branch
remote-ahead-of-locale() {
 echo $(local-behind-remote $@);
}

# check if current/passed remote branch is behind its local branch
remote-behind-of-locale() {
 echo $(local-ahead-of-remote $@);
}

# check if current/passed remote branch is ahead of master
remote-ahead-of-master() {
 local plant=$(_get-plant $@);

 if $(remote-exists master) && ! $(isEmpty $plant); then
  echo $(git rev-list --right-only --count origin/master...origin/$plant);
 else
  echo 0;
 fi
}

# check if current/passed remote branch is behind master
remote-behind-master() {
 local plant=$(_get-plant $@);

 if $(remote-exists master) && ! $(isEmpty $plant); then
  echo $(git rev-list --left-only --count origin/master...origin/$plant);
 else
  echo 0;
 fi
}
