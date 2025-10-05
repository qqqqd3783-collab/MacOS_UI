# 🎨 MacUI Library

MacUI is a UI library inspired by macOS. If you find any bugs, please report them to Discord and we'll fix them.

## ✨ Features

- 💾 **Auto Configuration Saving**
- 🔑 **Key System** (Simple & Service-based)
- 📱 **Mobile Support**
- 🎭 **Loading Screen**
- 🔔 **Notification System**
- 🎪 **14+ UI Elements**
- 🎨 **3 Themes** (Default, Dark, Ocean)

---

## 🚀 Installation

```lua
local MacUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/qqqqd3783-collab/MacOS_UI/refs/heads/main/Main.lua"))()
```

---

## 📖 Create Window

### Full Configuration

```lua
local Window = MacUI:Window({
    Title = "MacUI Demo",
    Size = UDim2.new(0, 600, 0, 400),
    Theme = "Dark", -- "Default", "Dark", "Ocean"
    Icon = 0, -- Asset ID or URL (optional)
    
    LoadingTitle = "MacUI",
    LoadingSubtitle = "Loading...",
    
    ToggleUIKeybind = "RightControl",
    ShowText = "Menu", -- Mobile button text
    
    NotifyFromBottom = false,
    
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyConfig"
    },
    
    -- Simple Key System
    KeySystem = true,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter your key to continue",
        Note = "Get key from our Discord!",
        Key = {"MyKey123", "TestKey456"}, -- Multiple keys supported
        KeyLink = "https://discord.gg/yourserver",
        SaveKey = true,
        FileName = "MyScriptKey"
    },
    
    Discord = {
        Enabled = true,
        Invite = "yourinvitecode",
        RememberJoins = true
    }
})
```

### Simple Window

```lua
local Window = MacUI:Window({
    Title = "My Script",
    Theme = "Dark"
})
```

---

## 🔑 Key System

### Simple Key System

```lua
local Window = MacUI:Window({
    Title = "My Script",
    KeySystem = true,
    KeySettings = {
        Title = "Enter Key",
        Subtitle = "Get key from Discord",
        Key = {"Key1", "Key2", "Key3"},
        KeyLink = "https://discord.gg/yourserver",
        SaveKey = true,
        FileName = "MyKey"
    }
})
```

### Service Key System

#### Platoboost

```lua
local Window = MacUI:Window({
    KeySystem = true,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter your key to continue",
        Note = "Copy link to get your key!",
        Service = "platoboost",
        ServiceId = "your_service_id_here",
        Secret = "your_secret_key_here",
        SaveKey = true,
        FileName = "MyScriptKey"
    }
})
```

#### Panda Development

```lua
local Window = MacUI:Window({
    KeySystem = true,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter your key to continue",
        Note = "Get your key from Panda Development!",
        Service = "pandadevelopment",
        ServiceId = "your_service_name_here",  -- ชื่อ service ของคุณ
        SaveKey = true,
        FileName = "MyScriptKey"
    }
})
```

#### Luarmor

```lua
local Window = MacUI:Window({
    KeySystem = true,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Enter your key to continue",
        Note = "Join Discord to get your key!",
        Service = "luarmor",
        ScriptId = "your_script_id_here",  -- Script ID จาก Luarmor
        Discord = "discord.gg/yourserver",  -- Discord invite link
        SaveKey = true,
        FileName = "MyScriptKey"
    }
})
```

---

## 📑 Create Tab

```lua
local MainTab = Window:Tab("Main")
local MainTab = Window:Tab("Main", "rbxassetid://7733779610")
local SettingsTab = Window:Tab("Settings", 7733799682)
```

---

## 🎯 UI Elements (14 Types)

### 1. Section

```lua
MainTab:Section("Combat Settings")
```

### 2. Divider

```lua
MainTab:Divider()
```

### 3. Paragraph

```lua
MainTab:Paragraph({
    Text = "This is a description text."
})
```

### 4. Label

```lua
local Label = MainTab:Label({
    Text = "Current Status: Ready"
})

Label:SetText("Status: Running")
Label:Destroy()
```

### 5. Button

```lua
local Button = MainTab:Button({
    Title = "Click Me",
    Desc = "This is a button",
    Callback = function()
        print("Clicked!")
    end
})

Button:SetTitle("New Title")
Button:SetDesc("New Description")
Button:SetCallback(function() print("New action!") end)
Button:Lock()
Button:Unlock()
Button:Destroy()
```

### 6. Toggle

```lua
local Toggle = MainTab:Toggle({
    Title = "Auto Farm",
    Default = false,
    Flag = "AutoFarm",
    Callback = function(value)
        print("Toggle:", value)
    end
})

Toggle:Set(true)
local value = Toggle:Get()
Toggle:Destroy()
```

### 7. Input

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

### 8. TextArea

```lua
local TextArea = MainTab:TextArea({
    Placeholder = "Enter long text...",
    Default = "",
    Callback = function(text)
        print("TextArea:", text)
    end
})
```

### 9. Slider

