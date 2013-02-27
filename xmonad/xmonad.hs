import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Data.Ratio ((%))

myTerminal = "gnome-terminal"

myModMask = mod4Mask -- Rebind Mod to the windows key

myBorderWidth = 2

myNormalBorderColor = "gray"

myFocusedBorderColor = "purple"

myFocusFollowsMouse = False

myLayoutHook = avoidStruts (smartBorders (tiled ||| Mirror tiled ||| Full))
                where
                    tiled   =   Tall nmaster delta ratio
                    nmaster =   1       -- Number of windows in the master panel
                    ratio   =   2%3     -- Percentage of the screen to increment by when resizing the window
                    delta   =   5%100   -- Default portion of the screen occupied by the master panel

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = myLayoutHook, 
      	logHook = dynamicLogWithPP xmobarPP {
		      ppOutput = hPutStrLn xmproc,
		      ppTitle = xmobarColor "red" "" . shorten 50
		    },
	      terminal = myTerminal,
	      modMask = myModMask,
        borderWidth = myBorderWidth,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        focusFollowsMouse = myFocusFollowsMouse
      }
