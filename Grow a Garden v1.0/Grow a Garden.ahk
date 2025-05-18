#Requires AutoHotkey v2.0
#SingleInstance

if A_IsCompiled {
    FileInstall "Lib\OCR.ahk", A_Temp "\OCR.ahk", true
    FileInstall "Lib\config.ini", A_Temp "\config.ini", true
    FileInstall "Assets\buy.png", A_Temp "\buy.png", true
    FileInstall "Assets\ps to deeplink.png", A_Temp "\ps.png", true
    FileInstall "Assets\ps to deeplink.txt", A_Temp "\ps.txt", true
    FileInstall "Assets\welcome.png", A_Temp "\welcome.png", true

    global OCRPath := A_Temp "\OCR.ahk"
    global Config := A_Temp "\config.ini"
    global BuyImage := A_Temp "\buy.png"
    global PsImage := A_Temp "\ps.png"
    global WelcomeImage := A_Temp "\welcome.png"
} else {
    global OCRPath := A_ScriptDir "\Lib\OCR.ahk"
    global Config := A_ScriptDir "\Lib\config.ini"
    global BuyImage := A_ScriptDir "\Assets\buy.png"
    global PsImage := A_ScriptDir "\Assets\ps to deeplink.png"
    global WelcomeImage := A_ScriptDir "\Assets\welcome.png"
}

#Include Lib\OCR.ahk

$F5::Pause -1
$F6::ExitApp

global MacroRunning := false
global StartTime := 0
global ElapsedTime := 0
global TimerInterval := 1000
global RetryMinutes := 5
global NextRun := 0
global DeepLinkRun := false
global SelectedFruitsArray := []
global FruitList := ["Carrot", "Strawberry", "Blueberry", "Orange", "Tomato", "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk"]

AutoOpenRoblox   := (IniRead(Config, "UserConfig", "AutoOpenRoblox", "false") = "true") ? 1 : 0
DeepLink         := IniRead(Config, "UserConfig", "DeepLink")
DelayMultiplier  := IniRead(Config, "UserConfig", "DelayMultiplier")
ReconnectionDelay:= IniRead(Config, "UserConfig", "ReconnectionDelay")
DisconnectUIPixel:= IniRead(Config, "UserConfig", "DisconnectUIPixel")
SeedButtonPixel  := IniRead(Config, "UserConfig", "SeedButtonPixel")
BuyButtonPixel1  := IniRead(Config, "UserConfig", "BuyButtonPixel1")

FruitKeys := ["Carrot", "Strawberry", "Blueberry", "Tulip", "Tomato",
             "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple",
             "Bamboo", "Coconut", "Cactus", "Dragon", "Mango",
             "Grape", "Mushroom", "Pepper", "Cacao", "Beanstall"]

for index, fruitKey in FruitKeys {
    value := IniRead(Config, "FruitsChosen", fruitKey, "false")
    if (value = "true") {
        SelectedFruitsArray.Push(fruitKey)
    }
}

CoordsMap := Map()
CoordsMap["SeedButton"] := [685, 112]
CoordsMap["ScrollSeed"] := [1334, 360]

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

AppendTask(text) {
    global MyGui
    old := MyGui["TaskQueue"].Value
    MyGui["TaskQueue"].Value := old . "`n" . text

    controlHWND := MyGui["TaskQueue"].Hwnd
    SendMessage(0x00B1, StrLen(MyGui["TaskQueue"].Value), StrLen(MyGui["TaskQueue"].Value), , controlHWND)
    SendMessage(0x00B7, 0, 0, , controlHWND)
}

StrJoin(delimiter, args*) {
    result := ""
    for index, value in args {
        result .= (index > 1 ? delimiter : "") . value
    }
    return result
}

global MyGui := Gui(, " Grow a Garden Macro")
MyGui.Opt("+Owner")
Tabs := MyGui.Add("Tab3",, ["Config", "Info", "Status", "Help", "Other"])

