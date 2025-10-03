# 🎨 MacUI Library - Complete Documentation

MacUI เป็นไลบรารี UI สำหรับ Roblox ที่ได้รับแรงบันดาลใจจาก macOS และ WindUI พร้อมฟีเจอร์ครบครันและการจัดการ Error อัจฉริยะ

## ✨ คุณสมบัติเด่น

- 🎯 **Error Handling อัจฉริยะ** - แจ้งเตือนเฉพาะ Error จากโค้ดของผู้ใช้
- 🎨 **3 Theme สวยงาม** - Default, Dark, Ocean พร้อมสีและขอบที่ชัดเจน
- 💾 **บันทึกค่าอัตโนมัติ** - Configuration Saving
- 🔑 **Key System** - ระบบ Key ในตัว
- 📱 **รองรับ Mobile** - Touch-friendly
- 🎭 **Loading Screen** - หน้าจอ Loading สวยงาม
- 🎪 **13+ UI Elements** - ครบครันทุกฟีเจอร์

---

## 🚀 การติดตั้ง

```lua
local MacUI = loadstring(game:HttpGet("YOUR_SCRIPT_URL"))()
```

---

## 📖 สร้าง Window (พร้อม Config ทั้งหมด)

```lua
local Window = MacUI:Window({
    -- ✅ พื้นฐาน
    Title = "MacUI Demo",
    Size = UDim2.new(0, 600, 0, 400),
    Theme = "Default", -- "Default", "Dark", "Ocean"
    Icon = 0, -- Asset ID หรือ URL (ไม่บังคับ)
    
    -- ✅ Loading Screen
    LoadingTitle = "MacUI",
    LoadingSubtitle = "Loading...",
    
    -- ✅ UI Toggle
    ToggleUIKeybind = "RightControl", -- Keybind สำหรับเปิด/ปิด UI (PC)
    ShowText = "Menu", -- แสดงปุ่มเปิด Menu บนมือถือ (ไม่บังคับ)
    
    -- ✅ Notification Settings
    NotifyFromBottom = false, -- true = Notify จากล่างขึ้นบน
    
    -- ✅ Configuration Saving
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyConfig"
    },
    
    -- ✅ Key System (รวมอยู่ใน Window Config)
    KeySystem = true, -- เปิด/ปิด Key System
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter your key to continue",
        Note = "Get key from our Discord!",
        Key = {"MyKey123", "TestKey456"}, -- สามารถมีหลาย Key
        KeyLink = "https://discord.gg/yourserver", -- ลิงก์รับ Key
        SaveKey = true, -- บันทึก Key อัตโนมัติ
        FileName = "MyScriptKey" -- ชื่อไฟล์บันทึก Key
    },
    
    -- ✅ Discord Integration (ไม่บังคับ)
    Discord = {
        Enabled = true,
        Invite = "yourinvitecode",
        RememberJoins = true
    }
})
```

### ตัวอย่างแบบง่าย

```lua
-- แบบง่ายที่สุด
local Window = MacUI:Window({
    Title = "My Script",
    Theme = "Dark"
})

-- แบบมี Config Saving
local Window = MacUI:Window({
    Title = "My Script",
    Theme = "Dark",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyConfig"
    }
})

-- แบบมี Key System
local Window = MacUI:Window({
    Title = "My Script",
    Theme = "Dark",
    KeySystem = true,
    KeySettings = {
        Title = "Enter Key",
        Key = {"TestKey123"},
        SaveKey = true
    }
})
```

---

## 📑 สร้าง Tab

```lua
-- Tab แบบไม่มีไอคอน
local MainTab = Window:Tab("Main")

-- Tab แบบมีไอคอน (แนะนำ - สวยกว่า)
local MainTab = Window:Tab("Main", "rbxassetid://7733779610")
local CombatTab = Window:Tab("Combat", "rbxassetid://7733764327")
local SettingsTab = Window:Tab("Settings", "rbxassetid://7733799682")
```

**💡 สีและขอบของ Tab:**
- Tab ที่เลือก → สีน้ำเงิน (Accent) + ข้อความสีขาว + ขอบชัดเจน
- Tab ปกติ → สีเทา + ข้อความสีเทา + ขอบจาง
- Dark Theme → ขอบสีขาวโปร่งใส สวยงาม

