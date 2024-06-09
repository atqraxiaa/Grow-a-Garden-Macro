; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                             Pet Simulator 99 Main Macro v1.2, created by @raeleii on Discord
;                                       Last updated on 18:52 GMT + 8, Jun 9, 2024 
;
;                                             Requirements to Use this Macro:
;                                           1920 x 1080 resolution, 100% scale
;
;                   If you find any bugs, please report to me by sending a dm to @raeleii on Discord, tysm!
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

#Requires AutoHotkey v2.0
#SingleInstance

; Function Keys to Pause / Exit Macro
F6::PauseMacro()
F12::ExitMacro()

; Delays, in seconds (change values in Settings.ini)
global DelayModifier := IniRead("Settings.ini", "Delays", "DelayModifier")
global TpToLastArea := IniRead("Settings.ini", "Delays", "TpToLastArea")
global ReconnectionDelay := IniRead("Settings.ini", "Delays", "ReconnectionDelay")

; Durations, in seconds (change values in Settings.ini)
global MoveLastArea := IniRead("Settings.ini", "Durations", "MoveLastArea")
global MoveToBestEggForward := IniRead("Settings.ini", "Durations", "MoveToBestEggForward")
global MoveToBestEggSideward := IniRead("Settings.ini", "Durations", "MoveToBestEggSideward")
global MoveDisableHatchEgg := IniRead("Settings.ini", "Durations", "MoveDisableHatchEgg")
global TimerDuration := IniRead("Settings.ini", "Durations", "TimerDuration")
global ItemCooldown := IniRead("Settings.ini", "Durations", "ItemCooldown")

; Click Loops (change values in Settings.ini)
global UltimateLoopClick := IniRead("Settings.ini", "ClickLoops", "UltimateLoopClick")
global FruitLoopClick := IniRead("Settings.ini", "ClickLoops", "FruitLoopClick")
global FlagLoopClick := IniRead("Settings.ini", "ClickLoops", "FlagLoopClick")

; Repeat Functions (change values in Settings.ini)
global UseItemCycles := IniRead("Settings.ini", "RepeatFunctions", "UseItemCycles")

; Reconnect via Private Server Deeplink (change values in Settings.ini)
global DeepLink := IniRead("Settings.ini", "ReconnectSettings", "Deeplink")
global AutoOpenRoblox := IniRead("Settings.ini", "ReconnectSettings", "AutoOpenRoblox")

; Current Mastery Level (change values in Settings.ini)
global FruitMastery99 := IniRead("Settings.ini", "Mastery", "FruitMastery99")

; Last Area Item / Flag to be Used (change values in Settings.ini)
CoordsItemUse := Map()
CoordsItemUse["UseItem"] := IniRead("Settings.ini", "ItemUse", "UseItemInLastZone")
CoordsItemUse["FlagInLastArea"] := IniRead("Settings.ini", "ItemUse", "UseFlagInLastZone")
CoordsItemUse["CurrentFlagPixel"] := IniRead("Settings.ini", "ItemUse", "FlagPixelUsedInLastZone")

; Hex Codes for Fruits (change values in Settings.ini)
CoordsPixelFruit := Map()
CoordsPixelFruit["AllFruits"] := ["Apple", "Pineapple", "Banana", "Orange", "Watermelon", "Rainbow Fruit"]
CoordsPixelFruit["Apple"] := IniRead("Settings.ini", "HexCodes", "ApplePixel")
CoordsPixelFruit["Pineapple"] := IniRead("Settings.ini", "HexCodes", "PineapplePixel")
CoordsPixelFruit["Banana"] := IniRead("Settings.ini", "HexCodes", "BananaPixel")
CoordsPixelFruit["Orange"] := IniRead("Settings.ini", "HexCodes", "OrangePixel")
CoordsPixelFruit["Watermelon"] := IniRead("Settings.ini", "HexCodes", "WatermelonPixel")
CoordsPixelFruit["Rainbow Fruit"] := IniRead("Settings.ini", "HexCodes", "RainbowFruitPixel")

