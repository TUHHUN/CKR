-- PHANTOM HUNTER v4.0 - EMBEDDED ORION LIBRARY
local OrionLib = (function()
    -- Embedded Orion Library (Modified for Phantom Hunter)
    local OrionLib = {}
    local tween = game:GetService("TweenService")
    local input = game:GetService("UserInputService")
    local run = game:GetService("RunService")
    
    local function MakeDraggable(topbarobject, object)
        local dragging = nil
        local dragInput = nil
        local dragStart = nil
        local startPos = nil
        
        topbarobject.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = object.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        topbarobject.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)
        
        input.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end
    
    function OrionLib:MakeWindow(options)
        options = options or {}
        local mainName = options.Name or "Phantom Hunter"
        local hidePremium = options.HidePremium or false
        local saveConfig = options.SaveConfig or false
        local configFolder = options.ConfigFolder or "PhantomConfig"
        local introEnabled = options.IntroEnabled or false
        local introText = options.IntroText or "Loading..."
        
        -- Main GUI
        local PhantomGUI = Instance.new("ScreenGui")
        PhantomGUI.Name = "PhantomGUI"
        PhantomGUI.Parent = game.CoreGui
        PhantomGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        -- Main Frame
        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.new(0, 500, 0, 550)
        MainFrame.Position = UDim2.new(0.5, -250, 0.5, -275)
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Parent = PhantomGUI
        
        -- Topbar
        local Topbar = Instance.new("Frame")
        Topbar.Name = "Topbar"
        Topbar.Size = UDim2.new(1, 0, 0, 40)
        Topbar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        Topbar.BorderSizePixel = 0
        Topbar.Parent = MainFrame
        
        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Text = "👁️ " .. mainName
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 16
        Title.TextColor3 = Color3.fromRGB(255, 0, 128)
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0, 15, 0, 0)
        Title.Size = UDim2.new(0, 200, 1, 0)
        Title.Parent = Topbar
        
        MakeDraggable(Topbar, MainFrame)
        
        -- Tab Container
        local TabContainer = Instance.new("Frame")
        TabContainer.Name = "TabContainer"
        TabContainer.Size = UDim2.new(1, 0, 1, -40)
        TabContainer.Position = UDim2.new(0, 0, 0, 40)
        TabContainer.BackgroundTransparency = 1
        TabContainer.Parent = MainFrame
        
        -- Tab Buttons
        local TabButtons = Instance.new("Frame")
        TabButtons.Name = "TabButtons"
        TabButtons.Size = UDim2.new(0, 150, 1, 0)
        TabButtons.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        TabButtons.BorderSizePixel = 0
        TabButtons.Parent = TabContainer
        
        local TabsFolder = Instance.new("Folder")
        TabsFolder.Name = "Tabs"
        TabsFolder.Parent = TabContainer
        
        local TabListLayout = Instance.new("UIListLayout")
        TabListLayout.Parent = TabButtons
        TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        TabListLayout.Padding = UDim.new(0, 5)
        
        local window = {}
        
        function window:MakeTab(options)
            options = options or {}
            local tabName = options.Name or "Tab"
            local icon = options.Icon or ""
            
            local TabButton = Instance.new("TextButton")
            TabButton.Name = tabName
            TabButton.Text = tabName
            TabButton.Font = Enum.Font.Gotham
            TabButton.TextSize = 14
            TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            TabButton.BorderSizePixel = 0
            TabButton.Size = UDim2.new(0.9, 0, 0, 40)
            TabButton.Parent = TabButtons
            
            local TabFrame = Instance.new("ScrollingFrame")
            TabFrame.Name = tabName
            TabFrame.Size = UDim2.new(1, -160, 1, 0)
            TabFrame.Position = UDim2.new(0, 160, 0, 0)
            TabFrame.BackgroundTransparency = 1
            TabFrame.Visible = false
            TabFrame.Parent = TabsFolder
            TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            TabFrame.ScrollBarThickness = 3
            
            local TabList = Instance.new("UIListLayout")
            TabList.Parent = TabFrame
            TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            TabList.Padding = UDim.new(0, 5)
            
            TabButton.MouseButton1Click:Connect(function()
                for _, tab in ipairs(TabsFolder:GetChildren()) do
                    tab.Visible = false
                end
                TabFrame.Visible = true
            end)
            
            if #TabsFolder:GetChildren() == 0 then
                TabFrame.Visible = true
            end
            
            local tab = {}
            
            function tab:AddButton(options)
                options = options or {}
                local btnName = options.Name or "Button"
                local callback = options.Callback or function() end
                
                local Button = Instance.new("TextButton")
                Button.Name = btnName
                Button.Text = btnName
                Button.Font = Enum.Font.Gotham
                Button.TextSize = 14
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(0.9, 0, 0, 35)
                Button.Parent = TabFrame
                
                Button.MouseButton1Click:Connect(callback)
                
                TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y)
            end
            
            function tab:AddToggle(options)
                options = options or {}
                local toggleName = options.Name or "Toggle"
                local default = options.Default or false
                local callback = options.Callback or function() end
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = toggleName
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(0.9, 0, 0, 35)
                ToggleFrame.Parent = TabFrame
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "ToggleButton"
                ToggleButton.Text = toggleName
                ToggleButton.Font = Enum.Font.Gotham
                ToggleButton.TextSize = 14
                ToggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
                ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Size = UDim2.new(1, 0, 1, 0)
                ToggleButton.Parent = ToggleFrame
                
                local ToggleIndicator = Instance.new("Frame")
                ToggleIndicator.Name = "Indicator"
                ToggleIndicator.Size = UDim2.new(0, 25, 0, 25)
                ToggleIndicator.Position = UDim2.new(1, -30, 0.5, -12.5)
                ToggleIndicator.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
                ToggleIndicator.BorderSizePixel = 0
                ToggleIndicator.Parent = ToggleButton
                
                local function updateToggle(value)
                    callback(value)
                    ToggleIndicator.BackgroundColor3 = value and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
                end
                
                ToggleButton.MouseButton1Click:Connect(function()
                    updateToggle(not (ToggleIndicator.BackgroundColor3 == Color3.fromRGB(0, 200, 0)))
                end)
                
                TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y)
                
                return {
                    Set = function(_, value)
                        updateToggle(value)
                    end
                }
            end
            
            -- Add other UI elements similarly (Slider, Dropdown, etc.)
            
            return tab
        end
        
        return window
    end
    
    return OrionLib
