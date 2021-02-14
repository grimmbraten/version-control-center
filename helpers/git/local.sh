# check if passed branch exists locally
local-exists() {
 if [ -n "$(git show-ref refs/heads/$1)" ]; then;
  echo true;
 else
  echo false;
 fi
}

# check if current/passed local branch is ahead of its remote branch
local-ahead-of-remote() {
 local plant=$(_get-plant $@);

 if $(remote-exists $plant) && ! $(isEmpty $plant); then
  echo $(git rev-list --right-only --count origin/$plant...$plant);
 else
  echo 0;
 fi
}

# check if current/passed local branch is behind its remote branch
local-behind-remote() {
 local plant=$(_get-plant $@);

 if $(remote-exists $plant) && ! $(isEmpty $plant); then
  echo $(git rev-list --left-only --count origin/$plant...$plant);
 else
  echo 0;
 fi
}

# check if current/passed local branch is ahead of master
local-ahead-of-master() {
 local plant=$(_get-plant $@);

 if $(remote-exists master) && ! $(isEmpty $plant); then
  echo $(git rev-list --right-only --count origin/master...$plant);
 else
  echo 0;
 fi
}

# check if current/passed local branch is behind master
local-behind-master() {
 local plant=$(_get-plant $@);

 if $(remote-exists master) && ! $(isEmpty $plant); then
  echo $(git rev-list --left-only --count origin/master...$plant);
 else
  echo 0;
 fi
}