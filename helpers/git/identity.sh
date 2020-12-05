growing-plant() {
 echo $(git branch --show-current);
}

forest-breed() {
 echo $(git rev-parse --short origin/master);
}

plant-breed() {
 if [ -z $1 ]; then
  echo $(git rev-parse --short HEAD);
 else
  echo $(git rev-parse --short $1);
 fi
}

plant-origin-breed() {
 echo $(git rev-parse --short origin/$(growing-plant));
}