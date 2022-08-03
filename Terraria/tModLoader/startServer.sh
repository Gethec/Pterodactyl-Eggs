#!/bin/bash
RED='\033[0;31m'

# Check for and create symlinks
if [ ! -L ~/.steam/sdk32 ]; then
    echo "Creating Steam SDK32 symlink"
    ln -s ~/.local/share/Steam/steamcmd/linux32 ~/.steam/sdk32
fi

if [ ! -L ~/.steam/sdk64 ]; then
    echo "Creating Steam SDK64 symlink"
    ln -s ~/.local/share/Steam/steamcmd/linux64 ~/.steam/sdk64
fi

# Set baseline startup command
chmod +x ~/start-tModLoader.sh
START_COMMAND="./start-tModLoader.sh -server -tmlsavedirectory ~/saves -modpath ~/mods -world \"~/saves/Worlds/${WORLD_NAME}.wld\" -ip 0.0.0.0 -port ${SERVER_PORT} -noupnp -npcstream ${NPC_STREAM} -maxplayers ${MAX_PLAYERS} -motd \"${MOTD}\" -password \"${SERVER_PASSWORD}\""

# Add secure flag if enabled
if [ $SECURE_SERVER ]; then
    START_COMMAND = ${START_COMMAND} + " -secure"
fi

# Perform startup logic
if [ -e ~/saves/Worlds/${WORLD_NAME}.wld ]; then
    echo -e $START_COMMAND
else
    if [ "$WORLD_SIZE" == "0" ]; then
        echo -e "${RED}Auto-generation is disabled and the specified world file \"${WORLD_NAME}\" is not present!  Upload a world file with the correct name, or change startup settings to generate a world."
        exit 1
    else
        START_COMMAND = ${START_COMMAND} + " -autocreate ${WORLD_SIZE} -worldname \"${WORLD_NAME}\" -seed \"${WORLD_SEED}\""
        echo -e $START_COMMAND
    fi
fi