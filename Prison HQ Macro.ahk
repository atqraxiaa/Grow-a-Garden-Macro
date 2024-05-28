; Prison HQ Auto Break Chest & Hatch Best Egg
; Created by @raeleii on Discord
; Last updated on 4:41 pm GMT + 8, 5/28/24 
; Srsly i'm tired of making this macro a gui, unless this prison event is permanent.

; Requirements to use this macro
; 1920 x 1080 resolution, 100% scale

#Requires AutoHotkey v2.0
#SingleInstance

; Delays, in seconds (can accept decimals)
DelayModifier := 1.05
TpToHQArea := 4.3
TpToLastArea := 10
ReconnectionDelay := 90

; Durations, in seconds (can accept decimals)
; If AutoBreakDuration runs out of time, it will auto eat fruits, put flags in the HQ Area and goes back to break the chest.
MoveHqEgg := 5
MoveDisableHatchEgg := 3
AutoBreakDuration := 18000

; Click iterations
ChestLoopClick := 200
FruitLoopClick := 10
FlagLoopClick := 10

; Enable or disable a specific part
AutoHatchEgg := false

; Your private server deeplink
; If no private server, put "" (it will reconnect you to a random server)
; Example of a deeplink is "roblox://placeID=8737899170&linkCode=32304994234327461361054696375530/"
DeepLink := ""

; Adjust the coordinates if macro isn't clicking the right buttons
CoordsMap := Map()
CoordsMap["OpenFreeGifts"] := [60, 383]
CoordsMap["OpenFreeGiftsExit"] := [1301, 256]
CoordsMap["FreeGift1RColumn"] := [702, 345]
CoordsMap["FreeGift2RColumn"] := [871, 345]
CoordsMap["FreeGift3RColumn"] := [1040, 345]
CoordsMap["FreeGift4RColumn"] := [1209, 345]
CoordsMap["FreeGiftYAdd1"] := [0, 145]
CoordsMap["FreeGiftYAdd2"] := [0, 290]
CoordsMap["TpButton"] := [174, 389]
CoordsMap["SearchWindow"] := [1274, 248]
CoordsMap["TpLastAreaButton"] := [959, 356]
CoordsMap["EnableHoverboard"] := [270, 377]
CoordsMap["EnableAutoFarm"] := [194, 460]
CoordsMap["OpenEggSettings"] := [87, 460]
CoordsMap["ToggleAutoHatch"] := [1155, 395]
CoordsMap["OpenEggSettingsExit"] := [1299, 256]
CoordsMap["MenuExit"] := [1492, 253]
CoordsMap["HatchAllEgg"] := [1199, 735]
CoordsMap["BreakChest"] := [308, 578]
CoordsMap["CheckDisconnectUI"] := [1109, 566]
CoordsMap["ReconnectButton"] := [1056, 620]
CoordsMap["MenuButton"] := [965, 961]
CoordsMap["BackpackButton"] := [387, 402]
CoordsMap["UseUltimate"] := [585, 957]
CoordsMap["VoidWorld"] := [383, 587]

/* Adjust the hex values if macro isn't recognizing the pixels from the flags
   (Tip: Use Window Spy from AHK to get the pixel color of the coordinates)
   If you adjust the value in CoordsPixelFlag["FlagInLastArea"], also change the value in line 555 of this code.
   Example: line 72 is CoordsPixelFlag["FlagInLastArea"] := "Shiny Flag"
   Go to line 565 and change also this:
       if Activate == (CoordsPixelFlag["Hasty Flag"]) {
                                             ^ 
                       Change this also to Shiny Flag and save it. */
CoordsPixelFlag := Map()
CoordsPixelFlag["FlagPixelSearch"] := [501, 410]
CoordsPixelFlag["FlagInLastArea"] := "Hasty Flag"
CoordsPixelFlag["Shiny Flag"] := "0xEEEFFA"
CoordsPixelFlag["Rainbow Flag"] := "0xFFFFFF"
CoordsPixelFlag["Fortune Flag"] := "0xC17BF2"
CoordsPixelFlag["Diamonds Flag"] := "0xFCFEFF"
CoordsPixelFlag["Hasty Flag"] := "0xF5B55D"
CoordsPixelFlag["Coins Flag"] := "0xFFFFFF"
CoordsPixelFlag["Magnet Flag"] := "0xFCEAEA"
CoordsPixelFlag["Strength Flag"] := "0xBB0071" 

