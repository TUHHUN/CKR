
-- PHANTOM HUNTER v5.0 - Optimized for iPhone X
local OrionLib = (function()
    -- Enhanced Embedded Orion Library
    local OrionLib = {}
    local input = game:GetService("UserInputService")
    local run = game:GetService("RunService")
    local coreGui = game:GetService("CoreGui")
    
    -- Create main UI
    local PhantomGUI = Instance.new("ScreenGui")
    PhantomGUI.Name = "PhantomGUI"
    PhantomGUI.ResetOnSpawn = false
    PhantomGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    PhantomGUI.DisplayOrder = 999
    PhantomGUI.Parent = coreGui
    
    -- Main Frame with optimized size for iPhone X
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 300, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = false
    MainFrame.Parent = PhantomGUI

    -- Topbar with modern design
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Size = UDim2.new(1, 0, 0, 30)
    Topbar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    Topbar.BorderSizePixel = 0
    Topbar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = "👁️ PHANTOM HUNTER"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextColor3 = Color3.fromRGB(255, 0, 128)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Parent = Topbar

    -- Close Button with modern icon
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageRectOffset = Vector2.new(924, 724)
    CloseButton.ImageRectSize = Vector2.new(36, 36)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0.5, -10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Parent = Topbar

    -- Tab Container with smooth scrolling
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 1, -30)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame

    -- Tab Buttons with modern styling
    local TabButtons = Instance.new("ScrollingFrame")
    TabButtons.Name = "TabButtons"
    TabButtons.Size = UDim2.new(0, 90, 1, 0)
    TabButtons.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TabButtons.BorderSizePixel = 0
    TabButtons.ScrollBarThickness = 3
    TabButtons.Parent = TabContainer

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabButtons
    TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabListLayout.Padding = UDim.new(0, 3)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Tabs Folder
    local TabsFolder = Instance.new("Folder")
    TabsFolder.Name = "Tabs"
    TabsFolder.Parent = TabContainer

    -- Modern Floating Menu Button
    local MenuButton = Instance.new("ImageButton")
    MenuButton.Name = "MenuButton"
    MenuButton.Image = "rbxassetid://3926307971"
    MenuButton.ImageRectOffset = Vector2.new(4, 844)
    MenuButton.ImageRectSize = Vector2.new(36, 36)
    MenuButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    MenuButton.BackgroundTransparency = 0.5
    MenuButton.BorderSizePixel = 0
    MenuButton.Size = UDim2.new(0, 40, 0, 40)
    MenuButton.Position = UDim2.new(0, 10, 0, 10)
    MenuButton.Visible = true
    MenuButton.Parent = PhantomGUI
    
    -- Make UI draggable
    local function MakeDraggable(topbar, frame)
        local dragging = false
        local dragInput, dragStart, startPos

        topbar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        input.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        input.InputChanged:Connect(function(input)
            if (input == dragInput and dragging) then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    MakeDraggable(Topbar, MainFrame)
    MakeDraggable(MenuButton, MenuButton)

    -- UI Visibility Control
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)
    
    MenuButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    input.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.Insert then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
    
    -- Library Functions
    function OrionLib:MakeWindow(options)
        local window = {}
        
        function window:MakeTab(options)
            local tabName = options.Name or "Tab"
            
            -- Tab Button with modern style
            local TabButton = Instance.new("TextButton")
            TabButton.Name = tabName
            TabButton.Text = "  " .. tabName
            TabButton.Font = Enum.Font.Gotham
            TabButton.TextSize = 12
            TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            TabButton.TextXAlignment = Enum.TextXAlignment.Left
            TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            TabButton.BorderSizePixel = 0
            TabButton.Size = UDim2.new(0.9, 0, 0, 30)
            TabButton.LayoutOrder = #TabButtons:GetChildren()
            TabButton.Parent = TabButtons

            -- Tab Content Frame
            local TabFrame = Instance.new("ScrollingFrame")
            TabFrame.Name = tabName
            TabFrame.Size = UDim2.new(1, -100, 1, 0)
            TabFrame.Position = UDim2.new(0, 100, 0, 0)
            TabFrame.BackgroundTransparency = 1
            TabFrame.Visible = false
            TabFrame.Parent = TabsFolder
            TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            TabFrame.ScrollBarThickness = 3

            local TabList = Instance.new("UIListLayout")
            TabList.Parent = TabFrame
            TabList.Padding = UDim.new(0, 5)
            TabList.SortOrder = Enum.SortOrder.LayoutOrder

            -- Show/Hide Tab
            TabButton.MouseButton1Click:Connect(function()
                for _, tab in ipairs(TabsFolder:GetChildren()) do
                    if tab:IsA("ScrollingFrame") then
                        tab.Visible = false
                    end
                end
                TabFrame.Visible = true
            end)

            -- Default Tab
            if #TabsFolder:GetChildren() == 1 then
                TabFrame.Visible = true
            end

            local tab = {}
            
            -- Add Button with modern style
            function tab:AddButton(options)
                local btnName = options.Name or "Button"
                local callback = options.Callback or function() end
                
                local Button = Instance.new("TextButton")
                Button.Name = btnName
                Button.Text = btnName
                Button.Font = Enum.Font.Gotham
                Button.TextSize = 12
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(0.95, 0, 0, 30)
                Button.LayoutOrder = #TabFrame:GetChildren()
                Button.Parent = TabFrame
                
                Button.MouseButton1Click:Connect(callback)
                
                TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 40)
            end
            
            -- Add Toggle with modern style
            function tab:AddToggle(options)
                local toggleName = options.Name or "Toggle"
                local default = options.Default or false
                local callback = options.Callback or function() end
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = toggleName
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(0.95, 0, 0, 30)
                ToggleFrame.LayoutOrder = #TabFrame:GetChildren()
                ToggleFrame.Parent = TabFrame
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "ToggleButton"
                ToggleButton.Text = "  " .. toggleName
                ToggleButton.Font = Enum.Font.Gotham
                ToggleButton.TextSize = 12
                ToggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
                ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Size = UDim2.new(1, 0, 1, 0)
                ToggleButton.Parent = ToggleFrame
                
                local ToggleIndicator = Instance.new("Frame")
                ToggleIndicator.Name = "Indicator"
                ToggleIndicator.Size = UDim2.new(0, 18, 0, 18)
                ToggleIndicator.Position = UDim2.new(1, -25, 0.5, -9)
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
                
                TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 40)
                
                return {
                    Set = function(_, value)
                        updateToggle(value)
                    end
                }
            end
            
            -- Add Slider with modern style
            function tab:AddSlider(options)
                local sliderName = options.Name or "Slider"
                local min = options.Min or 0
                local max = options.Max or 100
                local default = options.Default or 50
                local callback = options.Callback or function() end
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Name = sliderName
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Size = UDim2.new(0.95, 0, 0, 50)
                SliderFrame.LayoutOrder = #TabFrame:GetChildren()
                SliderFrame.Parent = TabFrame
                
                local SliderTitle = Instance.new("TextLabel")
                SliderTitle.Name = "Title"
                SliderTitle.Text = "  " .. sliderName
                SliderTitle.Font = Enum.Font.Gotham
                SliderTitle.TextSize = 12
                SliderTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                SliderTitle.BackgroundTransparency = 1
                SliderTitle.Size = UDim2.new(1, 0, 0.5, 0)
                SliderTitle.Parent = SliderFrame
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Name = "Bar"
                SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                SliderBar.BorderSizePixel = 0
                SliderBar.Position = UDim2.new(0.05, 0, 0.7, 0)
                SliderBar.Size = UDim2.new(0.9, 0, 0.2, 0)
                SliderBar.Parent = SliderFrame
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Name = "Fill"
                SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 128)
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                SliderFill.Parent = SliderBar
                
                local SliderValue = Instance.new("TextLabel")
                SliderValue.Name = "Value"
                SliderValue.Text = tostring(default)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.TextSize = 12
                SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(0.5, 0, 0, 0)
                SliderValue.Size = UDim2.new(0.5, 0, 1, 0)
                SliderValue.Parent = SliderBar
                
                local function updateSlider(value)
                    local percent = math.clamp((value - min) / (max - min), 0, 1)
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    SliderValue.Text = tostring(math.floor(value))
                    callback(value)
                end
                
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local function moveSlider()
                            local pos = input.Position.X - SliderBar.AbsolutePosition.X
                            local percent = math.clamp(pos / SliderBar.AbsoluteSize.X, 0, 1)
                            local value = min + (max - min) * percent
                            updateSlider(value)
                        end
                        
                        moveSlider()
                        
                        local connection
                        connection = input.Changed:Connect(function()
                            if input.UserInputState == Enum.UserInputState.End then
                                connection:Disconnect()
                            else
                                moveSlider()
                            end
                        end)
                    end
                end)
                
                TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 50)
                
                return {
                    Set = function(_, value)
                        updateSlider(value)
                    end
                }
            end
            
            return tab
        end
        
        return window
    end
    
    return OrionLib
