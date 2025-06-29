-- PHANTOM HUNTER v3.4 - ORION LIBRARY EDITION
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/OrionLibrary/Orion/main/source.lua'))()

local Window = OrionLib:MakeWindow({
    Name = "👁️ PHANTOM HUNTER ELITE",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "PhantomHunter",
    IntroEnabled = true,
    IntroText = "QUANTUM AIMBOT LOADING"
})

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

-- COMBAT TAB
local CombatTab = Window:MakeTab({
    Name = "🔥 QUANTUM COMBAT",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
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

CombatTab:AddSlider({
    Name = "PREDICTION",
    Min = 0.01,
    Max = 0.5,
    Default = Prediction,
    Color = Color3.fromRGB(255,0,128),
    Increment = 0.01,
    ValueName = "sec",
    Callback = function(Value)
        Prediction = Value
    end    
})

CombatTab:AddSlider({
    Name = "SMOOTHING",
    Min = 0.01,
    Max = 1.0,
    Default = Smoothing,
    Color = Color3.fromRGB(255,0,128),
    Increment = 0.01,
    ValueName = "x",
    Callback = function(Value)
        Smoothing = Value
    end    
})

CombatTab:AddDropdown({
    Name = "TARGET PART",
    Default = TargetPart,
    Options = {"Head", "HumanoidRootPart", "Torso", "Random"},
    Callback = function(Value)
        TargetPart = Value
    end    
})

CombatTab:AddDropdown({
    Name = "AIM MODE",
    Default = AimMode,
    Options = {"Closest to Crosshair", "Lowest Health", "Highest Threat"},
    Callback = function(Value)
        AimMode = Value
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

CombatTab:AddSlider({
    Name = "FOV SIZE",
    Min = 20,
    Max = 600,
    Default = 80,
    Color = Color3.fromRGB(255,0,128),
    Increment = 10,
    ValueName = "pixels",
    Callback = function(Value)
        FOVCircle.Radius = Value
    end    
})

-- VISUALS TAB
local VisualsTab = Window:MakeTab({
    Name = "👁️ QUANTUM VISUALS",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
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

VisualsTab:AddToggle({
    Name = "HIGHLIGHT ESP",
    Default = false,
    Callback = function(Value)
        for _, esp in pairs(ESPTable) do
            if esp.Highlight then esp.Highlight.Enabled = Value end
        end
    end    
})

VisualsTab:AddToggle({
    Name = "SKELETON ESP",
    Default = SkeletonESP,
    Callback = function(Value)
        SkeletonESP = Value
    end    
})

VisualsTab:AddToggle({
    Name = "HEALTH BAR",
    Default = HealthBarESP,
    Callback = function(Value)
        HealthBarESP = Value
    end    
})

VisualsTab:AddToggle({
    Name = "DISTANCE",
    Default = DistanceESP,
    Callback = function(Value)
        DistanceESP = Value
    end    
})

VisualsTab:AddToggle({
    Name = "NAME TAGS",
    Default = NameTags,
    Callback = function(Value)
        NameTags = Value
    end    
})

VisualsTab:AddToggle({
    Name = "THREAT LEVEL",
    Default = ThreatLevelESP,
    Callback = function(Value)
        ThreatLevelESP = Value
    end    
})

VisualsTab:AddToggle({
    Name = "WEAPON ESP",
    Default = WeaponESP,
    Callback = function(Value)
        WeaponESP = Value
    end    
})

VisualsTab:AddToggle({
    Name = "CHAMS",
    Default = ChamsEnabled,
    Callback = function(Value)
        ChamsEnabled = Value
        for player, esp in pairs(ESPTable) do
            if esp.Cham then esp.Cham.Enabled = Value end
        end
    end    
})

VisualsTab:AddColorpicker({
    Name = "FOV COLOR",
    Default = Color3.fromRGB(255, 0, 128),
    Callback = function(Value)
        FOVCircle.Color = Value
    end    
})

-- ADVANCED PLAYER TRACKING
local ESPTable = {}
local ThreatLevels = {}

local function CreateESP(player)
    if not player or not player.Parent then return nil end
    
    local components = {}
    
    -- Box ESP
    components.Box = Drawing.new("Square")
    components.Box.Visible = false
    components.Box.Color = Color3.new(1, 0, 0)
    components.Box.Thickness = 2
    components.Box.Filled = false
    
    -- Health Bar
    components.HealthBar = Drawing.new("Square")
    components.HealthBar.Visible = false
    components.HealthBar.Filled = true
    
    -- Distance
    components.DistanceText = Drawing.new("Text")
    components.DistanceText.Visible = false
    components.DistanceText.Color = Color3.new(1, 1, 1)
    components.DistanceText.Size = 14
    components.DistanceText.Center = true
    
    -- Name Tag
    components.NameText = Drawing.new("Text")
    components.NameText.Visible = false
    components.NameText.Size = 16
    components.NameText.Center = true
    
    -- Threat Level
    components.ThreatText = Drawing.new("Text")
    components.ThreatText.Visible = false
    components.ThreatText.Size = 14
    components.ThreatText.Center = true
    
    -- Weapon ESP
    components.WeaponText = Drawing.new("Text")
    components.WeaponText.Visible = false
    components.WeaponText.Size = 14
    components.WeaponText.Center = true
    
    -- Highlight
    if player.Character then
        components.Highlight = Instance.new("Highlight")
        components.Highlight.Parent = player.Character
        components.Highlight.Enabled = false
        components.Highlight.FillTransparency = 0.8
        components.Highlight.OutlineTransparency = 0
    end
    
    -- Skeleton ESP
    components.Skeleton = {}
    local boneNames = {"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "RightUpperArm", 
        "LeftLowerArm", "RightLowerArm", "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg"}
    
    for _, boneName in ipairs(boneNames) do
        components.Skeleton[boneName] = Drawing.new("Line")
        components.Skeleton[boneName].Visible = false
        components.Skeleton[boneName].Thickness = 1
    end
    
    -- Chams
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        components.Cham = Instance.new("BoxHandleAdornment")
        components.Cham.Parent = player.Character
        components.Cham.Adornee = player.Character.HumanoidRootPart
        components.Cham.Size = Vector3.new(2, 4, 1)
        components.Cham.Color3 = Color3.new(1, 0, 0)
        components.Cham.Transparency = 0.5
        components.Cham.AlwaysOnTop = true
        components.Cham.ZIndex = 10
        components.Cham.Enabled = false
    end
    
    -- Initialize threat level
    ThreatLevels[player] = 0
    
    return components
end

-- FIXED WALL CHECK
local function IsVisible(part)
    if not part or not part.Parent then return false end
    if not WallCheck then return true end
    
    local camera = workspace.CurrentCamera
    if not camera then return false end
    
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer or not localPlayer.Character then return false end

    local origin = camera.CFrame.Position
    local _, onScreen = camera:WorldToViewportPoint(part.Position)
    if not onScreen then return false end

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {localPlayer.Character}
    raycastParams.IgnoreWater = true
    
    local result = workspace:Raycast(origin, part.Position - origin, raycastParams)
    return result and result.Instance:IsDescendantOf(part.Parent)
end

-- PLAYER MANAGEMENT
local function PlayerAdded(player)
    if player == game.Players.LocalPlayer then return end
    
    player.CharacterAdded:Connect(function(char)
        ESPTable[player] = CreateESP(player)
    end)
    
    if player.Character then
        ESPTable[player] = CreateESP(player)
    end
end

local function PlayerRemoving(player)
    if ESPTable[player] then
        for _, drawing in pairs(ESPTable[player]) do
            if typeof(drawing) == "Drawing" then
                pcall(function() drawing:Remove() end)
            elseif typeof(drawing) == "table" then
                for _, bone in pairs(drawing) do
                    if typeof(bone) == "Drawing" then
                        pcall(function() bone:Remove() end)
                    end
                end
            elseif typeof(drawing) == "Instance" then
                pcall(function() drawing:Destroy() end)
            end
        end
        ESPTable[player] = nil
        ThreatLevels[player] = nil
    end
end

for _, player in ipairs(game.Players:GetPlayers()) do
    PlayerAdded(player)
end

game.Players.PlayerAdded:Connect(PlayerAdded)
game.Players.PlayerRemoving:Connect(PlayerRemoving)

-- FIXED TARGETING SYSTEM
local function FindTarget()
    local camera = workspace.CurrentCamera
    if not camera then return nil end
    
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then return nil end
    
    local localChar = localPlayer.Character
    if not localChar then return nil end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    local bestTarget, bestScore = nil, -math.huge
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player == localPlayer then continue end
        if not player or not player.Parent then continue end
        
        local char = player.Character
        if not char then continue end
        
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        if not rootPart or not head then continue end
        
        if TeamCheck and player.Team == localPlayer.Team then continue end
        if not IsVisible(head) then continue end
        
        -- Position calculations
        local screenPos, visible = camera:WorldToViewportPoint(head.Position)
        if not visible then continue end
        
        local distance = (localRoot.Position - rootPart.Position).Magnitude
        local crosshairDist = (Vector2.new(screenPos.X, screenPos.Y) - FOVCircle.Position).Magnitude
        
        -- Scoring system
        local score = 0
        if AimMode == "Closest to Crosshair" then
            score = 1 / (crosshairDist + 0.001)
        elseif AimMode == "Lowest Health" then
            score = 1 / (humanoid.Health + 0.001)
        elseif AimMode == "Highest Threat" then
            score = ThreatLevels[player] or 0
        end
        
        -- Add distance factor
        score = score * (1 / (distance * 0.1))
        
        if score > bestScore then
            bestTarget = player
            bestScore = score
        end
    end
    
    return bestTarget
end

-- QUANTUM PREDICTION ENGINE
local function CalculatePrediction(target)
    if not target or not target.Character then return Vector3.new(0,0,0) end
    
    local rootPart = target.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = target.Character:FindFirstChild("Humanoid")
    
    if not rootPart or not humanoid then 
        return rootPart and rootPart.Position or Vector3.new(0,0,0)
    end
    
    -- Advanced prediction using velocity and humanoid state
    local predictedPosition = rootPart.Position
    
    -- Add movement direction prediction
    if humanoid.MoveDirection.Magnitude > 0 then
        predictedPosition = predictedPosition + (humanoid.MoveDirection * Prediction * 20)
    end
    
    -- Add jump prediction
    if humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        predictedPosition = predictedPosition + Vector3.new(0, Prediction * 25, 0)
    end
    
    -- Add velocity factor
    predictedPosition = predictedPosition + (rootPart.Velocity * Prediction)
    
    return predictedPosition
end

-- HOOKING SYSTEM
local oldNamecall
local hookActive = false

local function SetupHook()
    if hookActive then return true end
    
    local mt = getrawmetatable(game)
    if not mt then return false end
    
    oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    local hookFunc = function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        
        if SilentAim and tostring(method) == "FindPartOnRayWithIgnoreList" then
            local target = FindTarget()
            if target and target.Character then
                -- Dynamic target part selection
                local actualTargetPart = TargetPart
                if TargetPart == "Random" then
                    local parts = {"Head", "HumanoidRootPart", "Torso"}
                    actualTargetPart = parts[math.random(1, #parts)]
                end
                
                local targetPart = target.Character:FindFirstChild(actualTargetPart) or target.Character.Head
                if not targetPart then return oldNamecall(self, unpack(args)) end
                
                local predictedPosition = CalculatePrediction(target)
                
                -- Smoothing algorithm
                local camera = workspace.CurrentCamera
                if not camera then return oldNamecall(self, unpack(args)) end
                
                local smoothedPosition = camera.CFrame.Position:Lerp(predictedPosition, Smoothing)
                
                -- Auto-shoot implementation
                if AutoShoot then
                    spawn(function()
                        local localChar = game.Players.LocalPlayer.Character
                        if localChar then
                            local tool = localChar:FindFirstChildOfClass("Tool")
                            if tool then
                                tool:Activate()
                            end
                        end
                    end)
                end
                
                return targetPart, smoothedPosition
            end
        end
        return oldNamecall(self, unpack(args))
    end
    
    -- Use newcclosure if available
    if newcclosure then
        mt.__namecall = newcclosure(hookFunc)
    else
        mt.__namecall = hookFunc
    end
    
    setreadonly(mt, true)
    hookActive = true
    return true
end

-- DAMAGE TRACKER FOR THREAT LEVELS
local function TrackDamage()
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then return end
    
    localPlayer.CharacterAdded:Connect(function(char)
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if humanoid.Health < humanoid.MaxHealth then
                -- Find who damaged us
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= localPlayer and player.Character then
                        local lastDamage = humanoid:GetAttribute("LastDamageSource")
                        if lastDamage and lastDamage:IsDescendantOf(player.Character) then
                            ThreatLevels[player] = (ThreatLevels[player] or 0) + 10
                        end
                    end
                end
            end
        end)
    end)
end

-- FIXED RENDER LOOP
local LastUpdate = tick()
local UpdateInterval = LightweightMode and 0.1 or 0.03

game:GetService("RunService").RenderStepped:Connect(function()
    if LightweightMode and (tick() - LastUpdate < UpdateInterval) then return end
    LastUpdate = tick()
    
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then return end
    
    local localChar = localPlayer.Character
    if not localChar then return end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return end
    
    -- Update FOV position
    FOVCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    
    for player, esp in pairs(ESPTable) do
        if not player or not player.Parent then
            ESPTable[player] = nil
            continue
        end
        
        local char = player.Character
        if not char or char.Parent == nil then
            for _, drawing in pairs(esp) do
                if typeof(drawing) == "Drawing" then
                    pcall(function() drawing.Visible = false end)
                elseif typeof(drawing) == "Instance" and drawing:IsA("Highlight") then
                    pcall(function() drawing.Enabled = false end)
                end
            end
            continue
        end
        
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChild("Humanoid")
        
        if rootPart and humanoid and humanoid.Health > 0 then
            local position, onScreen = camera:WorldToViewportPoint(rootPart.Position)
            
            if onScreen then
                -- BOX ESP
                local scale = 2000 / position.Z
                local boxSize = Vector2.new(scale * 2, scale * 3)
                local boxPos = Vector2.new(position.X - scale, position.Y - scale * 1.5)
                
                if esp.Box then
                    esp.Box.Size = boxSize
                    esp.Box.Position = boxPos
                    esp.Box.Visible = VisualsTab:GetActiveToggle("BOX ESP")
                end
                
                -- HEALTH BAR
                if HealthBarESP and esp.HealthBar then
                    local healthPercent = humanoid.Health / humanoid.MaxHealth
                    local healthHeight = boxSize.Y * healthPercent
                    esp.HealthBar.Size = Vector2.new(2, healthHeight)
                    esp.HealthBar.Position = Vector2.new(boxPos.X - 6, boxPos.Y + boxSize.Y - healthHeight)
                    esp.HealthBar.Color = Color3.new(1 - healthPercent, healthPercent, 0)
                    esp.HealthBar.Visible = true
                elseif esp.HealthBar then
                    esp.HealthBar.Visible = false
                end
                
                -- DISTANCE
                if DistanceESP and esp.DistanceText then
                    local distance = (localRoot.Position - rootPart.Position).Magnitude
                    esp.DistanceText.Text = math.floor(distance) .. "m"
                    esp.DistanceText.Position = Vector2.new(boxPos.X + boxSize.X/2, boxPos.Y + boxSize.Y + 5)
                    esp.DistanceText.Visible = true
                elseif esp.DistanceText then
                    esp.DistanceText.Visible = false
                end
                
                -- NAME TAG
                if NameTags and esp.NameText then
                    esp.NameText.Text = player.Name
                    esp.NameText.Position = Vector2.new(boxPos.X + boxSize.X/2, boxPos.Y - 20)
                    esp.NameText.Visible = true
                elseif esp.NameText then
                    esp.NameText.Visible = false
                end
                
                -- THREAT LEVEL
                if ThreatLevelESP and esp.ThreatText then
                    local threat = ThreatLevels[player] or 0
                    local threatColor
                    if threat < 20 then
                        threatColor = Color3.new(0, 1, 0)
                    elseif threat < 50 then
                        threatColor = Color3.new(1, 1, 0)
                    else
                        threatColor = Color3.new(1, 0, 0)
                    end
                    
                    esp.ThreatText.Text = "☠️" .. threat
                    esp.ThreatText.Color = threatColor
                    esp.ThreatText.Position = Vector2.new(boxPos.X + boxSize.X/2, boxPos.Y - 40)
                    esp.ThreatText.Visible = true
                elseif esp.ThreatText then
                    esp.ThreatText.Visible = false
                end
                
                -- WEAPON ESP
                if WeaponESP and esp.WeaponText then
                    local weapon = "Fists"
                    for _, tool in ipairs(char:GetChildren()) do
                        if tool:IsA("Tool") then
                            weapon = tool.Name
                            break
                        end
                    end
                    
                    esp.WeaponText.Text = "🔫 " .. weapon
                    esp.WeaponText.Position = Vector2.new(boxPos.X + boxSize.X/2, boxPos.Y + boxSize.Y + 25)
                    esp.WeaponText.Visible = true
                elseif esp.WeaponText then
                    esp.WeaponText.Visible = false
                end
                
                -- SKELETON ESP
                if SkeletonESP then
                    for boneName, line in pairs(esp.Skeleton) do
                        local bone = char:FindFirstChild(boneName)
                        if bone then
                            local bonePos, boneVisible = camera:WorldToViewportPoint(bone.Position)
                            if boneVisible then
                                line.From = Vector2.new(position.X, position.Y)
                                line.To = Vector2.new(bonePos.X, bonePos.Y)
                                line.Visible = true
                            else
                                line.Visible = false
                            end
                        end
                    end
                else
                    for _, line in pairs(esp.Skeleton) do
                        line.Visible = false
                    end
                end
                
                -- HIGHLIGHT
                if esp.Highlight then
                    esp.Highlight.Enabled = VisualsTab:GetActiveToggle("HIGHLIGHT ESP")
                end
                
                -- CHAMS
                if esp.Cham then
                    esp.Cham.Enabled = ChamsEnabled
                end
            else
                -- Hide all elements when off-screen
                if esp.Box then esp.Box.Visible = false end
                if esp.HealthBar then esp.HealthBar.Visible = false end
                if esp.DistanceText then esp.DistanceText.Visible = false end
                if esp.NameText then esp.NameText.Visible = false end
                if esp.ThreatText then esp.ThreatText.Visible = false end
                if esp.WeaponText then esp.WeaponText.Visible = false end
                for _, line in pairs(esp.Skeleton) do
                    line.Visible = false
                end
                if esp.Cham then esp.Cham.Enabled = false end
            end
        end
    end
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

OrionLib:MakeNotification({
    Name = "👁️ QUANTUM PHANTOM ACTIVE",
    Content = "Elite ESP & Silent Aim injected",
    Image = "rbxassetid://4483362458",
    Time = 6
})

-- DEBUG MODE
print("Phantom Hunter v3.4 - تم التفعيل بنجاح!")
warn("الحالة: جاهز للتشغيل")

-- UNHOOK ON SCRIPT TERMINATION
OrionLib:Init()