Tabs.UseTab(1)
MyGui.SetFont("s11", "Figtree")
MyGui.Add("Text", "cgreen y35 x110", "🌱 Grow a Garden Macro 🌱")
MyGui.SetFont("s10 italic", "Figtree")
MyGui.Add("Text", "cblack x20 y60 x175", "Welcome!")
MyGui.SetFont("s9", "Figtree")
MyGui.Add("Text", "cblack x76 y80", "Before running, please go to the 'Help' tab first.")
MyGui.Add("Picture", "x20 y100 w375 h200", WelcomeImage)
MyGui.Add("Button", "x20 y310 w375", "Run Macro").OnEvent("Click", MainMacro)

Tabs.UseTab(2)
MyGui.SetFont("s11", "Figtree")
MyGui.Add("Text", "x20 y35", "Recent Updates:")
MyGui.Add("Text", "x20 y60", "version 1.0 (5/18/25)").SetFont("s9 bold", "Figtree")
MyGui.Add("Text", "x20 y75", "Added buy seed macro").SetFont("s9", "Figtree")
MyGui.SetFont("s9", "Figtree")
MyGui.Add("Text", "x20 y100", "More updates will be released soon, so stay tuned!")

Tabs.UseTab(3)
StatusText := MyGui.Add("Text", "x20 y35 w200 vStatusText", "Status: Stopped")
MyGui.Add("Text", "x20 y55", "Seeds selected to be bought:")
chosenFruitsText := (SelectedFruitsArray.Length > 0) ? StrJoin(", ", SelectedFruitsArray*) : "None"
global chosenFruitsTextControl := MyGui.Add("Text", "x20 y70 w250 +Wrap", chosenFruitsText)
MyGui.Add("Text", "x20 y130", "Task Queue")
MyGui.Add("Edit", "vTaskQueue r12 x20 y150 w375 ReadOnly")

Tabs.UseTab(4)
MyGui.Add("Text", "x20 y35", "Before running this macro, please read this first.")
MyGui.Add("Text", "x20 y55", "Your monitor's resolution should be 1920x1080.")
MyGui.Add("Text", "x20 y70", "Your monitor's scale should be 100%.")
MyGui.Add("Text", "x20 y85", "Avoid moving your mouse while the macro is running.")
MyGui.Add("Text", "x20 y100", "Use F5 to pause and F6 to stop the macro.")
MyGui.Add("Text", "x20 y115", "To adjust other configurations, edit the config.ini file in this folder.")
MyGui.Add("Text", "x20 y140", "Additional settings are available on the 'Other' tab.")
MyGui.Add("Text", "x20 y165", "If you encounter any issues with the macro, please check the links `nbelow or contact the owner via these buttons.")
MyGui.Add("Button", "x20 y200 w375", "Discord").OnEvent("Click", OpenDiscord)
MyGui.Add("Button", "x20 y230 w375", "Github").OnEvent("Click", OpenGithub)
MyGui.Add("Button", "x20 y260 w375", "Youtube").OnEvent("Click", OpenYoutube)

OpenDiscord(*) {
    Run("https://discord.com/users/607083298996486183")
}

OpenGithub(*) {
    Run("https://github.com/atqraxiaa/Grow-a-Garden-Macro/")
}

OpenYoutube(*) {
    Run("https://www.youtube.com/channel/UCWlccRC2Zs0iC8YtvHlWnPA")
}

Tabs.UseTab(5)
MyGui.Add("Text", "x20 y35", "Auto Open Roblox")
AutoOpenRobloxControl := MyGui.Add("Checkbox", "vAutoOpenRoblox xp+220 yp w30" . (AutoOpenRoblox ? " Checked" : ""))
MyGui.Add("Text", "x20 y55 w350",
    "If this option is checked, the macro will automatically open Roblox via deeplink.`n"
  . "Otherwise, if it's not checked, the macro will check for an existing Roblox window.")
MyGui.Add("Text", "x20 y125", "Your Private Server Deeplink")
DeepLinkControl := MyGui.Add("Edit", "vDeepLink x17.5 y+7.5 w375 -VScroll" , DeepLink)
MyGui.Add("Text", "x20 y195", "If you don't have private server, just leave it blank.")
MyGui.Add("Text", "x20 y215 w350",
    "Click the button below if you don't know how to`nconvert a private server link to a deeplink.")