end)()

-- ===== AIMBOT CORE =====
-- FOV Circle with improved visuals
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = true
FOVCircle.Radius = 80
FOVCircle.Color = Color3.fromRGB(255, 0, 128)
FOVCircle.Thickness = 2
FOVCircle.Transparency = 1
FOVCircle.Filled = false
FOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)

-- Optimized settings with proper defaults
local settings = {
    Prediction = 0.165,
    Smoothing = 0.35,
    TargetPart = "HumanoidRootPart",
    TeamCheck = true,
    WallCheck = true,
    AutoShoot = false,
    AimMode = "Closest to Crosshair",
    FOVVisible = true,
    HealthBarESP = true,
    DistanceESP = true,
    NameTags = true,
    HighlightESP = true, -- Using Highlight instead of Box ESP
    SkeletonESP = false,
    WeaponESP = false,
    ThreatLevelESP = false,
    LightweightMode = true, -- Enabled by default for mobile
    SilentAim = false,
    Active = false
}

-- Create window with modern design
local Window = OrionLib:MakeWindow({
    Name = "👁️ PHANTOM HUNTER",
})

-- Combat Tab
local CombatTab = Window:MakeTab({
    Name = "🔥 AIMBOT",
})

local AimToggle = CombatTab:AddToggle({
    Name = "ACTIVATE AIMBOT",
    Default = false,
    Callback = function(Value)
        settings.SilentAim = Value
        settings.Active = Value
        if Value then
            OrionLib:MakeNotification({
                Name = "AIMBOT ACTIVATED",
                Content = "Quantum targeting system engaged",
                Image = "rbxassetid://3926305904",
                Time = 3
            })
        end
    end    
})

