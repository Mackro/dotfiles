import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Data.Ratio ((%))
import XMonad.Hooks.SetWMName

myTerminal = "gnome-terminal"

myModMask = mod4Mask -- Rebind Mod to the windows key

myBorderWidth = 2

myNormalBorderColor = "gray"

myFocusedBorderColor = "purple"

myFocusFollowsMouse = False

<<<<<<< HEAD
myLayoutHook = avoidStruts (smartBorders (tiled ||| Mirror tiled ||| noBorders (fullscreenFull Full) )) ||| noBorders (fullscreenFull Full)
=======
myLayoutHook = avoidStruts (smartBorders (tiled ||| Mirror tiled) ||| noBorders(Full)) ||| noBorders (fullscreenFull Full) 
>>>>>>> 2261b8162b8b5cc99222cd3e417b75d86f7f6bff
                where
                    tiled   =   Tall nmaster delta ratio
                    nmaster =   1       -- Number of windows in the master panel
                    ratio   =   2%3     -- Percentage of the screen to increment by when resizing the window
                    delta   =   5%100   -- Default portion of the screen occupied by the master panel

myLayout = avoidStruts (
	Tall 1 (3/100) (1/2) |||
	Mirror (Tall 1 (3/100) (1/2)) |||
	noBorders (fullscreenFull Full))

myStartupHook = do
	setWMName "LG3D"

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = myLayoutHook, 
      	logHook = dynamicLogWithPP xmobarPP {
		      ppOutput = hPutStrLn xmproc,
		      ppTitle = xmobarColor "#dc322f" "" . shorten 70
		    },
	      terminal = myTerminal,
	      modMask = myModMask,
        borderWidth = myBorderWidth,
		startupHook = myStartupHook,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        focusFollowsMouse = myFocusFollowsMouse
      }
