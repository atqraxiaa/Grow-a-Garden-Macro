#Requires AutoHotkey v2.0
; #Include Lib\OCR.ahk
#SingleInstance

; Function Keys to Pause / Exit Macro
F5::PauseMacro()
F6::ExitMacro()

; Read settings from the INI file
global SettingsIni := A_ScriptDir "\Lib\Settings.ini"

; Read Delays / Durations Tab
DelayModifier := IniRead(SettingsIni, "Delays/Durations", "DelayModifier")
TpToLastArea := IniRead(SettingsIni, "Delays/Durations", "TpToLastArea")
ReconnectionDelay := IniRead(SettingsIni, "Delays/Durations", "ReconnectionDelay")
MoveLastArea := IniRead(SettingsIni, "Delays/Durations", "MoveLastArea")
MoveToBestEggForward := IniRead(SettingsIni, "Delays/Durations", "MoveToBestEggForward")
MoveToBestEggSideward := IniRead(SettingsIni, "Delays/Durations", "MoveToBestEggSideward")
MoveDisableHatchEgg := IniRead(SettingsIni, "Delays/Durations", "MoveDisableHatchEgg")
TimerDuration := IniRead(SettingsIni, "Delays/Durations", "TimerDuration")
ItemCooldown := IniRead(SettingsIni, "Delays/Durations", "ItemCooldown")

; Read Hex Codes Tab
DisconnectUI := IniRead(SettingsIni, "HexCodes", "DisconnectUIPixel")
AutoFarmEnabled := IniRead(SettingsIni, "HexCodes", "AutoFarmEnabledPixel")
AutoHatchEnabled := IniRead(SettingsIni, "HexCodes", "AutoHatchEnabledPixel")
CrystalKeyPixel := IniRead(SettingsIni, "HexCodes", "CrystalKeyPixel")
TechKeyPixel := IniRead(SettingsIni, "HexCodes", "TechKeyPixel")
PartyBoxPixel := IniRead(SettingsIni, "HexCodes", "PartyBoxPixel")
NoItemBackpack := IniRead(SettingsIni, "HexCodes", "NoItemBackpackPixel")
TeleportBgPixel := IniRead(SettingsIni, "HexCodes", "TeleportBgPixel")
SprinklerPixel := IniRead(SettingsIni, "HexCodes", "SprinklerPixel")

; Read Fruits Tab
FruitMastery99 := IniRead(SettingsIni, "Fruits", "FruitMastery99")
FruitMastery99 := (FruitMastery99 = "true") ? 1 : 0
FruitLoopClick := IniRead(SettingsIni, "Fruits", "FruitLoopClick")
Apple := IniRead(SettingsIni, "Fruits", "ApplePixel")
Pineapple := IniRead(SettingsIni, "Fruits", "PineapplePixel")
Banana := IniRead(SettingsIni, "Fruits", "BananaPixel")
Orange := IniRead(SettingsIni, "Fruits", "OrangePixel")
Watermelon := IniRead(SettingsIni, "Fruits", "WatermelonPixel")
RainbowFruit := IniRead(SettingsIni, "Fruits", "RainbowFruitPixel")

; Read Item Use Tab
UseSprinkler := IniRead(SettingsIni, "ItemUse", "UseSprinklerInLastZone")
UseSprinkler := (UseSprinkler = "true") ? 1 : 0
SprinklerLoopClick := IniRead(SettingsIni, "ItemUse", "SprinklerLoopClick")
UseItem := IniRead(SettingsIni, "ItemUse", "UseItemInLastZone")
FlagInLastArea := IniRead(SettingsIni, "ItemUse", "UseFlagInLastZone")
CurrentFlagPixel := IniRead(SettingsIni, "ItemUse", "FlagPixelUsedInLastZone")
FlagLoopClick := IniRead(SettingsIni, "ItemUse", "FlagLoopClick")
UseItemCycles := IniRead(SettingsIni, "ItemUse", "UseItemCycles")
UltimateLoopClick := IniRead(SettingsIni, "ItemUse", "UltimateLoopClick")

; Read Reconnection Tab
DeepLink := IniRead(SettingsIni, "Reconnection", "DeepLink")
AutoOpenRoblox := IniRead(SettingsIni, "Reconnection", "AutoOpenRoblox")
AutoOpenRoblox := (AutoOpenRoblox = "true") ? 1 : 0

; Read Event Tab
MoveNewLastArea := IniRead(SettingsIni, "Event", "MoveNewLastArea")
MoveToEventEgg := IniRead(SettingsIni, "Event", "MoveToEventEgg")
MoveForwardNewArea := IniRead(SettingsIni, "Event", "MoveForwardNewArea")
MoveSidewardNewArea := IniRead(SettingsIni, "Event", "MoveSidewardNewArea")
MoveBackwardNewArea := IniRead(SettingsIni, "Event", "MoveBackwardNewArea")

; Define variables to hold references to GUI controls
DelayModifierControl := ""
TpToLastAreaControl := ""
ReconnectionDelayControl := ""
MoveLastAreaControl := ""
MoveToBestEggForwardControl := ""
MoveToBestEggSidewardControl := ""
MoveDisableHatchEggControl := ""
TimerDurationControl := ""
ItemCooldownControl := ""
DisconnectUIControl := ""
AutoFarmEnabledControl := ""
AutoHatchEnabledControl := ""
CrystalKeyPixelControl := ""
TechKeyPixelControl := ""
PartyBoxPixelControl := ""
NoItemBackpackControl := ""
TeleportBgPixelControl := ""
SprinklerPixelControl := ""
FruitMasteryControl := ""
AmountFruitsControl := ""
AppleControl := ""
PineappleControl := ""
BananaControl := ""
OrangeControl := ""
WatermelonControl := ""
RainbowFruitControl := ""
UseSprinklerControl := ""
SprinklerLoopClickControl := ""
UseItemControl := ""
FlagInLastZoneControl := ""
CurrentFlagPixelControl := ""
FlagLoopClickControl := ""
UseItemCyclesControl := ""
UltimateLoopClickControl := ""
DeepLinkControl := ""
AutoOpenRobloxControl := ""
EventForward := ""
EventSideward := ""
EventBackward := ""
EventHatchEgg := ""
EventLastArea := ""

