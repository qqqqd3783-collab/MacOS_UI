# 🎨 MacUI Library - Complete Guide

MacUI เป็นไลบรารี UI สำหรับ Roblox ที่ได้รับแรงบันดาลใจจาก macOS และ WindUI พร้อมฟีเจอร์ครบครันและการจัดการ Error อัจฉริยะ

## ✨ คุณสมบัติเด่น

- 🎯 **Error Handling อัจฉริยะ** - แจ้งเตือนเฉพาะ Error จากโค้ดของผู้ใช้
- 🎨 **3 Theme สวยงาม** - Default, Dark, Ocean
- 💾 **บันทึกค่าอัตโนมัติ** - Configuration Saving
- 🔑 **Key System** - ระบบ Key ในตัว
- 📱 **รองรับ Mobile** - Touch-friendly
- 🎭 **Loading Screen** - หน้าจอ Loading สวยงาม

---

## 🚀 การติดตั้ง

```lua
local MacUI = loadstring(game:HttpGet("YOUR_SCRIPT_URL"))()
```

---

## 📖 การใช้งานพื้นฐาน

### สร้าง Window

```lua
local Window = MacUI:Window({
    Title = "MacUI Demo",
    Size = UDim2.new(0, 600, 0, 400),
    Theme = "Default", -- "Default", "Dark", "Ocean"
    Icon = 0, -- Asset ID หรือ URL
    
    -- Loading Screen (ไม่บังคับ)
    LoadingTitle = "MacUI",
    LoadingSubtitle = "Loading...",
    
    -- Toggle UI Keybind (ไม่บังคับ)
    ToggleUIKeybind = "RightControl",
    
    -- Mobile Show Button (ไม่บังคับ)
    ShowText = "Menu",
    
    -- Notification Position (ไม่บังคับ)
    NotifyFromBottom = false,
    
    -- Configuration Saving (ไม่บังคับ)
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyConfig"
    }
})
```

### สร้าง Tab

```lua
-- Tab แบบไม่มีไอคอน
local MainTab = Window:Tab("Main")

-- Tab แบบมีไอคอน
local SettingsTab = Window:Tab("Settings", "rbxassetid://123456789")
```

---

## 🎯 Elements ทั้งหมด

### 1. Button (ปุ่ม)

```lua
local Button = MainTab:Button({
    Title = "Click Me",
    Desc = "This is a button", -- ไม่บังคับ
    Locked = false, -- ไม่บังคับ
    Callback = function()
        print("Button clicked!")
    end
})

-- ฟังก์ชันเพิ่มเติม
Button:SetTitle("New Title")
Button:SetDesc("New Description")
Button:SetCallback(function() print("New action!") end)
Button:Lock() -- ล็อคปุ่ม
Button:Unlock() -- ปลดล็อค
Button:Destroy() -- ลบปุ่ม
```

### 2. Toggle (สวิตช์)

```lua
local Toggle = MainTab:Toggle({
    Title = "Auto Farm",
    Default = false,
    Flag = "AutoFarm", -- สำหรับบันทึกค่า
    Callback = function(value)
        print("Toggle:", value)
    end
})
```

### 3. Input (ช่องกรอกข้อความ)

```lua
local Input = MainTab:Input({
    Placeholder = "Enter text...",
    Default = "",
    Flag = "UserInput",
    Callback = function(text)
        print("Input:", text)
    end
})
```

### 4. TextArea (ช่องข้อความหลายบรรทัด)

```lua
local TextArea = MainTab:TextArea({
    Placeholder = "Enter long text...",
    Default = "",
    Callback = function(text)
        print("TextArea:", text)
    end
})
```

### 5. Slider (แถบเลื่อน)

```lua
local Slider = MainTab:Slider({
    Title = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Flag = "Speed",
    Callback = function(value)
        print("Slider:", value)
    end
})
```

### 6. Dropdown (รายการเลือก)

