import           Data.Default                 (def)
import           System.IO                    (hPutStrLn)
import           XMonad                       (borderWidth, composeAll, focusedBorderColor, handleEventHook, layoutHook, logHook, manageHook, mod4Mask, modMask, spawn, startupHook, terminal, windows, xmonad, (<+>))
import           XMonad.Actions.CycleWS       (toggleWS)
import           XMonad.Actions.WindowBringer (gotoMenu)
import           XMonad.Config.Desktop        (desktopConfig)
import           XMonad.Hooks.DynamicLog      (dynamicLogWithPP, ppOrder, ppOutput, ppTitle, shorten)
import           XMonad.Hooks.EwmhDesktops    (fullscreenEventHook)
import           XMonad.Hooks.ManageDocks     (avoidStruts, docksEventHook)
import           XMonad.Layout                (Full (Full), (|||))
import           XMonad.Layout.NoBorders      (noBorders)
import           XMonad.Layout.ResizableTile  (ResizableTall (ResizableTall))
import           XMonad.Layout.Spacing        (spacing)
import           XMonad.Layout.TwoPane        (TwoPane (TwoPane))
import           XMonad.StackSet              (focusDown)
import           XMonad.Util.EZConfig         (additionalKeysP)
import           XMonad.Util.Run              (spawnPipe)

main :: IO ()
main = do
  spawn "bash ~/.xmonad/monitors.sh"
  spawn "feh --bg-fill /mnt/shared/Pictures/Wallpapers/himukai/gunko.jpg"
  spawn "xkbcomp -I${HOME}/.xkb ${HOME}/.xkb/keymap/mykbd $DISPLAY"
  spawn "xrdb .Xresources"
  bar <- spawnPipe "/usr/bin/xmobar"
  xmonad $ def { borderWidth        = 1
               , focusedBorderColor = "#ffffff"
               , handleEventHook    = fullscreenEventHook <+> docksEventHook <+> handleEventHook desktopConfig
               , layoutHook         = (avoidStruts . noBorders) Full
                                      ||| (avoidStruts . spacing 7 $ TwoPane (3 / 100) (1 / 2))
                                      ||| (avoidStruts . spacing 7 $ ResizableTall 1 (1 / 201) (116 / 201) [])
                                      ||| noBorders Full
               , logHook            = dynamicLogWithPP $ def { ppOutput = hPutStrLn bar
                                                             , ppOrder  = \(workSpaces : _ : title : _) -> [workSpaces, title]
                                                             , ppTitle  = shorten 65
                                                             }
               , manageHook         = composeAll []
                                      <+> manageHook desktopConfig
               , modMask            = mod4Mask
               , startupHook        = return ()
               , terminal           = "urxvt"
               }
           `additionalKeysP` [ ("M1-<Tab>", windows focusDown >> focusHook)
                             , ("M4-<Tab>", toggleWS >> focusHook)
                             , ("M4-e"    , gotoMenu)
                             , ("M4-r"    , spawn "dmenu_run")
                             , ("M4-v"    , spawn "urxvt -e /bin/tmux")
                             , ("M4-<U>"  , spawn "pamixer -i 1")
                             , ("M4-<D>"  , spawn "pamixer -d 1")
                             ]
    where focusHook = return ()