; Map Coordinates (change values here)
CoordsMap := Map()
CoordsMap["AllFruits"] := ["Apple", "Pineapple", "Banana", "Orange", "Watermelon", "Rainbow Fruit"]
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
CoordsMap["FirstItemLocation"] := [501, 410]
CoordsMap["CheckDisconnectUI"] := [773, 533]
CoordsMap["EnableAutoFarm"] := [194, 460]
CoordsMap["OpenEggSettings"] := [87, 460]
CoordsMap["FruitPixelSearch"] := [501, 410]
CoordsMap["NewEventFirstAreaTeleport"] := [529, 354]
CoordsMap["NewEventLastAreaTeleport"] := [1370, 354]

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                         Main GUI
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

DeepLinkRun := false
LastFunction := ""
LastChosenSwitch := ""

RequirementsMacro()
RequirementsMacro() {
    if (A_ScreenWidth != 1920 or A_ScreenHeight != 1080) {
        MsgBox "Your monitor's resolution is not 1920 x 1080. Exiting macro."
        ExitApp
    }
    
    if (A_ScreenDPI != 96) {
        MsgBox "Your monitor's scale is not 100%. Exiting macro."
        ExitApp
    }
}

MyGui := Gui(, "Pet Sim 99 Macro")
MyGui.Opt("+Owner")

; Create a Tab GUI
Tabs := MyGui.Add("Tab3",, ["General", "Delays / Durations", "Hex Codes", "Fruits", "Item Use", "Event", "Reconnect"])

; Main Tab
MyGui.Add("Text", "x20 y55", "Thank you for using my macro!")
MyGui.Add("Text", "x20 y75", "There will be more updates to this macro, including`nan Auto Fish Macro, OCR integration, GUI rework,`nand much more so stay tuned!")
MyGui.Add("Text", "x20 y120", "Click a button below to get started!")
MyGui.Add("Button", "x17.5 y140 w200", "Hatch and Grind").OnEvent("Click", HatchNGrind)
MyGui.Add("Button", "x17.5 y170 w200", "Drop and Grind").OnEvent("Click", DropNGrind)
MyGui.Add("Button", "x17.5 y200 w200", "Grind Last Area").OnEvent("Click", GrindLastArea)
MyGui.Add("Button", "x17.5 y230 w200", "Auto Craft Keys").OnEvent("Click", AutoCraftKeys)
MyGui.Add("Button", "x17.5 y260 w200", "Hatch and Grind (New Event)").OnEvent("Click", HatchNGrindNewEvent)
MyGui.Add("Button", "x17.5 y290 w200", "Debug Mode (Get Pixel Hex Codes)").OnEvent("Click", DebugMode)

; Delays / Durations Tab
Tabs.UseTab(2) 
MyGui.Add("Text", "x20 y55", "Delay Multiplier")
DelayModifierControl := MyGui.Add("Edit", "vDelayModifier xp+170 yp w70", DelayModifier)

MyGui.Add("Text", "x20 y85", "Teleport to Last Area")
TpToLastAreaControl := MyGui.Add("Edit", "vTpToLastArea xp+170 yp w70", TpToLastArea)

MyGui.Add("Text", "x20 y115", "Reconnection Delay")
ReconnectionDelayControl := MyGui.Add("Edit", "vReconnectionDelay xp+170 yp w70", ReconnectionDelay)

MyGui.Add("Text", "x20 y145", "Move to Last Area")
MoveLastAreaControl := MyGui.Add("Edit", "vMoveLastArea xp+170 yp w70", MoveLastArea)

MyGui.Add("Text", "x20 y175", "Move to Best Egg Forward")
MoveToBestEggForwardControl := MyGui.Add("Edit", "vMoveToBestEggForward xp+170 yp w70", MoveToBestEggForward)

MyGui.Add("Text", "x20 y205", "Move to Best Egg Sideward")
MoveToBestEggSidewardControl := MyGui.Add("Edit", "vMoveToBestEggSideward xp+170 yp w70", MoveToBestEggSideward)

MyGui.Add("Text", "x20 y235", "Move to Disable Hatch Egg")
MoveDisableHatchEggControl := MyGui.Add("Edit", "vMoveDisableHatchEgg xp+170 yp w70", MoveDisableHatchEgg)

MyGui.Add("Text", "x20 y265", "Timer Duration (in seconds)")
TimerDurationControl := MyGui.Add("Edit", "vTimerDuration xp+170 yp w70", TimerDuration)

MyGui.Add("Text", "x20 y295", "Item Cooldown")
ItemCooldownControl := MyGui.Add("Edit", "vItemCooldown xp+170 yp w70", ItemCooldown)

; Hex Codes Tab
Tabs.UseTab(3)
MyGui.Add("Text", "x20 y55", "Disconnect Background UI Pixel")
DisconnectUIControl := MyGui.Add("Edit", "vDisconnectUI xp+170 yp w70", DisconnectUI)

MyGui.Add("Text", "x20 y85", "Autofarm Enabled Pixel")
AutoFarmEnabledControl := MyGui.Add("Edit", "vAutoFarmEnabled xp+170 yp w70", AutoFarmEnabled)

MyGui.Add("Text", "x20 y115", "Autohatch Enabled Pixel")
AutoHatchEnabledControl := MyGui.Add("Edit", "vAutoHatchEnabled xp+170 yp w70", AutoHatchEnabled)

MyGui.Add("Text", "x20 y145", "Crystal Key Pixel")
CrystalKeyPixelControl := MyGui.Add("Edit", "vCrystalKeyPixel xp+170 yp w70", CrystalKeyPixel)

MyGui.Add("Text", "x20 y175", "Tech Key Pixel")
TechKeyPixelControl := MyGui.Add("Edit", "vTechKeyPixel xp+170 yp w70", TechKeyPixel)

MyGui.Add("Text", "x20 y205", "Party Box Pixel")
PartyBoxPixelControl := MyGui.Add("Edit", "vPartyBoxPixel xp+170 yp w70", PartyBoxPixel)

MyGui.Add("Text", "x20 y235", "No Item Backpack Pixel")
NoItemBackpackControl := MyGui.Add("Edit", "vNoItemBackpack xp+170 yp w70", NoItemBackpack)

MyGui.Add("Text", "x20 y265", "Teleport Background Pixel")
TeleportBgPixelControl := MyGui.Add("Edit", "vTeleportBgPixel xp+170 yp w70", TeleportBgPixel)

