local packageSteps=(32 16 8 4 2 1);

# $1: integer (amount of commits)
getDeliveryIcon() {
 if [ $ahead -gt $packageSteps[1] ]; then
  echo $rocketIcon;
 elif [ $ahead -gt $packageSteps[2] ]; then
  echo $shipIcon;
 elif [ $ahead -gt $packageSteps[3] ]; then
  echo $airplaneIcon;
 elif [ $ahead -gt $packageSteps[4] ]; then
  echo $truckIcon;
 elif [ $ahead -gt $packageSteps[5] ]; then
  echo $carIcon;
 elif [ $ahead -gt $packageSteps[6] ]; then
  echo $scooterIcon;
 else
  echo $bicycleIcon;
 fi
}