end)()

-- QUANTUM AIMBOT ENGINE
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = true
FOVCircle.Radius = 80
FOVCircle.Color = Color3.fromRGB(255, 0, 128)
FOVCircle.Thickness = 2
FOVCircle.Transparency = 0.7
FOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)

-- PRECISION PARAMETERS
local Prediction = 0.165
local Smoothing = 0.35
local TargetPart = "HumanoidRootPart"
local TeamCheck = true
local WallCheck = true
local AutoShoot = false
local AimMode = "Closest to Crosshair"
local FOVVisible = true

-- ESP ENHANCEMENTS
local HealthBarESP = true
local DistanceESP = true
local NameTags = true
local ChamsEnabled = false
local SkeletonESP = false
local WeaponESP = false
local ThreatLevelESP = false

-- EXECUTOR FIXES
local LightweightMode = false
local SilentAim = false

-- Create Orion Window
local Window = OrionLib:MakeWindow({
    Name = "👁️ PHANTOM HUNTER ELITE",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "PhantomConfig",
    IntroEnabled = true,
    IntroText = "QUANTUM AIMBOT LOADING"
})

-- COMBAT TAB
local CombatTab = Window:MakeTab({
    Name = "🔥 QUANTUM COMBAT",
    Icon = ""
})

CombatTab:AddToggle({
    Name = "AI AIMBOT",
    Default = false,
    Callback = function(Value)
        SilentAim = Value
    end    
})

CombatTab:AddToggle({
    Name = "AUTO SHOOT",
    Default = AutoShoot,
    Callback = function(Value)
        AutoShoot = Value
    end    
})

CombatTab:AddToggle({
    Name = "TEAM CHECK",
    Default = TeamCheck,
    Callback = function(Value)
        TeamCheck = Value
    end    
})

CombatTab:AddToggle({
    Name = "WALL CHECK",
    Default = WallCheck,
    Callback = function(Value)
        WallCheck = Value
    end    
})

-- VISUALS TAB
local VisualsTab = Window:MakeTab({
    Name = "👁️ QUANTUM VISUALS",
    Icon = ""
})

VisualsTab:AddToggle({
    Name = "FOV VISIBLE",
    Default = FOVVisible,
    Callback = function(Value)
        FOVVisible = Value
        FOVCircle.Visible = Value
    end    
})

VisualsTab:AddToggle({
    Name = "BOX ESP",
    Default = false,
    Callback = function(Value)
        for _, esp in pairs(ESPTable) do
            if esp.Box then esp.Box.Visible = Value end
        end
    end    
})

-- ADVANCED PLAYER TRACKING
local ESPTable = {}
local ThreatLevels = {}

local function CreateESP(player)
    -- ESP creation code (same as before)
end

-- FIXED WALL CHECK
local function IsVisible(part)
    -- Wall check code (same as before)
end

-- PLAYER MANAGEMENT
local function PlayerAdded(player)
    -- Player management code (same as before)
end

local function PlayerRemoving(player)
    -- Player removal code (same as before)
end

-- FIXED TARGETING SYSTEM
local function FindTarget()
    -- Target finding code (same as before)
end

-- QUANTUM PREDICTION ENGINE
local function CalculatePrediction(target)
    -- Prediction code (same as before)
end

-- HOOKING SYSTEM
local oldNamecall
local hookActive = false

local function SetupHook()
    -- Hook setup code (same as before)
end

-- DAMAGE TRACKER FOR THREAT LEVELS
local function TrackDamage()
    -- Damage tracking code (same as before)
end

-- FIXED RENDER LOOP
local LastUpdate = tick()
local UpdateInterval = LightweightMode and 0.1 or 0.03

game:GetService("RunService").RenderStepped:Connect(function()
    -- Render loop code (same as before)
end)

-- INITIALIZATION
SetupHook()
TrackDamage()

-- Initialize ESP for existing players
for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer and player.Character then
        ESPTable[player] = CreateESP(player)
    end
end

-- DEBUG MODE
print("Phantom Hunter v4.0 - تم التفعيل بنجاح!")
warn("الحالة: جاهز للتشغيل")