MyGui.Add("Text", "x20 y295", "Sprinkler Pixel")
SprinklerPixelControl := MyGui.Add("Edit", "vSprinklerPixel xp+170 yp w70", SprinklerPixel)

; Fruits Tab
Tabs.UseTab(4)
MyGui.Add("Text", "x20 y55", "Fruit Mastery Lvl 99")
FruitMasteryControl := MyGui.Add("Checkbox", "vFruitMastery xp+170 yp w70" . (FruitMastery99 ? " Checked" : ""))

MyGui.Add("Text", "x20 y80", "If Fruit Mastery Lvl 99 is checked, fruits will not be`nauto used by macro. Otherwise leave it unchecked.")

MyGui.Add("Text", "x20 y120", "Fruit Use Amount")
AmountFruitsControl := MyGui.Add("Edit", "vAmountFruits xp+170 yp w70", FruitLoopClick)

MyGui.Add("Text", "x20 y150", "Apple Pixel")
AppleControl := MyGui.Add("Edit", "vApple xp+170 yp w70", Apple)

MyGui.Add("Text", "x20 y180", "Pineapple Pixel")
PineappleControl := MyGui.Add("Edit", "vPineapple xp+170 yp w70", Pineapple)

MyGui.Add("Text", "x20 y210", "Banana Pixel")
BananaControl := MyGui.Add("Edit", "vBanana xp+170 yp w70", Banana)

MyGui.Add("Text", "x20 y240", "Orange Pixel")
OrangeControl := MyGui.Add("Edit", "vOrange xp+170 yp w70", Orange)

MyGui.Add("Text", "x20 y270", "Watermelon Pixel")
WatermelonControl := MyGui.Add("Edit", "vWatermelon xp+170 yp w70", Watermelon)

MyGui.Add("Text", "x20 y300", "Rainbow Fruit Pixel")
RainbowFruitControl := MyGui.Add("Edit", "vRainbowFruit xp+170 yp w70", RainbowFruit)

; Item Use Tab
Tabs.UseTab(5)

MyGui.Add("Text", "x20 y55", "Use Sprinkler in Last Zone")
UseSprinklerControl := MyGui.Add("Checkbox", "vUseSprinkler xp+170 yp w70" . (UseSprinkler ? " Checked" : ""))

MyGui.Add("Text", "x20 y85", "Sprinkler Use Amount")
SprinklerLoopClickControl := MyGui.Add("Edit", "vSprinklerLoopClick xp+150 yp w90", SprinklerLoopClick)

MyGui.Add("Text", "x20 y115", "Item Used in Last Zone")
Items := ["Party Box", "Item Jar", "Lucky Block", "Coin Jar", "Piñata", "Comet"]
UseItemControl := MyGui.AddComboBox("vItemLastZone xp+150 yp w90", Items)
UseItemControl.Text := UseItem

MyGui.Add("Text", "x20 y145", "Flag Used in Last Zone")
Flags := ["Exotic Treasure", "Shiny", "Rainbow", "Fortune", "Diamonds", "Hasty", "Coins", "Magnet", "Strength"]
FlagInLastZoneControl := MyGui.AddComboBox("vFlagLastZone xp+150 yp w90", Flags)
FlagInLastZoneControl.Text := FlagInLastArea

MyGui.Add("Text", "x20 y175", "Flag Pixel for Last Zone")
CurrentFlagPixelControl := MyGui.Add("Edit", "vCurrentFlagPixel xp+150 yp w90", CurrentFlagPixel)
CurrentFlagPixelControl.Opt("+ReadOnly -E0x200")

MyGui.Add("Text", "x20 y205", "Flag Use Amount")
FlagLoopClickControl := MyGui.Add("Edit", "vFlagLoopClick xp+150 yp w90", FlagLoopClick)

MyGui.Add("Text", "x20 y235", "Item Use Amount")
UseItemCyclesControl := MyGui.Add("Edit", "vUseItemCycles xp+150 yp w90", UseItemCycles)

MyGui.Add("Text", "x20 y265", "Ultimate Clicks Amount")
UltimateLoopClickControl := MyGui.Add("Edit", "vUltimateLoopClick xp+150 yp w90", UltimateLoopClick)

MyGui.Add("Text", "x20 y295", "After x amount of clicks in your ultimate, it checks`nfor Disconnect UI. If it doesn't, it goes back to loop.")

; Event Tab
Tabs.UseTab(6)
MyGui.Add("Text", "x20 y55", "Values are in seconds! Not milliseconds")

MyGui.Add("Text", "x20 y85", "Move to Event Area Forward")
EventForward := MyGui.Add("Edit", "vEventForward xp+170 yp w70", MoveForwardNewArea)

MyGui.Add("Text", "x20 y115", "Move to Event Area Sideward")
EventSideward := MyGui.Add("Edit", "vEventSideward xp+170 yp w70", MoveSidewardNewArea)

MyGui.Add("Text", "x20 y145", "Move to Event Area Backward")
EventBackward := MyGui.Add("Edit", "vEventBackward xp+170 yp w70", MoveBackwardNewArea)

MyGui.Add("Text", "x20 y175", "Move to Event Last Area")
EventLastArea := MyGui.Add("Edit", "vEventLastArea xp+170 yp w70", MoveNewLastArea)

MyGui.Add("Text", "x20 y205", "Move to Event Egg")
EventHatchEgg := MyGui.Add("Edit", "vEventHatchEgg xp+170 yp w70", MoveToEventEgg)

; Reconnection Tab
Tabs.UseTab(7)
MyGui.Add("Text", "x20 y55", "Auto Open Roblox")
AutoOpenRobloxControl := MyGui.Add("Checkbox", "vAutoOpenRoblox xp+170 yp w70" . (AutoOpenRoblox ? " Checked" : ""))

MyGui.Add("Text", "x20 y80", "If this option is checked, the macro will auto open`nRoblox via deeplink. Otherwise, if it is not checked,`nthe macro will check if a Roblox window exists.")

MyGui.Add("Text", "x20 y130", "Your Private Server Deeplink")
DeepLinkControl := MyGui.Add("Edit", "vDeepLink x17.5 y+7.5 w240 -VScroll" , DeepLink)

MyGui.Add("Text", "x20 y190", "If you don't have private server, just leave it blank.")

MyGui.Add("Text", "x20 y210", "Click the button below if you don't know how to`nconvert a private server link to a deeplink.")
MyGui.Add("Button", "x17.5 y245", "Private Server to Deeplink").OnEvent("Click", OpenPsToDeeplink)

