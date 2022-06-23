#!/bin/bash
RED='\033[0;31m'

if [ "$WORLD_SIZE" == "0" ]
then
    if [ -e ~/saves/Worlds/${WORLD_NAME}.wld ]
    then
        echo \n | ./DedicatedServerUtils/Setup_tModLoaderServer.sh && ./LaunchUtils/ScriptCaller.sh -server -ip 0.0.0.0 -port ${SERVER_PORT} -noupnp -maxplayers ${MAX_PLAYERS} -password "${SERVER_PASSWORD}" -motd "${MOTD}" -world ~/saves/Worlds/${WORLD_NAME}.wld$( [ \"$SECURE_SERVER\" == \"0\" ] || printf %s ' -secure' ) -savedirectory ~/ -tmlsavedirectory ~/saves -modpath ~/mods
    else
        echo -e "${RED}Auto-generation is disabled and the specified world file is not present!  Upload your world file with the correct name, or change startup settings to generate a world"
        exit 1
    fi
else
    echo \n | ./DedicatedServerUtils/Setup_tModLoaderServer.sh && ./LaunchUtils/ScriptCaller.sh -server -ip 0.0.0.0 -port ${SERVER_PORT} -noupnp -maxplayers ${MAX_PLAYERS} -password "${SERVER_PASSWORD}" -motd "${MOTD}" -world ~/saves/Worlds/${WORLD_NAME}.wld -autocreate ${WORLD_SIZE} -seed ${WORLD_SEED} -worldname "${WORLD_NAME}"$( [ \"$SECURE_SERVER\" == \"0\" ] || printf %s ' -secure' ) -savedirectory ~/ -tmlsavedirectory ~/saves -modpath ~/mods
fi