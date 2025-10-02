--// Enhanced MacUI Library
local MacUI = {}

-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Configuration Storage
local ConfigFolder = "MacUI_Configs"
local SavedConfigs = {}

-- Helper Functions
local function create(class, props)
    local obj = Instance.new(class)
    for i, v in pairs(props) do
        obj[i] = v
    end
    return obj
end

local function tween(obj, time, props)
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

-- Save/Load Configuration
local function SaveConfig(fileName, data)
    if not isfolder(ConfigFolder) then
        makefolder(ConfigFolder)
    end
    writefile(ConfigFolder .. "/" .. fileName .. ".json", HttpService:JSONEncode(data))
end

local function LoadConfig(fileName)
    if isfile(ConfigFolder .. "/" .. fileName .. ".json") then
        return HttpService:JSONDecode(readfile(ConfigFolder .. "/" .. fileName .. ".json"))
    end
    return nil
end

--// Loading Screen
local function CreateLoadingScreen(config)
    local LoadingGui = create("ScreenGui", {
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        Name = "MacUI_Loading",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })
    
    local LoadingFrame = create("Frame", {
        Parent = LoadingGui,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 25),
        BorderSizePixel = 0
    })
    
    local ContentFrame = create("Frame", {
        Parent = LoadingFrame,
        Size = UDim2.new(0, 300, 0, 200),
        Position = UDim2.new(0.5, -150, 0.5, -100),
        BackgroundTransparency = 1
    })
    
    local Title = create("TextLabel", {
        Parent = ContentFrame,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundTransparency = 1,
        Text = config.LoadingTitle or "MacUI",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 24
    })
    
    local Subtitle = create("TextLabel", {
        Parent = ContentFrame,
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundTransparency = 1,
        Text = config.LoadingSubtitle or "Loading...",
        TextColor3 = Color3.fromRGB(150, 150, 155),
        Font = Enum.Font.Gotham,
        TextSize = 14
    })
    
    local ProgressBar = create("Frame", {
        Parent = ContentFrame,
        Size = UDim2.new(1, 0, 0, 4),
        Position = UDim2.new(0, 0, 0, 100),
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        BorderSizePixel = 0
    })
    create("UICorner", { Parent = ProgressBar, CornerRadius = UDim.new(1, 0) })
    
    local Progress = create("Frame", {
        Parent = ProgressBar,
        Size = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(10, 132, 255),
        BorderSizePixel = 0
    })
    create("UICorner", { Parent = Progress, CornerRadius = UDim.new(1, 0) })
    
    -- Animate loading
    tween(Progress, 1.5, { Size = UDim2.new(1, 0, 1, 0) })
    
    task.delay(1.5, function()
        tween(LoadingFrame, 0.3, { BackgroundTransparency = 1 })
        tween(Title, 0.3, { TextTransparency = 1 })
        tween(Subtitle, 0.3, { TextTransparency = 1 })
        wait(0.3)
        LoadingGui:Destroy()
    end)
end

