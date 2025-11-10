#!/bin/bash

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt

[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

GAMEBINARY=sdlscav
GAMEDIR=/$directory/ports/scavenger
exec > >(tee "$GAMEDIR/log.txt") 2>&1

cd $GAMEDIR
bind_directories ~/.scavenger $GAMEDIR/conf
if [ $DISPLAY_WIDTH -lt 1024 ] && [ $DISPLAY_HEIGHT -lt 768 ]; then
 XWIDTH="0.50"
else
 XWIDTH="1.00"
fi
$GPTOKEYB "$GAMEBINARY.${DEVICE_ARCH}" -c "./$GAMEBINARY.gptk" &
SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig" ./$GAMEBINARY.${DEVICE_ARCH} -w $XWIDTH -h 1.00
pm_finish
