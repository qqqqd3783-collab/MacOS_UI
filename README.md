# 🌟 MacUI Library

MacUI เป็น **Roblox UI Library** ที่ออกแบบสไตล์ MacOS ใช้งานง่าย ครบฟังก์ชัน 🎨  

---

## 🔹 Load Library
```lua
local MacUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/qqqqd3783-collab/Tadui/refs/heads/main/MacUI_Fixed_Final.lua"))()

---

## Window
```lua
local Window = MacUI:Window({
    Title = "MacUI Hub",
    Name = "MyHub",
    Size = UDim2.new(0, 600, 0, 400),
    Icon = 4483362458,
    LoadingTitle = "MacUI Hub",
    LoadingSubtitle = "Loading...",
    Theme = "Default",
    ToggleUIKeybind = "K",
    ShowText = "MacUI",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "MyHub_Config"
    },
    KeySystem = false,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter your key",
        Note = "Get key from our website",
        FileName = "MyHub_Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Hello", "MyKey123"}
    }
})

---