; Hex Codes for Other Items (change values in Settings.ini)
CoordsOtherItems := Map()
CoordsOtherItems["DisconnectUI"] := IniRead("Settings.ini", "HexCodes", "DisconnectUIPixel")
CoordsOtherItems["AutoFarmEnabled"] := IniRead("Settings.ini", "HexCodes", "AutoFarmEnabledPixel")
CoordsOtherItems["AutoHatchEnabled"] := IniRead("Settings.ini", "HexCodes", "AutoHatchEnabledPixel")
CoordsOtherItems["CrystalKeyPixel"] := IniRead("Settings.ini", "HexCodes", "CrystalKeyPixel")
CoordsOtherItems["TechKeyPixel"] := IniRead("Settings.ini", "HexCodes", "TechKeyPixel")
CoordsOtherItems["PartyBoxPixel"] := IniRead("Settings.ini", "HexCodes", "PartyBoxPixel")
CoordsOtherItems["NoItemBackpack"] := IniRead("Settings.ini", "HexCodes", "NoItemBackpackPixel")
CoordsOtherItems["TeleportBgPixel"] := IniRead("Settings.ini", "HexCodes", "TeleportBgPixel")

; Map Coordinates (change values here)
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
CoordsMap["TpLastAreaButton"] := [907, 320]
CoordsMap["EnableHoverboard"] := [270, 377]
CoordsMap["ToggleAutoHatch"] := [1155, 395]
CoordsMap["OpenEggSettingsExit"] := [1299, 256]
CoordsMap["MenuExit"] := [1492, 253]
CoordsMap["HatchAllEgg"] := [1199, 735]
CoordsMap["ReconnectButton"] := [1056, 620]
CoordsMap["MenuButton"] := [965, 961]
CoordsMap["BackpackButton"] := [387, 402]
CoordsMap["UseUltimate"] := [585, 957]
CoordsMap["VoidWorld"] := [383, 587]
CoordsMap["CraftOneKeyButton"] := [670, 739]
CoordsMap["OkayButtonCraftKeys"] := [957, 733]
CoordsMap["FlagPixelSearch"] := [501, 410]
CoordsMap["FirstItemLocation"] := [501, 410]
CoordsMap["CheckDisconnectUI"] := [773, 533]
CoordsMap["EnableAutoFarm"] := [194, 460]
CoordsMap["OpenEggSettings"] := [87, 460]
CoordsMap["FruitPixelSearch"] := [501, 410]

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                         Main GUI
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

global DeepLinkRun := false
global LastFunction := ""
global LastChosenSwitch := ""
global ScreenWidth := SysGet(78)
global ScreenHeight := SysGet(79)