MyGui.Add("Button", "x17.5 y255 w185", "Private Server to Deeplink").OnEvent("Click", OpenPsToDeeplink)
MyGui.Add("Button", "x210 y255 w185", "Save Settings").OnEvent("Click", SaveSettings)
MyGui.Add("Text", "x20 y305", "Made with love by @vaixnae on Discord.")
MyGui.Add("Text", "x20 y320", "Last updated May 18, 2025 (version 1.0)")

MyGui.Show("h350")
MyGui.OnEvent("Close", (*) => ExitApp())

OpenPsToDeeplink(*) {
    picturePath := PsImage

    if !FileExist(picturePath) {
        MsgBox "Error: Picture file not found!"
        return
    }
    run picturePath
}

SaveSettings(*) {
    global MyGui, FruitKeys, SelectedFruitsArray, Config
    MyGui.Submit()

    IniWrite(AutoOpenRobloxControl.Value ? "true" : "false", Config, "UserConfig", "AutoOpenRoblox")
    IniWrite(DeepLinkControl.Text, Config, "UserConfig", "DeepLink")

    selectedFruits := []
    for index, fruitKey in FruitKeys {
        value := IniRead(Config, "FruitsChosen", fruitKey, "false")
        if (value = "true") {
            selectedFruits.Push(fruitKey)
        }
    }
    SelectedFruitsArray := selectedFruits.Clone()

    MsgBox "Settings saved successfully!"
    ExitApp
}

MainMacro(*) {
    RequirementsMacro()
    RunStatus()
    GuiMoveToCornerAndCenter()

    Loop {
        CheckRobloxWindow()
        Sleep(5 * 60 * 1000)
    }
}

ConvertToBooleanString(value) {
    if (value == 1) {
        return "true"
    } else {
        return "false"
    }
}

RunStatus() {
    global MacroRunning, StartTime, ElapsedTime, chosenFruitsTextControl

    if !MacroRunning {
        StartTime := A_TickCount
        ElapsedTime := 0
        MacroRunning := true
        MyGui["StatusText"].Value := "Status: Running (0s)"
        chosenFruitsTextControl.Visible := false
        SetTimer(UpdateTimerDisplay, TimerInterval)
    }
}

GuiMoveToCornerAndCenter() {
    ScreenWidth := A_ScreenWidth
    ScreenHeight := A_ScreenHeight

    MyGui.GetPos(&X, &Y, &GuiWidth, &GuiHeight)

    NewX := ScreenWidth - GuiWidth
    NewY := (ScreenHeight - GuiHeight) // 2

    MyGui.Move(NewX, NewY)
    MyGui.Opt("+AlwaysOnTop")
}

CheckRobloxWindow() {
    global DelayMultiplier, AutoOpenRoblox, DeepLink, ReconnectionDelay, DeepLinkRun

    CheckWindowSizeAndSendF11() {
        WinActivate()
        WinGetPos &X, &Y, &RobloxWidth, &RobloxHeight
        AppendTask("Checking Roblox Window...")
        if (RobloxWidth != A_ScreenWidth and RobloxHeight != A_ScreenHeight) {
            Send "{F11}"
        } else {
            return
        }
    }

    AutoOpenRoblox := ConvertToBooleanString(AutoOpenRoblox)
    if (AutoOpenRoblox == "true") {
        if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
            AppendTask("Roblox is present, running the main macro...")
            CheckWindowSizeAndSendF11()
            Send "{Click}"
            Sleep (1000 * DelayMultiplier)
            StartMouseMove()
        } else if !(WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox")) {
            AppendTask("Attempting to run Roblox via deeplink...")
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=126884695634066"
            }
            run (DeepLink)
            DeepLinkRun := true
            Sleep (ReconnectionDelay * 1000)
            if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
            AppendTask("Roblox is present, running the main macro...")
                CheckWindowSizeAndSendF11()
                Send "{Click}"
                Sleep (1000 * DelayMultiplier)
                StartMouseMove()
            } else {
                CheckRobloxWindow()
            }
        }
    } else if (AutoOpenRoblox == "false") {
        if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
            AppendTask("Roblox is present, running the main macro...")
            CheckWindowSizeAndSendF11()
            Send "{Click}"
            Sleep (1000 * DelayMultiplier)
            StartMouseMove()
        } else {
            AppendTask("Roblox is not present, exiting the macro...")
            MsgBox "Roblox is not running. Exiting script."
            ExitApp
        }
    }
}

