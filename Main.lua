-- join Discord: https://discord.gg/cQywVqjcyj
local MacUI = {}

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ConfigFolder = "MacUI_Configs"
local SavedConfigs = {}

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

local function SaveConfig(fileName, data)
    if not isfolder(ConfigFolder) then
        makefolder(ConfigFolder)
    end
    local filePath = ConfigFolder .. "/" .. fileName .. ".json"
    writefile(filePath, HttpService:JSONEncode(data))
    print("[MacUI Config] Saved to:", filePath)
    print("[MacUI Config] Check your executor's workspace folder!")
end

local function LoadConfig(fileName)
    if isfile(ConfigFolder .. "/" .. fileName .. ".json") then
        return HttpService:JSONDecode(readfile(ConfigFolder .. "/" .. fileName .. ".json"))
    end
    return nil
end

local function initKeySystemLibraries()
    local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;return {sha256=Z}
end

local KeySystemLibs = initKeySystemLibraries()
local sha256 = KeySystemLibs.sha256

local KeyServices = {}

KeyServices.custom = {
    Name = "Custom Link",
    Args = {"GetKeyLink"},
    New = function(getKeyLink)
        local fSetClipboard = setclipboard or toclipboard
        return {
            Verify = function(key)
                return true, "Manual verification"
            end,
            Copy = function()
                local success = pcall(function()
                    fSetClipboard(getKeyLink)
                end)
                return success
            end,
            GetLink = function()
                return getKeyLink
            end
        }
    end
}
  
KeyServices.platoboost = {
    Name = "Platoboost",
    Args = {"ServiceId", "Secret"},
    New = function(serviceId, secret)
        local fSetClipboard = setclipboard or toclipboard or syn and syn.set_clipboard
        local fRequest = request or http_request or syn_request
        local fGetHwid = gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
        
        local cachedUrl = ""
        local lastCacheTime = 0
        
        local host = "https://api.platoboost.com"
        local success, connectTest = pcall(function()
            return fRequest({
                Url = host .. "/public/connectivity",
                Method = "GET"
            })
        end)
        if not success or (connectTest and connectTest.StatusCode ~= 200 and connectTest.StatusCode ~= 429) then
            host = "https://api.platoboost.net"
        end
        
        local function cacheLink()
            if lastCacheTime + 600 < os.time() then
                local success, response = pcall(function()
                    return fRequest({
                        Url = host .. "/public/start",
                        Method = "POST",
                        Body = HttpService:JSONEncode({
                            service = serviceId,
                            identifier = sha256(tostring(fGetHwid()))
                        }),
                        Headers = {
                            ["Content-Type"] = "application/json",
                            ["User-Agent"] = "Roblox/Exploit"
                        }
                    })
                end)
                
                if success and response and response.StatusCode == 200 then
                    local decoded = HttpService:JSONDecode(response.Body)
                    if decoded.success and decoded.data.url then
                        cachedUrl = decoded.data.url
                        lastCacheTime = os.time()
                        return true, cachedUrl
                    end
                end
                return false, "Failed to get key link"
            else
                return true, cachedUrl
            end
        end
        
        cacheLink()
        
        return {
            Verify = function(key)
                local function generateNonce()
                    local nonce = ""
                    for i = 1, 16 do
                        nonce = nonce .. string.char(math.floor(math.random() * 26) + 97)
                    end
                    return nonce
                end
                
                local nonce = generateNonce()
                local body = {
                    identifier = sha256(tostring(fGetHwid())),
                    key = key,
                    nonce = nonce
                }
                
                local success, response = pcall(function()
                    return fRequest({
                        Url = host .. "/public/redeem/" .. tostring(serviceId),
                        Method = "POST",
                        Body = HttpService:JSONEncode(body),
                        Headers = {["Content-Type"] = "application/json"}
                    })
                end)
                
                if success and response and response.StatusCode == 200 then
                    local decoded = HttpService:JSONDecode(response.Body)
                    if decoded.success and decoded.data.valid then
                        if decoded.data.hash == sha256("true-" .. nonce .. "-" .. secret) then
                            return true, "Key verified!"
                        end
                    end
                end
                return false, "Invalid key"
            end,
            Copy = function()
                local success, url = cacheLink()
                if success and url and url ~= "" then
                    if fSetClipboard then
                        pcall(function() fSetClipboard(url) end)
                        return true
                    end
                end
                return false
            end
        }
    end
}

KeyServices.pandadevelopment = {
    Name = "Panda Development",
    Args = {"ServiceId"},
    New = function(serviceId)
        local fSetClipboard = setclipboard or toclipboard
        local fRequest = request or http_request or syn_request
        local fGetHwid = gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
        
        local function getKeyLink()
            return "https://pandadevelopment.net/getkey?service=" .. tostring(serviceId) .. "&hwid=" .. tostring(fGetHwid())
        end
        
        return {
            Verify = function(key)
                local url = "https://pandadevelopment.net/v2_validation?key=" .. tostring(key) .. "&service=" .. tostring(serviceId) .. "&hwid=" .. tostring(fGetHwid())
                
                local success, response = pcall(function()
                    return fRequest({
                        Url = url,
                        Method = "GET",
                        Headers = {["User-Agent"] = "Roblox/Exploit"}
                    })
                end)
                
                if success and response and response.Success then
                    local decoded = HttpService:JSONDecode(response.Body)
                    if decoded.V2_Authentication == "success" then
                        return true, "Authenticated!"
                    else
                        return false, decoded.Key_Information and decoded.Key_Information.Notes or "Invalid key"
                    end
                end
                return false, "Verification failed"
            end,
            Copy = function()
                local success = pcall(function() 
                    fSetClipboard(getKeyLink())
                end)
                return success
            end,
            GetLink = function()
                return getKeyLink()
            end
        }
    end
}

KeyServices.luarmor = {
    Name = "Luarmor",
    Args = {"ScriptId", "Discord"},
    New = function(scriptId, discord)
        local fSetClipboard = setclipboard or toclipboard
        local apiUrl = "https://sdkapi-public.luarmor.net/library.lua"
        
        local API
        local success = pcall(function()
            API = loadstring(
                game.HttpGetAsync and game:HttpGetAsync(apiUrl) or HttpService:GetAsync(apiUrl)
            )()
            API.script_id = scriptId
        end)
        
        if not success then
            return {
                Verify = function() return false, "Failed to load Luarmor API" end,
                Copy = function() fSetClipboard(tostring(discord)) end
            }
        end
        
        return {
            Verify = function(key)
                local status = API.check_key(key)
                if status.code == "KEY_VALID" then
                    return true, "Whitelisted!"
                elseif status.code == "KEY_HWID_LOCKED" then
                    return false, "Key linked to different HWID"
                else
                    return false, "Invalid key"
                end
            end,
            Copy = function()
                local success = pcall(function()
                    fSetClipboard(tostring(discord))
                end)
                return success
            end
        }
    end
}

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
    
    tween(Progress, 1.5, { Size = UDim2.new(1, 0, 1, 0) })
    
    task.delay(1.5, function()
        tween(LoadingFrame, 0.3, { BackgroundTransparency = 1 })
        tween(Title, 0.3, { TextTransparency = 1 })
        tween(Subtitle, 0.3, { TextTransparency = 1 })
        wait(0.3)
        LoadingGui:Destroy()
    end)