```lua
-- แบบเลือกอันเดียว
local Dropdown = MainTab:Dropdown({
    Title = "Select Weapon",
    Options = {"Sword", "Gun", "Bow"},
    Default = "Sword",
    Flag = "Weapon",
    Callback = function(selected)
        print("Selected:", selected)
    end
})

-- แบบเลือกได้หลายอัน
local MultiDropdown = MainTab:Dropdown({
    Title = "Select Items",
    Options = {"Item1", "Item2", "Item3"},
    Multi = true,
    Default = {},
    Callback = function(selected)
        print("Selected items:", table.concat(selected, ", "))
    end
})
```

### 7. Keybind (ปุ่มลัด)

```lua
local Keybind = MainTab:Keybind({
    Title = "Toggle GUI",
    Default = "Q",
    Flag = "ToggleKey",
    Callback = function(key)
        print("Keybind set to:", key)
    end
})
```

### 8. ColorPicker (เลือกสี)

```lua
local ColorPicker = MainTab:ColorPicker({
    Title = "ESP Color",
    Default = Color3.fromRGB(255, 0, 0),
    Flag = "ESPColor",
    Callback = function(color)
        print("Color:", color)
    end
})
```

### 9. Code (แสดงโค้ด)

```lua
local Code = MainTab:Code({
    Title = "Example Code",
    Code = [[
print("Hello World!")
local x = 10
for i = 1, x do
    print(i)
end
    ]]
})

-- ฟังก์ชันเพิ่มเติม
Code:SetCode([[print("New code!")]])
Code:OnCopy(function()
    print("Code copied!")
end)
Code:Destroy()
```

### 10. Section (หัวข้อแบ่งส่วน)

```lua
MainTab:Section("Combat Settings")
```

### 11. Paragraph (ข้อความอธิบาย)

```lua
MainTab:Paragraph({
    Text = "This is a description text that provides information to users."
})
```

---

## 🔔 Notification System

```lua
-- แจ้งเตือนพื้นฐาน
MacUI:Notify({
    Title = "Success",
    Content = "Action completed successfully!",
    Duration = 4
})

-- แจ้งเตือนพร้อมควบคุม
local Notif = MacUI:Notify({
    Title = "Loading",
    Content = "Please wait...",
    Duration = 10
})

-- เปลี่ยนข้อความ
task.wait(2)
Notif:SetTitle("Complete")
Notif:SetContent("Task finished!")

-- ปิดทันที
Notif:Close()
```

---

## 🔑 Key System

```lua
local Window = MacUI:Window({
    Title = "My Script",
    KeySystem = true,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter your key to continue",
        Note = "Get key from our Discord!",
        Key = {"MyKey123", "TestKey456"}, -- สามารถมีหลาย Key
        KeyLink = "https://discord.gg/yourserver",
        SaveKey = true,
        FileName = "MyScriptKey"
    }
})
```

---

## 💾 Configuration Saving

```lua
-- เปิดใช้งาน Config Saving
local Window = MacUI:Window({
    Title = "My Script",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyConfig"
    }
})

-- ใช้ Flag ในแต่ละ Element
MainTab:Toggle({
    Title = "Auto Farm",
    Flag = "AutoFarm", -- ระบบจะบันทึกค่าอัตโนมัติ
    Callback = function(value)
        -- Your code
    end
})
```

---

## 🎨 Themes (ธีม)

### Default Theme (สีสว่าง)
```lua
Theme = "Default"
```

### Dark Theme (สีเข้ม)
```lua
Theme = "Dark"
```

### Ocean Theme (สีน้ำเงิน)
```lua
Theme = "Ocean"
```

---

## 📱 Mobile Support

```lua
local Window = MacUI:Window({
    Title = "Mobile Friendly",
    ShowText = "Menu", -- แสดงปุ่มเปิด Menu บนมือถือ
    ToggleUIKeybind = "RightControl" -- PC Keybind
})
```

---

## 🎯 ตัวอย่างสคริปต์เต็มรูปแบบ