```lua
local Slider = MainTab:Slider({
    Title = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Flag = "Speed",
    Callback = function(value)
        print("Value:", value)
    end
})

Slider:Set(75)
local value = Slider:Get()
Slider:SetMin(10)
Slider:SetMax(200)
Slider:Destroy()
```

### 10. Dropdown

```lua
-- Single Selection
local Dropdown = MainTab:Dropdown({
    Title = "Select Weapon",
    Options = {"Sword", "Gun", "Bow"},
    Default = "Sword",
    Flag = "Weapon",
    Callback = function(selected)
        print("Selected:", selected)
    end
})

-- Multiple Selection
local MultiDropdown = MainTab:Dropdown({
    Title = "Select Items",
    Options = {"Item1", "Item2", "Item3"},
    Multi = true,
    Default = {},
    Callback = function(selected)
        print("Selected:", table.concat(selected, ", "))
    end
})
```

### 11. Keybind

```lua
local Keybind = MainTab:Keybind({
    Title = "Toggle GUI",
    Default = "Q",
    Flag = "ToggleKey",
    Callback = function(key)
        print("Key:", key)
    end
})
```

### 12. ColorPicker

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

### 13. Code

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

Code:SetCode([[print("New code!")]])
Code:OnCopy(function()
    print("Code copied!")
end)
Code:Destroy()
```

### 14. Image

```lua
local Image = MainTab:Image({
    Image = "rbxassetid://123456789",
    Height = 150,
    ScaleType = Enum.ScaleType.Fit
})

Image:SetImage("rbxassetid://987654321")
Image:Destroy()
```

---

## 🔔 Notification System

```lua
MacUI:Notify({
    Title = "Success",
    Content = "Action completed!",
    Duration = 4
})

local Notif = MacUI:Notify({
    Title = "Loading",
    Content = "Please wait...",
    Duration = 10
})

task.wait(2)
Notif:SetTitle("Complete")
Notif:SetContent("Finished!")
Notif:Close()
```

---

## 💾 Configuration Saving

```lua
local Window = MacUI:Window({
    Title = "My Script",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyConfig"
    }
})

-- Auto-saved with Flag
MainTab:Toggle({
    Title = "Auto Farm",
    Flag = "AutoFarm",
    Callback = function(value)
        -- Your code
    end
})

MainTab:Slider({
    Title = "Speed",
    Min = 1,
    Max = 10,
    Flag = "Speed",
    Callback = function(value)
        -- Your code
    end
})
```

**How it works:**
- Elements with `Flag` are saved automatically
- Configuration loads on next script execution
- File saved in `workspace/` + FileName

---

## 🎨 Themes

### Available Themes

- **Default** - Light theme
- **Dark** - Dark theme
- **Ocean** - Blue theme

```lua
local Window = MacUI:Window({
    Title = "My Script",
    Theme = "Dark"
})

-- Change theme dynamically
Window:SetTheme("Ocean")
```

---

## 🪟 Window API Methods

```lua
local Window = MacUI:Window({ Title = "My Script" })

-- Visibility
Window:Hide()
Window:Show()
Window:Toggle()

-- Theme
Window:SetTheme("Dark")
Window:SetTheme("Ocean")
Window:SetTheme("Default")

-- Tab Selection
Window:SelectTab(1)
Window:SelectTab(2)

-- Destroy
Window:Destroy()
```

---

## 📱 Mobile Support

```lua
local Window = MacUI:Window({
    Title = "Mobile Friendly",
    ShowText = "Menu", -- Shows button on mobile
    ToggleUIKeybind = "RightControl" -- PC keybind
})
```

---

## 🎯 Example

```lua
local MacUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/qqqqd3783-collab/MacOS_UI/refs/heads/main/Main.lua"))()

local Window = MacUI:Window({
    Title = "My Amazing Script",
    Theme = "Dark",
    LoadingTitle = "Loading",
    LoadingSubtitle = "Please wait...",
    ToggleUIKeybind = "RightControl",
    ShowText = "Menu",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "MyConfig"
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
            -- Auto farm code here
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
        MacUI:Notify({
            Title = "Teleporting",
            Content = "Moving to farm location...",
            Duration = 3
        })
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

local WeaponSelect = CombatTab:Dropdown({
    Title = "Select Weapon",
    Options = {"Sword", "Gun", "Bow", "Magic"},
    Default = "Sword",
    Flag = "Weapon",
    Callback = function(weapon)
        print("Weapon:", weapon)
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

SettingsTab:Divider()

SettingsTab:Paragraph({
    Text = "Use RightControl to toggle UI on PC, or tap Menu button on mobile."
})

-- Success notification
MacUI:Notify({
    Title = "Script Loaded",
    Content = "All features ready!",
    Duration = 5
})
```

---

## 🎯 Tips & Best Practices

1. **Use Flag** for auto-save configuration
2. **Use Section** to organize features
3. **Use Divider** to separate unrelated items
4. **Use Paragraph** to explain features
5. **Use Label** for real-time information
6. **Use Code** for update links or examples
7. **Use Image** for logos or visuals

---

## 💬 Support

- Discord: https://discord.gg/cQywVqjcyj
- Github: https://github.com/qqqqd3783-collab

---

**Made with ❤️ by TAD HUB Team**
