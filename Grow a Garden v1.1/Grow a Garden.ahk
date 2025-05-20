#Requires AutoHotkey v2.0
#SingleInstance

if A_IsCompiled {
    FileInstall "Lib\OCR.ahk", A_Temp "\OCR.ahk", true
    FileInstall "Lib\JSON.ahk", A_Temp "\JSON.ahk", true
    FileInstall "Lib\config.ini", A_Temp "\config.ini", true
    FileInstall "Assets\buy.png", A_Temp "\buy.png", true
    FileInstall "Assets\ps to deeplink.png", A_Temp "\ps.png", true
    FileInstall "Assets\ps to deeplink.txt", A_Temp "\ps.txt", true
    FileInstall "Assets\welcome.png", A_Temp "\welcome.png", true

    global OCRPath := A_Temp "\OCR.ahk"
    global JSONPath := A_Temp "\JSON.ahk"
    global Config := A_Temp "\config.ini"
    global BuyImage := A_Temp "\buy.png"
    global PsImage := A_Temp "\ps.png"
    global WelcomeImage := A_Temp "\welcome.png"
} else {
    global OCRPath := A_ScriptDir "\Lib\OCR.ahk"
    global JSONPath := A_ScriptDir "\Lib\JSON.ahk"
    global Config := A_ScriptDir "\Lib\config.ini"
    global BuyImage := A_ScriptDir "\Assets\buy.png"
    global PsImage := A_ScriptDir "\Assets\ps to deeplink.png"
    global WelcomeImage := A_ScriptDir "\Assets\welcome.png"
}

#Include Lib\OCR.ahk
#Include Lib\JSON.ahk

$F5::Pause -1
$F6::ExitApp

global MacroRunning := false
global StartTime := 0
global ElapsedTime := 0
global TimerInterval := 1000
global RetryMinutes := 5
global NextRun := 0
global DeepLinkRun := false
global RetryCount := 0
global SelectedFruitsArray := []

AutoOpenRoblox           := (IniRead(Config, "UserConfig", "AutoOpenRoblox", "false") = "true") ? 1 : 0
DeepLink                 := IniRead(Config, "UserConfig", "DeepLink")
DelayMultiplier          := IniRead(Config, "UserConfig", "DelayMultiplier")
ReconnectionDelay        := IniRead(Config, "UserConfig", "ReconnectionDelay")
DisconnectUIPixel        := IniRead(Config, "UserConfig", "DisconnectUIPixel")
SeedButtonPixel          := IniRead(Config, "UserConfig", "SeedButtonPixel")
BuyButtonPixel1          := IniRead(Config, "UserConfig", "BuyButtonPixel1")
MaxAttemptsDeeplink      := IniRead(Config, "UserConfig", "MaxAttemptsDeeplink")
WebHookUrl               := IniRead(Config, "UserConfig", "WebHookUrl")

FruitKeys := ["Carrot", "Strawberry", "Blueberry", "Tulip", "Tomato",
             "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple",
             "Bamboo", "Coconut", "Cactus", "Dragon", "Mango",
             "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk"]

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
MyGui.SetFont("s11")
MyGui.Add("Text", "cgreen x125 y35", "🌱 Grow a Garden Macro 🌱")
MyGui.SetFont("s10")
MyGui.Add("Text", "x175 y60 ", "Welcome!")
MyGui.SetFont("s9")
MyGui.Add("Text", "x100 y80", "Before running, please go to the 'Help' tab first.")
MyGui.Add("Picture", "x20 y100 w375 h200", WelcomeImage)
MyGui.Add("Button", "x20 y310 w375", "Run Macro").OnEvent("Click", MainMacro)

Tabs.UseTab(2)
MyGui.SetFont("s11")
MyGui.Add("Text", "x20 y35", "Recent Updates:")
MyGui.Add("Text", "x20 y60", "version 1.0 (5/18/25)").SetFont("s9 bold")
MyGui.Add("Text", "x20 y75", "Added a macro to buy seeds").SetFont("s9")
MyGui.Add("Text", "x20 y95", "version 1.1 (5/20/25)").SetFont("s9 bold")
MyGui.Add("Text", "x20 y110", "Added webhook integration to log messages to Discord").SetFont("s9")
MyGui.Add("Text", "x20 y125", "Added comments and improved clarity in config.ini").SetFont("s9")
MyGui.Add("Text", "x20 y140", "Deeplink runs are now limited based on the user").SetFont("s9")
MyGui.SetFont("s9")
MyGui.Add("Text", "x20 y175", "More updates will be released soon, so stay tuned!")

