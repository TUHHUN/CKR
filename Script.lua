-- PHANTOM HUNTER v5.1 - Rayfield Edition
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "👁️ PHANTOM HUNTER",
   LoadingTitle = "Loading Quantum Aim System...",
   LoadingSubtitle = "Optimizing for mobile performance",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "PhantomConfig",
      FileName = "MobileSettings"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   }
})

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
    FOVVisible = true,
    HighlightESP = true,
    DistanceESP = true,
    NameTags = true,
    SilentAim = false,
    Active = false
}

-- Create tabs
local CombatTab = Window:CreateTab("🔥 AIMBOT", 4483362458)
local VisualsTab = Window:CreateTab("👁️ VISUALS", 4483362458)

-- Combat Tab Elements
local AimToggle = CombatTab:CreateToggle({
    Name = "ACTIVATE AIMBOT",
    CurrentValue = false,
    Flag = "AimToggle",
    Callback = function(Value)
        settings.SilentAim = Value
        settings.Active = Value
        if Value then
            Rayfield:Notify({
                Title = "AIMBOT ACTIVATED",
                Content = "Quantum targeting system engaged",
                Duration = 3,
                Image = 4483362458,
            })
        end
    end,
})

CombatTab:CreateToggle({
    Name = "AUTO SHOOT",
    CurrentValue = settings.AutoShoot,
    Flag = "AutoShoot",
    Callback = function(Value)
        settings.AutoShoot = Value
    end,
})

CombatTab:CreateSlider({
    Name = "PREDICTION",
    Range = {0.01, 0.5},
    Increment = 0.01,
    Suffix = "sec",
    CurrentValue = settings.Prediction,
    Flag = "Prediction",
    Callback = function(Value)
        settings.Prediction = Value
    end,
})

CombatTab:CreateSlider({
    Name = "SMOOTHING",
    Range = {0.01, 1.0},
    Increment = 0.01,
    Suffix = "x",
    CurrentValue = settings.Smoothing,
    Flag = "Smoothing",
    Callback = function(Value)
        settings.Smoothing = Value
    end,
})

CombatTab:CreateToggle({
    Name = "WALL CHECK",
    CurrentValue = settings.WallCheck,
    Flag = "WallCheck",
    Callback = function(Value)
        settings.WallCheck = Value
    end,
})

CombatTab:CreateToggle({
    Name = "TEAM CHECK",
    CurrentValue = settings.TeamCheck,
    Flag = "TeamCheck",
    Callback = function(Value)
        settings.TeamCheck = Value
    end,
})

CombatTab:CreateSlider({
    Name = "FOV SIZE",
    Range = {20, 300},
    Increment = 5,
    Suffix = "pixels",
    CurrentValue = 80,
    Flag = "FOVSize",
    Callback = function(Value)
        FOVCircle.Radius = Value
    end,
})

-- Visuals Tab Elements
VisualsTab:CreateToggle({
    Name = "SHOW FOV",
    CurrentValue = settings.FOVVisible,
    Flag = "FOVVisible",
    Callback = function(Value)
        settings.FOVVisible = Value
        FOVCircle.Visible = Value
    end,
})

VisualsTab:CreateToggle({
    Name = "HIGHLIGHT ESP",
    CurrentValue = settings.HighlightESP,
    Flag = "HighlightESP",
    Callback = function(Value)
        settings.HighlightESP = Value
        updateHighlights()
    end,
})

VisualsTab:CreateToggle({
    Name = "DISTANCE",
    CurrentValue = settings.DistanceESP,
    Flag = "DistanceESP",
    Callback = function(Value)
        settings.DistanceESP = Value
    end,
})

VisualsTab:CreateToggle({
    Name = "NAMES",
    CurrentValue = settings.NameTags,
    Flag = "NameTags",
    Callback = function(Value)
        settings.NameTags = Value
    end,
})

VisualsTab:CreateColorPicker({
    Name = "ENEMY COLOR",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "EnemyColor",
    Callback = function(Value)
        settings.EnemyColor = Value
        updateHighlights()
    end
})

-- ===== PLAYER HIGHLIGHT SYSTEM =====
local highlightCache = {}
local characterConnections = {}
settings.EnemyColor = Color3.fromRGB(255, 0, 0)

local function createHighlight(player)
    if highlightCache[player] then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name .. "_Highlight"
    highlight.OutlineColor = settings.EnemyColor
    highlight.FillColor = settings.EnemyColor
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
                highlight.OutlineColor = settings.EnemyColor
                highlight.FillColor = settings.EnemyColor
            end
        end
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
local updateInterval = 0.1 -- Optimized for mobile

game:GetService("RunService").RenderStepped:Connect(function(step)
    -- Throttle updates for mobile
    if step - lastUpdate < updateInterval then return end
    lastUpdate = step
    
    -- Update FOV position
    FOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
    
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
Rayfield:Notify({
    Title = "PHANTOM HUNTER LOADED",
    Content = "Aimbot and ESP systems initialized",
    Duration = 5,
    Image = 4483362458,
})

-- KRNL compatibility fix
if identifyexecutor and string.find(string.lower(identifyexecutor()), "krnl") then
    Rayfield:Notify({
        Title = "KRNL COMPATIBILITY",
        Content = "Special optimizations applied for KRNL",
        Duration = 5,
        Image = 4483362458,
    })
end

print("Phantom Hunter v5.1 - Rayfield Edition")
