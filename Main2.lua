--// MacUI Library
local MacUI = {}

-- Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Helper
local function create(class, props)
    local obj = Instance.new(class)
    for i, v in pairs(props) do
        obj[i] = v
    end
    return obj
end

--// Window
function MacUI:Window(config)
    local self = {}
    self.Tabs = {}

    local ScreenGui = create("ScreenGui", {
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        Name = "MacUI_" .. HttpService:GenerateGUID(false),
        ZIndexBehavior = Enum.ZIndexBehavior.Global
    })

    local MainFrame = create("Frame", {
        Parent = ScreenGui,
        Size = config.Size or UDim2.new(0, 520, 0, 340),
        BackgroundColor3 = Color3.fromRGB(245, 245, 245),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -260, 0.5, -170)
    })
    MainFrame.ClipsDescendants = true
    create("UICorner", { Parent = MainFrame, CornerRadius = UDim.new(0, 12) })
    create("UIStroke", { Parent = MainFrame, Thickness = 1.2, Color = Color3.fromRGB(200, 200, 200) })

    -- Titlebar
    local TitleBar = create("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 28),
        BackgroundColor3 = Color3.fromRGB(235, 235, 235),
        BorderSizePixel = 0
    })
    create("UICorner", { Parent = TitleBar, CornerRadius = UDim.new(0, 12) })

    -- Title Text
    local TitleText = create("TextLabel", {
        Parent = TitleBar,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = config.Title or "MacUI Window",
        TextColor3 = Color3.fromRGB(60, 60, 60),
        Font = Enum.Font.SourceSansBold,
        TextSize = 14
    })

    -- Traffic Lights
    local TrafficHolder = create("Frame", {
        Parent = TitleBar,
        Size = UDim2.new(0, 60, 0, 20),
        Position = UDim2.new(0, 10, 0, 4),
        BackgroundTransparency = 1
    })

    local colors = { Color3.fromRGB(255, 95, 87), Color3.fromRGB(255, 189, 46), Color3.fromRGB(39, 201, 63) }
    for i, c in ipairs(colors) do
        local dot = create("Frame", {
            Parent = TrafficHolder,
            Size = UDim2.new(0, 12, 0, 12),
            Position = UDim2.new(0, (i - 1) * 18, 0, 0),
            BackgroundColor3 = c,
            BorderSizePixel = 0
        })
        create("UICorner", { Parent = dot, CornerRadius = UDim.new(1, 0) })

        local button = create("TextButton", {
            Parent = dot,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = ""
        })

        local isMinimized, isFullscreen = false, false
        if i == 1 then -- 🔴 Close
            button.MouseButton1Click:Connect(function()
                ScreenGui:Destroy()
            end)
        elseif i == 2 then -- 🟡 Minimize
            button.MouseButton1Click:Connect(function()
                isMinimized = not isMinimized
                ContentFrame.Visible = not isMinimized
            end)
        elseif i == 3 then -- 🟢 Fullscreen
            button.MouseButton1Click:Connect(function()
                isFullscreen = not isFullscreen
                if isFullscreen then
                    MainFrame.Size = UDim2.new(1, -40, 1, -40)
                    MainFrame.Position = UDim2.new(0, 20, 0, 20)
                else
                    MainFrame.Size = config.Size or UDim2.new(0, 520, 0, 340)
                    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
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

    -- Tab Buttons
    local TabButtons = create("Frame", {
        Parent = TitleBar,
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 80, 0, 0),
        BackgroundTransparency = 1
    })
    create("UIListLayout", {
        Parent = TabButtons,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 12)
    })

    -- Content Holder
    ContentFrame = create("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 1, -28),
        Position = UDim2.new(0, 0, 0, 28),
        BackgroundColor3 = Color3.fromRGB(250, 250, 250),
        BorderSizePixel = 0
    })

    -- Tab Function
    function self:Tab(name)
        local tab = {}
        local Button = create("TextButton", {
            Parent = TabButtons,
            Size = UDim2.new(0, 80, 1, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = Color3.fromRGB(80, 80, 80),
            Font = Enum.Font.SourceSansBold,
            TextSize = 14
        })

        local TabPage = create("ScrollingFrame", {
            Parent = ContentFrame,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            Visible = false
        })
        create("UIListLayout", {
            Parent = TabPage,
            Padding = UDim.new(0, 8),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top
        })
        create("UIPadding", { Parent = TabPage, PaddingTop = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10) })

        Button.MouseButton1Click:Connect(function()
            for _, t in pairs(self.Tabs) do
                t.Page.Visible = false
            end
            TabPage.Visible = true
        end)

        tab.Page = TabPage
        tab.Button = Button
        table.insert(self.Tabs, tab)

        if #self.Tabs == 1 then
            TabPage.Visible = true
        end

        -- Elements
        function tab:Button(cfg)
            local btn = create("TextButton", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 30),
                BackgroundColor3 = Color3.fromRGB(240, 240, 240),
                BorderSizePixel = 0,
                Text = cfg.Title,
                TextColor3 = Color3.fromRGB(50, 50, 50),
                Font = Enum.Font.SourceSans,
                TextSize = 14
            })
            create("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 6) })
            btn.MouseButton1Click:Connect(cfg.Callback)
            return btn
        end

        function tab:Toggle(cfg)
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 30),
                BackgroundTransparency = 1
            })
            local btn = create("TextButton", {
                Parent = holder,
                Size = UDim2.new(1, -40, 1, 0),
                BackgroundColor3 = Color3.fromRGB(240, 240, 240),
                BorderSizePixel = 0,
                Text = cfg.Title,
                TextColor3 = Color3.fromRGB(50, 50, 50),
                Font = Enum.Font.SourceSans,
                TextSize = 14
            })
            create("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 6) })

            local toggleState = cfg.Default or false
            local indicator = create("Frame", {
                Parent = holder,
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -25, 0.5, -10),
                BackgroundColor3 = toggleState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = indicator, CornerRadius = UDim.new(1, 0) })

            btn.MouseButton1Click:Connect(function()
                toggleState = not toggleState
                indicator.BackgroundColor3 = toggleState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
                if cfg.Callback then cfg.Callback(toggleState) end
            end)

            return holder
        end

        function tab:Input(cfg)
            local input = create("TextBox", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 30),
                BackgroundColor3 = Color3.fromRGB(240, 240, 240),
                BorderSizePixel = 0,
                PlaceholderText = cfg.Placeholder or "Type...",
                Text = cfg.Default or "",
                TextColor3 = Color3.fromRGB(50, 50, 50),
                Font = Enum.Font.SourceSans,
                TextSize = 14
            })
            create("UICorner", { Parent = input, CornerRadius = UDim.new(0, 6) })
            input.FocusLost:Connect(function()
                if cfg.Callback then cfg.Callback(input.Text) end
            end)
            return input
        end

        return tab
    end

    return self
end

-- Notify
function MacUI:Notify(cfg)
    local msg = Instance.new("Message", workspace)
    msg.Text = cfg.Title .. " — " .. cfg.Content
    game:GetService("Debris"):AddItem(msg, cfg.Duration or 3)
end

return MacUI
