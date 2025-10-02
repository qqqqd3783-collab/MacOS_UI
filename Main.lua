-- MacUI Library (Finder-style, like WindUI)
-- ใช้ loadstring(game:HttpGet("..."))()

local MacUI = {}
MacUI.__index = MacUI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- Create new Window
function MacUI:Window(config)
    config = config or {}
    local self = setmetatable({}, MacUI)

    local gui = Instance.new("ScreenGui")
    gui.Name = "MacUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    self.Gui = gui

    -- Window
    local window = Instance.new("Frame")
    window.Size = config.Size or UDim2.new(0, 520, 0, 340)
    window.Position = UDim2.new(0.5, -260, 0.4, -170)
    window.AnchorPoint = Vector2.new(0.5, 0.5)
    window.BackgroundColor3 = Color3.fromRGB(245, 246, 250)
    window.BorderSizePixel = 0
    window.Parent = gui
    self.Window = window

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = window

    -- Titlebar
    local titlebar = Instance.new("Frame")
    titlebar.Size = UDim2.new(1, 0, 0, 40)
    titlebar.BackgroundTransparency = 1
    titlebar.Parent = window

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = config.Title or "Finder — MacUI"
    titleLabel.Font = Enum.Font.SourceSansSemibold
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = Color3.fromRGB(45, 50, 56)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = titlebar

    -- Tabs holder
    local tabs = Instance.new("Folder")
    tabs.Name = "Tabs"
    tabs.Parent = window
    self.Tabs = tabs

    return self
end

-- Add Tab
function MacUI:Tab(name)
    local tab = {}
    tab.Name = name
    tab.Elements = {}

    -- Container
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, -20, 1, -60)
    frame.Position = UDim2.new(0, 10, 0, 50)
    frame.BackgroundTransparency = 1
    frame.Visible = #self.Tabs:GetChildren() == 0 -- show only first tab
    frame.Parent = self.Tabs

    tab.Frame = frame

    -- Switch tab system
    for _, other in ipairs(self.Tabs:GetChildren()) do
        if other ~= frame then
            other.Visible = false
        end
    end

    function tab:Show()
        for _, f in ipairs(self.Frame.Parent:GetChildren()) do
            f.Visible = false
        end
        self.Frame.Visible = true
    end

    -- Button
    function tab:Button(cfg)
        cfg = cfg or {}
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 200, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(247, 248, 250)
        btn.Text = cfg.Title or "Button"
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 14
        btn.TextColor3 = Color3.fromRGB(45, 50, 56)
        btn.Parent = frame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            if cfg.Callback then
                pcall(cfg.Callback)
            end
        end)
        return btn
    end

    -- Toggle
    function tab:Toggle(cfg)
        cfg = cfg or {}
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 200, 0, 36)
        btn.BackgroundColor3 = Color3.fromRGB(247, 248, 250)
        btn.Text = cfg.Title or "Toggle"
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 14
        btn.TextColor3 = Color3.fromRGB(45, 50, 56)
        btn.Parent = frame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn

        local state = cfg.Default or false
        btn.Text = (cfg.Title or "Toggle") .. ": " .. tostring(state)

        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.Text = (cfg.Title or "Toggle") .. ": " .. tostring(state)
            if cfg.Callback then
                pcall(cfg.Callback, state)
            end
        end)
        return btn
    end

    -- Input
    function tab:Input(cfg)
        cfg = cfg or {}
        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0, 200, 0, 36)
        box.PlaceholderText = cfg.Placeholder or "Type here..."
        box.Text = cfg.Default or ""
        box.Font = Enum.Font.SourceSans
        box.TextSize = 14
        box.TextColor3 = Color3.fromRGB(45, 50, 56)
        box.BackgroundColor3 = Color3.fromRGB(247, 248, 250)
        box.Parent = frame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = box

        box.FocusLost:Connect(function()
            if cfg.Callback then
                pcall(cfg.Callback, box.Text)
            end
        end)
        return box
    end

    return tab
end

-- Notify
function MacUI:Notify(cfg)
    cfg = cfg or {}
    local note = Instance.new("TextLabel")
    note.Size = UDim2.new(0, 260, 0, 50)
    note.Position = UDim2.new(0.5, -130, 0.05, 0)
    note.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    note.Text = (cfg.Title or "Notify") .. " - " .. (cfg.Content or "")
    note.Font = Enum.Font.SourceSans
    note.TextSize = 14
    note.TextColor3 = Color3.fromRGB(45, 50, 56)
    note.Parent = self.Gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = note

    task.delay(cfg.Duration or 3, function()
        note:Destroy()
    end)
end

return MacUI