--// Key System
local function CreateKeySystem(config)
    local keySettings = config.KeySettings or {}
    
    local KeyGui = create("ScreenGui", {
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        Name = "MacUI_KeySystem",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })
    
    local KeyFrame = create("Frame", {
        Parent = KeyGui,
        Size = UDim2.new(0, 400, 0, 300),
        Position = UDim2.new(0.5, -200, 0.5, -150),
        BackgroundColor3 = Color3.fromRGB(240, 240, 245),
        BorderSizePixel = 0
    })
    create("UICorner", { Parent = KeyFrame, CornerRadius = UDim.new(0, 14) })
    
    local KeyTitle = create("TextLabel", {
        Parent = KeyFrame,
        Size = UDim2.new(1, -40, 0, 40),
        Position = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Text = keySettings.Title or "Key System",
        TextColor3 = Color3.fromRGB(30, 30, 35),
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local KeySubtitle = create("TextLabel", {
        Parent = KeyFrame,
        Size = UDim2.new(1, -40, 0, 20),
        Position = UDim2.new(0, 20, 0, 65),
        BackgroundTransparency = 1,
        Text = keySettings.Subtitle or "Enter your key",
        TextColor3 = Color3.fromRGB(100, 100, 105),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local KeyNote = create("TextLabel", {
        Parent = KeyFrame,
        Size = UDim2.new(1, -40, 0, 40),
        Position = UDim2.new(0, 20, 0, 90),
        BackgroundColor3 = Color3.fromRGB(255, 245, 200),
        Text = "  " .. (keySettings.Note or "Get key from our website"),
        TextColor3 = Color3.fromRGB(100, 80, 0),
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    })
    create("UICorner", { Parent = KeyNote, CornerRadius = UDim.new(0, 8) })
    
    local KeyInput = create("TextBox", {
        Parent = KeyFrame,
        Size = UDim2.new(1, -40, 0, 38),
        Position = UDim2.new(0, 20, 0, 150),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        PlaceholderText = "Enter key here...",
        PlaceholderColor3 = Color3.fromRGB(150, 150, 155),
        Text = "",
        TextColor3 = Color3.fromRGB(50, 50, 55),
        Font = Enum.Font.Gotham,
        TextSize = 14,
        ClearTextOnFocus = false
    })
    create("UICorner", { Parent = KeyInput, CornerRadius = UDim.new(0, 8) })
    create("UIPadding", { Parent = KeyInput, PaddingLeft = UDim.new(0, 10) })
    
    local SubmitBtn = create("TextButton", {
        Parent = KeyFrame,
        Size = UDim2.new(1, -40, 0, 38),
        Position = UDim2.new(0, 20, 0, 205),
        BackgroundColor3 = Color3.fromRGB(10, 132, 255),
        BorderSizePixel = 0,
        Text = "Submit Key",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        AutoButtonColor = false
    })
    create("UICorner", { Parent = SubmitBtn, CornerRadius = UDim.new(0, 8) })
    
    local StatusLabel = create("TextLabel", {
        Parent = KeyFrame,
        Size = UDim2.new(1, -40, 0, 20),
        Position = UDim2.new(0, 20, 0, 255),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 59, 48),
        Font = Enum.Font.GothamMedium,
        TextSize = 12
    })
    
    local function CheckKey(key)
        local validKeys = keySettings.Key or {"Hello"}
        for _, validKey in ipairs(validKeys) do
            if key == validKey then
                return true
            end
        end
        return false
    end
    
    SubmitBtn.MouseButton1Click:Connect(function()
        local enteredKey = KeyInput.Text
        if CheckKey(enteredKey) then
            StatusLabel.Text = "✓ Key accepted!"
            StatusLabel.TextColor3 = Color3.fromRGB(52, 199, 89)
            
            if keySettings.SaveKey then
                SaveConfig(keySettings.FileName or "Key", { Key = enteredKey })
            end
            
            wait(0.5)
            tween(KeyFrame, 0.3, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0) })
            wait(0.3)
            KeyGui:Destroy()
            return true
        else
            StatusLabel.Text = "✗ Invalid key!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 59, 48)
        end
    end)
    
    -- Check saved key
    if keySettings.SaveKey then
        local saved = LoadConfig(keySettings.FileName or "Key")
        if saved and CheckKey(saved.Key) then
            KeyGui:Destroy()
            return true
        end
    end
end

--// Window
function MacUI:Window(config)
    local self = {}
    self.Tabs = {}
    self.Visible = true
    config = config or {}
    
    -- Show loading screen
    if config.LoadingTitle or config.LoadingSubtitle then
        CreateLoadingScreen(config)
        wait(1.5)
    end
    
    -- Key System
    if config.KeySystem then
        CreateKeySystem(config)
    end
    
    -- Discord Prompt
    if config.Discord and config.Discord.Enabled then
        local discordSettings = config.Discord
        local shouldPrompt = true
        
        if discordSettings.RememberJoins then
            local saved = LoadConfig("Discord_" .. (discordSettings.Invite or "default"))
            if saved and saved.Joined then
                shouldPrompt = false
            end
        end
        
        if shouldPrompt and syn and syn.request then
            local success = pcall(function()
                syn.request({
                    Url = "http://127.0.0.1:6463/rpc?v=1",
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        ["Origin"] = "https://discord.com"
                    },
                    Body = HttpService:JSONEncode({
                        cmd = "INVITE_BROWSER",
                        args = { code = discordSettings.Invite },
                        nonce = HttpService:GenerateGUID(false)
                    })
                })
                
                if discordSettings.RememberJoins then
                    SaveConfig("Discord_" .. (discordSettings.Invite or "default"), { Joined = true })
                end
            end)
        end
    end
    
    -- Theme system (FIXED - เพิ่มสีสำหรับ Tab states)
    local Themes = {
        Default = {
            Background = Color3.fromRGB(240, 240, 245),
            Sidebar = Color3.fromRGB(225, 225, 230),
            TitleBar = Color3.fromRGB(230, 230, 235),
            Content = Color3.fromRGB(248, 248, 252),
            Accent = Color3.fromRGB(10, 132, 255),
            TabInactive = Color3.fromRGB(215, 215, 220),
            TabActive = Color3.fromRGB(255, 255, 255),
            TextInactive = Color3.fromRGB(60, 60, 65)
        },
        Dark = {
            Background = Color3.fromRGB(30, 30, 35),
            Sidebar = Color3.fromRGB(25, 25, 30),
            TitleBar = Color3.fromRGB(35, 35, 40),
            Content = Color3.fromRGB(28, 28, 33),
            Accent = Color3.fromRGB(10, 132, 255),
            TabInactive = Color3.fromRGB(40, 40, 45),
            TabActive = Color3.fromRGB(50, 50, 55),
            TextInactive = Color3.fromRGB(150, 150, 155)
        },
        Ocean = {
            Background = Color3.fromRGB(230, 240, 250),
            Sidebar = Color3.fromRGB(215, 230, 245),
            TitleBar = Color3.fromRGB(220, 235, 250),
            Content = Color3.fromRGB(238, 245, 252),
            Accent = Color3.fromRGB(0, 122, 255),
            TabInactive = Color3.fromRGB(200, 220, 240),
            TabActive = Color3.fromRGB(255, 255, 255),
            TextInactive = Color3.fromRGB(60, 80, 100)
        }
    }
    
    local currentTheme = Themes[config.Theme] or Themes.Default

    local ScreenGui = create("ScreenGui", {
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        Name = config.Name or "MacUI_" .. HttpService:GenerateGUID(false),
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })

    local MainFrame = create("Frame", {
        Parent = ScreenGui,
        Size = config.Size or UDim2.new(0, 600, 0, 400),
        BackgroundColor3 = currentTheme.Background,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -300, 0.5, -200)
    })
    MainFrame.ClipsDescendants = true
    create("UICorner", { Parent = MainFrame, CornerRadius = UDim.new(0, 14) })
    
    -- Shadow effect
    local Shadow = create("ImageLabel", {
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, -15, 0, -15),
        Size = UDim2.new(1, 30, 1, 30),
        ZIndex = 0,
        Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.7
    })

    -- Titlebar
    local TitleBar = create("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundColor3 = currentTheme.TitleBar,
        BorderSizePixel = 0
    })
    create("UICorner", { Parent = TitleBar, CornerRadius = UDim.new(0, 14) })
    
    local TitleMask = create("Frame", {
        Parent = TitleBar,
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 1, -14),
        BackgroundColor3 = currentTheme.TitleBar,
        BorderSizePixel = 0
    })

    -- Icon
    if config.Icon and config.Icon ~= 0 then
        local IconImage = create("ImageLabel", {
            Parent = TitleBar,
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 80, 0.5, -10),
            BackgroundTransparency = 1,
            Image = type(config.Icon) == "number" and "rbxassetid://" .. config.Icon or config.Icon
        })
    end

    -- Title Text
    local titleXPos = config.Icon and config.Icon ~= 0 and 110 or 80
    local TitleText = create("TextLabel", {
        Parent = TitleBar,
        Size = UDim2.new(1, -titleXPos - 20, 1, 0),
        Position = UDim2.new(0, titleXPos, 0, 0),
        BackgroundTransparency = 1,
        Text = config.Title or "MacUI Window",
        TextColor3 = Color3.fromRGB(50, 50, 55),
        Font = Enum.Font.GothamMedium,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- Traffic Lights
    local TrafficHolder = create("Frame", {
        Parent = TitleBar,
        Size = UDim2.new(0, 60, 0, 20),
        Position = UDim2.new(0, 12, 0.5, -10),
        BackgroundTransparency = 1
    })

    local colors = { 
        Color3.fromRGB(255, 95, 87), 
        Color3.fromRGB(255, 189, 46), 
        Color3.fromRGB(39, 201, 63) 
    }
    
    for i, c in ipairs(colors) do
        local dot = create("Frame", {
            Parent = TrafficHolder,
            Size = UDim2.new(0, 13, 0, 13),
            Position = UDim2.new(0, (i - 1) * 20, 0.5, -6.5),
            BackgroundColor3 = c,
            BorderSizePixel = 0
        })
        create("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })
        
        create("UIGradient", {
            Parent = dot,
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, c)
            }),
            Rotation = 90
        })

        local button = create("TextButton", {
            Parent = dot,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = ""
        })

        button.MouseEnter:Connect(function()
            tween(dot, 0.2, { Size = UDim2.new(0, 15, 0, 15), Position = UDim2.new(0, (i - 1) * 20, 0.5, -7.5) })
        end)
        button.MouseLeave:Connect(function()
            tween(dot, 0.2, { Size = UDim2.new(0, 13, 0, 13), Position = UDim2.new(0, (i - 1) * 20, 0.5, -6.5) })
        end)

        local isMinimized, isFullscreen = false, false
        if i == 1 then
            button.MouseButton1Click:Connect(function()
                tween(MainFrame, 0.3, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0) })
                wait(0.3)
                ScreenGui:Destroy()
            end)
        elseif i == 2 then
            button.MouseButton1Click:Connect(function()
                isMinimized = not isMinimized
                if isMinimized then
                    tween(MainFrame, 0.3, { Size = UDim2.new(0, 600, 0, 32) })
                else
                    tween(MainFrame, 0.3, { Size = config.Size or UDim2.new(0, 600, 0, 400) })
                end
            end)
        elseif i == 3 then
            button.MouseButton1Click:Connect(function()
                isFullscreen = not isFullscreen
                if isFullscreen then
                    tween(MainFrame, 0.3, { 
                        Size = UDim2.new(1, -40, 1, -40),
                        Position = UDim2.new(0, 20, 0, 20)
                    })
                else
                    tween(MainFrame, 0.3, {
                        Size = config.Size or UDim2.new(0, 600, 0, 400),
                        Position = UDim2.new(0.5, -300, 0.5, -200)
                    })
                end
            end)
        end
    end

    -- Dragging
    local dragging, dragInput, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Toggle UI Keybind
    if config.ToggleUIKeybind then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
                local keyPressed = input.KeyCode.Name
                if keyPressed == config.ToggleUIKeybind or 
                   (type(config.ToggleUIKeybind) == "userdata" and input.KeyCode == config.ToggleUIKeybind) then
                    self.Visible = not self.Visible
                    MainFrame.Visible = self.Visible
                end
            end
        end)
    end

    -- Mobile Show Button
    if config.ShowText and UserInputService.TouchEnabled then
        local ShowButton = create("TextButton", {
            Parent = ScreenGui,
            Size = UDim2.new(0, 80, 0, 30),
            Position = UDim2.new(0, 10, 0, 10),
            BackgroundColor3 = currentTheme.Accent,
            BorderSizePixel = 0,
            Text = config.ShowText,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            Visible = false
        })
        create("UICorner", { Parent = ShowButton, CornerRadius = UDim.new(0, 8) })
        
        ShowButton.MouseButton1Click:Connect(function()
            self.Visible = true
            MainFrame.Visible = true
            ShowButton.Visible = false
        end)
        
        -- Show button when UI is hidden
        RunService.RenderStepped:Connect(function()
            if not self.Visible then
                ShowButton.Visible = true
            end
        end)
    end

    -- Sidebar
    local Sidebar = create("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(0, 160, 1, -32),
        Position = UDim2.new(0, 0, 0, 32),
        BackgroundColor3 = currentTheme.Sidebar,
        BorderSizePixel = 0
    })
    
    create("UICorner", { Parent = Sidebar, CornerRadius = UDim.new(0, 14) })
    
    local SidebarMask = create("Frame", {
        Parent = Sidebar,
        Size = UDim2.new(0, 14, 1, 0),
        Position = UDim2.new(1, -14, 0, 0),
        BackgroundColor3 = currentTheme.Sidebar,
        BorderSizePixel = 0
    })
    
    local SidebarMaskTop = create("Frame", {
        Parent = Sidebar,
        Size = UDim2.new(1, 0, 0, 14),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = currentTheme.Sidebar,
        BorderSizePixel = 0
    })

    local TabButtons = create("ScrollingFrame", {
        Parent = Sidebar,
        Size = UDim2.new(1, -10, 1, -10),
        Position = UDim2.new(0, 5, 0, 5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(180, 180, 185)
    })
    
    create("UIListLayout", {
        Parent = TabButtons,
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 6)
    })
    
    create("UIPadding", { 
        Parent = TabButtons, 
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8)
    })

    -- Content Holder
    local ContentFrame = create("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(1, -160, 1, -32),
        Position = UDim2.new(0, 160, 0, 32),
        BackgroundColor3 = currentTheme.Content,
        BorderSizePixel = 0
    })

    -- Configuration Saving (Initialize ConfigData ถึงแม้ไม่เปิด ConfigSaving)
    self.ConfigData = {}
    if config.ConfigurationSaving and config.ConfigurationSaving.Enabled then
        self.ConfigData = LoadConfig(config.ConfigurationSaving.FileName or "MacUI_Config") or {}
        
        self.SaveConfig = function()
            if config.ConfigurationSaving and config.ConfigurationSaving.Enabled then
                SaveConfig(config.ConfigurationSaving.FileName or "MacUI_Config", self.ConfigData)
            end
        end
    else
        self.SaveConfig = function() end
    end

    -- Tab Function
    function self:Tab(name, icon)
        local tab = {}
        
        local Button = create("TextButton", {
            Parent = TabButtons,
            Size = UDim2.new(1, -10, 0, 36),
            BackgroundColor3 = currentTheme.TabInactive,
            BorderSizePixel = 0,
            Text = "",
            TextColor3 = currentTheme.TextInactive,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            AutoButtonColor = false
        })
        create("UICorner", { Parent = Button, CornerRadius = UDim.new(0, 8) })
        
        -- Icon
        if icon then
            local TabIcon = create("ImageLabel", {
                Parent = Button,
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(0, 8, 0.5, -9),
                BackgroundTransparency = 1,
                Image = type(icon) == "number" and "rbxassetid://" .. icon or icon,
                ImageColor3 = currentTheme.TextInactive
            })
            
            local TabLabel = create("TextLabel", {
                Parent = Button,
                Size = UDim2.new(1, -34, 1, 0),
                Position = UDim2.new(0, 30, 0, 0),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = currentTheme.TextInactive,
                Font = Enum.Font.GothamMedium,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            tab.Icon = TabIcon
            tab.Label = TabLabel
        else
            Button.Text = name
        end

        local TabPage = create("ScrollingFrame", {
            Parent = ContentFrame,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 6,
            ScrollBarImageColor3 = Color3.fromRGB(200, 200, 205),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false
        })
        
        create("UIListLayout", {
            Parent = TabPage,
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top
        })
        
        create("UIPadding", { 
            Parent = TabPage, 
            PaddingTop = UDim.new(0, 15), 
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15)
        })

        -- Tab switching (FIXED - ใช้ theme colors แทน hardcoded)
        Button.MouseButton1Click:Connect(function()
            -- ซ่อน tabs ทั้งหมด และรีเซ็ตสี
            for _, t in pairs(self.Tabs) do
                if t.Page ~= TabPage then  -- ไม่ซ่อน tab ที่จะแสดง
                    t.Page.Visible = false
                end
                tween(t.Button, 0.2, { 
                    BackgroundColor3 = currentTheme.TabInactive
                })
                if t.Label then
                    t.Label.TextColor3 = currentTheme.TextInactive
                else
                    t.Button.TextColor3 = currentTheme.TextInactive
                end
                if t.Icon then
                    t.Icon.ImageColor3 = currentTheme.TextInactive
                end
            end
            
            -- แสดง tab ที่ถูกคลิก
            TabPage.Visible = true
            tween(Button, 0.2, { 
                BackgroundColor3 = currentTheme.TabActive
            })
            if tab.Label then
                tab.Label.TextColor3 = currentTheme.Accent
            else
                Button.TextColor3 = currentTheme.Accent
            end
            if tab.Icon then
                tab.Icon.ImageColor3 = currentTheme.Accent
            end
        end)
        
        Button.MouseEnter:Connect(function()
            if not TabPage.Visible then
                tween(Button, 0.15, { BackgroundColor3 = Color3.new(
                    currentTheme.TabInactive.R * 0.95,
                    currentTheme.TabInactive.G * 0.95,
                    currentTheme.TabInactive.B * 0.95
                )})
            end
        end)
        
        Button.MouseLeave:Connect(function()
            if not TabPage.Visible then
                tween(Button, 0.15, { BackgroundColor3 = currentTheme.TabInactive })
            end
        end)

        tab.Page = TabPage
        tab.Button = Button
        table.insert(self.Tabs, tab)

        -- แสดง tab แรกโดยอัตโนมัติ (FIXED - ใช้ theme colors)
        if #self.Tabs == 1 then
            TabPage.Visible = true
            Button.BackgroundColor3 = currentTheme.TabActive
            if tab.Label then
                tab.Label.TextColor3 = currentTheme.Accent
            else
                Button.TextColor3 = currentTheme.Accent
            end
            if tab.Icon then
                tab.Icon.ImageColor3 = currentTheme.Accent
            end
        end

        -- Elements (ใส่ทุก function ที่มีจากเวอร์ชั่นก่อนหน้า + เพิ่มใหม่)
        
        function tab:Section(title)
            local section = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 32),
                BackgroundTransparency = 1
            })
            
            local line = create("Frame", {
                Parent = section,
                Size = UDim2.new(1, -80, 0, 1),
                Position = UDim2.new(0, 0, 0.5, 0),
                BackgroundColor3 = Color3.fromRGB(200, 200, 205),
                BorderSizePixel = 0
            })
            
            local label = create("TextLabel", {
                Parent = section,
                Size = UDim2.new(0, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = currentTheme.Content,
                BorderSizePixel = 0,
                Text = " " .. title .. " ",
                TextColor3 = Color3.fromRGB(100, 100, 105),
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.X
            })
            
            return section
        end
        
        function tab:Label(cfg)
            local label = create("TextLabel", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 28),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Text = cfg.Text or "",
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true
            })
            create("UICorner", { Parent = label, CornerRadius = UDim.new(0, 8) })
            create("UIPadding", { Parent = label, PaddingLeft = UDim.new(0, 15) })
            
            return label
        end
        
        function tab:Paragraph(cfg)
            local paragraph = create("TextLabel", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Text = cfg.Text or "",
                TextColor3 = Color3.fromRGB(70, 70, 75),
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            create("UICorner", { Parent = paragraph, CornerRadius = UDim.new(0, 8) })
            create("UIPadding", { 
                Parent = paragraph, 
                PaddingLeft = UDim.new(0, 15),
                PaddingRight = UDim.new(0, 15),
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10)
            })
            
            return paragraph
        end
        
        function tab:Divider()
            local divider = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 1),
                BackgroundColor3 = Color3.fromRGB(220, 220, 225),
                BorderSizePixel = 0
            })
            
            return divider
        end

        function tab:Button(cfg)
            local btn = create("TextButton", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 38),
                BackgroundColor3 = currentTheme.Accent,
                BorderSizePixel = 0,
                Text = cfg.Title,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                AutoButtonColor = false
            })
            create("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 8) })
            
            btn.MouseEnter:Connect(function()
                local darker = Color3.fromRGB(
                    math.max(currentTheme.Accent.R * 255 - 10, 0),
                    math.max(currentTheme.Accent.G * 255 - 10, 0),
                    math.max(currentTheme.Accent.B * 255 - 10, 0)
                )
                tween(btn, 0.2, { BackgroundColor3 = darker })
            end)
            
            btn.MouseLeave:Connect(function()
                tween(btn, 0.2, { BackgroundColor3 = currentTheme.Accent })
            end)
            
            btn.MouseButton1Down:Connect(function()
                tween(btn, 0.1, { Size = UDim2.new(1, -20, 0, 36) })
            end)
            
            btn.MouseButton1Up:Connect(function()
                tween(btn, 0.1, { Size = UDim2.new(1, -20, 0, 38) })
            end)
            
            btn.MouseButton1Click:Connect(cfg.Callback)
            return btn
        end

        function tab:Toggle(cfg)
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 38),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local label = create("TextLabel", {
                Parent = holder,
                Size = UDim2.new(1, -60, 1, 0),
                Position = UDim2.new(0, 15, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Title,
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local toggleState = cfg.Default or false
            
            local toggleBg = create("Frame", {
                Parent = holder,
                Size = UDim2.new(0, 48, 0, 28),
                Position = UDim2.new(1, -58, 0.5, -14),
                BackgroundColor3 = toggleState and Color3.fromRGB(52, 199, 89) or Color3.fromRGB(200, 200, 205),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = toggleBg, CornerRadius = UDim.new(1, 0) })
            
            local toggleKnob = create("Frame", {
                Parent = toggleBg,
                Size = UDim2.new(0, 24, 0, 24),
                Position = toggleState and UDim2.new(1, -26, 0.5, -12) or UDim2.new(0, 2, 0.5, -12),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = toggleKnob, CornerRadius = UDim.new(1, 0) })

            local btn = create("TextButton", {
                Parent = holder,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = ""
            })

            btn.MouseButton1Click:Connect(function()
                toggleState = not toggleState
                tween(toggleBg, 0.2, { 
                    BackgroundColor3 = toggleState and Color3.fromRGB(52, 199, 89) or Color3.fromRGB(200, 200, 205)
                })
                tween(toggleKnob, 0.2, {
                    Position = toggleState and UDim2.new(1, -26, 0.5, -12) or UDim2.new(0, 2, 0.5, -12)
                })
                if cfg.Callback then cfg.Callback(toggleState) end
                
                -- Save config
                if self.ConfigData and cfg.Flag then
                    self.ConfigData[cfg.Flag] = toggleState
                    if self.SaveConfig then self.SaveConfig() end
                end
            end)
            
            -- Load saved value
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] ~= nil then
                toggleState = self.ConfigData[cfg.Flag]
                toggleBg.BackgroundColor3 = toggleState and Color3.fromRGB(52, 199, 89) or Color3.fromRGB(200, 200, 205)
                toggleKnob.Position = toggleState and UDim2.new(1, -26, 0.5, -12) or UDim2.new(0, 2, 0.5, -12)
            end

            return holder
        end

        function tab:Input(cfg)
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 38),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local input = create("TextBox", {
                Parent = holder,
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                PlaceholderText = cfg.Placeholder or "Type...",
                PlaceholderColor3 = Color3.fromRGB(150, 150, 155),
                Text = cfg.Default or "",
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.Gotham,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false
            })
            
            input.Focused:Connect(function()
                tween(holder, 0.2, { BackgroundColor3 = Color3.fromRGB(245, 245, 250) })
            end)
            
            input.FocusLost:Connect(function()
                tween(holder, 0.2, { BackgroundColor3 = Color3.fromRGB(255, 255, 255) })
                if cfg.Callback then cfg.Callback(input.Text) end
                
                -- Save config
                if self.ConfigData and cfg.Flag then
                    self.ConfigData[cfg.Flag] = input.Text
                    if self.SaveConfig then self.SaveConfig() end
                end
            end)
            
            -- Load saved value
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] then
                input.Text = self.ConfigData[cfg.Flag]
            end
            
            return input
        end
        
        function tab:TextArea(cfg)
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 100),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local textArea = create("TextBox", {
                Parent = holder,
                Size = UDim2.new(1, -20, 1, -20),
                Position = UDim2.new(0, 10, 0, 10),
                BackgroundTransparency = 1,
                PlaceholderText = cfg.Placeholder or "Type here...",
                PlaceholderColor3 = Color3.fromRGB(150, 150, 155),
                Text = cfg.Default or "",
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
                MultiLine = true,
                ClearTextOnFocus = false
            })
            
            textArea.Focused:Connect(function()
                tween(holder, 0.2, { BackgroundColor3 = Color3.fromRGB(245, 245, 250) })
            end)
            
            textArea.FocusLost:Connect(function()
                tween(holder, 0.2, { BackgroundColor3 = Color3.fromRGB(255, 255, 255) })
                if cfg.Callback then cfg.Callback(textArea.Text) end
            end)
            
            return textArea
        end
        
        function tab:Slider(cfg)
            local value = cfg.Default or cfg.Min or 0
            local min = cfg.Min or 0
            local max = cfg.Max or 100
            
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 60),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local titleLabel = create("TextLabel", {
                Parent = holder,
                Size = UDim2.new(1, -20, 0, 20),
                Position = UDim2.new(0, 10, 0, 8),
                BackgroundTransparency = 1,
                Text = cfg.Title,
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.GothamMedium,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local valueLabel = create("TextLabel", {
                Parent = holder,
                Size = UDim2.new(0, 50, 0, 20),
                Position = UDim2.new(1, -60, 0, 8),
                BackgroundTransparency = 1,
                Text = tostring(value),
                TextColor3 = currentTheme.Accent,
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Right
            })
            
            local sliderBg = create("Frame", {
                Parent = holder,
                Size = UDim2.new(1, -20, 0, 6),
                Position = UDim2.new(0, 10, 1, -18),
                BackgroundColor3 = Color3.fromRGB(220, 220, 225),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = sliderBg, CornerRadius = UDim.new(1, 0) })
            
            local sliderFill = create("Frame", {
                Parent = sliderBg,
                Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = currentTheme.Accent,
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = sliderFill, CornerRadius = UDim.new(1, 0) })
            
            local sliderKnob = create("Frame", {
                Parent = sliderBg,
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new((value - min) / (max - min), -9, 0.5, -9),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ZIndex = 2
            })
            create("UICorner", { Parent = sliderKnob, CornerRadius = UDim.new(1, 0) })
            create("UIStroke", { 
                Parent = sliderKnob, 
                Thickness = 2, 
                Color = currentTheme.Accent
            })
            
            local dragging = false
            
            local function updateSlider(input)
                local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * pos)
                
                valueLabel.Text = tostring(value)
                sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                sliderKnob.Position = UDim2.new(pos, -9, 0.5, -9)
                
                if cfg.Callback then cfg.Callback(value) end
                
                -- Save config
                if self.ConfigData and cfg.Flag then
                    self.ConfigData[cfg.Flag] = value
                    if self.SaveConfig then self.SaveConfig() end
                end
            end
            
            -- Touch/Mouse support with better mobile handling
            local function startDragging(input)
                dragging = true
                tween(sliderKnob, 0.1, { Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(sliderKnob.Position.X.Scale, -11, 0.5, -11) })
                updateSlider(input)
            end
            
            local function stopDragging()
                dragging = false
                tween(sliderKnob, 0.1, { Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(sliderKnob.Position.X.Scale, -9, 0.5, -9) })
            end
            
            sliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    startDragging(input)
                end
            end)
            
            sliderKnob.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    stopDragging()
                end
            end)
            
            -- Handle dragging on both mouse and touch
            UserInputService.InputChanged:Connect(function(input)
                if dragging then
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateSlider(input)
                    end
                end
            end)
            
            UserInputService.TouchMoved:Connect(function(input, processed)
                if dragging and not processed then
                    updateSlider(input)
                end
            end)
            
            -- Click/tap anywhere on slider to jump
            sliderBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    startDragging(input)
                end
            end)
            
            sliderBg.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    stopDragging()
                end
            end)
            
            -- Load saved value
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] then
                value = self.ConfigData[cfg.Flag]
                valueLabel.Text = tostring(value)
                local pos = (value - min) / (max - min)
                sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                sliderKnob.Position = UDim2.new(pos, -9, 0.5, -9)
            end
            
            return holder
        end
        
        function tab:Dropdown(cfg)
            local selectedValue = cfg.Default or (cfg.Options and cfg.Options[1]) or "Select"
            local isOpen = false
            local multiSelect = cfg.Multi or false
            local selectedValues = multiSelect and (cfg.Default or {}) or nil
            
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 38),
                BackgroundTransparency = 1,
                ZIndex = 10
            })
            
            local dropdownBtn = create("TextButton", {
                Parent = holder,
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false
            })
            create("UICorner", { Parent = dropdownBtn, CornerRadius = UDim.new(0, 8) })
            
            local selectedLabel = create("TextLabel", {
                Parent = dropdownBtn,
                Size = UDim2.new(1, -50, 1, 0),
                Position = UDim2.new(0, 15, 0, 0),
                BackgroundTransparency = 1,
                Text = multiSelect and (#selectedValues > 0 and table.concat(selectedValues, ", ") or "Select") or selectedValue,
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd
            })
            
            local arrow = create("TextLabel", {
                Parent = dropdownBtn,
                Size = UDim2.new(0, 20, 1, 0),
                Position = UDim2.new(1, -30, 0, 0),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = Color3.fromRGB(150, 150, 155),
                Font = Enum.Font.GothamBold,
                TextSize = 10
            })
            
            local optionsFrame = create("Frame", {
                Parent = holder,
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 42),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ClipsDescendants = true,
                Visible = false
            })
            create("UICorner", { Parent = optionsFrame, CornerRadius = UDim.new(0, 8) })
            create("UIStroke", { 
                Parent = optionsFrame, 
                Thickness = 1, 
                Color = Color3.fromRGB(220, 220, 225)
            })
            
            local optionsList = create("ScrollingFrame", {
                Parent = optionsFrame,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ScrollBarThickness = 4,
                ScrollBarImageColor3 = Color3.fromRGB(200, 200, 205)
            })
            
            create("UIListLayout", {
                Parent = optionsList,
                Padding = UDim.new(0, 2),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            })
            
            create("UIPadding", { 
                Parent = optionsList, 
                PaddingTop = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 4)
            })
            
            if cfg.Options then
                for _, option in ipairs(cfg.Options) do
                    local optionBtn = create("TextButton", {
                        Parent = optionsList,
                        Size = UDim2.new(1, -8, 0, 32),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0,
                        Text = option,
                        TextColor3 = Color3.fromRGB(50, 50, 55),
                        Font = Enum.Font.Gotham,
                        TextSize = 13,
                        AutoButtonColor = false
                    })
                    create("UICorner", { Parent = optionBtn, CornerRadius = UDim.new(0, 6) })
                    
                    -- Multi-select checkbox
                    if multiSelect then
                        local checkbox = create("Frame", {
                            Parent = optionBtn,
                            Size = UDim2.new(0, 16, 0, 16),
                            Position = UDim2.new(1, -24, 0.5, -8),
                            BackgroundColor3 = Color3.fromRGB(240, 240, 245),
                            BorderSizePixel = 0
                        })
                        create("UICorner", { Parent = checkbox, CornerRadius = UDim.new(0, 4) })
                        create("UIStroke", { 
                            Parent = checkbox, 
                            Thickness = 2, 
                            Color = Color3.fromRGB(200, 200, 205)
                        })
                        
                        local checkmark = create("TextLabel", {
                            Parent = checkbox,
                            Size = UDim2.new(1, 0, 1, 0),
                            BackgroundTransparency = 1,
                            Text = "✓",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            Font = Enum.Font.GothamBold,
                            TextSize = 12,
                            Visible = false
                        })
                        
                        -- Check if already selected
                        for _, v in ipairs(selectedValues) do
                            if v == option then
                                checkbox.BackgroundColor3 = currentTheme.Accent
                                checkmark.Visible = true
                                break
                            end
                        end
                        
                        optionBtn.MouseButton1Click:Connect(function()
                            local found = false
                            for i, v in ipairs(selectedValues) do
                                if v == option then
                                    table.remove(selectedValues, i)
                                    found = true
                                    checkbox.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
                                    checkmark.Visible = false
                                    break
                                end
                            end
                            
                            if not found then
                                table.insert(selectedValues, option)
                                checkbox.BackgroundColor3 = currentTheme.Accent
                                checkmark.Visible = true
                            end
                            
                            selectedLabel.Text = #selectedValues > 0 and table.concat(selectedValues, ", ") or "Select"
                            
                            if cfg.Callback then cfg.Callback(selectedValues) end
                        end)
                    else
                        optionBtn.MouseEnter:Connect(function()
                            tween(optionBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(240, 240, 245) })
                        end)
                        
                        optionBtn.MouseLeave:Connect(function()
                            tween(optionBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(255, 255, 255) })
                        end)
                        
                        optionBtn.MouseButton1Click:Connect(function()
                            selectedValue = option
                            selectedLabel.Text = option
                            isOpen = false
                            tween(optionsFrame, 0.2, { Size = UDim2.new(1, 0, 0, 0) })
                            tween(arrow, 0.2, { Rotation = 0 })
                            wait(0.2)
                            optionsFrame.Visible = false
                            holder.Size = UDim2.new(1, -20, 0, 38)
                            
                            if cfg.Callback then cfg.Callback(option) end
                            
                            -- Save config
                            if self.ConfigData and cfg.Flag then
                                self.ConfigData[cfg.Flag] = option
                                if self.SaveConfig then self.SaveConfig() end
                            end
                        end)
                    end
                end
            end
            
            dropdownBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    optionsFrame.Visible = true
                    local optionCount = #(cfg.Options or {})
                    local maxHeight = math.min(optionCount * 34 + 8, 150)
                    holder.Size = UDim2.new(1, -20, 0, 38 + maxHeight + 4)
                    tween(optionsFrame, 0.2, { Size = UDim2.new(1, 0, 0, maxHeight) })
                    tween(arrow, 0.2, { Rotation = 180 })
                else
                    tween(optionsFrame, 0.2, { Size = UDim2.new(1, 0, 0, 0) })
                    tween(arrow, 0.2, { Rotation = 0 })
                    wait(0.2)
                    optionsFrame.Visible = false
                    holder.Size = UDim2.new(1, -20, 0, 38)
                end
            end)
            
            -- Load saved value
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] and not multiSelect then
                selectedValue = self.ConfigData[cfg.Flag]
                selectedLabel.Text = selectedValue
            end
            
            return holder
        end
        
        function tab:Keybind(cfg)
            local currentKey = cfg.Default or "None"
            local waitingForKey = false
            
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 38),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local label = create("TextLabel", {
                Parent = holder,
                Size = UDim2.new(1, -120, 1, 0),
                Position = UDim2.new(0, 15, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Title or "Keybind",
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local keyBtn = create("TextButton", {
                Parent = holder,
                Size = UDim2.new(0, 100, 0, 28),
                Position = UDim2.new(1, -110, 0.5, -14),
                BackgroundColor3 = Color3.fromRGB(240, 240, 245),
                BorderSizePixel = 0,
                Text = currentKey,
                TextColor3 = currentTheme.Accent,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                AutoButtonColor = false
            })
            create("UICorner", { Parent = keyBtn, CornerRadius = UDim.new(0, 6) })
            
            keyBtn.MouseButton1Click:Connect(function()
                waitingForKey = true
                keyBtn.Text = "..."
                tween(keyBtn, 0.2, { BackgroundColor3 = currentTheme.Accent, TextColor3 = Color3.fromRGB(255, 255, 255) })
            end)
            
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if waitingForKey and not gameProcessed then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode.Name
                        keyBtn.Text = currentKey
                        waitingForKey = false
                        tween(keyBtn, 0.2, { BackgroundColor3 = Color3.fromRGB(240, 240, 245), TextColor3 = currentTheme.Accent })
                        
                        if cfg.Callback then cfg.Callback(currentKey) end
                        
                        -- Save config
                        if self.ConfigData and cfg.Flag then
                            self.ConfigData[cfg.Flag] = currentKey
                            if self.SaveConfig then self.SaveConfig() end
                        end
                    end
                elseif not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
                    if input.KeyCode.Name == currentKey and cfg.Callback then
                        cfg.Callback(currentKey)
                    end
                end
            end)
            
            -- Load saved value
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] then
                currentKey = self.ConfigData[cfg.Flag]
                keyBtn.Text = currentKey
            end
            
            return holder
        end
        
        function tab:ColorPicker(cfg)
            local currentColor = cfg.Default or Color3.fromRGB(255, 255, 255)
            
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 38),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local label = create("TextLabel", {
                Parent = holder,
                Size = UDim2.new(1, -60, 1, 0),
                Position = UDim2.new(0, 15, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Title or "Color",
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local colorDisplay = create("Frame", {
                Parent = holder,
                Size = UDim2.new(0, 32, 0, 24),
                Position = UDim2.new(1, -42, 0.5, -12),
                BackgroundColor3 = currentColor,
                BorderSizePixel = 0,
                ZIndex = 2
            })
            create("UICorner", { Parent = colorDisplay, CornerRadius = UDim.new(0, 6) })
            create("UIStroke", { 
                Parent = colorDisplay, 
                Thickness = 2, 
                Color = Color3.fromRGB(220, 220, 225),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })
            
            local colorBtn = create("TextButton", {
                Parent = holder,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = ""
            })
            
            local colorPickerOpen = false
            local colorPicker
            
            colorBtn.MouseButton1Click:Connect(function()
                if colorPickerOpen then
                    if colorPicker then
                        colorPicker:Destroy()
                        colorPickerOpen = false
                    end
                    return
                end
                
                colorPickerOpen = true
                
                colorPicker = create("Frame", {
                    Parent = holder,
                    Size = UDim2.new(1, 0, 0, 180),
                    Position = UDim2.new(0, 0, 0, 42),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    ZIndex = 20
                })
                create("UICorner", { Parent = colorPicker, CornerRadius = UDim.new(0, 8) })
                create("UIStroke", { 
                    Parent = colorPicker, 
                    Thickness = 1, 
                    Color = Color3.fromRGB(220, 220, 225)
                })
                
                holder.Size = UDim2.new(1, -20, 0, 226)
                
                local r, g, b = math.floor(currentColor.R * 255), math.floor(currentColor.G * 255), math.floor(currentColor.B * 255)
                
                local function createSlider(name, value, yPos)
                    local sliderLabel = create("TextLabel", {
                        Parent = colorPicker,
                        Size = UDim2.new(0, 20, 0, 20),
                        Position = UDim2.new(0, 10, 0, yPos),
                        BackgroundTransparency = 1,
                        Text = name,
                        TextColor3 = Color3.fromRGB(50, 50, 55),
                        Font = Enum.Font.GothamBold,
                        TextSize = 12
                    })
                    
                    local sliderBg = create("Frame", {
                        Parent = colorPicker,
                        Size = UDim2.new(1, -80, 0, 6),
                        Position = UDim2.new(0, 40, 0, yPos + 7),
                        BackgroundColor3 = Color3.fromRGB(220, 220, 225),
                        BorderSizePixel = 0
                    })
                    create("UICorner", { Parent = sliderBg, CornerRadius = UDim.new(1, 0) })
                    
                    -- Gradient สีสำหรับแต่ละ channel
                    local gradient = create("UIGradient", {
                        Parent = sliderBg,
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                            ColorSequenceKeypoint.new(1, 
                                name == "R" and Color3.fromRGB(255, 0, 0) or
                                name == "G" and Color3.fromRGB(0, 255, 0) or
                                Color3.fromRGB(0, 0, 255)
                            )
                        })
                    })
                    
                    -- Fill bar แสดงค่าที่เลือก
                    local sliderFill = create("Frame", {
                        Parent = sliderBg,
                        Size = UDim2.new(value / 255, 0, 1, 0),
                        BackgroundColor3 = currentTheme.Accent,
                        BorderSizePixel = 0,
                        BackgroundTransparency = 0.3
                    })
                    create("UICorner", { Parent = sliderFill, CornerRadius = UDim.new(1, 0) })
                    
                    local sliderKnob = create("Frame", {
                        Parent = sliderBg,
                        Size = UDim2.new(0, 18, 0, 18),
                        Position = UDim2.new(value / 255, -9, 0.5, -9),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0,
                        ZIndex = 22
                    })
                    create("UICorner", { Parent = sliderKnob, CornerRadius = UDim.new(1, 0) })
                    create("UIStroke", { 
                        Parent = sliderKnob, 
                        Thickness = 2, 
                        Color = currentTheme.Accent
                    })
                    
                    local valueLabel = create("TextLabel", {
                        Parent = colorPicker,
                        Size = UDim2.new(0, 30, 0, 20),
                        Position = UDim2.new(1, -35, 0, yPos),
                        BackgroundTransparency = 1,
                        Text = tostring(value),
                        TextColor3 = currentTheme.Accent,
                        Font = Enum.Font.GothamBold,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Right
                    })
                    
                    local dragging = false
                    
                    local function updateSlider(input)
                        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                        local newValue = math.floor(pos * 255)
                        
                        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                        sliderKnob.Position = UDim2.new(pos, -9, 0.5, -9)
                        valueLabel.Text = tostring(newValue)
                        
                        return newValue
                    end
                    
                    -- Touch/Mouse support for ColorPicker sliders
                    local function startDragging(input)
                        dragging = true
                        local newVal = updateSlider(input)
                        if name == "R" then r = newVal
                        elseif name == "G" then g = newVal
                        else b = newVal end
                        
                        currentColor = Color3.fromRGB(r, g, b)
                        colorDisplay.BackgroundColor3 = currentColor
                        
                        if cfg.Callback then cfg.Callback(currentColor) end
                    end
                    
                    sliderKnob.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                           input.UserInputType == Enum.UserInputType.Touch then
                            dragging = true
                        end
                    end)
                    
                    sliderKnob.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                           input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                        end
                    end)
                    
                    -- Handle dragging
                    UserInputService.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local newVal = updateSlider(input)
                            if name == "R" then r = newVal
                            elseif name == "G" then g = newVal
                            else b = newVal end
                            
                            currentColor = Color3.fromRGB(r, g, b)
                            colorDisplay.BackgroundColor3 = currentColor
                            
                            if cfg.Callback then cfg.Callback(currentColor) end
                        end
                    end)
                    
                    UserInputService.TouchMoved:Connect(function(input, processed)
                        if dragging and not processed then
                            local newVal = updateSlider(input)
                            if name == "R" then r = newVal
                            elseif name == "G" then g = newVal
                            else b = newVal end
                            
                            currentColor = Color3.fromRGB(r, g, b)
                            colorDisplay.BackgroundColor3 = currentColor
                            
                            if cfg.Callback then cfg.Callback(currentColor) end
                        end
                    end)
                    
                    -- Click/tap anywhere on slider
                    sliderBg.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                           input.UserInputType == Enum.UserInputType.Touch then
                            startDragging(input)
                        end
                    end)
                    
                    sliderBg.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                           input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                        end
                    end)
                end
                
                createSlider("R", r, 15)
                createSlider("G", g, 50)
                createSlider("B", b, 85)
                
                local closeBtn = create("TextButton", {
                    Parent = colorPicker,
                    Size = UDim2.new(1, -20, 0, 32),
                    Position = UDim2.new(0, 10, 1, -42),
                    BackgroundColor3 = currentTheme.Accent,
                    BorderSizePixel = 0,
                    Text = "Done",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Font = Enum.Font.GothamMedium,
                    TextSize = 13,
                    AutoButtonColor = false
                })
                create("UICorner", { Parent = closeBtn, CornerRadius = UDim.new(0, 6) })
                
                closeBtn.MouseButton1Click:Connect(function()
                    colorPicker:Destroy()
                    colorPickerOpen = false
                    holder.Size = UDim2.new(1, -20, 0, 38)
                    
                    -- Save config
                    if self.ConfigData and cfg.Flag then
                        self.ConfigData[cfg.Flag] = {r, g, b}
                        if self.SaveConfig then self.SaveConfig() end
                    end
                end)
            end)
            
            -- Load saved value
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] then
                local saved = self.ConfigData[cfg.Flag]
                currentColor = Color3.fromRGB(saved[1], saved[2], saved[3])
                colorDisplay.BackgroundColor3 = currentColor
            end
            
            return holder
        end
        
        function tab:Image(cfg)
            local imageHolder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, cfg.Height or 150),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = imageHolder, CornerRadius = UDim.new(0, 8) })
            
            local image = create("ImageLabel", {
                Parent = imageHolder,
                Size = UDim2.new(1, -10, 1, -10),
                Position = UDim2.new(0, 5, 0, 5),
                BackgroundTransparency = 1,
                Image = type(cfg.Image) == "number" and "rbxassetid://" .. cfg.Image or cfg.Image,
                ScaleType = Enum.ScaleType.Fit
            })
            create("UICorner", { Parent = image, CornerRadius = UDim.new(0, 6) })
            
            return imageHolder
        end

        return tab
    end

    return self
