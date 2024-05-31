; Pet Simulator 99 Main Macro (Auto Hatch, Auto Farm, Auto Eat Fruit, Auto Place Flag)
; Ported from Prison HQ Macro
; Created by @raeleii on Discord
; Last updated on 20:09 GMT + 8, 5/31/24 

; Requirements to use this macro
; 1920 x 1080 resolution, 100% scale

#Requires AutoHotkey v2.0
#SingleInstance

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                             Function Keys to Pause/Exit Macro
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

F5::PauseMacro()
F6::ExitMacro()

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                          Delays, in seconds (can accept decimals)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

DelayModifier := 1.05
TpToLastArea := 10
ReconnectionDelay := 120

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                         Durations, in seconds (can accept decimals)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

MoveLastArea := 0.7
MoveToBestEggSideward := 4
MoveToBestEggForward := 0.9
MoveDisableHatchEgg := 3
TimerDuration := 10
ItemCooldown := 7

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                     Click Iterations 
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

UltimateLoopClick := 250
FruitLoopClick := 100
FlagLoopClick := 100

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                 Cycle / Repeat Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

UseItemCycles := 3

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                           Reconnect via Private Server Deeplink
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

DeepLink := "roblox://placeID=8737899170&linkCode=80219899786206186248911499651846"

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                Last Area Item to be Used
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CoordsItemUse := Map()
CoordsItemUse["UseItem"] := "Party Box"

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                              Map Coordinates (Customizable)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

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
CoordsMap["ToggleAutoHatch"] := [1155, 395]
CoordsMap["OpenEggSettingsExit"] := [1299, 256]
CoordsMap["MenuExit"] := [1492, 253]
CoordsMap["HatchAllEgg"] := [1199, 735]
CoordsMap["BreakChest"] := [308, 578]
CoordsMap["ReconnectButton"] := [1056, 620]
CoordsMap["MenuButton"] := [965, 961]
CoordsMap["BackpackButton"] := [387, 402]
CoordsMap["UseUltimate"] := [585, 957]
CoordsMap["VoidWorld"] := [383, 587]
CoordsMap["CraftOneKeyButton"] := [670, 739]
CoordsMap["OkayButtonCraftKeys"] := [957, 733]

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                   Map Coordinates / Hex Codes for Fruits (Customizable)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

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

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                    Map Coordinates / Hex Codes for Flags (Customizable)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CoordsPixelFruit := Map()
CoordsPixelFruit["FruitPixelSearch"] := [501, 410]
CoordsPixelFruit["AllFruits"] := ["Apple", "Pineapple", "Banana", "Orange", "Watermelon", "Rainbow Fruit"]
CoordsPixelFruit["Apple"] := "0xE62F2B"
CoordsPixelFruit["Pineapple"] := "0xFF8C00"
CoordsPixelFruit["Banana"] := "0xBFFFA8"
CoordsPixelFruit["Orange"] := "0xF89C00"
CoordsPixelFruit["Watermelon"] := "0xF0236E"
CoordsPixelFruit["Rainbow Fruit"] := "0xC4EE67"

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                  Map Coordinates / Hex Codes for Other Items (Customizable)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CoordsOtherItems := Map()
CoordsOtherItems["CheckDisconnectUI"] := [1109, 566]
CoordsOtherItems["DisconnectUI"] := "0x393B3D" 
CoordsOtherItems["EnableAutoFarm"] := [194, 460]
CoordsOtherItems["AutoFarmEnabled"] := "0x7CF50C"
CoordsOtherItems["OpenEggSettings"] := [87, 460]
CoordsOtherItems["AutoHatchEnabled"] := "0x7CF50C"
CoordsOtherItems["FirstItemLocation"] := [501, 410]
CoordsOtherItems["CrystalKeyPixel"] := "0x7CF50C"
CoordsOtherItems["TechKeyPixel"] := "0xA0C5DD"
CoordsOtherItems["NoItemBackpack"] := "0xFFFFFF"

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                         Main GUI
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