MyGui.Add("Button", "x180 y245", "Save Settings").OnEvent("Click", SaveSettings)

MyGui.Add("Text", "x20 y305", "Made by raeleii with love <3")
MyGui.Show()
MyGui.OnEvent("Close", OnGuiClose)
 
OnGuiClose(*) {
    ExitApp()
}

OpenPsToDeeplink(*) {
    picturePath := A_ScriptDir "\Assets\ps to deeplink.png"
    
    if !FileExist(picturePath) {
        MsgBox "Error: Picture file not found!"
        return
    }
    run picturePath
}

SaveSettings(*) {
    global MyGui
    
    ; Delays / Durations Tab
    IniWrite(DelayModifierControl.Text, SettingsIni, "Delays/Durations", "DelayModifier")
    IniWrite(TpToLastAreaControl.Text, SettingsIni, "Delays/Durations", "TpToLastArea")
    IniWrite(ReconnectionDelayControl.Text, SettingsIni, "Delays/Durations", "ReconnectionDelay")
    IniWrite(MoveLastAreaControl.Text, SettingsIni, "Delays/Durations", "MoveLastArea")
    IniWrite(MoveToBestEggForwardControl.Text, SettingsIni, "Delays/Durations", "MoveToBestEggForward")
    IniWrite(MoveToBestEggSidewardControl.Text, SettingsIni, "Delays/Durations", "MoveToBestEggSideward")
    IniWrite(MoveDisableHatchEggControl.Text, SettingsIni, "Delays/Durations", "MoveDisableHatchEgg")
    IniWrite(TimerDurationControl.Text, SettingsIni, "Delays/Durations", "TimerDuration")
    IniWrite(ItemCooldownControl.Text, SettingsIni, "Delays/Durations", "ItemCooldown")
    
    ; Hex Codes Tab
    IniWrite(DisconnectUIControl.Text, SettingsIni, "HexCodes", "DisconnectUIPixel")
    IniWrite(AutoFarmEnabledControl.Text, SettingsIni, "HexCodes", "AutoFarmEnabledPixel")
    IniWrite(AutoHatchEnabledControl.Text, SettingsIni, "HexCodes", "AutoHatchEnabledPixel")
    IniWrite(CrystalKeyPixelControl.Text, SettingsIni, "HexCodes", "CrystalKeyPixel")
    IniWrite(TechKeyPixelControl.Text, SettingsIni, "HexCodes", "TechKeyPixel")
    IniWrite(PartyBoxPixelControl.Text, SettingsIni, "HexCodes", "PartyBoxPixel")
    IniWrite(NoItemBackpackControl.Text, SettingsIni, "HexCodes", "NoItemBackpackPixel")
    IniWrite(TeleportBgPixelControl.Text, SettingsIni, "HexCodes", "TeleportBgPixel")
    IniWrite(SprinklerPixelControl.Text, SettingsIni, "HexCodes", "SprinklerPixel")
    
    ; Fruits Tab
    IniWrite(FruitMasteryControl.Value ? "true" : "false", SettingsIni, "Fruits", "FruitMastery99")
    IniWrite(AmountFruitsControl.Text, SettingsIni, "Fruits", "FruitLoopClick")
    IniWrite(AppleControl.Text, SettingsIni, "Fruits", "ApplePixel")
    IniWrite(PineappleControl.Text, SettingsIni, "Fruits", "PineapplePixel")
    IniWrite(BananaControl.Text, SettingsIni, "Fruits", "BananaPixel")
    IniWrite(OrangeControl.Text, SettingsIni, "Fruits", "OrangePixel")
    IniWrite(WatermelonControl.Text, SettingsIni, "Fruits", "WatermelonPixel")
    IniWrite(RainbowFruitControl.Text, SettingsIni, "Fruits", "RainbowFruitPixel")
    
    ; Item Use Tab
    IniWrite(UseSprinklerControl.Value ? "true" : "false", SettingsIni, "ItemUse", "UseSprinklerInLastZone")
    IniWrite(SprinklerLoopClickControl.Text, SettingsIni, "ItemUse", "SprinklerLoopClick")
    IniWrite(UseItemControl.Text, SettingsIni, "ItemUse", "UseItemInLastZone")
    IniWrite(FlagInLastZoneControl.Text, SettingsIni, "ItemUse", "UseFlagInLastZone")
    IniWrite(CurrentFlagPixelControl.Text, SettingsIni, "ItemUse", "FlagPixelUsedInLastZone")
    IniWrite(FlagLoopClickControl.Text, SettingsIni, "ItemUse", "FlagLoopClick")
    IniWrite(UseItemCyclesControl.Text, SettingsIni, "ItemUse", "UseItemCycles")
    IniWrite(UltimateLoopClickControl.Text, SettingsIni, "ItemUse", "UltimateLoopClick")
    
    ; Events Tab
    IniWrite(EventForward.Text, SettingsIni, "Event", "MoveForwardNewArea")
    IniWrite(EventSideward.Text, SettingsIni, "Event", "MoveSidewardNewArea")
    IniWrite(EventBackward.Text, SettingsIni, "Event", "MoveBackwardNewArea")
    IniWrite(EventLastArea.Text, SettingsIni, "Event", "MoveNewLastArea")
    IniWrite(EventHatchEgg.Text, SettingsIni, "Event", "MoveToEventEgg")

    ; Reconnection Tab
    IniWrite(AutoOpenRobloxControl.Value ? "true" : "false", SettingsIni, "Reconnection", "AutoOpenRoblox")
    IniWrite(DeepLinkControl.Text, SettingsIni, "Reconnection", "DeepLink")
    
    ; Show confirmation message
    MsgBox "Settings saved successfully!"
    ExitApp
}

HatchNGrind(*) {
    global LastChosenSwitch, FruitMastery99

    FruitMastery99 := ConvertToBooleanString(FruitMastery99)
    MsgBox("You selected Hatch & Grind. The macro will now start.")
    MyGui.Destroy()
    LastChosenSwitch := 1
    CheckRobloxWindow()
    StupidLeaderboard()
    ClaimFreeGifts()
    if (FruitMastery99 == "false") {
        AutoEatFruit()
        GoToLastArea()
        CheckAutoFarmCase1()
    } else if (FruitMastery99 == "true") {
        GoToLastArea()
        CheckAutoFarmCase1()
    }
}

