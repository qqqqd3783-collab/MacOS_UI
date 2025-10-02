# MacUI Library - Example Usage

นี่คือตัวอย่างการใช้งาน **MacUI Library** สำหรับ Roblox โดยมีฟีเจอร์ครบครัน เช่น Tabs, Sections, Buttons, Sliders, Toggles, Dropdowns, Inputs, ColorPicker, Keybinds และ Configuration Saving

---

## การใช้งานเบื้องต้น

```lua
-- โหลด MacUI Library
local MacUI = loadstring(game:HttpGet("your_raw_script_url"))()

-- สร้าง Window พร้อมการตั้งค่าครบครัน
local Window = MacUI:Window({
    Title = "MacUI Hub",
    Name = "MyHub",
    Size = UDim2.new(0, 600, 0, 400),
    Icon = 4483362458, -- หรือ 0 ไม่แสดง icon
    LoadingTitle = "MacUI Hub",
    LoadingSubtitle = "Loading...",
    Theme = "Default", -- Default, Dark, Ocean
    ToggleUIKeybind = "K",
    ShowText = "MacUI",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "MyHub_Config"
    },
    Discord = {
        Enabled = false,
        Invite = "your_invite_code",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter your key",
        Note = "Get key from our website: example.com",
        FileName = "MyHub_Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Hello", "MyKey123"}
    }
})
