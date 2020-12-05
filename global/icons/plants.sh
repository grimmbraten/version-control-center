local plantSteps=(12 8 5);

# $1: integer (changed files count)
plant-icon() {
 if [ $1 -gt $plantSteps[1] ]; then
  echo $evergreenIcon;
  return;
 elif [ $1 -gt $plantSteps[2] ]; then
  echo $treeIcon;
  return;
 elif [ $1 -lt $plantSteps[3] ]; then
  echo $seedlingIcon;
  return;
 else
  echo $plantIcon; 
 fi
}

# $1: integer (changed files count)
plant-name() {
 if [ $1 -gt $plantSteps[1] ]; then
  echo "Rugged evergreen";
  return;
 elif [ $1 -gt $plantSteps[2] ]; then
  echo "Majestic tree";
  return;
 elif [ $1 -lt $plantSteps[3] ]; then
  echo "Delicate seedling";
  return;
 else
  echo "Small plant";
 fi
}