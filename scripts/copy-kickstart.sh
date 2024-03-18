#!/bin/bash

# see if there's FUSIONAUTH_APP_KICKSTART_DIRECTORY_PATH
# if not, exit 0

if [[ -z "$FUSIONAUTH_APP_KICKSTART_DIRECTORY_PATH" ]]; then
    exit 0
fi

rm -rf kickstart && cp -r $GH_WORKSPACE_PATH/$FUSIONAUTH_APP_KICKSTART_DIRECTORY_PATH kickstart

# if so, copy to all to kickstart directory
# then, copy the FUSIONAUTH_APP_KICKSTART_FILENAME to kickstart.json

if [[ -z "$FUSIONAUTH_APP_KICKSTART_FILENAME" ]]; then
    exit 0
fi

cp kickstart/$FUSIONAUTH_APP_KICKSTART_FILENAME kickstart/kickstart.json