DropNGrind(*) {
    global LastChosenSwitch, FruitMastery99

    FruitMastery99 := ConvertToBooleanString(FruitMastery99)
    MsgBox FruitMastery99
    MsgBox("You selected Drop & Grind. The macro will now start.")
    MyGui.Destroy()
    LastChosenSwitch := 2
    CheckRobloxWindow()
    StupidLeaderboard()
    ClaimFreeGifts()
    if (FruitMastery99 == "false") {
        AutoEatFruit()
        GoToLastArea()
        CheckAutoFarmCase2()
    } else if (FruitMastery99 == "true") {
        GoToLastArea()
        CheckAutoFarmCase2()
    }
}

GrindLastArea(*) {
    global LastChosenSwitch, FruitMastery99

    FruitMastery99 := ConvertToBooleanString(FruitMastery99)
    MsgBox("You selected Grind Last Area. The macro will now start.")
    MyGui.Destroy()
    LastChosenSwitch := 3
    CheckRobloxWindow()
    StupidLeaderboard()
    ClaimFreeGifts()
    if (FruitMastery99 == "false") {
        AutoEatFruit()
        GoToLastArea()
        CheckAutoFarmCase3()
    } else if (FruitMastery99 == "true") {
        GoToLastArea()
        CheckAutoFarmCase3()
    }
}

AutoCraftKeys(*) {
    global LastChosenSwitch

    MsgBox("You selected Auto Craft Keys. The macro will now start.")
    MyGui.Destroy()
    LastChosenSwitch := 4
    CheckRobloxWindow()
    StupidLeaderboard()
    CraftCrystalKeys()
    CraftTechKeys()
}

HatchNGrindNewEvent(*) {
    global LastChosenSwitch, FruitMastery99

    FruitMastery99 := ConvertToBooleanString(FruitMastery99)
    MsgBox("You selected Hatch & Grind (New Event). The macro will now start.")
    MyGui.Destroy()
    LastChosenSwitch := 5
    CheckRobloxWindow()
    StupidLeaderboard()
    ClaimFreeGifts()
    if (FruitMastery99 == "false") {
        AutoEatFruit()
        GoToNewAreaEvent()
        CheckAutoFarmCase5()
    } else if (FruitMastery99 == "true") {
        GoToNewAreaEvent()
        CheckAutoFarmCase5()
    }
}