Tabs.UseTab(3)
StatusText := MyGui.Add("Text", "x20 y35 w200 vStatusText", "Status: Stopped")
MyGui.Add("Text", "x20 y55", "Seeds selected to be bought:")
chosenFruitsText := (SelectedFruitsArray.Length > 0) ? StrJoin(", ", SelectedFruitsArray*) : "None"
SendDiscordMessage("Seeds selected to be bought: " . chosenFruitsText)
global chosenFruitsTextControl := MyGui.Add("Text", "x20 y70 w375 +Wrap", chosenFruitsText)
MyGui.Add("Text", "x20 y130", "Task Queue")
MyGui.Add("Edit", "vTaskQueue r12 x20 y150 w375 ReadOnly")

Tabs.UseTab(4)
MyGui.Add("Text", "x20 y35", "Before running this macro, please read this first.")
MyGui.Add("Text", "x20 y55", "Your monitor's resolution should be 1920x1080.")
MyGui.Add("Text", "x20 y70", "Your monitor's scale should be 100%.")
MyGui.Add("Text", "x20 y85", "Avoid moving your mouse while the macro is running.")
MyGui.Add("Text", "x20 y100", "Please disable Shift Lock in your Roblox window.")
MyGui.Add("Text", "x20 y115", "Do not open the 'Status' tab while the macro is running.")
MyGui.Add("Text", "x20 y130", "Use F5 to pause and F6 to stop the macro.")
MyGui.Add("Text", "x20 y145", "To adjust other configurations, edit the config.ini file in this folder.")
MyGui.Add("Button", "x20 y165 w375", "Open config.ini File").OnEvent("Click", OpenConfig)
MyGui.Add("Text", "x20 y200", "Additional settings are available on the 'Other' tab.")
MyGui.Add("Text", "x20 y220", "If you encounter any issues with the macro, please check the links `nbelow or contact the owner via these buttons.")
MyGui.Add("Button", "x20 y260 w375", "Discord").OnEvent("Click", OpenDiscord)
MyGui.Add("Button", "x20 y290 w375", "Github").OnEvent("Click", OpenGithub)

OpenConfig(*) {
    global Config
    Run Config
}

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
MyGui.Add("Text", "x20 y55 w350", "If this option is checked, the macro will automatically open Roblox via deeplink.")
MyGui.Add("Text", "x20 y90 w350", "Otherwise, if it's not checked, the macro will check for an existing Roblox window.")
MyGui.Add("Text", "x20 y125", "Your Private Server Deeplink")
DeepLinkControl := MyGui.Add("Edit", "vDeepLink x17.5 y+7.5 w375 -VScroll" , DeepLink)
MyGui.Add("Text", "x20 y195", "If you don't have private server, just leave it blank.")
MyGui.Add("Text", "x20 y215 w350",
    "Click the button below if you don't know how to`nconvert a private server link to a deeplink.")
MyGui.Add("Button", "x17.5 y255 w185", "Private Server to Deeplink").OnEvent("Click", OpenPsToDeeplink)
MyGui.Add("Button", "x210 y255 w185", "Save Settings").OnEvent("Click", SaveSettings)
MyGui.Add("Text", "x20 y305", "Made with love by @vaixnae on Discord.")
MyGui.Add("Text", "x20 y320", "Last updated May 20, 2025 (version 1.1)")

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

CheckWindowSizeAndSendF11() {
    WinActivate()
    WinGetPos &X, &Y, &RobloxWidth, &RobloxHeight
    AppendTask("Checking Roblox Window...")
    SendDiscordMessage("Checking Roblox Window...")
    if (RobloxWidth != A_ScreenWidth and RobloxHeight != A_ScreenHeight) {
        Send "{F11}"
        Sleep (1000)
    } else {
        return
    }
}