end

local function CreateKeySystem(config, callback)
    local keySettings = config.KeySettings or {}
    local keyAccepted = false
    
    local KeyGui = create("ScreenGui", {
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        Name = "MacUI_KeySystem",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })
    
    local KeyFrame = create("Frame", {
        Parent = KeyGui,
        Size = UDim2.new(0, 420, 0, 340),
        Position = UDim2.new(0.5, -210, 0.5, -170),
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
        Text = keySettings.Subtitle or "Enter your key to continue",
        TextColor3 = Color3.fromRGB(100, 100, 105),
        Font = Enum.Font.Gotham,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local KeyNote = create("TextLabel", {
        Parent = KeyFrame,
        Size = UDim2.new(1, -40, 0, 40),
        Position = UDim2.new(0, 20, 0, 95),
        BackgroundColor3 = Color3.fromRGB(255, 245, 200),
        Text = "  " .. (keySettings.Note or "Click 'Get Key' to obtain your key"),
        TextColor3 = Color3.fromRGB(100, 80, 0),
        Font = Enum.Font.Gotham,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    })
    create("UICorner", { Parent = KeyNote, CornerRadius = UDim.new(0, 8) })
    
    local GetKeyBtn = create("TextButton", {
        Parent = KeyFrame,
        Size = UDim2.new(1, -40, 0, 38),
        Position = UDim2.new(0, 20, 0, 150),
        BackgroundColor3 = Color3.fromRGB(52, 199, 89),
        BorderSizePixel = 0,
        Text = "Get Key",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        AutoButtonColor = false
    })
    create("UICorner", { Parent = GetKeyBtn, CornerRadius = UDim.new(0, 8) })
    
    local serviceHandler = nil
    if keySettings.Service then
        local serviceType = keySettings.Service:lower()
        local serviceModule = KeyServices[serviceType]
        
        if serviceModule then
            local args = {}
            for _, argName in ipairs(serviceModule.Args) do
                table.insert(args, keySettings[argName])
            end
            serviceHandler = serviceModule.New(table.unpack(args))
        end
    end
    
    GetKeyBtn.MouseButton1Click:Connect(function()
        local copySuccess = false
        
        if serviceHandler and serviceHandler.Copy then
            copySuccess = serviceHandler.Copy()
        elseif keySettings.KeyLink then
            local success = pcall(function()
                local fSetClipboard = setclipboard or toclipboard
                fSetClipboard(keySettings.KeyLink)
            end)
            copySuccess = success
        end
        
        if copySuccess then
            GetKeyBtn.Text = "✓ Link Copied!"
            GetKeyBtn.BackgroundColor3 = Color3.fromRGB(52, 199, 89)
            
            pcall(function()
                MacUI:Notify({
                    Title = "Key System",
                    Content = "Key link copied to clipboard",
                    Duration = 3
                })
            end)
            
            task.wait(1.5)
            GetKeyBtn.Text = "Get Key"
            GetKeyBtn.BackgroundColor3 = Color3.fromRGB(52, 199, 89)
        else
            GetKeyBtn.Text = "Failed"
            GetKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 69, 58)
            
            pcall(function()
                MacUI:Notify({
                    Title = "Key System Error",
                    Content = "Failed to get key link. Please try again.",
                    Duration = 3
                })
            end)
            
            task.wait(1.5)
            GetKeyBtn.Text = "Get Key"
            GetKeyBtn.BackgroundColor3 = Color3.fromRGB(52, 199, 89)
        end
    end)
    
    local KeyInput = create("TextBox", {
        Parent = KeyFrame,
        Size = UDim2.new(1, -40, 0, 38),
        Position = UDim2.new(0, 20, 0, 200),
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
        Position = UDim2.new(0, 20, 0, 250),
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
        Position = UDim2.new(0, 20, 0, 300),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 59, 48),
        Font = Enum.Font.GothamMedium,
        TextSize = 12
    })
    
    local function CheckKey(key)
        if serviceHandler and serviceHandler.Verify then
            local success, message = serviceHandler.Verify(key)
            if not success then
                StatusLabel.Text = message or "Invalid key"
            end
            return success
        else
            local validKeys = keySettings.Key or {"Hello"}
            if type(validKeys) == "string" then
                validKeys = {validKeys}
            end
            for _, validKey in ipairs(validKeys) do
                if key == validKey then
                    return true
                end
            end
            return false
        end
    end
    
    SubmitBtn.MouseButton1Click:Connect(function()
        local enteredKey = KeyInput.Text
        if CheckKey(enteredKey) then
            StatusLabel.Text = "✓ Key accepted! Loading..."
            StatusLabel.TextColor3 = Color3.fromRGB(52, 199, 89)
            
            if keySettings.SaveKey then
                SaveConfig(keySettings.FileName or "MacUI_Key", { Key = enteredKey })
            end
            
            keyAccepted = true
            wait(0.5)
            tween(KeyFrame, 0.3, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0) })
            wait(0.3)
            KeyGui:Destroy()
            
            if callback then
                callback(true)
            end
        else
            if not StatusLabel.Text or StatusLabel.Text == "" then
                StatusLabel.Text = "✗ Invalid key!"
            end
            StatusLabel.TextColor3 = Color3.fromRGB(255, 59, 48)
        end
    end)
    
    if keySettings.SaveKey then
        local saved = LoadConfig(keySettings.FileName or "MacUI_Key")
        if saved and CheckKey(saved.Key) then
            KeyGui:Destroy()
            if callback then
                callback(true)
            end
            return
        end
    end
end

