# returns the name of the active branch
growing-plant() {
 if [ -z $1 ]; then
  echo $(git branch --show-current);
 else
  echo $1;
 fi 
}

# returns the unique id of the remote master branch
forest-breed() {
 echo $(git rev-parse --short origin/master);
}

# returns the unique id of the active/passed locale branch
plant-breed() {
 if [ -z $1 ]; then
  echo $(git rev-parse --short HEAD);
 else
  echo $(git rev-parse --short $1);
 fi
}

# returns the unique id of the remote active branch
plant-origin-breed() {
 echo $(git rev-parse --short origin/$(growing-plant));
}