CheckRobloxWindow() {
    global DelayMultiplier, AutoOpenRoblox, DeepLink, ReconnectionDelay, DeepLinkRun, MaxAttemptsDeeplink

    AutoOpenRoblox := ConvertToBooleanString(AutoOpenRoblox)
    if (AutoOpenRoblox == "true") {
        if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
            AppendTask("Roblox is present, running the main macro...")
            SendDiscordMessage("Roblox is present, running the main macro...")
            CheckWindowSizeAndSendF11()
            Send "{Click}"
            Sleep (1000 * DelayMultiplier)
            StartMouseMove()
        } else if !(WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox")) {
            AppendTask("Attempting to run Roblox via deeplink...")
            SendDiscordMessage("Attempting to run Roblox via deeplink...")
            if (DeepLink == "") {
                DeepLink := "roblox://placeID=126884695634066"
            }
            run (DeepLink)
            DeepLinkRun := true
            Sleep (ReconnectionDelay * 1000)
            if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
            AppendTask("Roblox is present, running the main macro...")
            SendDiscordMessage("Roblox is present, running the main macro...")
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
            SendDiscordMessage("Roblox is present, running the main macro...")
            CheckWindowSizeAndSendF11()
            Send "{Click}"
            Sleep (1000 * DelayMultiplier)
            StartMouseMove()
        } else {
            AppendTask("Roblox is not present, exiting the macro...")
            SendDiscordMessage("Roblox is not present, exiting the macro...")
            MsgBox "Roblox is not running. Exiting script."
            ExitApp
        }
    }
}

StartMouseMove() {
    global DelayMultiplier, DeepLink, DeepLinkRun, ReconnectionDelay, SelectedFruitsArray, RetryCount

    X := CoordsMap["SeedButton"][1]
    Y := CoordsMap["SeedButton"][2]
    AppendTask("Checking for seed button pixel...")
    SendDiscordMessage("Checking for seed button pixel...")
    SendEvent "{Click, " X ", " Y ", Right}"
    MouseGetPos &MouseX, &MouseY
    Activate := PixelGetColor(MouseX, MouseY, )

    if (Activate != SeedButtonPixel) {
        if (DeepLink == "") {
            DeepLink := "roblox://placeID=126884695634066"
        }

        ResetRobloxWithRetries()
    }

    Sleep (500 * DelayMultiplier)
    SendEvent "{Click}"
    AppendTask("Checking for available seeds...")
    SendDiscordMessage("Checking for available seeds...")
    RetryCount := 0
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
    SendDiscordMessage("Waiting 5 minutes before next scan...")
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
        SendDiscordMessage("Buying " . phrase . "...")
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

ResetRobloxWithRetries() {
    global MaxAttemptsDeeplink, ReconnectionDelay, DeepLink, DelayMultiplier, DeepLinkRun, RetryCount

    if (RetryCount >= MaxAttemptsDeeplink) {
        AppendTask("Failed to restart Roblox after " MaxAttemptsDeeplink " attempts.")
        SendDiscordMessage("Failed to restart Roblox after " MaxAttemptsDeeplink " attempts.")
        MsgBox "Roblox failed to restart. Exiting script."
        ExitApp
    }

    RetryCount += 1
    AppendTask("Resetting Roblox (attempt " RetryCount "/" MaxAttemptsDeeplink ")...")
    SendDiscordMessage("Resetting Roblox (attempt " RetryCount "/" MaxAttemptsDeeplink ")...")

    if (DeepLink == "")
        DeepLink := "roblox://placeID=126884695634066"

    Run(DeepLink)
    DeepLinkRun := true
    Sleep(ReconnectionDelay * 1000)

    if WinExist("ahk_exe RobloxPlayerBeta.exe") or WinExist("ahk_title Roblox") {
        AppendTask("Roblox restarted successfully.")
        SendDiscordMessage("Roblox restarted successfully.")
        CheckWindowSizeAndSendF11()
        Send "{Click}"
        Sleep(1000 * DelayMultiplier)
        StartMouseMove()
    } else {
        ResetRobloxWithRetries()
    }
}

UpdateTimerDisplay() {
    global MacroRunning, StartTime, ElapsedTime

    if MacroRunning {
        seconds := Round((A_TickCount - StartTime) / 1000)
        MyGui["StatusText"].Value := "Status: Running (" seconds "s)"
    }
}

SendDiscordMessage(message) {
    global Config

    if !WebHookUrl
        return

    time := FormatTime(, "hh:mm:ss tt")
    formatted := time . " - " . message

    payload := JSON.stringify({content: formatted})
    Http := ComObject("WinHttp.WinHttpRequest.5.1")
    Http.Open("POST", WebHookUrl, false)
    Http.SetRequestHeader("Content-Type", "application/json")
    Http.Send(payload)
}