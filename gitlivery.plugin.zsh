if [ -d .git ]; then
 local root=$(dirname "$0");

 . $root/helpers/bundler.sh;

 . $root/global/bundler.sh;

 . $root/events/bundler.sh;

 . $root/core/bundler.sh;
 . $root/functions/bundler.sh;

 . $root/commands/abbreviations.sh
fi

#TODO: This startup file should be used to load settings and other plugin related customizations