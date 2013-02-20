import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myTerminal = "gnome-terminal"

myModMask = mod4Mask -- Rebind Mod to the windows key



main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  layoutHook defaultConfig,
      	logHook = dynamicLogWithPP xmobarPP {
		      ppOutput = hPutStrLn xmproc,
		      ppTitle = xmobarColor "red" "" . shorten 50
		    },
	      terminal = myTerminal,
	      modMask = myModMask
      }