---

## 🎯 UI Elements ทั้งหมด (13 ชนิด)

### 1. Section (หัวข้อแบ่งส่วน)

```lua
MainTab:Section("Combat Settings")
```

### 2. Divider (เส้นแบ่ง)

```lua
MainTab:Divider()
```

### 3. Paragraph (ข้อความอธิบาย)

```lua
MainTab:Paragraph({
    Text = "This is a description text that provides information to users."
})
```

### 4. Label (ข้อความในกล่อง)

```lua
local Label = MainTab:Label({
    Text = "Current Status: Ready"
})

-- ฟังก์ชันเพิ่มเติม
Label:SetText("Status: Running")
Label:Destroy()
```

### 5. Button (ปุ่ม)

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

### 6. Toggle (สวิตช์)

```lua
local Toggle = MainTab:Toggle({
    Title = "Auto Farm",
    Default = false,
    Flag = "AutoFarm", -- สำหรับบันทึกค่า (ถ้าเปิด Config Saving)
    Callback = function(value)
        print("Toggle:", value)
    end
})
```

### 7. Input (ช่องกรอกข้อความ)

```lua
local Input = MainTab:Input({
    Placeholder = "Enter text...",
    Default = "",
    Flag = "UserInput", -- สำหรับบันทึกค่า
    Callback = function(text)
        print("Input:", text)
    end
})
```

### 8. TextArea (ช่องข้อความหลายบรรทัด)

```lua
local TextArea = MainTab:TextArea({
    Placeholder = "Enter long text...",
    Default = "",
    Callback = function(text)
        print("TextArea:", text)
    end
})
```

### 9. Slider (แถบเลื่อน)

```lua
local Slider = MainTab:Slider({
    Title = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Flag = "Speed", -- สำหรับบันทึกค่า
    Callback = function(value)
        print("Slider:", value)
    end
})
```

### 10. Dropdown (รายการเลือก)

```lua
-- แบบเลือกอันเดียว
local Dropdown = MainTab:Dropdown({
    Title = "Select Weapon",
    Options = {"Sword", "Gun", "Bow"},
    Default = "Sword",
    Flag = "Weapon", -- สำหรับบันทึกค่า
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

### 11. Keybind (ปุ่มลัด)

```lua
local Keybind = MainTab:Keybind({
    Title = "Toggle GUI",
    Default = "Q",
    Flag = "ToggleKey", -- สำหรับบันทึกค่า
    Callback = function(key)
        print("Keybind set to:", key)
    end
})
```

### 12. ColorPicker (เลือกสี)

```lua
local ColorPicker = MainTab:ColorPicker({
    Title = "ESP Color",
    Default = Color3.fromRGB(255, 0, 0),
    Flag = "ESPColor", -- สำหรับบันทึกค่า
    Callback = function(color)
        print("Color:", color)
    end
})
```

### 13. Code (แสดงโค้ด)

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

### 14. Image (แสดงรูปภาพ) 🆕

```lua
local Image = MainTab:Image({
    Image = "rbxassetid://123456789", -- หรือ URL
    Height = 150, -- ไม่บังคับ (default: 150)
    ScaleType = Enum.ScaleType.Fit -- ไม่บังคับ
})

-- ฟังก์ชันเพิ่มเติม
Image:SetImage("rbxassetid://987654321")
Image:Destroy()
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

MainTab:Slider({
    Title = "Speed",
    Min = 1,
    Max = 10,
    Flag = "Speed", -- บันทึกค่า Slider
    Callback = function(value)
        -- Your code
    end
})
```

**การทำงาน:**
- ค่าที่มี `Flag` จะถูกบันทึกอัตโนมัติ
- เมื่อเปิดสคริปต์ครั้งถัดไป ค่าจะโหลดกลับมาอัตโนมัติ
- ไฟล์บันทึกอยู่ที่ `workspace/` + ชื่อไฟล์ที่กำหนด

---

## 🎨 Themes (ธีม)

### Default Theme (สีสว่าง)
- พื้นหลังสีขาว
- Tab Active: สีน้ำเงิน + ขอบ
- Tab Inactive: สีเทา

### Dark Theme (สีเข้ม)
- พื้นหลังสีดำ
- Tab Active: สีน้ำเงิน + **ขอบสีขาว**
- Tab Inactive: สีเทาเข้ม

### Ocean Theme (สีน้ำเงิน)
- พื้นหลังสีฟ้าอ่อน
- Tab Active: สีฟ้าสด + ขอบ
- Tab Inactive: สีฟ้าอ่อน

```lua
-- เปลี่ยน Theme
local Window = MacUI:Window({
    Title = "My Script",
    Theme = "Dark" -- "Default", "Dark", "Ocean"
})
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