CombatTab:AddToggle({
    Name = "AUTO SHOOT",
    Default = settings.AutoShoot,
    Callback = function(Value)
        settings.AutoShoot = Value
    end    
})

CombatTab:AddSlider({
    Name = "PREDICTION",
    Min = 0.01,
    Max = 0.5,
    Default = settings.Prediction,
    Callback = function(Value)
        settings.Prediction = Value
    end    
})

CombatTab:AddSlider({
    Name = "SMOOTHING",
    Min = 0.01,
    Max = 1.0,
    Default = settings.Smoothing,
    Callback = function(Value)
        settings.Smoothing = Value
    end    
})

CombatTab:AddToggle({
    Name = "WALL CHECK",
    Default = settings.WallCheck,
    Callback = function(Value)
        settings.WallCheck = Value
    end    
})

CombatTab:AddToggle({
    Name = "TEAM CHECK",
    Default = settings.TeamCheck,
    Callback = function(Value)
        settings.TeamCheck = Value
    end    
})

CombatTab:AddSlider({
    Name = "FOV SIZE",
    Min = 20,
    Max = 300,
    Default = 80,
    Callback = function(Value)
        FOVCircle.Radius = Value
    end    
})

-- Visuals Tab
local VisualsTab = Window:MakeTab({
    Name = "👁️ VISUALS",
})

VisualsTab:AddToggle({
    Name = "SHOW FOV",
    Default = settings.FOVVisible,
    Callback = function(Value)
        settings.FOVVisible = Value
        FOVCircle.Visible = Value
    end    
})

VisualsTab:AddToggle({
    Name = "HIGHLIGHT ESP",
    Default = settings.HighlightESP,
    Callback = function(Value)
        settings.HighlightESP = Value
    end    
})

VisualsTab:AddToggle({
    Name = "DISTANCE",
    Default = settings.DistanceESP,
    Callback = function(Value)
        settings.DistanceESP = Value
    end    
})

VisualsTab:AddToggle({
    Name = "NAMES",
    Default = settings.NameTags,
    Callback = function(Value)
        settings.NameTags = Value
    end    
})

-- ===== PLAYER HIGHLIGHT SYSTEM =====
local highlightCache = {}
local characterConnections = {}

local function createHighlight(player)
    if highlightCache[player] then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name .. "_Highlight"
    highlight.OutlineColor = Color3.new(1, 0, 0)
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.8
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = false
    
    highlightCache[player] = highlight
    
    -- Handle character added
    local function onCharacterAdded(character)
        highlight.Adornee = character
        highlight.Enabled = settings.HighlightESP
    end
    
    -- Handle character removal
    local function onCharacterRemoving()
        highlight.Adornee = nil
        highlight.Enabled = false
    end
    
    -- Connect events
    if player.Character then
        onCharacterAdded(player.Character)
    end
    
    characterConnections[player] = {
        Added = player.CharacterAdded:Connect(onCharacterAdded),
        Removing = player.CharacterRemoving:Connect(onCharacterRemoving)
    }
    
    highlight.Parent = game.CoreGui
end

local function removeHighlight(player)
    if highlightCache[player] then
        highlightCache[player]:Destroy()
        highlightCache[player] = nil
    end
    
    if characterConnections[player] then
        characterConnections[player].Added:Disconnect()
        characterConnections[player].Removing:Disconnect()
        characterConnections[player] = nil
    end
end