StartMouseMove() {
    global DelayMultiplier, DeepLink, DeepLinkRun, ReconnectionDelay, SelectedFruitsArray

    X := CoordsMap["SeedButton"][1]
    Y := CoordsMap["SeedButton"][2]
    AppendTask("Checking for seed button pixel...")
    SendEvent "{Click, " X ", " Y ", Right}"
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if (Activate != SeedButtonPixel) {
        if (DeepLink == "") {
            DeepLink := "roblox://placeID=126884695634066"
        }
            AppendTask("Attempting to reset Roblox...")
            run (DeepLink)
            DeepLinkRun := true
            Sleep (ReconnectionDelay * 1000)
            PostReconnectOperations()
            return
    }
    Sleep (500 * DelayMultiplier)
    SendEvent "{Click}"
    AppendTask("Checking for available seeds...")
    Sleep (500 * DelayMultiplier)
    Send "{E}"
    Sleep (5000 * DelayMultiplier)
    SendEvent "{Click, " CoordsMap["ScrollSeed"][1] ", " CoordsMap["ScrollSeed"][2] "}"
    Sleep (2000 * DelayMultiplier)

    if (SelectedFruitsArray.Length == 0) {
        MsgBox "Please select at least one fruit in the 'Settings' tab before running the macro."
        return
    }

    OCRReadText(SelectedFruitsArray*)
    Sleep (500)
}

OCRReadText(selectedFruits*) {
    foundFruits := Map()

    Loop 10 {
        Send "{WheelUp 5}"
        Sleep(100)
    }

    AppendTask("Scanning page 1 of 20...")
    result := OCR.FromWindow("Roblox")
    ScanFruits(result, selectedFruits, foundFruits)

    Loop 19 {
        Loop 2 {
            Send "{WheelDown}"
            Sleep(500)
        }

        page := A_Index + 1
        AppendTask("Scanning page " . page . " of 20...")
        result := OCR.FromDesktop()
        ScanFruits(result, selectedFruits, foundFruits)
    }

    for fruit in selectedFruits {
        if !foundFruits.Has(fruit) {
            AppendTask(fruit . " has no stock!")
        }
    }

    AppendTask("Waiting 5 minutes before next scan...")
}

ScanFruits(result, selectedFruits, foundFruits) {
    for phrase in selectedFruits {
        if foundFruits.Has(phrase)
            continue

        for line in result.Lines {
            if InStr(line.Text, phrase) {
                AppendTask("Found " . phrase . " at (" . line.x . ", " . line.y . ")")
                SendEvent("{Click " . line.x . ", " . line.y . "}")
                Sleep(1000)

                if TryBuy(phrase) {
                    foundFruits[phrase] := true
                    Sleep(1000)
                } else {
                    AppendTask(phrase . " has no stock!")
                    Sleep(1000)
                }
                break
            }
        }
    }
}

TryBuy(phrase) {
    if ImageSearch(&FoundX, &FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, BuyImage) {
        AppendTask("Buying " . phrase . "...")
        SendEvent("{Click " . FoundX . ", " . FoundY . "}")
        Sleep(500)

        MouseGetPos &MouseX, &MouseY
        Loop {
            Pixel := PixelGetColor(MouseX, MouseY)
            if (Pixel == BuyButtonPixel1) {
                Send "{Click}"
                Sleep(200)
            } else {
                break
            }
        }
        Sleep(1000)
        return true
    }
    return false
}

PostReconnectOperations() {
    global DeepLinkRun

    DeepLinkRun := true
    CheckRobloxWindow()
}

UpdateTimerDisplay() {
    global MacroRunning, StartTime, ElapsedTime

    if MacroRunning {
        seconds := Round((A_TickCount - StartTime) / 1000)
        MyGui["StatusText"].Value := "Status: Running (" seconds "s)"
    }
}