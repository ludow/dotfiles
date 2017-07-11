#!/bin/bash

function usage(){
	printf "Utilisation du script :\n"
	printf "\tstart: activate nat rules for vagrant\n"
	printf "\tstop: desactivate NAT rules for vagrant\n"
	printf "\thelp -h: display usage.\n"
}

if [ $# -eq 0 ]
then
	usage
fi

function start(){
  echo "
  rdr pass inet proto tcp from any to any port 80 -> 127.0.0.1 port 8080
  rdr pass inet proto tcp from any to any port 443 -> 127.0.0.1 port 8443
  " | sudo pfctl -ef -
}

function stop(){
  echo "" | sudo pfctl -ef -
}

while true ; do
  case "$1" in
    help | -h )   usage
                  exit 0
                  ;;
    start)        start
                  shift
                  ;;
    stop)         stop
                  shift
                  ;;
    *)            exit 1
    esac
    shift;
done

exit 0
