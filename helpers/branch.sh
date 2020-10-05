local branchSteps=(12 8 5);

# $1: integer (changed files count)
getBranchIcon() {
 if [ $1 -gt $branchSteps[1] ]; then
  echo $evergreenIcon;
  return;
 elif [ $1 -gt $branchSteps[2] ]; then
  echo $treeIcon;
  return;
 elif [ $1 -lt $branchSteps[3] ]; then
  echo $seedlingIcon;
  return;
 else
  echo $plantIcon; 
 fi
}

# $1: integer (changed files count)
getBranchIconName() {
 if [ $1 -gt $branchSteps[1] ]; then
  echo "Rugged evergreen";
  return;
 elif [ $1 -gt $branchSteps[2] ]; then
  echo "Majestic tree";
  return;
 elif [ $1 -lt $branchSteps[3] ]; then
  echo "Delicate seedling";
  return;
 else
  echo "Small plant";
 fi
}