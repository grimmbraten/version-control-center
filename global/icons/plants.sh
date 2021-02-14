local evergreen="\U0001F332";
local tree="\U0001F333";
local plant="\U0001F33F";
local seedling="\U0001F331";

local plantSteps=(16 8 4);
local repositorySteps=(1200 770 550 440 330 260 200 140 100 60 20);

# $1: integer (changed files count)
plant-size() {
 local plant;

 if [ -z $1 ]; then
  plant=$(growing-plant);
 else
  plant=$1;
 fi

 if $(remote-exists $plant); then
  echo $(local-ahead-of-remote $1);
 else
  echo $(local-ahead-of-master $plant);
 fi
}

plant-icon() {
 local size;

 if [ -z $1 ]; then
  size=$(plant-size);
 else
  size=$1;
 fi

 if [ $size -gt $plantSteps[1] ]; then
  echo $evergreen;
 elif [ $size -gt $plantSteps[2] ]; then
  echo $tree;
 elif [ $size -lt $plantSteps[3] ]; then
  echo $seedling;
 else
  echo $plant; 
 fi
}

# $1: integer (changed files count)
plant-name() {
 local size=$(plant-size $@);

 if [ $size -gt $plantSteps[1] ]; then
  echo "Rugged evergreen";
 elif [ $size -gt $plantSteps[2] ]; then
  echo "Majestic tree";
 elif [ $size -lt $plantSteps[3] ]; then
  echo "Delicate seedling";
 else
  echo "Small plant";
 fi
}

repository-name() {
 local size=0;

 if $(remote-exists); then
  size=$(git rev-list --count origin/master);
 fi

 if [ $size -gt $repositorySteps[1] ]; then
  echo "Yellowstone";
 elif [ $size -gt $repositorySteps[2] ]; then
  echo "Everglades";
 elif [ $size -gt $repositorySteps[3] ]; then
  echo "Olympic";
 elif [ $size -gt $repositorySteps[4] ]; then
  echo "Yosemite";
 elif [ $size -gt $repositorySteps[5] ]; then
  echo "Sequoia";
 elif [ $size -gt $repositorySteps[6] ]; then
  echo "Voyagerurs";
 elif [ $size -gt $repositorySteps[7] ]; then
  echo "Shenandoah";
 elif [ $size -gt $repositorySteps[8] ]; then
  echo "Zion";
 elif [ $size -gt $repositorySteps[9] ]; then
  echo "Redwood";
 elif [ $size -gt $repositorySteps[10] ]; then
  echo "Saguaro";
 elif [ $size -lt $repositorySteps[11] ]; then
  echo "Congaree";
 else
  echo "Pinnacles";
 fi
}

#TODO: Document in readme later on

#1 Congaree South Carolina 107km2 < 20
#2 Pinnacles California 108km2 > 40
#3 Saguaro Arizona 349km2 > 80
#4 Redwood California 562km2 > 120
#5 Zion Utah 595km2 > 160
#6 Shenandoah Virginia 806km2 > 200
#7 Voyagerurs Minnesota 883km2 > 220
#8 Sequoia California 1635km2 > 330
#9 Yosemite California 3082km2 > 440
#10 Olympic Washington 3733km2 > 550
#11 Everglades Florida 6106km2 > 700
#12 Yellowstone Wyoming Montana Idaho 8983km2 > 1000