RequirementsMacro()
RequirementsMacro() {
    if (ScreenWidth != 1920 or ScreenHeight != 1080) {
        MsgBox "Your monitor's resolution is not 1920 x 1080. Exiting macro."
        ExitApp
    }
    
    if (A_ScreenDPI != 96) {
        MsgBox "Your monitor's scale is not 100%. Exiting macro."
        ExitApp
    }

    MyGui := Gui(, "Pet Sim 99 Macro v1.2")
    MyGui.Opt("+AlwaysOnTop +Owner")
    MyGui.Add("Text",, "Thank you for using my macro! From @raeleii on Discord.")
    MyGui.Add("Text",, "Choose an option:`n1) Hatch and Grind`n2) Drop and Grind`n3) Grind Last Area`n4) Auto Craft Keys`n5) Debug Mode (Get pixel hex codes)`n6) Exit Macro")
    MyGui.Add("Text", "xm y+10", "Please input a number from 1 to 6.")
    MyGui.Add("Edit", "vOption w230 xm")
    MyGui.Add("Button", "default x+10", "OK").OnEvent("Click", ProcessUserInput)
    MyGui.OnEvent("Close", ProcessUserInput)
    MyGui.Show("NoActivate")
    MyGui.Show

    ProcessUserInput(*) {
        Saved := MyGui.Submit()
        Switch Saved.Option {
            Case 1:
                MsgBox("You selected Hatch & Grind. The macro will now start.")
                LastChosenSwitch := 1
                CheckRobloxWindow()
                StupidLeaderboard()
                ClaimFreeGifts()
                if (FruitMastery99 == "false") {
                    AutoEatFruit()
                }
                GoToLastArea()
                CheckAutoFarmCase1()
            Case 2:
                MsgBox("You selected Drop & Grind. The macro will now start.")
                LastChosenSwitch := 2
                CheckRobloxWindow()
                StupidLeaderboard()
                ClaimFreeGifts()
                if (FruitMastery99 == "false") {
                    AutoEatFruit()
                }
                GoToLastArea()
                CheckAutoFarmCase2()
            Case 3:
                MsgBox("You selected Grind Last Area. The macro will now start.")
                LastChosenSwitch := 3
                CheckRobloxWindow()
                StupidLeaderboard()
                ClaimFreeGifts()
                if (FruitMastery99 == "false") {
                    AutoEatFruit()
                }
                GoToLastArea()
                CheckAutoFarmCase3()
            Case 4:
                MsgBox("You selected Auto Craft Keys. The macro will now start.")
                LastChosenSwitch := 4
                CheckRobloxWindow()
                StupidLeaderboard()
                CraftCrystalKeys()
                CraftTechKeys()
            Case 5:
                CheckRobloxWindow()
                StupidLeaderboard()
                GetPixelHexCode()
            Case 6:
                MsgBox "Thank you for using my macro. Have a great day!"
                ExitApp
            Default:
                MsgBox "The selected option is not recognized. Exiting macro."
                ExitApp
        }
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                      Main Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CheckRobloxWindow() {
    CheckWindowSizeAndSendF11() {
        WinActivate()
        WinGetPos &X, &Y, &RobloxWidth, &RobloxHeight
        if (RobloxWidth != ScreenWidth and RobloxHeight != ScreenHeight) {
            Send "{F11}"
        } else {
            return
        }
    }

    if (AutoOpenRoblox == "true") {
        if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
            CheckWindowSizeAndSendF11()
            Sleep (1000 * DelayModifier)
        } else if !(WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox")) {
            global DeepLink
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=8737899170"
            }
            run (DeepLink)
            DeepLinkRun := true
            Sleep (ReconnectionDelay * 1000)
            if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
                CheckWindowSizeAndSendF11()
                Sleep (1000 * DelayModifier)
            } else {
                CheckRobloxWindow()
            }
        } 
    } else if (AutoOpenRoblox == "false") {
        if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
            CheckWindowSizeAndSendF11()
            Sleep (1000 * DelayModifier)
        } else {
            MsgBox "Roblox is not running. Exiting script."
            ExitApp
        }
    }
}

StupidLeaderboard() {
    DeepLinkRun := false
    Send "{Tab}"
    Sleep (250 * DelayModifier)
}