DebugMode(*) {
    MyGui.Destroy()
    CheckRobloxWindow()
    StupidLeaderboard()
    GetPixelHexCode()
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                      Main Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

ConvertToBooleanString(value) {
    if (value == 1) {
        return "true"
    } else {
        return "false"
    }
}

CheckRobloxWindow() {
    global DelayModifier, AutoOpenRoblox, DeepLink, ReconnectionDelay, DeepLinkRun

    CheckWindowSizeAndSendF11() {
        WinActivate()
        WinGetPos &X, &Y, &RobloxWidth, &RobloxHeight
        if (RobloxWidth != A_ScreenWidth and RobloxHeight != A_ScreenHeight) {
            Send "{F11}"
        } else {
            return
        }
    }

    AutoOpenRoblox := ConvertToBooleanString(AutoOpenRoblox)
    if (AutoOpenRoblox == "true") {
        if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
            CheckWindowSizeAndSendF11()
            Sleep (1000 * DelayModifier)
        } else if !(WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox")) {
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
    global DeepLinkRun

    DeepLinkRun := false
    Send "{Tab}"
    Sleep (250 * DelayModifier)
}

ClaimFreeGifts() { ; Claim free gifts when macro is starting or reconnects
    global DelayModifier, DeepLink, DeepLinkRun, ReconnectionDelay

    MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if (Activate == DisconnectUI) { ; If disconnect UI shows the color bg
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
    global DelayModifier, FruitLoopClick, Apple
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsMap["AllFruits"][1]
        Sleep (250 * DelayModifier)

        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == Apple) { ; If apple color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (200 * DelayModifier)
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
    global DelayModifier, FruitLoopClick, Pineapple
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsMap["AllFruits"][2]
        Sleep (250 * DelayModifier)
    
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == Pineapple) { ; If pineapple color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (200 * DelayModifier)
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
    global DelayModifier, FruitLoopClick, Banana
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsMap["AllFruits"][3]
        Sleep (250 * DelayModifier)
    
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == Banana) { ; If banana color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (200 * DelayModifier)
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
    global DelayModifier, FruitLoopClick, Orange
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsMap["AllFruits"][4]
        Sleep (250 * DelayModifier)
        
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == Orange) { ; If orange color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (200 * DelayModifier)
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
    global DelayModifier, FruitLoopClick, Watermelon
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) {
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsMap["AllFruits"][5]
        Sleep (250 * DelayModifier)
    
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == Watermelon) { ; If watermelon color pixel is there
            Loop FruitLoopClick {
                SendEvent "{Click}"
                Sleep (200 * DelayModifier)
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
    global DelayModifier, FruitLoopClick, RainbowFruit
    consecutiveElseCount := 0
    
    while (consecutiveElseCount < 3) {
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText CoordsMap["AllFruits"][6]
        Sleep (250 * DelayModifier)
     
        X := CoordsMap["FruitPixelSearch"][1]
        Y := CoordsMap["FruitPixelSearch"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == RainbowFruit) { ; If rainbow fruit color pixel is there
            Loop FruitLoopClick {
            SendEvent "{Click}"
            Sleep (200 * DelayModifier)
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
    global DelayModifier, FlagLoopClick, CurrentFlagPixel
    consecutiveElseCount := 0

    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText FlagInLastArea
        Sleep (250 * DelayModifier)

        X := CoordsMap["FirstItemLocation"][1]
        Y := CoordsMap["FirstItemLocation"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == CurrentFlagPixel) { ; If flag color pixel is there
            Loop FlagLoopClick {
                SendEvent "{Click}"
                Sleep (200 * DelayModifier)
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

AutoUseSprinkler() {
    global DelayModifier, SprinklerLoopClick, SprinklerPixel
    consecutiveElseCount := 0

    while (consecutiveElseCount < 3) { 
        SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
        Sleep (500 * DelayModifier)
        SendText "Sprinkler"
        Sleep (250 * DelayModifier)

        X := CoordsMap["FirstItemLocation"][1]
        Y := CoordsMap["FirstItemLocation"][2]
        SendEvent "{Click, " X ", " Y ", Right}"
        Sleep (100 * DelayModifier)
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == SprinklerPixel) { ; If sprinkler color pixel is there
            Loop SprinklerLoopClick {
                SendEvent "{Click}"
                Sleep (200 * DelayModifier)
            }
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
            Sleep (250 * DelayModifier)
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            break
        } else { ; If sprinkler color pixel is not there
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            Sleep (250 * DelayModifier)
            consecutiveElseCount += 1
        }
    }
    return
}

GoToLastArea() {
    global TpToLastArea, MoveLastArea, DelayModifier, TeleportBgPixel

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

    if (Activate == TeleportBgPixel) {
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
    global DelayModifier, TpToLastArea

    Sleep (1000 * DelayModifier)
    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["VoidWorld"][1] ", " CoordsMap["VoidWorld"][2] "}"
    Sleep (TpToLastArea * 1000)
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                  Hatch & Grind Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CheckAutoFarmCase1() {
    global DelayModifier, UseSprinkler, AutoFarmEnabled

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

    UseSprinkler := ConvertToBooleanString(UseSprinkler)
    if (Activate == AutoFarmEnabled) { ; If autofarm is enabled 
        Sleep(1000 * DelayModifier)
        AutoPlaceFlagEvent()
        Sleep(1000 * DelayModifier)
        if (UseSprinkler == "true") {
            AutoUseSprinkler()
            Sleep(1000 * DelayModifier)
        }
        CheckEggAutoHatch()
    } else { ; If autofarm is disabled
        Sleep(1000 * DelayModifier)
        SendEvent "{Click}"
        Sleep(1000 * DelayModifier)
        AutoPlaceFlagEvent()
        Sleep(1000 * DelayModifier)
        if (UseSprinkler == "true") {
            AutoUseSprinkler()
            Sleep(1000 * DelayModifier)
        }
        CheckEggAutoHatch()
    }
}

CheckEggAutoHatch() {
    global DelayModifier, AutoHatchEnabled

    X := CoordsMap["OpenEggSettings"][1]
    Y := CoordsMap["OpenEggSettings"][2]
    SendEvent "{Click, " X ", " Y ", Right}"
    Sleep (500 * DelayModifier)
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if (Activate == AutoHatchEnabled) { ; If autohatch is enabled
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
    global DelayModifier, MoveToBestEggForward, MoveToBestEggSideward

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
    global LastFunction, DelayModifier, DeepLink, DeepLinkRun, UltimateLoopClick, DisconnectUI
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

        if (Activate == DisconnectUI) { ; If disconnect UI shows the color bg
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
    Loop 50 {
        SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
    }
    TeleportToSpawn()
    if (LastFunction == "HatchBestEgg") {
        LastFunction := ""
        PostReconnectOperations()
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                  Drop & Grind Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CheckAutoFarmCase2() {
    global DelayModifier, UseSprinkler, AutoFarmEnabled, UseSprinkler

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

    UseSprinkler := ConvertToBooleanString(UseSprinkler)
    if (Activate == AutoFarmEnabled) { ; If autofarm is enabled 
        Sleep(1000 * DelayModifier)
        AutoPlaceFlagEvent()
        Sleep(1000 * DelayModifier)
        if (UseSprinkler == "true") {
            AutoUseSprinkler()
            Sleep(1000 * DelayModifier)
        }
        UseItemLastArea()
    } else { ; If autofarm is disabled
        Sleep(1000 * DelayModifier)
        SendEvent "{Click}"
        Sleep(1000 * DelayModifier)
        AutoPlaceFlagEvent()
        Sleep(1000 * DelayModifier)
        if (UseSprinkler == "true") {
            AutoUseSprinkler()
            Sleep(1000 * DelayModifier)
        }
        UseItemLastArea()
    }
}

UseItemLastArea() {
    global LastFunction, DelayModifier, ItemCooldown, DeepLink, DeepLinkRun, ReconnectionDelay, DisconnectUI, PartyBoxPixel
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
            SendText UseItem
            Sleep (500 * DelayModifier)

            X := CoordsMap["FirstItemLocation"][1]
            Y := CoordsMap["FirstItemLocation"][2]
            SendEvent "{Click, " X ", " Y ", Right}"
            Sleep (100 * DelayModifier)
            MouseGetPos &MouseX, &MouseY
            Activate := PixelGetColor(MouseX, MouseY, )
    
            if (Activate == PartyBoxPixel) { ; If party box color pixel is there
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

        if (Activate == DisconnectUI) { ; If disconnect UI shows the color bg
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
    global DelayModifier, LastFunction

    Sleep (1000 * DelayModifier)
    TeleportToSpawn()
    if (LastFunction == "UseItemLastArea") {
        LastFunction := ""
        PostReconnectOperations()
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                 Grind Last Area Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CheckAutoFarmCase3() {
    global DelayModifier, UseSprinkler, AutoFarmEnabled

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

    UseSprinkler := ConvertToBooleanString(UseSprinkler)
    if (Activate == AutoFarmEnabled) { ; If autofarm is enabled 
        Sleep(1000 * DelayModifier)
        AutoPlaceFlagEvent()
        Sleep(1000 * DelayModifier)
        if (UseSprinkler == "true") {
            AutoUseSprinkler()
            Sleep(1000 * DelayModifier)
        }
        UseUltimateAndReconnect()
    } else { ; If autofarm is disabled
        Sleep(1000 * DelayModifier)
        SendEvent "{Click}"
        Sleep(1000 * DelayModifier)
        AutoPlaceFlagEvent()
        Sleep(1000 * DelayModifier)
        if (UseSprinkler == "true") {
            AutoUseSprinkler()
            Sleep(1000 * DelayModifier)
        }
        UseUltimateAndReconnect()
    }
}

UseUltimateAndReconnect() {
    global LastFunction, DeepLink, DeepLinkRun, ReconnectionDelay, DelayModifier, DisconnectUI
    LastFunction := "UseUltimateAndReconnect"

    EndTime := A_TickCount + (TimerDuration * 1000)
    while (A_TickCount < EndTime) {
        Loop UltimateLoopClick {
            SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
        }
        MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == DisconnectUI) { ; If disconnect UI shows the color bg
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
    global LastFunction, DelayModifier

    Sleep (1000 * DelayModifier)
    TeleportToSpawn()
    if (LastFunction == "UseUltimateAndReconnect") {
        LastFunction := ""
        PostReconnectOperations()
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                 Auto Craft Keys Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

CraftCrystalKeys() {
    global DelayModifier, DeepLink, DeepLinkRun, ReconnectionDelay, DisconnectUI, CrystalKeyPixel, NoItemBackpack

    SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
    Sleep (500 * DelayModifier)

    while (true) {
        MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == DisconnectUI) { ; If disconnect UI shows the color bg
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
    
        if (Activate == CrystalKeyPixel) { 
            SendEvent "{Click}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["CraftOneKeyButton"][1] ", " CoordsMap["CraftOneKeyButton"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OkayButtonCraftKeys"][1] ", " CoordsMap["OkayButtonCraftKeys"][2] "}"
            Sleep (700 * DelayModifier)
            continue
        } else if (Activate == NoItemBackpack) {
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            break
        } else if (Activate != CrystalKeyPixel) {
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
    global DelayModifier, DeepLink, DeepLinkRun, ReconnectionDelay, DisconnectUI, TechKeyPixel, NoItemBackpack

    SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
    Sleep (500 * DelayModifier)

    while (true) {
        MouseMove CoordsMap["CheckDisconnectUI"][1], CoordsMap["CheckDisconnectUI"][2], 2
        MouseGetPos &MouseX, &MouseY
        Activate := PixelGetColor(MouseX, MouseY, )

        if (Activate == DisconnectUI) { ; If disconnect UI shows the color bg
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
    
        if (Activate == TechKeyPixel) {
            SendEvent "{Click}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["CraftOneKeyButton"][1] ", " CoordsMap["CraftOneKeyButton"][2] "}"
            Sleep (350 * DelayModifier)
            SendEvent "{Click, " CoordsMap["OkayButtonCraftKeys"][1] ", " CoordsMap["OkayButtonCraftKeys"][2] "}"
            Sleep (700 * DelayModifier)
            continue
        } else if (Activate == NoItemBackpack) {
            SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
            break
        } else if (Activate != TechKeyPixel) {
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
;                                            Hatch & Grind (New Event) Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

GoToNewAreaEvent() {
    global DelayModifier, TeleportBgPixel, MoveBackwardNewArea, MoveSidewardNewArea, MoveForwardNewArea

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

    if (Activate == TeleportBgPixel) {
        SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
    } else {
        SendEvent "{Click, " CoordsMap["TpLastAreaButton"][1] ", " CoordsMap["TpLastAreaButton"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
        Sleep (TpToLastArea * 1000)
    }
    TeleportToSpawn()
    Send ("{W down}")
    Sleep (MoveForwardNewArea * 1000)
    Send ("{W up}")
    Sleep (1000 * DelayModifier)
    Send ("{A down}")
    Sleep (MoveSidewardNewArea * 1000)
    Send ("{A up}")
    Sleep (1000 * DelayModifier)
    Send ("{S down}")
    Sleep (MoveBackwardNewArea * 1000)
    Send ("{S up}")
    Sleep (TpToLastArea * 1000)
    GoToLastAreaNewEvent()
}

GoToLastAreaNewEvent() {
    global DelayModifier, TpToLastArea, MoveNewLastArea

    SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["NewEventLastAreaTeleport"][1] ", " CoordsMap["NewEventLastAreaTeleport"][2] "}"
    Sleep (1000 * DelayModifier)
    SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
    Sleep (TpToLastArea * 1000)
    Send ("{W down}")
    Sleep (MoveNewLastArea * 1000)
    Send ("{W up}")
    Sleep (1000 * DelayModifier)
}

CheckAutoFarmCase5() {
    global DelayModifier, AutoFarmEnabled, AutoHatchEnabled

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

    if (Activate == AutoFarmEnabled) { ; If autofarm is enabled 
        Sleep(1000 * DelayModifier)
    } else { ; If autofarm is disabled
        Sleep(1000 * DelayModifier)
        SendEvent "{Click}"
        Sleep(1000 * DelayModifier)
    }

    X := CoordsMap["OpenEggSettings"][1]
    Y := CoordsMap["OpenEggSettings"][2]
    SendEvent "{Click, " X ", " Y ", Right}"
    Sleep (500 * DelayModifier)
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if (Activate == AutoHatchEnabled) { ; If autohatch is enabled
        AutoPlaceFlagEvent()
        Sleep(1000 * DelayModifier)
        GoToEggHatch()
    } else { ; If autohatch is disabled
        SendEvent "{Click}"
        Sleep (250 * DelayModifier)
        SendEvent "{Click, " CoordsMap["ToggleAutoHatch"][1] ", " CoordsMap["ToggleAutoHatch"][2] "}"
        Sleep (500 * DelayModifier)
        SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
        Sleep (500 * DelayModifier)
        AutoPlaceFlagEvent()
        Sleep(1000 * DelayModifier)
        GoToEventEggHatch()
    }
}

AutoPlaceFlagEvent() {
    global DelayModifier, FlagLoopClick

    SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
    Sleep (500 * DelayModifier)
    SendText FlagInLastArea
    Sleep (250 * DelayModifier)

    Loop FlagLoopClick {
        SendEvent "{Click, " CoordsMap["FirstItemLocation"][1] ", " CoordsMap["FirstItemLocation"][2] "}"
        Sleep (200 * DelayModifier)
    }
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
    Sleep (250 * DelayModifier)
    SendEvent "{Click, " CoordsMap["MenuExit"][1] ", " CoordsMap["MenuExit"][2] "}"
    Sleep (250 * DelayModifier)
}

GoToEventEggHatch() {
    global DelayModifier, MoveToEventEgg, LastFunction, UltimateLoopClick, DeepLink, DeepLinkRun, DisconnectUI, ReconnectionDelay
    LastFunction := "HatchBestEggEvent"

    Send ("{A down}")
    Sleep (MoveToEventEgg * 1000)
    Send ("{A up}")
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

        if (Activate == DisconnectUI) { ; If disconnect UI shows the color bg
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
    AutoEatFruitTimerCase5()
}

AutoEatFruitTimerCase5() {
    global LastFunction, DelayModifier

    Sleep (1000 * DelayModifier)
    MoveToDisableAutoHatch()
    Loop 50 {
        SendEvent "{Click, " CoordsMap["UseUltimate"][1] ", " CoordsMap["UseUltimate"][2] "}"
    }
    TeleportToFirstArea()
    if (LastFunction == "HatchBestEggEvent") {
        LastFunction := ""
        PostReconnectOperationsCase5()
    }
}

PostReconnectOperationsCase5() {
    ClaimFreeGifts()
    if (FruitMastery99 == "false") {
        AutoEatFruit()
        GoToLastAreaNewEvent()
        CheckAutoFarmCase5()
    } else if (FruitMastery99 == "true") {
        GoToLastAreaNewEvent()
        CheckAutoFarmCase5()
    }
}

TeleportToFirstArea() {
    global DelayModifier, TpToLastArea

    SendEvent "{Click, " CoordsMap["TpButton"][1] ", " CoordsMap["TpButton"][2] "}"
    Sleep (500 * DelayModifier)
    SendEvent "{Click, " CoordsMap["NewEventFirstAreaTeleport"][1] ", " CoordsMap["NewEventFirstAreaTeleport"][2] "}"
    Sleep (1000 * DelayModifier)
    SendEvent "{Click, " CoordsMap["OpenEggSettingsExit"][1] ", " CoordsMap["OpenEggSettingsExit"][2] "}"
    Sleep (TpToLastArea * 1000)
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                                    Restart Functions
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

PostReconnectOperations() {
    global LastChosenSwitch, FruitMastery99

    Switch LastChosenSwitch {
        Case 1:
            ClaimFreeGifts()
            if (FruitMastery99 == "false") {
                AutoEatFruit()
                GoToLastArea()
                CheckAutoFarmCase1()
            } else if (FruitMastery99 == "true") {
                GoToLastArea()
                CheckAutoFarmCase1()
            }
        Case 2:
            ClaimFreeGifts()
            if (FruitMastery99 == "false") {    
                AutoEatFruit()
                GoToLastArea()
                CheckAutoFarmCase2()
            } else if (FruitMastery99 == "true") {
                GoToLastArea()
                CheckAutoFarmCase2()
            }
        Case 3:
            ClaimFreeGifts()
            if (FruitMastery99 == "false") {
                AutoEatFruit()
                GoToLastArea()
                CheckAutoFarmCase3()
            } else if (FruitMastery99 == "true") {
                GoToLastArea()
                CheckAutoFarmCase3()
            }
        Case 4:
            ClaimFreeGifts()
            if (FruitMastery99 == "false") {
                AutoEatFruit()
                CraftCrystalKeys()
                CraftTechKeys()
            } else if (FruitMastery99 == "true") {
                CraftCrystalKeys()
                CraftTechKeys()
            }
        Case 5:
            ClaimFreeGifts()
            if (FruitMastery99 == "false") {
                AutoEatFruit()
                GoToNewAreaEvent()
                CheckAutoFarmCase5()
            } else if (FruitMastery99 == "true") {
                GoToNewAreaEvent()
                CheckAutoFarmCase5()
            }
    }
}

; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༺❀༻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾
;                                             Functions for Pause / Exit Macro
; ≿━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━༻❀༺━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━≾

PauseMacro() { ; Pause the macro
    if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
        WinActivate()
        WinGetPos &X, &Y, &RobloxWidth, &RobloxHeight
        if (RobloxWidth == A_ScreenWidth and RobloxHeight == A_ScreenHeight) {
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
        if (RobloxWidth == A_ScreenWidth and RobloxHeight == A_ScreenHeight) {
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
    MyGui2.Add("Text",, "Choose an option:`n1) Get Fruit Hex Code`n2) Get Flag Used in Last Area Hex Code`n3) Get Farm / Hatch Enabled Hex Code`n4) Get Crystal / Tech Key Hex Code`n5) Get Item Used in Last Area Hex Code`n6) Get Teleport Background Button Hex Code`n7) Get Sprinkler Hex Code`n8) Go Back to Main Macro")
    MyGui2.Add("Text", "xm y+10", "Please input a number from 1 to 8.")
    MyGui2.Add("Edit", "vOption w230 xm")
    MyGui2.Add("Button", "default x+10", "OK").OnEvent("Click", ProcessUserInput)
    MyGui2.OnEvent("Close", ProcessUserInput)
    MyGui2.Show("NoActivate")
    MyGui2.Show

    ProcessUserInput(*) {
        global DelayModifier, TeleportBgPixel, AutoFarmEnabled, AutoHatchEnabled
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
                SendText CoordsMap["AllFruits"][1]
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
                SendText CoordsMap["AllFruits"][2]
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
                SendText CoordsMap["AllFruits"][3]
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
                SendText CoordsMap["AllFruits"][4]
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
                SendText CoordsMap["AllFruits"][5]
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
                SendText CoordsMap["AllFruits"][6]
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
                SendText FlagInLastArea
                Sleep (250 * DelayModifier)

                X := CoordsMap["FirstItemLocation"][1]
                Y := CoordsMap["FirstItemLocation"][2]
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

                    if (Activate == TeleportBgPixel) {
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
            
                if (Activate != AutoFarmEnabled) {
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
            
                if (Activate != AutoHatchEnabled) { ; If autohatch is enabled
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
                SendText UseItem
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

                if (TpBgPixel == TeleportBgPixel) {
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
                SendEvent "{Click, " CoordsMap["MenuButton"][1] ", " CoordsMap["MenuButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["BackpackButton"][1] ", " CoordsMap["BackpackButton"][2] "}"
                Sleep (500 * DelayModifier)
                SendEvent "{Click, " CoordsMap["SearchWindow"][1] ", " CoordsMap["SearchWindow"][2] "}"
                Sleep (500 * DelayModifier)
                SendText "Sprinkler"
                Sleep (250 * DelayModifier)
        
                X := CoordsMap["FirstItemLocation"][1]
                Y := CoordsMap["FirstItemLocation"][2]
                SendEvent "{Click, " X ", " Y ", Right}"
                Sleep (100 * DelayModifier)
                MouseGetPos &MouseX, &MouseY
                SprinkPixel := PixelGetColor(MouseX, MouseY, )
        
                MsgBox ("Sprinkler Hex Code: " SprinkPixel)
                GetPixelHexCode()
            Case 8:
                RequirementsMacro()
            Default:
                MsgBox "The selected option is not recognized. Exiting macro."
                ExitApp
        }
    }
}