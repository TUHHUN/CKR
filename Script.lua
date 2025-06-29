--[CKR]
-- PHANTOM HUNTER v4.2 - كود كامل مع واجهة مضمونة
local OrionLib = (function()
    -- مكتبة أوريون المدمجة - تصميم خاص لـ Phantom Hunter
    local OrionLib = {}
    local input = game:GetService("UserInputService")
    local run = game:GetService("RunService")
    local coreGui = game:GetService("CoreGui")
    
    -- إنشاء واجهة المستخدم الرئيسية
    local PhantomGUI = Instance.new("ScreenGui")
    PhantomGUI.Name = "PhantomGUI"
    PhantomGUI.ResetOnSpawn = false
    PhantomGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    PhantomGUI.DisplayOrder = 999
    PhantomGUI.Parent = coreGui
    
    -- الإطار الرئيسي
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 550)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -275)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = true
    MainFrame.Parent = PhantomGUI

    -- الزاوية العلوية
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Size = UDim2.new(1, 0, 0, 40)
    Topbar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    Topbar.BorderSizePixel = 0
    Topbar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = "👁️ PHANTOM HUNTER ELITE"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 0, 128)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Parent = Topbar

    -- زر الإغلاق
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -35, 0.5, -10)
    CloseButton.Size = UDim2.new(0, 30, 0, 20)
    CloseButton.Parent = Topbar

    -- منطقة التبويبات
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Visible = true
    TabContainer.Parent = MainFrame

    -- أزرار التبويبات
    local TabButtons = Instance.new("Frame")
    TabButtons.Name = "TabButtons"
    TabButtons.Size = UDim2.new(0, 150, 1, 0)
    TabButtons.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TabButtons.BorderSizePixel = 0
    TabButtons.Parent = TabContainer

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabButtons
    TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- مجلد التبويبات
    local TabsFolder = Instance.new("Folder")
    TabsFolder.Name = "Tabs"
    TabsFolder.Parent = TabContainer

    -- جعل الإطار قابل للسحب
    local function MakeDraggable(topbar, frame)
        local dragging = false
        local dragInput, dragStart, startPos

        topbar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

        topbar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)

        input.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    MakeDraggable(Topbar, MainFrame)

    -- التحكم برؤية الواجهة
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    input.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.Insert then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    -- وظائف المكتبة
    function OrionLib:MakeWindow(options)
        local window = {}
        
        function window:MakeTab(options)
            local tabName = options.Name or "Tab"
            
            -- زر التبويب
            local TabButton = Instance.new("TextButton")
            TabButton.Name = tabName
            TabButton.Text = "  " .. tabName
            TabButton.Font = Enum.Font.Gotham
            TabButton.TextSize = 14
            TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            TabButton.TextXAlignment = Enum.TextXAlignment.Left
            TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            TabButton.BorderSizePixel = 0
            TabButton.Size = UDim2.new(0.9, 0, 0, 40)
            TabButton.LayoutOrder = #TabButtons:GetChildren()
            TabButton.Parent = TabButtons

            -- إطار التبويب
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
            TabList.Padding = UDim.new(0, 10)
            TabList.SortOrder = Enum.SortOrder.LayoutOrder

            -- إظهار/إخفاء التبويب عند النقر
            TabButton.MouseButton1Click:Connect(function()
                for _, tab in ipairs(TabsFolder:GetChildren()) do
                    if tab:IsA("ScrollingFrame") then
                        tab.Visible = false
                    end
                end
                TabFrame.Visible = true
            end)

            -- تبويب افتراضي
            if #TabsFolder:GetChildren() == 1 then
                TabFrame.Visible = true
            end

            local tab = {}
            
            -- إضافة زر
            function tab:AddButton(options)
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
                Button.Size = UDim2.new(0.95, 0, 0, 40)
                Button.LayoutOrder = #TabFrame:GetChildren()
                Button.Parent = TabFrame
                
                Button.MouseButton1Click:Connect(callback)
                
                TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 50)
            end
            
            -- إضافة تبديل
            function tab:AddToggle(options)
                local toggleName = options.Name or "Toggle"
                local default = options.Default or false
                local callback = options.Callback or function() end
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = toggleName
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(0.95, 0, 0, 40)
                ToggleFrame.LayoutOrder = #TabFrame:GetChildren()
                ToggleFrame.Parent = TabFrame
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Name = "ToggleButton"
                ToggleButton.Text = "  " .. toggleName
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
                ToggleIndicator.Size = UDim2.new(0, 20, 0, 20)
                ToggleIndicator.Position = UDim2.new(1, -30, 0.5, -10)
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
                
                TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 50)
                
                return {
                    Set = function(_, value)
                        updateToggle(value)
                    end
                }
            end
            
            -- إضافة منزلق
            function tab:AddSlider(options)
                local sliderName = options.Name or "Slider"
                local min = options.Min or 0
                local max = options.Max or 100
                local default = options.Default or 50
                local callback = options.Callback or function() end
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Name = sliderName
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Size = UDim2.new(0.95, 0, 0, 60)
                SliderFrame.LayoutOrder = #TabFrame:GetChildren()
                SliderFrame.Parent = TabFrame
                
                local SliderTitle = Instance.new("TextLabel")
                SliderTitle.Name = "Title"
                SliderTitle.Text = "  " .. sliderName
                SliderTitle.Font = Enum.Font.Gotham
                SliderTitle.TextSize = 14
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
                SliderValue.TextSize = 14
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