ClaimFreeGifts() { ; Claim free gifts when macro is starting or reconnects
    MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if Activate == (CoordsOtherItems["DisconnectUI"]) { ; If disconnect UI shows the color bg
        global DeepLink
        if (DeepLink == "") {
            DeepLink := "roblox://placeID=8737899170"
        }
            run (DeepLink)
            DeepLinkRun := true
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

        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
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
    
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
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
    
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
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
        
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
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
    
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
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
     
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
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

AutoPlaceFlag() {
    consecutiveElseCount := 0

    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsItemUse["FlagInLastArea"]
        Sleep (250 * DelayModifier)

        X := CoordsMap["FlagPixelSearch"][1]
        Y := CoordsMap["FlagPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsItemUse["CurrentFlagPixel"]) { ; If flag color pixel is there
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

GoToLastArea() {
    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
    Sleep (500 * DelayModifier)
    SendText "Hacker Mainframe"
    Sleep (500 * DelayModifier)

    X := CoordsMap["TpLastAreaButton"][1]
    Y := CoordsMap["TpLastAreaButton"][2]
    SendEvent "{Click, " X ", " Y ", Right}"
    Sleep (500 * DelayModifier)
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if (Activate == CoordsOtherItems["TeleportBgPixel"]) {
        SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
    } else {
        SendEvent "{Click, " CoordsMap["TpLastAreaButton"][1] ", " CoordsMap["TpLastAreaButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
        Sleep (TpToLastArea * 1000)
        SendEvent "{Click, " CoordsMap["EnableHoverboard"][1] ", " CoordsMap["EnableHoverboard"][2] "}"
        Sleep (1000 * DelayModifier)
        Send ("{W down}")
        Sleep (MoveLastArea * 1000)
        Send ("{W up}")
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["EnableHoverboard"][1] ", " CoordsMap["EnableHoverboard"][2] "}"
        Sleep (500 * DelayModifier)
    }
}

TeleportToSpawn() {
    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["VoidWorld"][1] ", " CoordsMap["VoidWorld"][2] "}"
    Sleep (TpToLastArea * 1000)
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                              Hatch & Grind Functions (Case 1)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CheckAutoFarmCase1() {
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

    if (Activate == CoordsOtherItems["AutoFarmEnabled"]) { ; If autofarm is enabled 
        Sleep(1000 * DelayModifier)
        AutoPlaceFlag()
        Sleep(1000 * DelayModifier)
        CheckEggAutoHatch()
    } else { ; If autofarm is disabled
        Sleep(1000 * DelayModifier)
        SendEvent "{Click}"
        Sleep(1000 * DelayModifier)
        AutoPlaceFlag()
        Sleep(1000 * DelayModifier)
        CheckEggAutoHatch()
    }
}

CheckEggAutoHatch() {
    X := CoordsMap["OpenEggSettings"][1]
    Y := CoordsMap["OpenEggSettings"][2]
    SendEvent "{Click, " X ", " Y ", Right}"
    Sleep (500 * DelayModifier)
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if Activate == (CoordsOtherItems["AutoHatchEnabled"]) { ; If autohatch is enabled
        GoToEggHatch()
    } else { ; If autohatch is disabled
        SendEvent "{Click}"
        Sleep (250 * DelayModifier)
        SendEvent "{Click, " CoordsMap["ToggleAutoHatch"][1] ", " CoordsMap["ToggleAutoHatch"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
        Sleep (500 * DelayModifier)
        GoToEggHatch()
    }
}

GoToEggHatch() {
    Send ("{I down}")
    Sleep (400)
    Send ("{I up}")
    Sleep (1000 * DelayModifier)
    Send ("{D down}")
    Sleep (MoveToBestEggSideward * 1000)
    Send ("{D up}")
    Sleep (1000 * DelayModifier)
    Send ("{W down}")
    Sleep (MoveToBestEggForward * 1000)
    Send ("{W up}")
    HatchBestEgg()
}

HatchBestEgg() {
    LastFunction := "HatchBestEgg"

    Sleep (1000 * DelayModifier)
    Send ("{E}")
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["HatchAllEgg"][1] ", " CoordsMap["HatchAllEgg"][2] "}"
    Sleep (250 * DelayModifier)

    EndTime := A_TickCount + (TimerDuration * 1000)
    while (A_TickCount < EndTime) {
        Loop UltimateLoopClick {
            SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
        }
        MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsOtherItems["DisconnectUI"]) { ; If disconnect UI shows the color bg
            global DeepLink
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=8737899170"
            }
                run (DeepLink)
                DeepLinkRun := true
                Sleep (ReconnectionDelay * 1000)
                PostReconnectOperations()
                return
        }
    }
    AutoEatFruitTimerCase1()
}

MoveToDisableAutoHatch() {
    Send ("{S down}")
    Sleep (MoveDisableHatchEgg * 1000)
    Send ("{S up}")
    Sleep (1000 * DelayModifier)
}

AutoEatFruitTimerCase1() {
    Sleep (1000 * DelayModifier)
    MoveToDisableAutoHatch()
    TeleportToSpawn()
    if LastFunction = ("HatchBestEgg") {
        LastFunction := ""
        PostReconnectOperations()
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                              Drop & Grind Functions (Case 2)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CheckAutoFarmCase2() {
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

    if (Activate == CoordsOtherItems["AutoFarmEnabled"]) { ; If autofarm is enabled 
        Sleep(1000 * DelayModifier)
        AutoPlaceFlag()
        Sleep(1000 * DelayModifier)
        UseItemLastArea()
    } else { ; If autofarm is disabled
        Sleep(1000 * DelayModifier)
        SendEvent "{Click}"
        Sleep(1000 * DelayModifier)
        AutoPlaceFlag()
        Sleep(1000 * DelayModifier)
        UseItemLastArea()
    }
}

UseItemLastArea() {
    LastFunction := "UseItemLastArea"
    counter := 0

    while (counter < UseItemCycles) {
        if (UseItemCycles <= 0) {
            MsgBox("UseItemCycles value must be greater than 0. Exiting macro.")
            ExitApp
        }
        Loop 1 {
            SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
            Sleep (500 * DelayModifier)
            SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
            Sleep (500 * DelayModifier)
            SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
            Sleep (500 * DelayModifier)
            SendText CoordsItemUse["UseItem"]
            Sleep (500 * DelayModifier)

            X := CoordsMap["FirstItemLocation"][1]
            Y := CoordsMap["FirstItemLocation"][2]
            SendEvent "{Click, " X ", " Y ", Right}"
            Sleep (100 * DelayModifier)
            MouseGetPos &MouseX, &MouseY
            Activate := PixelGetColor(MouseX, MouseY, )
    
            if Activate == (CoordsOtherItems["PartyBoxPixel"]) { ; If party box color pixel is there
                SendEvent "{Click}"
                Sleep (250 * DelayModifier) 
                SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
                Sleep (250 * DelayModifier) 
                SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
                Sleep (250 * DelayModifier) 
                SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
                Sleep (ItemCooldown * 1000)
                counter++
            } else { ; If party box color pixel is not there
                SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
                Sleep (250 * DelayModifier) 
                SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
                Sleep (250 * DelayModifier) 
            }
        }

        MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsOtherItems["DisconnectUI"]) { ; If disconnect UI shows the color bg
            global DeepLink
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=8737899170"
            }
                run (DeepLink)
                DeepLinkRun := true
                Sleep (ReconnectionDelay * 1000)
                PostReconnectOperations()
                return
        }
    }
    AutoEatFruitTimerCase2()
}

AutoEatFruitTimerCase2() {
    Sleep (1000 * DelayModifier)
    TeleportToSpawn()
    if LastFunction = ("UseItemLastArea") {
        LastFunction := ""
        PostReconnectOperations()
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                             Grind Last Area Functions (Case 3)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CheckAutoFarmCase3() {
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

    if (Activate == CoordsOtherItems["AutoFarmEnabled"]) { ; If autofarm is enabled 
        Sleep(1000 * DelayModifier)
        AutoPlaceFlag()
        Sleep(1000 * DelayModifier)
        UseUltimateAndReconnect()
    } else { ; If autofarm is disabled
        Sleep(1000 * DelayModifier)
        SendEvent "{Click}"
        Sleep(1000 * DelayModifier)
        AutoPlaceFlag()
        Sleep(1000 * DelayModifier)
        UseUltimateAndReconnect()
    }
}

UseUltimateAndReconnect() {
    LastFunction := "UseUltimateAndReconnect"

    EndTime := A_TickCount + (TimerDuration * 1000)
    while (A_TickCount < EndTime) {
        Loop UltimateLoopClick {
            SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
        }
        MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsOtherItems["DisconnectUI"]) { ; If disconnect UI shows the color bg
            global DeepLink
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=8737899170"
            }
                run (DeepLink)
                DeepLinkRun := true
                Sleep (ReconnectionDelay * 1000)
                PostReconnectOperations()
                return
        }
    }
    AutoEatFruitTimerCase3()
}

AutoEatFruitTimerCase3() {
    Sleep (1000 * DelayModifier)
    TeleportToSpawn()
    if LastFunction = ("UseUltimateAndReconnect") {
        LastFunction := ""
        PostReconnectOperations()
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                 Auto Craft Keys (Case 4)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CraftCrystalKeys() {
    SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
    Sleep (500 * DelayModifier)

    while (true) {
        MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsOtherItems["DisconnectUI"]) { ; If disconnect UI shows the color bg
            global DeepLink
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=8737899170"
            }
                run (DeepLink)
                DeepLinkRun := true
                Sleep (ReconnectionDelay * 1000)
                PostReconnectOperations()
                return
        }

        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText "Crystal Key: Upper Half"
        Sleep (250 * DelayModifier)

        X := CoordsMap["FirstItemLocation"][1]
        Y := CoordsMap["FirstItemLocation"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )
    
        if Activate == (CoordsOtherItems["CrystalKeyPixel"]) { 
            SendEvent "{Click}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["CraftOneKeyButton"][1] ", " CoordsMap["CraftOneKeyButton"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OkayButtonCraftKeys"][1] ", " CoordsMap["OkayButtonCraftKeys"][2] "}"
            Sleep (700 * DelayModifier)
            continue
        } else if Activate == (CoordsOtherItems["NoItemBackpack"]) {
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            break
        } else if Activate != (CoordsOtherItems["CrystalKeyPixel"]) {
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
            Sleep (500 * DelayModifier)
            SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
            Sleep (350 * DelayModifier)
            continue
        }
    }
}

CraftTechKeys() {
    SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
    Sleep (500 * DelayModifier)

    while (true) {
        MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsOtherItems["DisconnectUI"]) { ; If disconnect UI shows the color bg
            global DeepLink
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=8737899170"
            }
                run (DeepLink)
                DeepLinkRun := true
                Sleep (ReconnectionDelay * 1000)
                PostReconnectOperations()
                return
        }

        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText "Tech Key: Upper Half"
        Sleep (250 * DelayModifier)

        X := CoordsMap["FirstItemLocation"][1]
        Y := CoordsMap["FirstItemLocation"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )
    
        if Activate == (CoordsOtherItems["TechKeyPixel"]) {
            SendEvent "{Click}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["CraftOneKeyButton"][1] ", " CoordsMap["CraftOneKeyButton"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OkayButtonCraftKeys"][1] ", " CoordsMap["OkayButtonCraftKeys"][2] "}"
            Sleep (700 * DelayModifier)
            continue
        } else if Activate == (CoordsOtherItems["NoItemBackpack"]) {
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            break
        } else if Activate != (CoordsOtherItems["CrystalKeyPixel"]) {
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
            Sleep (500 * DelayModifier)
            SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
            Sleep (350 * DelayModifier)
            continue
        }
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                    Restart Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

PostReconnectOperations() {
    Switch LastChosenSwitch {
        Case 1:
            ClaimFreeGifts()
            if (FruitMastery99 == "false") {
                AutoEatFruit()
            }
            GoToLastArea()
            CheckAutoFarmCase1()
        Case 2:
            ClaimFreeGifts()
            if (FruitMastery99 == "false") {
                AutoEatFruit()
            }
            GoToLastArea()
            CheckAutoFarmCase2()
        Case 3:
            ClaimFreeGifts()
            if (FruitMastery99 == "false") {
                AutoEatFruit()
            }
            GoToLastArea()
            CheckAutoFarmCase3()
        Case 4:
            ClaimFreeGifts()
            if (FruitMastery99 == "false") {
                AutoEatFruit()
            }
            CraftCrystalKeys()
            CraftTechKeys()
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                             Functions for Pause / Exit Macro
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

PauseMacro() { ; Pause the macro
    if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
        WinActivate()
        WinGetPos &X, &Y, &RobloxWidth, &RobloxHeight
        if (RobloxWidth == ScreenWidth and RobloxHeight == ScreenHeight) {
            Send "{F11}"
            Pause -1
        } else {
            Send "{F11}"
            Pause -1
        }
    }
}

ExitMacro() { ; Exit the macro
    if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
        WinActivate()
        WinGetPos &X, &Y, &RobloxWidth, &RobloxHeight
        if (RobloxWidth == ScreenWidth and RobloxHeight == ScreenHeight) {
            Send "{F11}"
            ExitApp
        } else {
            ExitApp
        }
    } else {
        ExitApp
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                   Debugging Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

GetPixelHexCode() {
    MyGui2 := Gui(, "Pet Sim 99 Macro v1.2")
    MyGui2.Opt("+AlwaysOnTop +Owner")
    MyGui2.Add("Text",, "Choose an option:`n1) Get Fruit Hex Code`n2) Get Flag Used in Last Area Hex Code`n3) Get Farm / Hatch Enabled Hex Code`n4) Get Crystal / Tech Key Hex Code`n5) Get Item Used in Last Area Hex Code`n6) Get Teleport Background Button Hex Code`n7) Go Back to Main Macro")
    MyGui2.Add("Text", "xm y+10", "Please input a number from 1 to 7.")
    MyGui2.Add("Edit", "vOption w230 xm")
    MyGui2.Add("Button", "default x+10", "OK").OnEvent("Click", ProcessUserInput)
    MyGui2.OnEvent("Close", ProcessUserInput)
    MyGui2.Show("NoActivate")
    MyGui2.Show

    ProcessUserInput(*) {
        Saved := MyGui2.Submit()
        Switch Saved.Option {
            Case 1:
                SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText CoordsPixelFruit["AllFruits"][1]
                Sleep (250 * DelayModifier)

                X := CoordsMap["FruitPixelSearch"][1]
                Y := CoordsMap["FruitPixelSearch"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                AppleHexCode := PixelGetColor(MouseX, MouseY, )

                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText CoordsPixelFruit["AllFruits"][2]
                Sleep (250 * DelayModifier)

                X := CoordsMap["FruitPixelSearch"][1]
                Y := CoordsMap["FruitPixelSearch"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                PineappleHexCode := PixelGetColor(MouseX, MouseY, )

                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText CoordsPixelFruit["AllFruits"][3]
                Sleep (250 * DelayModifier)

                X := CoordsMap["FruitPixelSearch"][1]
                Y := CoordsMap["FruitPixelSearch"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                BananaHexCode := PixelGetColor(MouseX, MouseY, )

                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText CoordsPixelFruit["AllFruits"][4]
                Sleep (250 * DelayModifier)

                X := CoordsMap["FruitPixelSearch"][1]
                Y := CoordsMap["FruitPixelSearch"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                OrangeHexCode := PixelGetColor(MouseX, MouseY, )

                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText CoordsPixelFruit["AllFruits"][5]
                Sleep (250 * DelayModifier)

                X := CoordsMap["FruitPixelSearch"][1]
                Y := CoordsMap["FruitPixelSearch"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                WatermelonHexCode := PixelGetColor(MouseX, MouseY, )

                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText CoordsPixelFruit["AllFruits"][6]
                Sleep (250 * DelayModifier)

                X := CoordsMap["FruitPixelSearch"][1]
                Y := CoordsMap["FruitPixelSearch"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                RainbowFruitHexCode := PixelGetColor(MouseX, MouseY, )

                MsgBox ("Apple Hex Code: " AppleHexCode "`nPineapple Hex Code: " PineappleHexCode "`nBanana Hex Code: " BananaHexCode "`nOrange Hex Code: " OrangeHexCode "`nWatermelon Hex Code: " WatermelonHexCode "`nRainbow Fruit Hex Code: " RainbowFruitHexCode)
                GetPixelHexCode()
            Case 2:
                SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText CoordsItemUse["FlagInLastArea"]
                Sleep (250 * DelayModifier)

                X := CoordsMap["FlagPixelSearch"][1]
                Y := CoordsMap["FlagPixelSearch"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                Activate := PixelGetColor(MouseX, MouseY, )
                MouseGetPos &MouseX, &MouseY
                FlagUsedHexCode := PixelGetColor(MouseX, MouseY, )

                MsgBox ("Hex Code for used flag in Last Zone: " FlagUsedHexCode)
                GetPixelHexCode()
            Case 3:
                SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
                Sleep (500 * DelayModifier)
                GoToLastAreaModified()
                ZoomOut()

                GoToLastAreaModified() {
                    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
                    Sleep (500 * DelayModifier)
                    SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                    Sleep (500 * DelayModifier)
                    SendText "Hacker Mainframe"
                    Sleep (500 * DelayModifier)

                    X := CoordsMap["TpLastAreaButton"][1]
                    Y := CoordsMap["TpLastAreaButton"][2]
                    SendEvent "{Click, " X ", " Y ", Right}"
                    Sleep (500 * DelayModifier)
                    MouseGetPos &MouseX, &MouseY
                    Activate := PixelGetColor(MouseX, MouseY, )

                    if (Activate == CoordsOtherItems["TeleportBgPixel"]) {
                        SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
                        ZoomOut()
                    } else {
                        SendEvent "{Click, " CoordsMap["TpLastAreaButton"][1] ", " CoordsMap["TpLastAreaButton"][2] "}"
                        Sleep (500 * DelayModifier)
                        SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
                        Sleep (TpToLastArea * 1000)
                        SendEvent "{Click, " CoordsMap["EnableHoverboard"][1] ", " CoordsMap["EnableHoverboard"][2] "}"
                        Sleep (1000 * DelayModifier)
                        Send ("{W down}")
                        Sleep (MoveLastArea * 1000)
                        Send ("{W up}")
                        Sleep (500 * DelayModifier)
                        SendEvent "{Click, " CoordsMap["EnableHoverboard"][1] ", " CoordsMap["EnableHoverboard"][2] "}"
                        Sleep (500 * DelayModifier)
                        ZoomOut()
                    }
                }

                ZoomOut() {
                    Send ("{O down}")
                    Sleep (3000 * DelayModifier)
                    Send ("{O up}")
                }

                X := CoordsMap["EnableAutoFarm"][1]
                Y := CoordsMap["EnableAutoFarm"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (500 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                Activate := PixelGetColor(MouseX, MouseY, )
            
                if (Activate != CoordsOtherItems["AutoFarmEnabled"]) {
                    SendEvent "{Click}"
                    Sleep (500 * DelayModifier)
                }
                MouseGetPos &MouseX, &MouseY
                AutoFarmHexCode := PixelGetColor(MouseX, MouseY, )

                X := CoordsMap["OpenEggSettings"][1]
                Y := CoordsMap["OpenEggSettings"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (500 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                Activate := PixelGetColor(MouseX, MouseY, )
            
                if Activate != (CoordsOtherItems["AutoHatchEnabled"]) { ; If autohatch is enabled
                    SendEvent "{Click}"
                    Sleep (250 * DelayModifier)
                    SendEvent "{Click, " CoordsMap["ToggleAutoHatch"][1] ", " CoordsMap["ToggleAutoHatch"][2] "}"
                    Sleep (500 * DelayModifier)
                    SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
                    Sleep (250 * DelayModifier)
                }
                MouseGetPos &MouseX, &MouseY
                OpenEggHexCode := PixelGetColor(MouseX, MouseY, )

                MsgBox ("Auto Farm Hex Code: " AutoFarmHexCode "`nAuto Hatch Hex Code: " OpenEggHexCode)
                GetPixelHexCode()
            Case 4:
                SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText "Crystal Key: Upper Half"
                Sleep (250 * DelayModifier)

                X := CoordsMap["FirstItemLocation"][1]
                Y := CoordsMap["FirstItemLocation"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                CrystalKeyHexCode := PixelGetColor(MouseX, MouseY, )

                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText "Tech Key: Upper Half"
                Sleep (250 * DelayModifier)

                X := CoordsMap["FirstItemLocation"][1]
                Y := CoordsMap["FirstItemLocation"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                TechKeyHexCode := PixelGetColor(MouseX, MouseY, )

                MsgBox ("Crystal Key Hex Code: " CrystalKeyHexCode "`nTech Key Hex Code: " TechKeyHexCode)
                GetPixelHexCode()
            Case 5:
                SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText CoordsItemUse["UseItem"]
                Sleep (500 * DelayModifier)

                X := CoordsMap["FirstItemLocation"][1]
                Y := CoordsMap["FirstItemLocation"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                ItemPixelLastArea := PixelGetColor(MouseX, MouseY, )
                
                MsgBox ("Last Area Item Hex Code: " ItemPixelLastArea)
                GetPixelHexCode()
            Case 6:
                SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText "Hacker Mainframe"
                Sleep (500 * DelayModifier)

                X := CoordsMap["TpLastAreaButton"][1]
                Y := CoordsMap["TpLastAreaButton"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (500 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                TpBgPixel := PixelGetColor(MouseX, MouseY, )

                if (TpBgPixel == CoordsOtherItems["TeleportBgPixel"]) {
                    MsgBox ("Teleport Current Background Hex Code: " TpBgPixel)
                } else {
                    SendEvent "{Click, " CoordsMap["TpLastAreaButton"][1] ", " CoordsMap["TpLastAreaButton"][2] "}"
                    Sleep (500 * DelayModifier)
                    SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
                    Sleep (TpToLastArea * 1000)
                    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
                    Sleep (500 * DelayModifier)
                    SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                    Sleep (500 * DelayModifier)
                    SendText "Hacker Mainframe"
                    Sleep (500 * DelayModifier)

                    X := CoordsMap["TpLastAreaButton"][1]
                    Y := CoordsMap["TpLastAreaButton"][2]
                    SendEvent "{Click, " X ", " Y ", Right}"
                    Sleep (500 * DelayModifier)
                    MouseGetPos &MouseX, &MouseY
                    TpBgPixel := PixelGetColor(MouseX, MouseY, )

                    MsgBox ("Teleport Current Background Hex Code: " TpBgPixel)
                }
                GetPixelHexCode()
            Case 7:
                RequirementsMacro()
                Default:
                MsgBox "The selected option is not recognized. Exiting macro."
                ExitApp
        }
    }
}