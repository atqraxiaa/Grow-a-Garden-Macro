# 🌱 Grow a Garden Macro

An AutoHotkey v2 macro designed to automate seed buying and farming tasks in Roblox's "Grow a Garden" game.

---

## Features

- Automatically opens Roblox via a private server deeplink or detects an existing Roblox window.
- Uses OCR to scan for selected seeds/fruits in the Roblox GUI.
- Clicks to buy seeds if available, with retry and reconnect logic.
- Customizable seed selection and settings.
- Status updates and task queue display within the GUI.
- Supports compiled and uncompiled script modes.
- Adjustable delay and retry intervals through config.ini.
- Monitor resolution and scale check to ensure compatibility.

---

## Requirements

- Windows PC with **1920 x 1080** resolution.
- Monitor scale set to **100%** (DPI 96).
- Roblox installed and logged in.
- AutoHotkey v2.0 installed (not needed if running with compiled exe).

---

## Installation

1. Clone or download this repository.
2. Place the `Lib` and `Assets` folders in the same directory as the script.
3. Adjust your settings in `config.ini` as needed.
4. Run the script `Grow a Garden Macro.ahk` with AutoHotkey v2.

If using the compiled version, required libraries and assets are automatically included.

---

## Usage

- Launch the script.
- Go to the **Config** tab to select which seeds/fruits to buy.
- Use the **Other** tab to configure Roblox auto-open and deeplink options.
- Click **Run Macro** to start the automation.
- Use **F5** to pause and **F6** to exit the script.
- Watch status updates and task queue in the **Status** tab.

---

## Configuration

- `config.ini` contains settings such as:
  - `AutoOpenRoblox`: Whether to launch Roblox automatically.
  - `DeepLink`: Your private server deeplink URL.
  - `DelayMultiplier`: Adjusts wait times for delays.
  - `ReconnectionDelay`: Time in seconds to wait before reconnect attempts.
  - Seed selection under the `FruitsChosen` section.

---

## Known Limitations

- Script only works with **1920x1080** resolution and 100% DPI scaling.
- Mouse movement during execution can disrupt automation.
- Requires Roblox window to be active and unobstructed.
- OCR accuracy depends on the game’s UI clarity.

---

## Troubleshooting

- Ensure Roblox is running and logged in.
- Avoid moving your mouse while the macro is running.
- Disable Shift Lock in your Roblox window.
- Check that all required files in `Lib` and `Assets` are present.
- Use the **Help** tab in the GUI for guidance and links.
- For issues, visit the GitHub repository or contact the author.

---

## Links

- [Discord](https://discord.com/users/607083298996486183)
- [GitHub Repository](https://github.com/atqraxiaa/Grow-a-Garden-Macro/)
- [YouTube Channel](https://www.youtube.com/channel/UCWlccRC2Zs0iC8YtvHlWnPA)

---

## License

This project is made with ❤️ by @fleurcestt on Discord.  
Feel free to use and modify for personal use. Redistribution or commercial use without permission is prohibited.

---

## Acknowledgments

- Uses AutoHotkey v2 for automation.
- OCR library integrated for text recognition.
- Inspired by Roblox Grow a Garden community needs.

---

If you enjoy this macro, please consider starring the repo ⭐ and sharing with fellow Roblox growers!