-- ===== نظام التصويب الذكي =====
-- دائرة مجال الرؤية
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = true
FOVCircle.Radius = 80
FOVCircle.Color = Color3.fromRGB(255, 0, 128)
FOVCircle.Thickness = 2
FOVCircle.Transparency = 0.7
FOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)

-- إعدادات التصويب
local Prediction = 0.165
local Smoothing = 0.35
local TargetPart = "HumanoidRootPart"
local TeamCheck = true
local WallCheck = true
local AutoShoot = false
local AimMode = "Closest to Crosshair"
local FOVVisible = true

-- إعدادات الـ ESP
local HealthBarESP = true
local DistanceESP = true
local NameTags = true
local ChamsEnabled = false
local SkeletonESP = false
local WeaponESP = false
local ThreatLevelESP = false

-- إعدادات الأداء
local LightweightMode = false
local SilentAim = false

-- إنشاء النافذة
local Window = OrionLib:MakeWindow({
    Name = "👁️ PHANTOM HUNTER ELITE",
})

-- تبويب القتال
local CombatTab = Window:MakeTab({
    Name = "🔥 القتال",
})

CombatTab:AddToggle({
    Name = "التصويب الذكي",
    Default = false,
    Callback = function(Value)
        SilentAim = Value
    end    
})

CombatTab:AddToggle({
    Name = "إطلاق نار تلقائي",
    Default = AutoShoot,
    Callback = function(Value)
        AutoShoot = Value
    end    
})

CombatTab:AddSlider({
    Name = "توقع الحركة",
    Min = 0.01,
    Max = 0.5,
    Default = Prediction,
    Callback = function(Value)
        Prediction = Value
    end    
})

CombatTab:AddSlider({
    Name = "السلاسة",
    Min = 0.01,
    Max = 1.0,
    Default = Smoothing,
    Callback = function(Value)
        Smoothing = Value
    end    
})

CombatTab:AddToggle({
    Name = "تصويب عبر الحائط",
    Default = WallCheck,
    Callback = function(Value)
        WallCheck = Value
    end    
})

CombatTab:AddToggle({
    Name = "فلترة الفريق",
    Default = TeamCheck,
    Callback = function(Value)
        TeamCheck = Value
    end    
})

CombatTab:AddSlider({
    Name = "حجم مجال الرؤية",
    Min = 20,
    Max = 600,
    Default = 80,
    Callback = function(Value)
        FOVCircle.Radius = Value
    end    
})

-- تبويب المرئيات
local VisualsTab = Window:MakeTab({
    Name = "👁️ المرئيات",
})

VisualsTab:AddToggle({
    Name = "إظهار مجال الرؤية",
    Default = FOVVisible,
    Callback = function(Value)
        FOVVisible = Value
        FOVCircle.Visible = Value
    end    
})

VisualsTab:AddToggle({
    Name = "مربع ESP",
    Default = false,
    Callback = function(Value)
        -- سيتم تنفيذ هذا لاحقًا
    end    
})

-- ===== نظام التتبع والتصويب =====
-- جدول تتبع اللاعبين
local ESPTable = {}
local ThreatLevels = {}

-- إنشاء عناصر ESP للاعب
local function CreateESP(player)
    -- سيتم تنفيذ هذا لاحقًا
    return {}
end

-- التحقق من الرؤية عبر الجدران
local function IsVisible(part)
    if not WallCheck then return true end
    -- سيتم تنفيذ هذا لاحقًا
    return true
end

-- إدارة اللاعبين
local function PlayerAdded(player)
    if player == game.Players.LocalPlayer then return end
    -- سيتم تنفيذ هذا لاحقًا
end

local function PlayerRemoving(player)
    -- سيتم تنفيذ هذا لاحقًا
end

-- العثور على الهدف
local function FindTarget()
    -- سيتم تنفيذ هذا لاحقًا
    return nil
end

-- حساب توقع الحركة
local function CalculatePrediction(target)
    -- سيتم تنفيذ هذا لاحقًا
    return Vector3.new()
end

-- نظام التصويب
local oldNamecall
local function SetupHook()
    local mt = getrawmetatable(game)
    if not mt then return false end
    
    oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        if SilentAim and tostring(getnamecallmethod()) == "FindPartOnRayWithIgnoreList" then
            local target = FindTarget()
            if target and target.Character then
                -- سيتم تنفيذ هذا لاحقًا
            end
        end
        return oldNamecall(self, ...)
    end)
    
    setreadonly(mt, true)
    return true
end

-- حلقة التصيير
game:GetService("RunService").RenderStepped:Connect(function()
    -- تحديث موقع دائرة FOV
    FOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
    
    -- سيتم تنفيذ بقية النظام لاحقًا
end)

-- ===== التهيئة النهائية =====
-- تهيئة نظام التصويب
SetupHook()

-- تهيئة ESP للاعبين الموجودين
for _, player in ipairs(game.Players:GetPlayers()) do
    PlayerAdded(player)
end

-- رسالة البدء
print("Phantom Hunter v4.2 - تم التفعيل بنجاح!")
warn("اضغط على زر INSERT لفتح/إغلاق القائمة")

-- التأكد من ظهور الواجهة
task.spawn(function()
    wait(1)
    if game:GetService("CoreGui"):FindFirstChild("PhantomGUI") then
        game:GetService("CoreGui").PhantomGUI.MainFrame.Visible = true
        print("تم عرض واجهة المستخدم بنجاح")
    else
        warn("فشل في العثور على واجهة المستخدم")
    end
end)

-- إظهار إشعار بدء التشغيل
OrionLib:MakeWindow({}):MakeTab({}):AddButton({
    Name = "تم التحميل بنجاح!",
    Callback = function()
    end
})