end

-- Enhanced Notify
function MacUI:Notify(cfg)
    local notificationHolder = LocalPlayer.PlayerGui:FindFirstChild("MacUI_Notifications")
    if not notificationHolder then
        notificationHolder = create("ScreenGui", {
            Parent = LocalPlayer.PlayerGui,
            Name = "MacUI_Notifications",
            ZIndexBehavior = Enum.ZIndexBehavior.Global,
            ResetOnSpawn = false
        })
        
        create("UIListLayout", {
            Parent = notificationHolder,
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        create("UIPadding", {
            Parent = notificationHolder,
            PaddingTop = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 20)
        })
    end
    
    local notification = create("Frame", {
        Parent = notificationHolder,
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Position = UDim2.new(1, 0, 0, 0)
    })
    create("UICorner", { Parent = notification, CornerRadius = UDim.new(0, 12) })
    create("UIStroke", { 
        Parent = notification, 
        Thickness = 1.5, 
        Color = Color3.fromRGB(220, 220, 225)
    })
    
    local icon = create("TextLabel", {
        Parent = notification,
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundColor3 = Color3.fromRGB(10, 132, 255),
        BorderSizePixel = 0,
        Text = cfg.Icon or "ℹ️",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 20
    })
    create("UICorner", { Parent = icon, CornerRadius = UDim.new(0, 8) })
    
    local title = create("TextLabel", {
        Parent = notification,
        Size = UDim2.new(1, -110, 0, 20),
        Position = UDim2.new(0, 60, 0, 10),
        BackgroundTransparency = 1,
        Text = cfg.Title or "Notification",
        TextColor3 = Color3.fromRGB(30, 30, 35),
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local content = create("TextLabel", {
        Parent = notification,
        Size = UDim2.new(1, -110, 0, 20),
        Position = UDim2.new(0, 60, 0, 30),
        BackgroundTransparency = 1,
        Text = cfg.Content or "",
        TextColor3 = Color3.fromRGB(100, 100, 105),
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    })
    
    local closeBtn = create("TextButton", {
        Parent = notification,
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -34, 0, 10),
        BackgroundColor3 = Color3.fromRGB(245, 245, 250),
        BorderSizePixel = 0,
        Text = "✕",
        TextColor3 = Color3.fromRGB(100, 100, 105),
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        AutoButtonColor = false
    })
    create("UICorner", { Parent = closeBtn, CornerRadius = UDim.new(1, 0) })
    
    closeBtn.MouseEnter:Connect(function()
        tween(closeBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(235, 235, 240) })
    end)
    
    closeBtn.MouseLeave:Connect(function()
        tween(closeBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(245, 245, 250) })
    end)
    
    local function closeNotification()
        tween(notification, 0.3, { 
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(1, 0, 0, 0)
        })
        wait(0.3)
        notification:Destroy()
    end
    
    closeBtn.MouseButton1Click:Connect(closeNotification)
    
    tween(notification, 0.4, { Size = UDim2.new(0, 320, 0, 60) })
    
    task.delay(cfg.Duration or 5, function()
        if notification and notification.Parent then
            closeNotification()
        end
    end)
end

return MacUI
