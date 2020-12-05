local root=$(dirname "$0");

. $root/global/bundler.sh;
. $root/helpers/bundler.sh;
. $root/events/bundler.sh;

. $root/core/bundler.sh;
. $root/functions/bundler.sh;

. $root/commands/abbreviations.sh

#TODO: This startup file should be used to load settings and other plugin related customizations