```lua
-- โหลด Library
local MacUI = loadstring(game:HttpGet("YOUR_URL"))()

-- สร้าง Window
local Window = MacUI:Window({
    Title = "My Amazing Script",
    Size = UDim2.new(0, 600, 0, 400),
    Theme = "Dark",
    LoadingTitle = "Loading Script",
    LoadingSubtitle = "Please wait...",
    ToggleUIKeybind = "RightControl",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyScriptConfig"
    }
})

-- สร้าง Tabs
local MainTab = Window:Tab("Main", "rbxassetid://7733779610")
local CombatTab = Window:Tab("Combat", "rbxassetid://7733764327")
local SettingsTab = Window:Tab("Settings", "rbxassetid://7733799682")

-- Main Tab
MainTab:Section("Farming")

local AutoFarm = MainTab:Toggle({
    Title = "Auto Farm",
    Default = false,
    Flag = "AutoFarm",
    Callback = function(value)
        _G.AutoFarm = value
        while _G.AutoFarm do
            task.wait(1)
            -- ใส่โค้ด Auto Farm ตรงนี้
        end
    end
})

local FarmSpeed = MainTab:Slider({
    Title = "Farm Speed",
    Min = 1,
    Max = 10,
    Default = 5,
    Flag = "FarmSpeed",
    Callback = function(value)
        _G.FarmSpeed = value
    end
})

-- Combat Tab
CombatTab:Section("Combat Settings")

local KillAura = CombatTab:Toggle({
    Title = "Kill Aura",
    Default = false,
    Flag = "KillAura",
    Callback = function(value)
        print("Kill Aura:", value)
    end
})

local AttackRange = CombatTab:Slider({
    Title = "Attack Range",
    Min = 5,
    Max = 50,
    Default = 20,
    Flag = "AttackRange",
    Callback = function(value)
        print("Range:", value)
    end
})

-- Settings Tab
SettingsTab:Section("UI Settings")

local UIKeybind = SettingsTab:Keybind({
    Title = "Toggle UI",
    Default = "RightControl",
    Flag = "UIKeybind",
    Callback = function(key)
        print("UI Keybind:", key)
    end
})

local ThemeDropdown = SettingsTab:Dropdown({
    Title = "Select Theme",
    Options = {"Default", "Dark", "Ocean"},
    Default = "Dark",
    Callback = function(theme)
        MacUI:Notify({
            Title = "Theme Changed",
            Content = "Please restart script for changes",
            Duration = 3
        })
    end
})

-- แสดง Credits
SettingsTab:Section("Credits")
SettingsTab:Paragraph({
    Text = "Created by YourName\nThanks for using this script!"
})

-- Code Example
local CodeExample = SettingsTab:Code({
    Title = "Update Script",
    Code = [[loadstring(game:HttpGet("YOUR_URL"))()]]
})

CodeExample:OnCopy(function()
    MacUI:Notify({
        Title = "Copied!",
        Content = "Update link copied to clipboard",
        Duration = 2
    })
end)

-- แจ้งเตือนเมื่อโหลดเสร็จ
MacUI:Notify({
    Title = "Script Loaded",
    Content = "All features ready to use!",
    Duration = 5
})
```

---

## ⚡ Error Handling

MacUI มีระบบจัดการ Error อัจฉริยะที่จะแจ้งเตือนเฉพาะ Error ที่เกิดจากโค้ดของผู้ใช้:

```lua
MainTab:Button({
    Title = "Test Error",
    Callback = function()
        -- Error นี้จะแสดง Notification อัตโนมัติ
        Local = Test -- ตัว L เป็นตัวใหญ่ จะเกิด error
    end
})
```

---

## 🎯 Tips & Tricks

1. **ใช้ Flag** เพื่อบันทึกค่า Config อัตโนมัติ
2. **ใช้ Section** เพื่อแบ่งหมวดหมู่ให้เป็นระเบียบ
3. **ใช้ Paragraph** เพื่ออธิบายฟีเจอร์ก่อนใช้งาน
4. **ใช้ Code** เพื่อแสดงลิงก์อัพเดทหรือโค้ดตัวอย่าง
5. **ทดสอบบน Mobile** เพื่อให้แน่ใจว่าใช้งานได้ทุกแพลตฟอร์ม

---

## 📝 License

Free to use for personal and commercial projects.

---

## 💬 Support

หากมีปัญหาหรือต้องการความช่วยเหลือ:
- Discord: Your Discord Server
- Github: Your Github Repository

---

**Made with ❤️ by MacUI Team**