; Adjust the hex values if macro isn't recognizing the pixels from the fruits
; (Tip: Use Window Spy from AHK to get the pixel color of the coordinates)
CoordsPixelFruit := Map()
CoordsPixelFruit["FruitPixelSearch"] := [501, 410]
CoordsPixelFruit["AllFruits"] := ["Apple", "Pineapple", "Banana", "Orange", "Watermelon", "Rainbow Fruit"]
CoordsPixelFruit["Apple"] := "0xE62F2B"
CoordsPixelFruit["Pineapple"] := "0xFF8C00"
CoordsPixelFruit["Banana"] := "0xBFFFA8"
CoordsPixelFruit["Orange"] := "0xF89C00"
CoordsPixelFruit["Watermelon"] := "0xF0236E"
CoordsPixelFruit["Rainbow Fruit"] := "0xC4EE67"

; Don't change the code below here! If you know about ahk, you can rewrite it as you want.
DeepLinkRun := false
LastFunction := ""

$F5:: { ; Pause the macro
    global DelayModifier
    Sleep (100 * DelayModifier) 
    Send "{F11}"
    Pause -1
}

$F6:: { ; Exit the macro
    if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
        WinActivate()
        Send "{F11}"
        ExitApp
    } else {
        MsgBox "Roblox is not running. Fullscreen will not be inputted."
        ExitApp
    }
}

$F3:: { ; Start the macro
    global DelayModifier, AutoHatchEgg
    if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
        WinActivate()
        Send "{F11}"
        Sleep (1000 * DelayModifier)
    } else {
        MsgBox "Roblox is not running. Exiting script."
        ExitApp
    }

    ; The main functions
    ClaimFreeGifts()
    AutoEatFruit()
    GoToPrisonHQ()
    CheckAutoFarm()
}

ClaimFreeGifts() {
    global DelayModifier, DeepLink, DeeplinkRun
    SendEvent "{Click, " CoordsMap["CheckDisconnectUI"][1] ", " CoordsMap["CheckDisconnectUI"][2] "}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (0x393B3D) { ; If disconnect UI shows the color bg
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=8737899170"
            }
                run (DeepLink)
                DeeplinkRun := true
                Sleep (ReconnectionDelay * 1000)
                PostReconnectOperations()
                return
        }
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["OpenFreeGifts"][1] ", " CoordsMap["OpenFreeGifts"][2] "}"
    Sleep (750 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift1RColumn"][1] ", " CoordsMap["FreeGift1RColumn"][2] "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift2RColumn"][1] ", " CoordsMap["FreeGift2RColumn"][2] "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift3RColumn"][1] ", " CoordsMap["FreeGift3RColumn"][2] "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift4RColumn"][1] ", " CoordsMap["FreeGift4RColumn"][2] "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift1RColumn"][1] ", " (CoordsMap["FreeGift1RColumn"][2] + CoordsMap["FreeGiftYAdd1"][2]) "}"
    Sleep (250 * DelayModifier) 
    SendEvent "{Click, " CoordsMap["FreeGift2RColumn"][1] ", " (CoordsMap["FreeGift2RColumn"][2] + CoordsMap["FreeGiftYAdd1"][2]) "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift3RColumn"][1] ", " (CoordsMap["FreeGift3RColumn"][2] + CoordsMap["FreeGiftYAdd1"][2]) "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift4RColumn"][1] ", " (CoordsMap["FreeGift4RColumn"][2] + CoordsMap["FreeGiftYAdd1"][2]) "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift1RColumn"][1] ", " (CoordsMap["FreeGift1RColumn"][2] + CoordsMap["FreeGiftYAdd2"][2]) "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift2RColumn"][1] ", " (CoordsMap["FreeGift2RColumn"][2] + CoordsMap["FreeGiftYAdd2"][2]) "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift3RColumn"][1] ", " (CoordsMap["FreeGift3RColumn"][2] + CoordsMap["FreeGiftYAdd2"][2]) "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["FreeGift4RColumn"][1] ", " (CoordsMap["FreeGift4RColumn"][2] + CoordsMap["FreeGiftYAdd2"][2]) "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["OpenFreeGiftsExit"][1] ", " CoordsMap["OpenFreeGiftsExit"][2] "}"
    Sleep (250 * DelayModifier)
}

AutoEatFruit() {
    AutoEatApple()
    AutoEatPineapple()
    AutoEatBanana()
    AutoEatOrange()
    AutoEatWatermelon()
    AutoEatRainbowFruit()
}

AutoEatApple() {
    global FruitLoopClick, DelayModifier
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsPixelFruit["AllFruits"][1]
        Sleep (250 * DelayModifier)

        X := CoordsPixelFruit["FruitPixelSearch"][1]
        Y := CoordsPixelFruit["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (500 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsPixelFruit["Apple"]) { ; If apple color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (50 * DelayModifier)
            }
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            break
        } else { ; If apple color pixel is not there
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            consecutiveElseCount += 1
        }
    }
    return
}

