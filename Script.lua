
-- CKR AIMBOT + ESP UI SYSTEM - v2.0 FINAL FIXED

-- SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- SETTINGS
local Settings = {
    Aimbot = true,
    TeamCheck = false,
    ESPEnabled = true,
    WallCheck = false,
    FOV = 78,
    Part = "Head",
    FOVVisible = true,
    RGB = true,
    AimStrength = 0.5,
}

-- GLOBAL VARIABLES
local menuOpen = false

-- SOUNDS
local menuSound = Instance.new("Sound", SoundService)
menuSound.SoundId = "rbxassetid://2556932492"
menuSound.Volume = 0.3
local toggleSound = Instance.new("Sound", SoundService)
toggleSound.SoundId = "rbxassetid://2556932492"
toggleSound.Volume = 0.2

--
local function showNotification(text)
    local notif = Instance.new("TextLabel", ScreenGui)
    notif.Size = UDim2.new(0, 300, 0, 40)
    notif.Position = UDim2.new(0.5, -150, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    notif.TextColor3 = Color3.new(1, 1, 1)
    notif.TextScaled = true
    notif.Text = "✅ " .. text
    notif.Font = Enum.Font.SourceSansBold
    notif.BorderSizePixel = 0
    notif.BackgroundTransparency = 0.1

    local corner = Instance.new("UICorner", notif)
    corner.CornerRadius = UDim.new(0, 8)

    TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -150, 0, 60)}):Play()
    task.delay(1.6, function()
        TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -150, 0, 0)}):Play()
        task.wait(0.3)
        notif:Destroy()
    end)
end

createToggleButton("🎯 Aimbot", Settings.Aimbot, function(v)
    Settings.Aimbot = v
    showNotification("Aimbot: " .. (v and "Enabled" or "Disabled"))
end)

createToggleButton("👥 Team Check", Settings.TeamCheck, function(v)
    Settings.TeamCheck = v
    showNotification("Team Check: " .. (v and "ON" or "OFF"))
end)

createToggleButton("🧱 Wall Check", Settings.WallCheck, function(v)
    Settings.WallCheck = v
    showNotification("Wall Check: " .. (v and "ON" or "OFF"))
end)

createToggleButton("👀 ESP", Settings.ESPEnabled, function(v)
    Settings.ESPEnabled = v
    showNotification("ESP: " .. (v and "Enabled" or "Disabled"))
end)

createToggleButton("⭕ FOV Visible", Settings.FOVVisible, function(v)
    Settings.FOVVisible = v
    showNotification("FOV Circle: " .. (v and "Visible" or "Hidden"))
end)

createToggleButton("🌈 RGB FOV", Settings.RGB, function(v)
    Settings.RGB = v
    showNotification("RGB FOV: " .. (v and "ON" or "OFF"))
end)

createOptionButton("🎯 Target Part", {"Head", "Torso"}, function(v)
    Settings.Part = v
    showNotification("Target Part: " .. v)
end)

-- Modify FOV + / - controls:

fovMinus.MouseButton1Click:Connect(function()
    Settings.FOV = math.max(10, Settings.FOV - 10)
    fovLabel.Text = "FOV: " .. Settings.FOV
    animateButton(fovMinus, 0.8)
    toggleSound:Play()
    showNotification("FOV: " .. Settings.FOV)
end)

fovPlus.MouseButton1Click:Connect(function()
    Settings.FOV = math.min(1000, Settings.FOV + 10)
    fovLabel.Text = "FOV: " .. Settings.FOV
    animateButton(fovPlus, 0.8)
    toggleSound:Play()
    showNotification("FOV: " .. Settings.FOV)
end)

-- 

print("✅ CKR Hacker System v2.0 FIXED and LOADED!")