DeepLinkRun := false
LastFunction := ""
LastChosenSwitch := ""

MyGui := Gui(, "test gui")
MyGui.Opt("+AlwaysOnTop -SysMenu +Owner")
MyGui.Add("Text",, "1) Hatch and Grind`n2) Drop and Grind`n3) Grind Last Area`n4) Grind Economy Mastery (Closed)`n5) Auto Craft Keys")
MyGui.Add("Text",, "Choose a option:")
MyGui.Add("Edit", "vOption")
MyGui.Add("Button", "default", "OK").OnEvent("Click", ProcessUserInput)
MyGui.OnEvent("Close", ProcessUserInput)
MyGui.Show("NoActivate")
MyGui.Show("w230 h160")

ProcessUserInput(*) {
    global LastChosenSwitch
    Saved := MyGui.Submit()
    Switch Saved.Option {
        Case 1:
            MsgBox("You selected Hatch & Grind. The macro will now start.")
            LastChosenSwitch := 1
            CheckRobloxWindow()
            StupidLeaderboard()
            ClaimFreeGifts()
            AutoEatFruit()
            GoToLastArea()
            CheckAutoFarmCase1()
        Case 2:
            MsgBox("You selected Drop & Grind. The macro will now start.")
            LastChosenSwitch := 2
            CheckRobloxWindow()
            StupidLeaderboard()
            ClaimFreeGifts()
            AutoEatFruit()
            GoToLastArea()
            CheckAutoFarmCase2()
        Case 3:
            MsgBox("You selected Grind Last Area. The macro will now start.")
            LastChosenSwitch := 3
            CheckRobloxWindow()
            StupidLeaderboard()
            ClaimFreeGifts()
            AutoEatFruit()
            GoToLastArea()
            CheckAutoFarmCase3()
        Case 4:
            MsgBox("Waiting for more vendings to release on World 3. Exiting macro.")
            LastChosenSwitch := 4
            ExitApp
            ; CheckRobloxWindow()
            ; StupidLeaderboard()
            ; ClaimFreeGifts()
            ; AutoEatFruit()
        Case 5:
            MsgBox("You selected Auto Craft Keys. The macro will now start.")
            LastChosenSwitch := 5
            CheckRobloxWindow()
            ; StupidLeaderboard()
            ; CraftCrystalKeys()
            CraftCrystalKeys()
        Default:
            MsgBox "The selected option is not recognized. Exiting macro."
            ExitApp
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                      Main Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CheckRobloxWindow() { ; Start the macro
    global DelayModifier
    if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
        WinActivate()
        Send "{F11}"
        Sleep (1000 * DelayModifier)
    } else {
        MsgBox "Roblox is not running. Exiting script."
        ExitApp
    }
}   

StupidLeaderboard() {
    global DelayModifier
    Send "{Tab}"
    Sleep (250 * DelayModifier)
}

ClaimFreeGifts() { ; Claim free gifts when macro is starting or reconnects
    global DelayModifier, DeepLink, DeeplinkRun
    SendEvent "{Click, " CoordsOtherItems["CheckDisconnectUI"][1] ", " CoordsOtherItems["CheckDisconnectUI"][2] "}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsOtherItems["CheckDisconnectUI"]) { ; If disconnect UI shows the color bg
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
        Sleep (100 * DelayModifier)
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

GoToLastArea() {
    global TpToLastArea, DelayModifier, MoveLastArea
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
    Sleep (MoveLastArea * 1000)
    Send ("{D up}")
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["EnableHoverboard"][1] ", " CoordsMap["EnableHoverboard"][2] "}"
    Sleep (500 * DelayModifier)
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
    global DelayModifier
    Send ("{O down}")
    Sleep (3000 * DelayModifier)
    Send ("{O up}")
    Sleep (250 * DelayModifier)

    X := CoordsOtherItems["EnableAutoFarm"][1]
    Y := CoordsOtherItems["EnableAutoFarm"][2]
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
    global DelayModifier

    X := CoordsOtherItems["OpenEggSettings"][1]
    Y := CoordsOtherItems["OpenEggSettings"][2]
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
    global TpToLastArea, DelayModifier
    Send ("{I down}")
    Sleep (400)
    Send ("{I up}")
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
    Sleep (500 * DelayModifier)
    SendText "Prison Tower"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["TpLastAreaButton"][1] ", " CoordsMap["TpLastAreaButton"][2] "}"
    Sleep (TpToLastArea * 1000)
    HatchBestEgg()
}

HatchBestEgg() {
    global DeepLink, DeepLinkRun, ReconnectionDelay, LastFunction, TimerDuration, DelayModifier, UltimateLoopClick
    LastFunction := "HatchBestEgg"

    Send ("{A down}")
    Sleep (MoveToBestEggSideward * 1000)
    Send ("{A up}")
    Sleep (1000 * DelayModifier)
    Send ("{W down}")
    Sleep (MoveToBestEggForward * 1000)
    Send ("{W up}")
    Sleep (500 * DelayModifier)
    Send ("{E}")
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["HatchAllEgg"][1] ", " CoordsMap["HatchAllEgg"][2] "}"
    Sleep (250 * DelayModifier)

    EndTime := A_TickCount + (TimerDuration * 1000)
    while (A_TickCount < EndTime) {
        Loop UltimateLoopClick {
            SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
        }
        SendEvent "{Click, " CoordsOtherItems["CheckDisconnectUI"][1] ", " CoordsOtherItems["CheckDisconnectUI"][2] "}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsOtherItems["CheckDisconnectUI"]) { ; If disconnect UI shows the color bg
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
    AutoEatFruitTimerCase1()
}

MoveToDisableAutoHatch() {
    global DelayModifier, MoveDisableHatchEgg
    Send ("{S down}")
    Sleep (MoveDisableHatchEgg * 1000)
    Send ("{S up}")
    Sleep (1000 * DelayModifier)
}

AutoEatFruitTimerCase1() {
    global LastFunction, DelayModifier
    Sleep (1000 * DelayModifier)
    MoveToDisableAutoHatch()
    TeleportToSpawn()
    if LastFunction = ("HatchBestEgg") {
        LastFunction := ""
        PostReconnectOperations()
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                               Drop & Grind Functions (Case 2)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CheckAutoFarmCase2() {
    global DelayModifier
    Send ("{O down}")
    Sleep (3000 * DelayModifier)
    Send ("{O up}")
    Sleep (250 * DelayModifier)

    X := CoordsOtherItems["EnableAutoFarm"][1]
    Y := CoordsOtherItems["EnableAutoFarm"][2]
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
    global DeepLink, DeepLinkRun, ReconnectionDelay, LastFunction, DelayModifier, ItemCooldown, UseItemCycles
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
            SendEvent "{Click, " CoordsOtherItems["FirstItemLocation"][1] ", " CoordsOtherItems["FirstItemLocation"][2] "}"
            Sleep (500 * DelayModifier) 
            SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
            Sleep (250 * DelayModifier) 
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier) 
            SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
            Sleep (ItemCooldown * 1000)
        }

        counter++

        SendEvent "{Click, " CoordsOtherItems["CheckDisconnectUI"][1] ", " CoordsOtherItems["CheckDisconnectUI"][2] "}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsOtherItems["CheckDisconnectUI"]) { ; If disconnect UI shows the color bg
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
    AutoEatFruitTimerCase2()
}

AutoEatFruitTimerCase2() {
    global LastFunction, DelayModifier
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
    global DelayModifier
    Send ("{O down}")
    Sleep (3000 * DelayModifier)
    Send ("{O up}")
    Sleep (250 * DelayModifier)

    X := CoordsOtherItems["EnableAutoFarm"][1]
    Y := CoordsOtherItems["EnableAutoFarm"][2]
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
    global DeepLink, DeepLinkRun, ReconnectionDelay, LastFunction, TimerDuration, DelayModifier, UltimateLoopClick
    LastFunction := "UseUltimateAndReconnect"

    EndTime := A_TickCount + (TimerDuration * 1000)
    while (A_TickCount < EndTime) {
        Loop UltimateLoopClick {
            SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
        }
        SendEvent "{Click, " CoordsOtherItems["CheckDisconnectUI"][1] ", " CoordsOtherItems["CheckDisconnectUI"][2] "}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if Activate == (CoordsOtherItems["CheckDisconnectUI"]) { ; If disconnect UI shows the color bg
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
    AutoEatFruitTimerCase3()
}

AutoEatFruitTimerCase3() {
    global LastFunction, DelayModifier
    Sleep (1000 * DelayModifier)
    TeleportToSpawn()
    if LastFunction = ("UseUltimateAndReconnect") {
        LastFunction := ""
        PostReconnectOperations()
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                               Grind Economy Mastery (Case 4)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

; No code as for now, because there are only 1 vending in World 3.
; World 2 has many vendings but the exp for the mastery is too low.

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                  Auto Craft Keys (Case 5)
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CraftCrystalKeys() {
    global DelayModifier

    SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
    Sleep (500 * DelayModifier)

    while (true) {
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText "Crystal Key: Upper Half"
        Sleep (250 * DelayModifier)

        X := CoordsOtherItems["FirstItemLocation"][1]
        Y := CoordsOtherItems["FirstItemLocation"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )
    
        if (Activate == CoordsOtherItems["CrystalKeyPixel"]) { 
            SendEvent "{Click}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["CraftOneKeyButton"][1] ", " CoordsMap["CraftOneKeyButton"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OkayButtonCraftKeys"][1] ", " CoordsMap["OkayButtonCraftKeys"][2] "}"
            Sleep (700 * DelayModifier)
            continue
        } else if (Activate == CoordsOtherItems["NoItemBackpack"]) {
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            break
        } else {
            SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
            Sleep (350 * DelayModifier)
            continue
        }
    }
}

CraftTechKeys() {
    global DelayModifier

    SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
    Sleep (500 * DelayModifier)

    while (true) {
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText "Tech Key: Upper Half"
        Sleep (250 * DelayModifier)

        X := CoordsOtherItems["FirstItemLocation"][1]
        Y := CoordsOtherItems["FirstItemLocation"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )
    
        if (Activate == CoordsOtherItems["TechKeyPixel"]) {
            SendEvent "{Click}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["CraftOneKeyButton"][1] ", " CoordsMap["CraftOneKeyButton"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OkayButtonCraftKeys"][1] ", " CoordsMap["OkayButtonCraftKeys"][2] "}"
            Sleep (700 * DelayModifier)
            continue
        } else if (Activate == CoordsOtherItems["NoItemBackpack"]) {
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            break
        } else {
            SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
            Sleep (350 * DelayModifier)
            continue
        }
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                     Restart Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

PostReconnectOperations() {
    global LastChosenSwitch
    Switch LastChosenSwitch {
        Case 1:
            ClaimFreeGifts()
            AutoEatFruit()
            GoToLastArea()
            CheckAutoFarmCase1()
        Case 2:
            ClaimFreeGifts()
            AutoEatFruit()
            GoToLastArea()
            CheckAutoFarmCase2()
        Case 3:
            ClaimFreeGifts()
            AutoEatFruit()
            GoToLastArea()
            CheckAutoFarmCase3()
        Case 4:
            ClaimFreeGifts()
            AutoEatFruit()
        Case 5:
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                             Functions for Pause / Exit Macro
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

PauseMacro() { ; Pause the macro
    global DelayModifier
    Sleep (100 * DelayModifier) 
    Send "{F11}"
    Pause -1
}

ExitMacro() { ; Exit the macro
    if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
        WinActivate()
        Send "{F11}"
        ExitApp
    } else {
        MsgBox "Roblox is not running. Fullscreen will not be inputted."
        ExitApp
    }
}