AutoEatPineapple() {
    global FruitLoopClick, DelayModifier
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsPixelFruit["AllFruits"][2]
        Sleep (250 * DelayModifier)
    
        X := CoordsPixelFruit["FruitPixelSearch"][1]
        Y := CoordsPixelFruit["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (500 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsPixelFruit["Pineapple"]) { ; If pineapple color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (50 * DelayModifier)
            }
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            break
        } else { ; If pineapple color pixel is not there
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            consecutiveElseCount += 1
        }
    }
    return
}

AutoEatBanana() {
    global FruitLoopClick, DelayModifier
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsPixelFruit["AllFruits"][3]
        Sleep (250 * DelayModifier)
    
        X := CoordsPixelFruit["FruitPixelSearch"][1]
        Y := CoordsPixelFruit["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (500 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsPixelFruit["Banana"]) { ; If banana color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (50 * DelayModifier)
            }
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            break
        } else { ; If banana color pixel is not there
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            consecutiveElseCount += 1
        }
    }
    return
}

AutoEatOrange() {
    global FruitLoopClick, DelayModifier
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsPixelFruit["AllFruits"][4]
        Sleep (250 * DelayModifier)
        
        X := CoordsPixelFruit["FruitPixelSearch"][1]
        Y := CoordsPixelFruit["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (500 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsPixelFruit["Orange"]) { ; If orange color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (50 * DelayModifier)
            }
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            break
        } else { ; If orange color pixel is not there
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            consecutiveElseCount += 1
        }
    }
    return
}

AutoEatWatermelon() {
    global FruitLoopClick, DelayModifier
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) {
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsPixelFruit["AllFruits"][5]
        Sleep (250 * DelayModifier)
    
        X := CoordsPixelFruit["FruitPixelSearch"][1]
        Y := CoordsPixelFruit["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (500 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsPixelFruit["Watermelon"]) { ; If watermelon color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (50 * DelayModifier)
            }
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            break
        } else { ; If watermelon color pixel is not there
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            consecutiveElseCount += 1
        }
    }
    return
}

AutoEatRainbowFruit() {
    global FruitLoopClick, DelayModifier
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) {
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsPixelFruit["AllFruits"][6]
        Sleep (250 * DelayModifier)
     
        X := CoordsPixelFruit["FruitPixelSearch"][1]
        Y := CoordsPixelFruit["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (500 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsPixelFruit["Rainbow Fruit"]) { ; If rainbow fruit color pixel is there
            Loop FruitLoopClick {
            SendEvent "{Click}"
            Sleep (50 * DelayModifier)
        }
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            break
        } else { ; If rainbow fruit color pixel is not there
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            consecutiveElseCount += 1
        }
    }
    return
}

GoToPrisonHQ() {
    global TpToHQArea, TpToLastArea, DelayModifier
    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
    Sleep (500 * DelayModifier)
    SendText "Prison HQ"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["TpLastAreaButton"][1] ", " CoordsMap["TpLastAreaButton"][2] "}"
    Sleep (TpToLastArea * 1000)
    SendEvent "{Click, " CoordsMap["EnableHoverboard"][1] ", " CoordsMap["EnableHoverboard"][2] "}"
    Sleep (1000 * DelayModifier)
    Send ("{D down}")
    Sleep (TpToHQArea * 1000)
    Send ("{D up}")
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["EnableHoverboard"][1] ", " CoordsMap["EnableHoverboard"][2] "}"
    Sleep (500 * DelayModifier)
}

CheckAutoFarm() {
    global DelayModifier, AutoHatchEgg
    Send ("{O down}")
    Sleep (3000 * DelayModifier)
    Send ("{O up}")
    Sleep (250 * DelayModifier)

    X := CoordsMap["EnableAutoFarm"][1]
    Y := CoordsMap["EnableAutoFarm"][2]
    SendEvent "{Click, " X ", " Y ", Right}"
    Sleep (500 * DelayModifier)
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if (AutoHatchEgg == true) { ; If auto hatch egg is enabled
        if (Activate == 0x7CF50C) { ; If autofarm is enabled
            Sleep(1000 * DelayModifier)
            CheckEggAutoHatch()
        } else { ; If autofarm is disabled
            Sleep(1000 * DelayModifier)
            SendEvent "{Click}"
            Sleep(1000 * DelayModifier)
            CheckEggAutoHatch()
        }
    } else if (AutoHatchEgg == false) { ; If auto hatch egg is disabled
        if (Activate == 0x7CF50C) { ; If autofarm is enabled 
            Sleep(1000 * DelayModifier)
            AutoPlaceFlag()
            Sleep(1000 * DelayModifier)
            MoveToHQEgg()
            Sleep(1000 * DelayModifier)
            AutoBreakAndReconnect()
        } else { ; If autofarm is disabled
            Sleep(1000 * DelayModifier)
            SendEvent "{Click}"
            Sleep(1000 * DelayModifier)
            AutoPlaceFlag()
            Sleep(1000 * DelayModifier)
            MoveToHQEgg()
            Sleep(1000 * DelayModifier)
            AutoBreakAndReconnect()
        }
    }
}    

