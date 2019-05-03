#!/bin/bash

DHISWAR=$1
unzip -p $DHISWAR WEB-INF/lib/dhis-service-core-2.31.3.jar |busybox unzip -p - build.properties