-- Player management
game.Players.PlayerAdded:Connect(function(player)
    createHighlight(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    removeHighlight(player)
end)

for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        createHighlight(player)
    end
end

-- Update highlights
local function updateHighlights()
    for player, highlight in pairs(highlightCache) do
        if player and player.Parent and highlight then
            highlight.Enabled = settings.HighlightESP
            
            -- Update color based on team
            if settings.TeamCheck and player.Team == game.Players.LocalPlayer.Team then
                highlight.OutlineColor = Color3.new(0, 1, 0)
                highlight.FillColor = Color3.new(0, 1, 0)
            else
                highlight.OutlineColor = Color3.new(1, 0, 0)
                highlight.FillColor = Color3.new(1, 0, 0)
            end
        end
    end
end

-- ===== OPTIMIZED AIMBOT SYSTEM =====
local targetCache = {}
local lastTarget = nil

local function isVisible(part)
    if not settings.WallCheck then return true end
    
    local camera = workspace.CurrentCamera
    local origin = camera.CFrame.Position
    local _, onScreen = camera:WorldToViewportPoint(part.Position)
    if not onScreen then return false end

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character}
    raycastParams.IgnoreWater = true
    
    local result = workspace:Raycast(origin, part.Position - origin, raycastParams)
    return result and result.Instance:IsDescendantOf(part.Parent)
end

local function findTarget()
    if not settings.Active then return nil end
    
    local camera = workspace.CurrentCamera
    local localPlayer = game.Players.LocalPlayer
    local bestTarget, bestDistance = nil, FOVCircle.Radius
    
    -- Use cached targets if available
    if next(targetCache) == nil then
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    table.insert(targetCache, player)
                end
            end
        end
    end
    
    for _, player in ipairs(targetCache) do
        if not player or not player.Parent then
            table.remove(targetCache, _)
            goto continue
        end
        
        local character = player.Character
        if not character then goto continue end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then goto continue end
        
        if settings.TeamCheck and player.Team == localPlayer.Team then goto continue end
        
        local head = character:FindFirstChild("Head")
        if not head or not isVisible(head) then goto continue end
        
        local screenPos = camera:WorldToViewportPoint(head.Position)
        local distance = (Vector2.new(screenPos.X, screenPos.Y) - FOVCircle.Position).Magnitude
        
        if distance < bestDistance then
            bestTarget = player
            bestDistance = distance
        end
        
        ::continue::
    end
    
    return bestTarget
end

-- Optimized aiming system
local function aimAtTarget(target)
    if not target or not target.Character then return end
    
    local targetPart = target.Character:FindFirstChild(settings.TargetPart) or target.Character:FindFirstChild("Head")
    if not targetPart then return end
    
    local camera = workspace.CurrentCamera
    local localMouse = game.Players.LocalPlayer:GetMouse()
    
    local predictedPosition = targetPart.Position + (targetPart.Velocity * settings.Prediction)
    local smoothedPosition = camera.CFrame.Position:Lerp(predictedPosition, settings.Smoothing)
    
    -- Auto-shoot implementation
    if settings.AutoShoot then
        local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
    end
    
    -- Return target for silent aim
    return targetPart, smoothedPosition
end

-- Hook for silent aim
local oldNamecall
local function setupHook()
    local mt = getrawmetatable(game)
    if not mt then return end
    
    oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        if settings.SilentAim and tostring(getnamecallmethod()) == "FindPartOnRayWithIgnoreList" then
            local target = findTarget()
            if target then
                return aimAtTarget(target)
            end
        end
        return oldNamecall(self, ...)
    end)
    
    setreadonly(mt, true)
end

-- ===== OPTIMIZED RENDER LOOP =====
local lastUpdate = 0
local updateInterval = settings.LightweightMode and 0.1 or 0.05

game:GetService("RunService").RenderStepped:Connect(function(step)
    -- Throttle updates for mobile
    if step - lastUpdate < updateInterval then return end
    lastUpdate = step
    
    -- Update FOV position
    FOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
    
    -- Update highlights
    updateHighlights()
    
    -- Refresh target cache periodically
    if step % 5 < updateInterval then
        targetCache = {}
    end
    
    -- Handle aiming
    if settings.SilentAim then
        local target = findTarget()
        if target then
            aimAtTarget(target)
        end
    end
end)

-- ===== INITIALIZATION =====
setupHook()

-- Initial notification
task.spawn(function()
    wait(1)
    if game:GetService("CoreGui"):FindFirstChild("PhantomGUI") then
        game:GetService("CoreGui").PhantomGUI.MenuButton.Visible = true
        OrionLib:MakeNotification({
            Name = "PHANTOM HUNTER LOADED",
            Content = "Press the menu button to open settings",
            Image = "rbxassetid://3926307971",
            Time = 5
        })
    end
end)

print("Phantom Hunter v5.0 - Optimized for iPhone X")
