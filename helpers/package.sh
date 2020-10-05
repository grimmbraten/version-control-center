local packageSteps=(32 16 8 4 2 1);

# $1: integer (amount of commits)
getDeliveryIcon() {
 if [ $1 -gt $packageSteps[1] ]; then
  echo $rocketIcon;
 elif [ $1 -gt $packageSteps[2] ]; then
  echo $shipIcon;
 elif [ $1 -gt $packageSteps[3] ]; then
  echo $airplaneIcon;
 elif [ $1 -gt $packageSteps[4] ]; then
  echo $truckIcon;
 elif [ $1 -gt $packageSteps[5] ]; then
  echo $carIcon;
 elif [ $1 -gt $packageSteps[6] ]; then
  echo $scooterIcon;
 else
  echo $bicycleIcon;
 fi
}