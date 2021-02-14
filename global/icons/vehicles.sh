local rocket="\U0001F680";
local ship="\U0001F6A2";
local airplane="\U0001F6EB";
local truck="\U0001F69A";
local car="\U0001F699";
local scooter="\U0001F6F5";
local bicycle="\U0001F6B2";

local packageSteps=(32 16 8 4 2 1);

# $1: integer (amount of commits)
getDeliveryIcon() {
 if [ $1 -gt $packageSteps[1] ]; then
  echo $rocket;
 elif [ $1 -gt $packageSteps[2] ]; then
  echo $ship;
 elif [ $1 -gt $packageSteps[3] ]; then
  echo $airplane;
 elif [ $1 -gt $packageSteps[4] ]; then
  echo $truck;
 elif [ $1 -gt $packageSteps[5] ]; then
  echo $car;
 elif [ $1 -gt $packageSteps[6] ]; then
  echo $scooter;
 else
  echo $bicycle;
 fi
}