CheckEggAutoHatch() {
    global DelayModifier, AutoHatchEgg

    X := CoordsMap["OpenEggSettings"][1]
    Y := CoordsMap["OpenEggSettings"][2]
    SendEvent "{Click, " X ", " Y ", Right}"
    Sleep (500 * DelayModifier)
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if Activate == (0x7CF50C) { ; If autohatch is enabled
        AutoPlaceFlag()
        Sleep (500 * DelayModifier)
        MoveToHQEgg()
        Sleep (250 * DelayModifier)
        Send ("{E}")
        Sleep (250 * DelayModifier)
        SendEvent "{Click, " CoordsMap["HatchAllEgg"][1] ", " CoordsMap["HatchAllEgg"][2] "}"
        Sleep (250 * DelayModifier)
        AutoBreakAndReconnect()
    } else { ; If autohatch is disabled
        SendEvent "{Click}"
        Sleep (250 * DelayModifier)
        SendEvent "{Click, " CoordsMap["ToggleAutoHatch"][1] ", " CoordsMap["ToggleAutoHatch"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
        Sleep (500 * DelayModifier)
        AutoPlaceFlag()
        Sleep (500 * DelayModifier)
        MoveToHQEgg()
        Sleep (250 * DelayModifier)
        Send ("{E}")
        Sleep (250 * DelayModifier)
        SendEvent "{Click, " CoordsMap["HatchAllEgg"][1] ", " CoordsMap["HatchAllEgg"][2] "}"
        Sleep (250 * DelayModifier)
        AutoBreakAndReconnect()
    }
}

AutoPlaceFlag() {
    global FlagLoopClick, DelayModifier
    consecutiveElseCount := 0

    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsPixelFlag["FlagInLastArea"]
        Sleep (250 * DelayModifier)

        X := CoordsPixelFlag["FlagPixelSearch"][1]
        Y := CoordsPixelFlag["FlagPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (500 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsPixelFlag["Hasty Flag"]) { ; If flag color pixel is there
            Loop FlagLoopClick {
                SendEvent "{Click}"
                Sleep (50 * DelayModifier)
            }
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            break
        } else { ; If flag color pixel is not there
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            consecutiveElseCount += 1
        }
    }
    return
}

MoveToHQEgg() {
    global MoveHqEgg, DelayModifier
    Send ("{S down}")
    Sleep (275)
    Send ("{S up}")
    Sleep (500 * DelayModifier)
    Send ("{D down}")
    Sleep (MoveHqEgg * 1000)
    Send ("{D up}")
    Sleep (500 * DelayModifier)
    Send ("{A down}")
    Sleep (500)
    Send ("{A up}")
    Sleep (500 * DelayModifier)
}

AutoBreakAndReconnect() {
    global DeepLink, DeepLinkRun, ReconnectionDelay, LastFunction, AutoBreakDuration, DelayModifier, ChestLoopClick
    LastFunction := "AutoBreakAndReconnect"

    EndTime := A_TickCount + (AutoBreakDuration * 1000)
    while (A_TickCount < EndTime) {
        Loop ChestLoopClick {
            SendEvent "{Click, " CoordsMap["BreakChest"][1] ", " CoordsMap["BreakChest"][2] "}"
        }
        SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
        Sleep (100 * DelayModifier)
        SendEvent "{Click, " CoordsMap["CheckDisconnectUI"][1] ", " CoordsMap["CheckDisconnectUI"][2] "}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (0x393B3D) { ; If disconnect UI shows the color bg
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=8737899170"
            }
                run (DeepLink)
                DeeplinkRun := true
                Sleep (ReconnectionDelay * 1000)
                PostReconnectOperations()
                return
        }
    }
    AutoEatFruitTimer()
}

PostReconnectOperations() {
    global AutoHatchEgg
    ClaimFreeGifts()
    AutoEatFruit()
    GoToPrisonHQ()
    CheckAutoFarm()
}

AutoEatFruitTimer() {
    global LastFunction, DelayModifier
    Sleep (1000 * DelayModifier)
    MoveToDisableAutoHatch()
    TeleportToSpawn()
    if LastFunction = ("AutoBreakAndReconnect") {
        LastFunction := ""
        PostReconnectOperations()
    }
}

MoveToDisableAutoHatch() {
    global DelayModifier, MoveDisableHatchEgg
    Send ("{S down}")
    Sleep (MoveDisableHatchEgg * 1000)
    Send ("{S up}")
    Sleep (500 * DelayModifier)
}

TeleportToSpawn() {
    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["VoidWorld"][1] ", " CoordsMap["VoidWorld"][2] "}"
    Sleep (TpToLastArea * 1000)
}