-- สร้าง Window พร้อม Config ครบ
local Window = MacUI:Window({
    Title = "My Amazing Script",
    Size = UDim2.new(0, 600, 0, 400),
    Theme = "Dark",
    LoadingTitle = "Loading Script",
    LoadingSubtitle = "Please wait...",
    ToggleUIKeybind = "RightControl",
    ShowText = "Menu",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyScriptConfig"
    },
    KeySystem = true,
    KeySettings = {
        Title = "Enter Key",
        Subtitle = "Join Discord for key",
        Key = {"TestKey123", "Premium456"},
        KeyLink = "https://discord.gg/yourserver",
        SaveKey = true
    }
})

-- สร้าง Tabs
local MainTab = Window:Tab("Main", "rbxassetid://7733779610")
local CombatTab = Window:Tab("Combat", "rbxassetid://7733764327")
local MiscTab = Window:Tab("Misc", "rbxassetid://7733920644")
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

MainTab:Divider()

MainTab:Button({
    Title = "Teleport to Farm",
    Desc = "TP to farming location",
    Callback = function()
        print("Teleporting...")
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

local WeaponSelect = CombatTab:Dropdown({
    Title = "Select Weapon",
    Options = {"Sword", "Gun", "Bow", "Magic"},
    Default = "Sword",
    Flag = "Weapon",
    Callback = function(weapon)
        print("Weapon:", weapon)
    end
})

-- Misc Tab
MiscTab:Section("ESP Settings")

local ESPColor = MiscTab:ColorPicker({
    Title = "ESP Color",
    Default = Color3.fromRGB(255, 0, 0),
    Flag = "ESPColor",
    Callback = function(color)
        print("ESP Color changed")
    end
})

MiscTab:Divider()

local StatusLabel = MiscTab:Label({
    Text = "Status: Ready"
})

task.spawn(function()
    while task.wait(5) do
        StatusLabel:SetText("Status: Running - " .. os.date("%X"))
    end
end)

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

SettingsTab:Divider()

SettingsTab:Paragraph({
    Text = "Tips: You can use RightControl to toggle UI on PC, or tap the Menu button on mobile."
})

SettingsTab:Section("About")

SettingsTab:Image({
    Image = "rbxassetid://7733799682",
    Height = 100
})

SettingsTab:Paragraph({
    Text = "Script Version: 1.0.0\nCreated by: YourName\nThanks for using!"
})

local UpdateCode = SettingsTab:Code({
    Title = "Update Script",
    Code = [[loadstring(game:HttpGet("YOUR_URL"))()]]
})

UpdateCode:OnCopy(function()
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

## 🎯 Tips & Best Practices

1. **ใช้ Flag** เพื่อบันทึกค่า Config อัตโนมัติ
2. **ใช้ Section** เพื่อแบ่งหมวดหมู่ให้เป็นระเบียบ
3. **ใช้ Divider** เพื่อแยกส่วนที่ไม่เกี่ยวข้องกัน
4. **ใช้ Paragraph** เพื่ออธิบายฟีเจอร์ก่อนใช้งาน
5. **ใช้ Label** สำหรับแสดงข้อมูล Real-time
6. **ใช้ Code** เพื่อแสดงลิงก์อัพเดทหรือโค้ดตัวอย่าง
7. **ใช้ Image** เพื่อเพิ่มความสวยงามหรือแสดง Logo
8. **ทดสอบบน Mobile** เพื่อให้แน่ใจว่าใช้งานได้ทุกแพลตฟอร์ม
9. **Dark Theme มีขอบสีขาว** - เลือก Dark Theme สำหรับความสวยงาม
10. **Tab มีไอคอน** - แสดงไอคอนทำให้ดูโปรฟังก์ชั่นมากขึ้น

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
