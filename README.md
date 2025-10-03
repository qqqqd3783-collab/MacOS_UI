# 🌟 MacUI Library Example

```lua
-- โหลด MacUI Library
local MacUI = loadstring(game:HttpGet("https://your_raw_script_url_here"))()

-- สร้าง Window
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

-- สร้าง Tabs
local MainTab = Window:Tab("Home", 4483362458)
local SettingsTab = Window:Tab("Settings", 0)
local PlayerTab = Window:Tab("Player")

-- Section
MainTab:Section("Main Features")

-- Elements
MainTab:Label({ Text = "Welcome to MacUI Hub!" })
MainTab:Paragraph({ Text = "This is a modern MacOS-style UI library for Roblox with full features including config saving, themes, and more!" })
MainTab:Divider()
MainTab:Button({
    Title = "Click Me",
    Callback = function()
        print("Button clicked!")
        MacUI:Notify({ Title = "Success", Content = "Button was clicked!", Icon = "✓", Duration = 3 })
    end
})
MainTab:Toggle({ Title = "Auto Farm", Default = false, Flag = "AutoFarm", Callback = function(state) print("Auto Farm:", state) _G.AutoFarm = state end })
MainTab:Input({ Placeholder = "Enter your name...", Default = "", Flag = "PlayerName", Callback = function(text) print("Name:", text) end })
MainTab:TextArea({ Placeholder = "Enter multiple lines here...", Default = "", Callback = function(text) print("Text Area:", text) end })
MainTab:Slider({ Title = "Walk Speed", Min = 16, Max = 100, Default = 16, Flag = "WalkSpeed", Callback = function(value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value end })
MainTab:Dropdown({ Title = "Select Weapon", Options = {"Sword","Gun","Bow","Magic"}, Default = "Sword", Flag = "SelectedWeapon", Callback = function(selected) print("Selected:", selected) end })
MainTab:Dropdown({ Title = "Select Items", Options = {"Health Potion","Mana Potion","Speed Boost","Shield"}, Default = {"Health Potion"}, Multi = true, Callback = function(selected) print("Selected Items:", table.concat(selected,", ")) end })
MainTab:Keybind({ Title = "Toggle ESP", Default = "E", Flag = "ESPKeybind", Callback = function(key) print("ESP Key:", key) _G.ToggleESP = not _G.ToggleESP end })
MainTab:ColorPicker({ Title = "ESP Color", Default = Color3.fromRGB(255,0,0), Flag = "ESPColor", Callback = function(color) print("ESP Color:", color) _G.ESPColor = color end })
MainTab:Image({ Image = 4483362458, Height = 150 })

-- Settings Tab
SettingsTab:Section("Configuration")
SettingsTab:Button({ Title = "Save Configuration", Callback = function() if Window.SaveConfig then Window.SaveConfig() MacUI:Notify({ Title = "Saved", Content = "Configuration saved successfully!", Icon = "💾", Duration = 3 }) end end })
SettingsTab:Button({ Title = "Reset Configuration", Callback = function() if Window.ConfigData then Window.ConfigData = {} if Window.SaveConfig then Window.SaveConfig() end MacUI:Notify({ Title = "Reset", Content = "Configuration has been reset!", Icon = "🔄", Duration = 3 }) end end })

-- Notify ต้อนรับ
MacUI:Notify({ Title = "Welcome!", Content = "MacUI Hub loaded successfully", Icon = "👋", Duration = 5 })
