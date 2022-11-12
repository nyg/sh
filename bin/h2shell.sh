#!/usr/bin/env sh
java -cp $HOME/bin/h2/bin/h2-1.4.193.jar org.h2.tools.Shell -url jdbc:h2:$1 -user sa -password "" -sql "$2"
