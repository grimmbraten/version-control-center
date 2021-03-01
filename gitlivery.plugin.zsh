if [ -d .git ]; then
 local root=$(dirname "$0");

 . $root/helpers;

 . $root/global;

 . $root/events;

 . $root/core;
 . $root/functions;

 . $root/commands;
fi