function MacUI:Window(config)
    local self = {}
    self.Tabs = {}
    self.Visible = true
    self.SelectedTab = nil
    self.CurrentTab = nil
    self.OnTabChangeCallbacks = {}
    self.NotifyFromBottom = config.NotifyFromBottom or false
    config = config or {}
    
    local MainFrame
    local ScreenGui
    
    ScreenGui = create("ScreenGui", {
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        Name = config.Name or "MacUI_" .. HttpService:GenerateGUID(false),
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })
    
    if config.KeySystem then
        ScreenGui.Enabled = false
    end
    
    local function InitializeUI()
        if config.LoadingTitle or config.LoadingSubtitle then
            CreateLoadingScreen(config)
            wait(1.5)
        end
    
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
    
    local Themes = {
        Default = {
            Background = Color3.fromRGB(240, 240, 245),
            Sidebar = Color3.fromRGB(225, 225, 230),
            TitleBar = Color3.fromRGB(230, 230, 235),
            Content = Color3.fromRGB(248, 248, 252),
            Accent = Color3.fromRGB(10, 132, 255),
            TabInactive = Color3.fromRGB(210, 210, 215),
            TabActive = Color3.fromRGB(10, 132, 255),
            TextInactive = Color3.fromRGB(80, 80, 85),
            TextActive = Color3.fromRGB(255, 255, 255),
            TabStrokeInactive = Color3.fromRGB(200, 200, 205),
            TabStrokeActive = Color3.fromRGB(10, 132, 255)
        },
        Dark = {
            Background = Color3.fromRGB(30, 30, 35),
            Sidebar = Color3.fromRGB(25, 25, 30),
            TitleBar = Color3.fromRGB(35, 35, 40),
            Content = Color3.fromRGB(28, 28, 33),
            Accent = Color3.fromRGB(10, 132, 255),
            TabInactive = Color3.fromRGB(35, 35, 40),
            TabActive = Color3.fromRGB(10, 132, 255),
            TextInactive = Color3.fromRGB(120, 120, 125),
            TextActive = Color3.fromRGB(255, 255, 255),
            TabStrokeInactive = Color3.fromRGB(255, 255, 255),
            TabStrokeActive = Color3.fromRGB(255, 255, 255)
        },
        Ocean = {
            Background = Color3.fromRGB(230, 240, 250),
            Sidebar = Color3.fromRGB(215, 230, 245),
            TitleBar = Color3.fromRGB(220, 235, 250),
            Content = Color3.fromRGB(238, 245, 252),
            Accent = Color3.fromRGB(0, 122, 255),
            TabInactive = Color3.fromRGB(200, 220, 240),
            TabActive = Color3.fromRGB(0, 122, 255),
            TextInactive = Color3.fromRGB(80, 100, 120),
            TextActive = Color3.fromRGB(255, 255, 255),
            TabStrokeInactive = Color3.fromRGB(180, 200, 220),
            TabStrokeActive = Color3.fromRGB(0, 122, 255)
        }
    }
    
    local currentTheme = Themes[config.Theme] or Themes.Default

    MainFrame = create("Frame", {
        Parent = ScreenGui,
        Size = config.Size or UDim2.new(0, 600, 0, 400),
        BackgroundColor3 = currentTheme.Background,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -300, 0.5, -200)
    })
    MainFrame.ClipsDescendants = true
    create("UICorner", { Parent = MainFrame, CornerRadius = UDim.new(0, 14) })
    
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

    if config.Icon and config.Icon ~= 0 then
        local iconUrl = config.Icon
        if type(config.Icon) == "number" then
            iconUrl = "rbxassetid://" .. config.Icon
        elseif type(config.Icon) == "string" then
            if config.Icon:match("^http") or config.Icon:match("^rbxassetid://") or config.Icon:match("^rbxthumb://") then
                iconUrl = config.Icon
            elseif tonumber(config.Icon) then
                iconUrl = "rbxassetid://" .. config.Icon
            else
                iconUrl = config.Icon
            end
        end
        
        local IconImage = create("ImageLabel", {
            Parent = TitleBar,
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 80, 0.5, -10),
            BackgroundTransparency = 1,
            Image = iconUrl
        })
    end

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
        
        RunService.RenderStepped:Connect(function()
            if not self.Visible then
                ShowButton.Visible = true
            end
        end)
    end

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

    local ContentFrame = create("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(1, -160, 1, -32),
        Position = UDim2.new(0, 160, 0, 32),
        BackgroundColor3 = currentTheme.Content,
        BorderSizePixel = 0
    })
    create("UICorner", { Parent = ContentFrame, CornerRadius = UDim.new(0, 14) })
    
    local ContentMask = create("Frame", {
        Parent = ContentFrame,
        Size = UDim2.new(0, 14, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = currentTheme.Content,
        BorderSizePixel = 0
    })

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

    function self:SelectTab(index)
        if not self.Tabs[index] then
            warn("[MacUI] Tab index " .. tostring(index) .. " does not exist")
            return
        end
        
        if self.Tabs[index].Locked then
            return
        end
        
        local previousTab = self.SelectedTab
        self.SelectedTab = index
        self.CurrentTab = index
        
        for i, tab in ipairs(self.Tabs) do
            if tab.Page and typeof(tab.Page) == "Instance" then
                tab.Page.Visible = false
            end
            
            if tab.Button and typeof(tab.Button) == "Instance" then
                tween(tab.Button, 0.2, { BackgroundColor3 = currentTheme.TabInactive })
                
                if not tab.Label then
                    tab.Button.TextColor3 = currentTheme.TextInactive
                end
            end
            
            if tab.Label and typeof(tab.Label) == "Instance" then
                tween(tab.Label, 0.2, { TextColor3 = currentTheme.TextInactive })
            end
            
            if tab.Icon and typeof(tab.Icon) == "Instance" then
                tween(tab.Icon, 0.2, { ImageColor3 = currentTheme.TextInactive })
            end
            
            if tab.Stroke and typeof(tab.Stroke) == "Instance" then
                tween(tab.Stroke, 0.2, { 
                    Color = currentTheme.TabStrokeInactive,
                    Transparency = config.Theme == "Dark" and 0.8 or 0.5 
                })
            end
        end
        
        local selectedTab = self.Tabs[index]
        if selectedTab.Page and typeof(selectedTab.Page) == "Instance" then
            selectedTab.Page.Visible = true
        end
        
        if selectedTab.Button and typeof(selectedTab.Button) == "Instance" then
            tween(selectedTab.Button, 0.2, { BackgroundColor3 = currentTheme.TabActive })
            
            if not selectedTab.Label then
                selectedTab.Button.TextColor3 = currentTheme.TextActive
            end
        end
        
        if selectedTab.Label and typeof(selectedTab.Label) == "Instance" then
            tween(selectedTab.Label, 0.2, { TextColor3 = currentTheme.TextActive })
        end
        
        if selectedTab.Icon and typeof(selectedTab.Icon) == "Instance" then
            tween(selectedTab.Icon, 0.2, { ImageColor3 = currentTheme.TextActive })
        end
        
        if selectedTab.Stroke and typeof(selectedTab.Stroke) == "Instance" then
            tween(selectedTab.Stroke, 0.2, { 
                Color = currentTheme.TabStrokeActive,
                Transparency = 0 
            })
        end
        
        for _, callback in pairs(self.OnTabChangeCallbacks) do
            pcall(callback, index, previousTab)
        end
    end
    
    function self:OnTabChange(callback)
        table.insert(self.OnTabChangeCallbacks, callback)
    end

    function self:Tab(name, icon)
        local tab = {}
        local tabIndex = #self.Tabs + 1
        
        local Button = create("TextButton", {
            Parent = TabButtons,
            Size = UDim2.new(1, -10, 0, 36),
            BackgroundColor3 = currentTheme.TabInactive,
            BorderSizePixel = 0,
            Text = "",
            TextColor3 = currentTheme.TextInactive,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            AutoButtonColor = false,
            ZIndex = 3
        })
        create("UICorner", { Parent = Button, CornerRadius = UDim.new(0, 8) })
        
        local tabStroke = create("UIStroke", {
            Parent = Button,
            Thickness = 3,
            Color = currentTheme.TabStrokeInactive,
            Transparency = config.Theme == "Dark" and 0.8 or 0.5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
        
        if icon then
            local tabIconUrl = icon
            if type(icon) == "number" then
                tabIconUrl = "rbxassetid://" .. icon
            elseif type(icon) == "string" then
                if icon:match("^http") or icon:match("^rbxassetid://") or icon:match("^rbxthumb://") then
                    tabIconUrl = icon
                elseif tonumber(icon) then
                    tabIconUrl = "rbxassetid://" .. icon
                else
                    tabIconUrl = icon
                end
            end
            
            local TabIcon = create("ImageLabel", {
                Parent = Button,
                Size = UDim2.new(0, 18, 0, 18),
                Position = UDim2.new(0, 8, 0.5, -9),
                BackgroundTransparency = 1,
                Image = tabIconUrl,
                ImageColor3 = currentTheme.TextInactive,
                ZIndex = 10
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
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 10
            })
            
            tab.Icon = TabIcon
            tab.Label = TabLabel
            tab.Stroke = tabStroke
        else
            Button.Text = name
            tab.Stroke = tabStroke
        end

        local TabPage = create("ScrollingFrame", {
            Parent = ContentFrame,
            Name = name .. "_Page",
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

        Button.MouseButton1Click:Connect(function()
            self:SelectTab(tabIndex)
        end)
        
        Button.MouseEnter:Connect(function()
            if self.SelectedTab ~= tabIndex then
                tween(Button, 0.15, { BackgroundColor3 = Color3.new(
                    currentTheme.TabInactive.R * 0.95,
                    currentTheme.TabInactive.G * 0.95,
                    currentTheme.TabInactive.B * 0.95
                )})
            end
        end)
        
        Button.MouseLeave:Connect(function()
            if self.SelectedTab ~= tabIndex then
                tween(Button, 0.15, { BackgroundColor3 = currentTheme.TabInactive })
            end
        end)

        tab.Page = TabPage
        tab.Button = Button
        tab.Index = tabIndex
        tab.Name = name
        tab.Locked = false
        table.insert(self.Tabs, tab)

        if #self.Tabs == 1 then
            task.spawn(function()
                task.wait(0.1)
                self:SelectTab(1)
            end)
        end

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
        
        function tab:Divider()
            local divider = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 1),
                BackgroundColor3 = Color3.fromRGB(200, 200, 205),
                BorderSizePixel = 0
            })
            
            return divider
        end
        
        function tab:Paragraph(cfg)
            local paragraph = create("TextLabel", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Text or "Paragraph text here...",
                TextColor3 = Color3.fromRGB(80, 80, 85),
                Font = Enum.Font.Gotham,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            create("UIPadding", {
                Parent = paragraph,
                PaddingTop = UDim.new(0, 5),
                PaddingBottom = UDim.new(0, 5)
            })
            
            return paragraph
        end
        
        function tab:Label(cfg)
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 32),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local label = create("TextLabel", {
                Parent = holder,
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Text or "Label",
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local labelAPI = {}
            
            function labelAPI:SetText(newText)
                label.Text = type(newText) == "string" and newText or tostring(newText)
            end
            
            function labelAPI:Destroy()
                holder:Destroy()
            end
            
            return labelAPI
        end
        
        function tab:Image(cfg)
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, cfg.Height or 150),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local imageUrl = cfg.Image or ""
            if type(cfg.Image) == "number" then
                imageUrl = "rbxassetid://" .. cfg.Image
            elseif type(cfg.Image) == "string" then
                if cfg.Image:match("^http") or cfg.Image:match("^rbxassetid://") or cfg.Image:match("^rbxthumb://") then
                    imageUrl = cfg.Image
                elseif tonumber(cfg.Image) then
                    imageUrl = "rbxassetid://" .. cfg.Image
                else
                    imageUrl = cfg.Image
                end
            end
            
            local image = create("ImageLabel", {
                Parent = holder,
                Size = UDim2.new(1, -10, 1, -10),
                Position = UDim2.new(0, 5, 0, 5),
                BackgroundTransparency = 1,
                Image = imageUrl,
                ScaleType = cfg.ScaleType or Enum.ScaleType.Fit
            })
            create("UICorner", { Parent = image, CornerRadius = UDim.new(0, 6) })
            
            local imageAPI = {
                SetImage = function(newImage)
                    local newUrl = newImage
                    if type(newImage) == "number" then
                        newUrl = "rbxassetid://" .. newImage
                    elseif type(newImage) == "string" then
                        if newImage:match("^http") or newImage:match("^rbxassetid://") or newImage:match("^rbxthumb://") then
                            newUrl = newImage
                        elseif tonumber(newImage) then
                            newUrl = "rbxassetid://" .. newImage
                        else
                            newUrl = newImage
                        end
                    end
                    image.Image = newUrl
                end,
                Destroy = function()
                    holder:Destroy()
                end
            }
            
            return imageAPI
        end
        
        function tab:Button(cfg)
            local currentCallback = cfg.Callback
            local isLocked = cfg.Locked or false
            local currentTitle = cfg.Title or "Button"
            local currentDesc = cfg.Desc
            
            local holder = create("Frame", {
                Parent = TabPage,
                Size = currentDesc and UDim2.new(1, -20, 0, 60) or UDim2.new(1, -20, 0, 38),
                BackgroundTransparency = 1
            })
            
            local btn = create("TextButton", {
                Parent = holder,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = isLocked and Color3.fromRGB(180, 180, 185) or currentTheme.Accent,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false
            })
            create("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 8) })
            
            local titleLabel = create("TextLabel", {
                Parent = btn,
                Size = currentDesc and UDim2.new(1, -20, 0, 20) or UDim2.new(1, -20, 1, 0),
                Position = currentDesc and UDim2.new(0, 10, 0, 8) or UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = currentTitle,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local descLabel
            if currentDesc then
                descLabel = create("TextLabel", {
                    Parent = btn,
                    Size = UDim2.new(1, -20, 0, 18),
                    Position = UDim2.new(0, 10, 0, 30),
                    BackgroundTransparency = 1,
                    Text = currentDesc,
                    TextColor3 = Color3.fromRGB(230, 230, 235),
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
            end
            
            local lockIcon
            if isLocked then
                lockIcon = create("TextLabel", {
                    Parent = btn,
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(1, -30, 0.5, -10),
                    BackgroundTransparency = 1,
                    Text = "🔒",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    Font = Enum.Font.GothamBold,
                    TextSize = 14
                })
            end
            
            btn.MouseEnter:Connect(function()
                if not isLocked then
                    tween(btn, 0.2, { BackgroundColor3 = Color3.new(
                        currentTheme.Accent.R * 0.85,
                        currentTheme.Accent.G * 0.85,
                        currentTheme.Accent.B * 0.85
                    )})
                end
            end)
            
            btn.MouseLeave:Connect(function()
                if not isLocked then
                    tween(btn, 0.2, { BackgroundColor3 = currentTheme.Accent })
                end
            end)
            
            btn.MouseButton1Click:Connect(function()
                if isLocked then return end
                if currentCallback then
                    local success, errorMsg = pcall(function()
                        currentCallback()
                    end)
                    
                    if not success then
                        MacUI:Notify({
                            Title = "Script Error",
                            Content = tostring(errorMsg):sub(1, 100),
                            Duration = 6
                        })
                    end
                end
            end)
            
            local buttonAPI = {
                SetTitle = function(newTitle)
                    currentTitle = newTitle
                    titleLabel.Text = newTitle
                end,
                
                SetDesc = function(newDesc)
                    currentDesc = newDesc
                    if newDesc and newDesc ~= "" then
                        if not descLabel then
                            descLabel = create("TextLabel", {
                                Parent = btn,
                                Size = UDim2.new(1, -20, 0, 18),
                                Position = UDim2.new(0, 10, 0, 30),
                                BackgroundTransparency = 1,
                                Text = newDesc,
                                TextColor3 = Color3.fromRGB(230, 230, 235),
                                Font = Enum.Font.Gotham,
                                TextSize = 12,
                                TextXAlignment = Enum.TextXAlignment.Left
                            })
                            titleLabel.Size = UDim2.new(1, -20, 0, 20)
                            titleLabel.Position = UDim2.new(0, 10, 0, 8)
                            holder.Size = UDim2.new(1, -20, 0, 60)
                            btn.Size = UDim2.new(1, 0, 1, 0)
                        else
                            descLabel.Text = newDesc
                        end
                    elseif descLabel then
                        descLabel:Destroy()
                        descLabel = nil
                        titleLabel.Size = UDim2.new(1, -20, 1, 0)
                        titleLabel.Position = UDim2.new(0, 10, 0, 0)
                        holder.Size = UDim2.new(1, -20, 0, 38)
                        btn.Size = UDim2.new(1, 0, 1, 0)
                    end
                end,
                
                SetCallback = function(newCallback)
                    currentCallback = newCallback
                end,
                
                Lock = function()
                    isLocked = true
                    btn.BackgroundColor3 = Color3.fromRGB(180, 180, 185)
                    if not lockIcon then
                        lockIcon = create("TextLabel", {
                            Parent = btn,
                            Size = UDim2.new(0, 20, 0, 20),
                            Position = UDim2.new(1, -30, 0.5, -10),
                            BackgroundTransparency = 1,
                            Text = "🔒",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            Font = Enum.Font.GothamBold,
                            TextSize = 14
                        })
                    end
                end,
                
                Unlock = function()
                    isLocked = false
                    btn.BackgroundColor3 = currentTheme.Accent
                    if lockIcon then
                        lockIcon:Destroy()
                        lockIcon = nil
                    end
                end,
                
                Destroy = function()
                    holder:Destroy()
                end
            }
            
            return buttonAPI
        end
        
        function tab:Toggle(cfg)
            local toggleState = cfg.Default or false
            
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 38),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local label = create("TextLabel", {
                Parent = holder,
                Size = UDim2.new(1, -70, 1, 0),
                Position = UDim2.new(0, 15, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Title or "Toggle",
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local toggleBg = create("Frame", {
                Parent = holder,
                Size = UDim2.new(0, 50, 0, 28),
                Position = UDim2.new(1, -60, 0.5, -14),
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
                
                if self.ConfigData and cfg.Flag then
                    self.ConfigData[cfg.Flag] = toggleState
                    if self.SaveConfig then self.SaveConfig() end
                end
            end)
            
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] ~= nil then
                toggleState = self.ConfigData[cfg.Flag]
                toggleBg.BackgroundColor3 = toggleState and Color3.fromRGB(52, 199, 89) or Color3.fromRGB(200, 200, 205)
                toggleKnob.Position = toggleState and UDim2.new(1, -26, 0.5, -12) or UDim2.new(0, 2, 0.5, -12)
            end
            
            local toggleAPI = {
                Set = function(value)
                    toggleState = value
                    tween(toggleBg, 0.2, { 
                        BackgroundColor3 = toggleState and Color3.fromRGB(52, 199, 89) or Color3.fromRGB(200, 200, 205)
                    })
                    tween(toggleKnob, 0.2, {
                        Position = toggleState and UDim2.new(1, -26, 0.5, -12) or UDim2.new(0, 2, 0.5, -12)
                    })
                    if cfg.Callback then cfg.Callback(toggleState) end
                    if self.ConfigData and cfg.Flag then
                        self.ConfigData[cfg.Flag] = toggleState
                        if self.SaveConfig then self.SaveConfig() end
                    end
                end,
                
                Get = function()
                    return toggleState
                end,
                
                Destroy = function()
                    holder:Destroy()
                end
            }

            return toggleAPI
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
                
                if self.ConfigData and cfg.Flag then
                    self.ConfigData[cfg.Flag] = input.Text
                    if self.SaveConfig then self.SaveConfig() end
                end
            end)
            
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
            local min = cfg.Min
            if min == nil then min = 0 end
            local max = cfg.Max
            if max == nil then max = 100 end
            local value = cfg.Default
            if value == nil then value = min end

            local isDecimal = (min % 1 ~= 0) or (max % 1 ~= 0) or (cfg.Decimals and cfg.Decimals > 0)
local decimals = cfg.Decimals or 2

local function roundValue(val)
    if isDecimal then
        local mult = 10^decimals
        return math.floor(val * mult + 0.5) / mult
    else
        return math.floor(val)
    end
                end
            
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
                value = roundValue(min + (max - min) * pos)
                
                valueLabel.Text = tostring(value)
                sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                sliderKnob.Position = UDim2.new(pos, -9, 0.5, -9)
                
                if cfg.Callback then cfg.Callback(value) end
                
                if self.ConfigData and cfg.Flag then
                    self.ConfigData[cfg.Flag] = value
                    if self.SaveConfig then self.SaveConfig() end
                end
            end
            
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
            
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] then
                value = self.ConfigData[cfg.Flag]
                valueLabel.Text = tostring(value)
                local pos = (value - min) / (max - min)
                sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                sliderKnob.Position = UDim2.new(pos, -9, 0.5, -9)
            end
            
            local sliderAPI = {
                Set = function(newValue)
                    value = math.clamp(newValue, min, max)
                    valueLabel.Text = tostring(value)
                    local pos = (value - min) / (max - min)
                    tween(sliderFill, 0.2, { Size = UDim2.new(pos, 0, 1, 0) })
                    tween(sliderKnob, 0.2, { Position = UDim2.new(pos, -9, 0.5, -9) })
                    if cfg.Callback then cfg.Callback(value) end
                    if self.ConfigData and cfg.Flag then
                        self.ConfigData[cfg.Flag] = value
                        if self.SaveConfig then self.SaveConfig() end
                    end
                end,
                
                Get = function()
                    return value
                end,
                
                SetMin = function(newMin)
                    min = newMin
                    if value < min then
                        value = min
                    end
                    local pos = (value - min) / (max - min)
                    sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    sliderKnob.Position = UDim2.new(pos, -9, 0.5, -9)
                    valueLabel.Text = tostring(value)
                end,
                
                SetMax = function(newMax)
                    max = newMax
                    if value > max then
                        value = max
                    end
                    local pos = (value - min) / (max - min)
                    sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    sliderKnob.Position = UDim2.new(pos, -9, 0.5, -9)
                    valueLabel.Text = tostring(value)
                end,
                
                Destroy = function()
                    holder:Destroy()
                end
            }
            
            return sliderAPI
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
                ScrollBarImageColor3 = Color3.fromRGB(200, 200, 205),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y
            })
            
            local listLayout = create("UIListLayout", {
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
                    local maxHeight = math.min(optionCount * 34 + 8, cfg.MaxHeight or 250)
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
                        
                        if self.ConfigData and cfg.Flag then
                            self.ConfigData[cfg.Flag] = currentKey
                            if self.SaveConfig then self.SaveConfig() end
                        end
                    end
                end
            end)
            
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] then
                currentKey = self.ConfigData[cfg.Flag]
                keyBtn.Text = currentKey
            end
            
            return holder
        end
        
        function tab:ColorPicker(cfg)
            local selectedColor = cfg.Default or Color3.fromRGB(255, 0, 0)
            local isOpen = false
            
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 38),
                BackgroundTransparency = 1
            })
            
            local mainBtn = create("TextButton", {
                Parent = holder,
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false
            })
            create("UICorner", { Parent = mainBtn, CornerRadius = UDim.new(0, 8) })
            
            local label = create("TextLabel", {
                Parent = mainBtn,
                Size = UDim2.new(1, -70, 1, 0),
                Position = UDim2.new(0, 15, 0, 0),
                BackgroundTransparency = 1,
                Text = cfg.Title or "Color Picker",
                TextColor3 = Color3.fromRGB(50, 50, 55),
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local colorDisplay = create("Frame", {
                Parent = mainBtn,
                Size = UDim2.new(0, 40, 0, 28),
                Position = UDim2.new(1, -50, 0.5, -14),
                BackgroundColor3 = selectedColor,
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = colorDisplay, CornerRadius = UDim.new(0, 6) })
            create("UIStroke", { 
                Parent = colorDisplay, 
                Thickness = 2, 
                Color = Color3.fromRGB(220, 220, 225)
            })
            
            local pickerFrame = create("Frame", {
                Parent = holder,
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 42),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ClipsDescendants = true,
                Visible = false
            })
            create("UICorner", { Parent = pickerFrame, CornerRadius = UDim.new(0, 8) })
            create("UIStroke", { 
                Parent = pickerFrame, 
                Thickness = 1, 
                Color = Color3.fromRGB(220, 220, 225)
            })
            
            local hue, sat, val = 0, 1, 1
            local r, g, b = selectedColor.R * 255, selectedColor.G * 255, selectedColor.B * 255
            
            local function RGBToHSV(r, g, b)
                r, g, b = r / 255, g / 255, b / 255
                local max, min = math.max(r, g, b), math.min(r, g, b)
                local h, s, v = 0, 0, max
                local d = max - min
                s = max == 0 and 0 or d / max
                
                if max ~= min then
                    if max == r then
                        h = (g - b) / d + (g < b and 6 or 0)
                    elseif max == g then
                        h = (b - r) / d + 2
                    elseif max == b then
                        h = (r - g) / d + 4
                    end
                    h = h / 6
                end
                
                return h, s, v
            end
            
            local function HSVToRGB(h, s, v)
                local r, g, b
                
                local i = math.floor(h * 6)
                local f = h * 6 - i
                local p = v * (1 - s)
                local q = v * (1 - f * s)
                local t = v * (1 - (1 - f) * s)
                
                i = i % 6
                
                if i == 0 then r, g, b = v, t, p
                elseif i == 1 then r, g, b = q, v, p
                elseif i == 2 then r, g, b = p, v, t
                elseif i == 3 then r, g, b = p, q, v
                elseif i == 4 then r, g, b = t, p, v
                elseif i == 5 then r, g, b = v, p, q
                end
                
                return Color3.fromRGB(r * 255, g * 255, b * 255)
            end
            
            hue, sat, val = RGBToHSV(r, g, b)
            
            local satValPicker = create("Frame", {
                Parent = pickerFrame,
                Size = UDim2.new(1, -60, 0, 150),
                Position = UDim2.new(0, 10, 0, 10),
                BackgroundColor3 = HSVToRGB(hue, 1, 1),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = satValPicker, CornerRadius = UDim.new(0, 6) })
            
            local satGradient = create("Frame", {
                Parent = satValPicker,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 0
            })
            create("UICorner", { Parent = satGradient, CornerRadius = UDim.new(0, 6) })
            create("UIGradient", {
                Parent = satGradient,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1)
                })
            })
            
            local valGradient = create("Frame", {
                Parent = satValPicker,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 0
            })
            create("UICorner", { Parent = valGradient, CornerRadius = UDim.new(0, 6) })
            create("UIGradient", {
                Parent = valGradient,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                }),
                Rotation = 90
            })
            
            local hueSlider = create("Frame", {
                Parent = pickerFrame,
                Size = UDim2.new(0, 30, 0, 150),
                Position = UDim2.new(1, -40, 0, 10),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = hueSlider, CornerRadius = UDim.new(0, 6) })
            create("UIGradient", {
                Parent = hueSlider,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
                }),
                Rotation = 90
            })
            
            local function updateColor()
                selectedColor = HSVToRGB(hue, sat, val)
                colorDisplay.BackgroundColor3 = selectedColor
                satValPicker.BackgroundColor3 = HSVToRGB(hue, 1, 1)
                
                if cfg.Callback then cfg.Callback(selectedColor) end
                
                if self.ConfigData and cfg.Flag then
                    self.ConfigData[cfg.Flag] = selectedColor
                    if self.SaveConfig then self.SaveConfig() end
                end
            end
            
            local draggingSV = false
            local draggingHue = false
            
            satValPicker.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or
                   input.UserInputType == Enum.UserInputType.Touch then
                    draggingSV = true
                    local relX = math.clamp((input.Position.X - satValPicker.AbsolutePosition.X) / satValPicker.AbsoluteSize.X, 0, 1)
                    local relY = math.clamp((input.Position.Y - satValPicker.AbsolutePosition.Y) / satValPicker.AbsoluteSize.Y, 0, 1)
                    sat = relX
                    val = 1 - relY
                    updateColor()
                end
            end)
            
            satValPicker.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or
                   input.UserInputType == Enum.UserInputType.Touch then
                    draggingSV = false
                end
            end)
            
            hueSlider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or
                   input.UserInputType == Enum.UserInputType.Touch then
                    draggingHue = true
                    local relY = math.clamp((input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y, 0, 1)
                    hue = relY
                    updateColor()
                end
            end)
            
            hueSlider.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or
                   input.UserInputType == Enum.UserInputType.Touch then
                    draggingHue = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement or
                   input.UserInputType == Enum.UserInputType.Touch then
                    if draggingSV then
                        local relX = math.clamp((input.Position.X - satValPicker.AbsolutePosition.X) / satValPicker.AbsoluteSize.X, 0, 1)
                        local relY = math.clamp((input.Position.Y - satValPicker.AbsolutePosition.Y) / satValPicker.AbsoluteSize.Y, 0, 1)
                        sat = relX
                        val = 1 - relY
                        updateColor()
                    end
                    if draggingHue then
                        local relY = math.clamp((input.Position.Y - hueSlider.AbsolutePosition.Y) / hueSlider.AbsoluteSize.Y, 0, 1)
                        hue = relY
                        updateColor()
                    end
                end
            end)
            
            mainBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    pickerFrame.Visible = true
                    holder.Size = UDim2.new(1, -20, 0, 38 + 170)
                    tween(pickerFrame, 0.2, { Size = UDim2.new(1, 0, 0, 170) })
                else
                    tween(pickerFrame, 0.2, { Size = UDim2.new(1, 0, 0, 0) })
                    wait(0.2)
                    pickerFrame.Visible = false
                    holder.Size = UDim2.new(1, -20, 0, 38)
                end
            end)
            
            if self.ConfigData and cfg.Flag and self.ConfigData[cfg.Flag] then
                selectedColor = self.ConfigData[cfg.Flag]
                colorDisplay.BackgroundColor3 = selectedColor
                local r, g, b = selectedColor.R * 255, selectedColor.G * 255, selectedColor.B * 255
                hue, sat, val = RGBToHSV(r, g, b)
                satValPicker.BackgroundColor3 = HSVToRGB(hue, 1, 1)
            end
            
            return holder
        end
        
        function tab:Code(cfg)
            local currentCode = cfg.Code or ""
            local currentTitle = cfg.Title or "Code"
            local onCopyCallback = nil
            
            local holder = create("Frame", {
                Parent = TabPage,
                Size = UDim2.new(1, -20, 0, 120),
                BackgroundColor3 = Color3.fromRGB(40, 40, 45),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = holder, CornerRadius = UDim.new(0, 8) })
            
            local titleBar = create("Frame", {
                Parent = holder,
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = Color3.fromRGB(50, 50, 55),
                BorderSizePixel = 0
            })
            create("UICorner", { Parent = titleBar, CornerRadius = UDim.new(0, 8) })
            
            local titleMask = create("Frame", {
                Parent = titleBar,
                Size = UDim2.new(1, 0, 0, 8),
                Position = UDim2.new(0, 0, 1, -8),
                BackgroundColor3 = Color3.fromRGB(50, 50, 55),
                BorderSizePixel = 0
            })
            
            local titleLabel = create("TextLabel", {
                Parent = titleBar,
                Size = UDim2.new(1, -80, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = currentTitle,
                TextColor3 = Color3.fromRGB(200, 200, 205),
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local copyButton = create("TextButton", {
                Parent = titleBar,
                Size = UDim2.new(0, 60, 0, 22),
                Position = UDim2.new(1, -70, 0.5, -11),
                BackgroundColor3 = currentTheme.Accent,
                BorderSizePixel = 0,
                Text = "Copy",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                AutoButtonColor = false
            })
            create("UICorner", { Parent = copyButton, CornerRadius = UDim.new(0, 4) })
            
            local codeBox = create("TextBox", {
                Parent = holder,
                Size = UDim2.new(1, -20, 1, -40),
                Position = UDim2.new(0, 10, 0, 35),
                BackgroundTransparency = 1,
                Text = currentCode,
                TextColor3 = Color3.fromRGB(220, 220, 225),
                Font = Enum.Font.Code,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextWrapped = true,
                MultiLine = true,
                ClearTextOnFocus = false,
                TextEditable = false
            })
            
            copyButton.MouseEnter:Connect(function()
                tween(copyButton, 0.15, { BackgroundColor3 = Color3.new(
                    currentTheme.Accent.R * 0.85,
                    currentTheme.Accent.G * 0.85,
                    currentTheme.Accent.B * 0.85
                )})
            end)
            
            copyButton.MouseLeave:Connect(function()
                tween(copyButton, 0.15, { BackgroundColor3 = currentTheme.Accent })
            end)
            
            copyButton.MouseButton1Click:Connect(function()
                if setclipboard then
                    setclipboard(currentCode)
                    copyButton.Text = "✓ Copied"
                    if onCopyCallback then
                        pcall(onCopyCallback)
                    end
                    task.wait(1)
                    copyButton.Text = "Copy"
                end
            end)
            
            local codeAPI = {
                Title = currentTitle,
                
                SetCode = function(newCode)
                    currentCode = newCode
                    codeBox.Text = newCode
                    
                    local lines = 1
                    for _ in string.gmatch(newCode, "\n") do
                        lines = lines + 1
                    end
                    
                    local newHeight = math.max(120, math.min(300, 30 + lines * 18))
                    holder.Size = UDim2.new(1, -20, 0, newHeight)
                end,
                
                OnCopy = function(callback)
                    onCopyCallback = callback
                end,
                
                Destroy = function()
                    holder:Destroy()
                end
            }
            
            return codeAPI
        end
        
        return tab
    end
    
    end
    
    InitializeUI()
    
    if config.KeySystem then
        CreateKeySystem(config, function(success)
            if success then
                ScreenGui.Enabled = true
            end
        end)
    end
    
    function self:Hide()
        ScreenGui.Enabled = false
        self.Visible = false
    end
    
    function self:Show()
        ScreenGui.Enabled = true
        self.Visible = true
    end
    
    function self:Toggle()
        ScreenGui.Enabled = not ScreenGui.Enabled
        self.Visible = ScreenGui.Enabled
    end
    
    function self:Destroy()
        ScreenGui:Destroy()
    end
    
    function self:SetTheme(themeName)
        local newTheme = Themes[themeName] or Themes.Default
        MainFrame.BackgroundColor3 = newTheme.Background
        TitleBar.BackgroundColor3 = newTheme.TitleBar
        for _, tab in ipairs(self.Tabs) do
            if tab == self.CurrentTab then
                tab.Button.BackgroundColor3 = newTheme.TabActive
                tab.Label.TextColor3 = newTheme.TextActive
                if tab.Icon then
                    tab.Icon.ImageColor3 = newTheme.TextActive
                end
            else
                tab.Button.BackgroundColor3 = newTheme.TabInactive
                tab.Label.TextColor3 = newTheme.TextInactive
                if tab.Icon then
                    tab.Icon.ImageColor3 = newTheme.TextInactive
                end
            end
        end
    end
    
    return self
end

function MacUI:Notify(cfg)
    cfg = cfg or {}
    local window = cfg.Window
    
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local notificationHolder = PlayerGui:FindFirstChild("MacUI_Notifications")
    if not notificationHolder then
        notificationHolder = create("ScreenGui", {
            Parent = PlayerGui,
            Name = "MacUI_Notifications",
            ZIndexBehavior = Enum.ZIndexBehavior.Global,
            ResetOnSpawn = false,
            Enabled = true,
            DisplayOrder = 9999
        })
        
        local vertAlign = (window and window.NotifyFromBottom) and Enum.VerticalAlignment.Bottom or Enum.VerticalAlignment.Top
        
        create("UIListLayout", {
            Parent = notificationHolder,
            Padding = UDim.new(0, 10),
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = vertAlign,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        create("UIPadding", {
            Parent = notificationHolder,
            PaddingTop = UDim.new(0, 20),
            PaddingRight = UDim.new(0, 20),
            PaddingBottom = UDim.new(0, 20)
        })
    end
    
    local notification = create("Frame", {
        Parent = notificationHolder,
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    create("UICorner", { Parent = notification, CornerRadius = UDim.new(0, 10) })
    create("UIStroke", { 
        Parent = notification, 
        Thickness = 1, 
        Color = Color3.fromRGB(220, 220, 225)
    })
    
    local title = create("TextLabel", {
        Parent = notification,
        Size = UDim2.new(1, -50, 0, 20),
        Position = UDim2.new(0, 15, 0, 12),
        BackgroundTransparency = 1,
        Text = cfg.Title or "Notification",
        TextColor3 = Color3.fromRGB(30, 30, 35),
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local content = create("TextLabel", {
        Parent = notification,
        Size = UDim2.new(1, -50, 0, 18),
        Position = UDim2.new(0, 15, 0, 32),
        BackgroundTransparency = 1,
        Text = cfg.Content or "",
        TextColor3 = Color3.fromRGB(100, 100, 105),
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true
    })
    
    local closeBtn = create("TextButton", {
        Parent = notification,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -30, 0, 10),
        BackgroundColor3 = Color3.fromRGB(240, 240, 245),
        BorderSizePixel = 0,
        Text = "✕",
        TextColor3 = Color3.fromRGB(100, 100, 105),
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        AutoButtonColor = false
    })
    create("UICorner", { Parent = closeBtn, CornerRadius = UDim.new(1, 0) })
    
    closeBtn.MouseEnter:Connect(function()
        tween(closeBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(230, 230, 235) })
    end)
    
    closeBtn.MouseLeave:Connect(function()
        tween(closeBtn, 0.15, { BackgroundColor3 = Color3.fromRGB(240, 240, 245) })
    end)
    
    local function closeNotification()
        tween(notification, 0.3, { 
            Size = UDim2.new(0, 0, 0, 0)
        })
        wait(0.3)
        notification:Destroy()
    end
    
    closeBtn.MouseButton1Click:Connect(closeNotification)
    
    tween(notification, 0.3, { Size = UDim2.new(0, 300, 0, 60) })
    
    task.delay(cfg.Duration or 4, function()
        if notification and notification.Parent then
            closeNotification()
        end
    end)
    
    return {
        Close = closeNotification,
        SetTitle = function(text)
            title.Text = text
        end,
        SetContent = function(text)
            content.Text = text
        end
    }
end


function MacUI:Dialog(cfg)
    local DialogGui = create("ScreenGui", {
        Parent = LocalPlayer.PlayerGui,
        Name = "MacUI_Dialog",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })
    
    local Overlay = create("Frame", {
        Parent = DialogGui,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0
    })
    
    local DialogFrame = create("Frame", {
        Parent = Overlay,
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    })
    create("UICorner", { Parent = DialogFrame, CornerRadius = UDim.new(0, 14) })
    
    local Title = create("TextLabel", {
        Parent = DialogFrame,
        Size = UDim2.new(1, -40, 0, 30),
        Position = UDim2.new(0, 20, 0, 20),
        BackgroundTransparency = 1,
        Text = cfg.Title or "Dialog",
        TextColor3 = Color3.fromRGB(30, 30, 35),
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local Content = create("TextLabel", {
        Parent = DialogFrame,
        Size = UDim2.new(1, -40, 0, 60),
        Position = UDim2.new(0, 20, 0, 60),
        BackgroundTransparency = 1,
        Text = cfg.Content or "",
        TextColor3 = Color3.fromRGB(80, 80, 85),
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true
    })
    
    local ButtonHolder = create("Frame", {
        Parent = DialogFrame,
        Size = UDim2.new(1, -40, 0, 40),
        Position = UDim2.new(0, 20, 1, -60),
        BackgroundTransparency = 1
    })
    
    local ConfirmBtn = create("TextButton", {
        Parent = ButtonHolder,
        Size = UDim2.new(0.48, 0, 1, 0),
        Position = UDim2.new(0.52, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(10, 132, 255),
        BorderSizePixel = 0,
        Text = cfg.ConfirmText or "Confirm",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        AutoButtonColor = false
    })
    create("UICorner", { Parent = ConfirmBtn, CornerRadius = UDim.new(0, 8) })
    
    local CancelBtn = create("TextButton", {
        Parent = ButtonHolder,
        Size = UDim2.new(0.48, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(240, 240, 245),
        BorderSizePixel = 0,
        Text = cfg.CancelText or "Cancel",
        TextColor3 = Color3.fromRGB(60, 60, 65),
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        AutoButtonColor = false
    })
    create("UICorner", { Parent = CancelBtn, CornerRadius = UDim.new(0, 8) })
    
    local function closeDialog(confirmed)
        tween(DialogFrame, 0.2, { Size = UDim2.new(0, 0, 0, 0) })
        tween(Overlay, 0.2, { BackgroundTransparency = 1 })
        wait(0.2)
        DialogGui:Destroy()
        if cfg.Callback then
            cfg.Callback(confirmed)
        end
    end
    
    ConfirmBtn.MouseButton1Click:Connect(function()
        closeDialog(true)
    end)
    
    CancelBtn.MouseButton1Click:Connect(function()
        closeDialog(false)
    end)
    
    tween(DialogFrame, 0.3, { Size = UDim2.new(0, 400, 0, 200) })
end

return MacUI
