-- ==========================================
-- 🛡️ [حماية] Anti-Kick
-- ==========================================
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then
        return nil
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- ==========================================
-- 🚀 Buggy Hub - النسخة الكاملة (Delta & Medium Support)
-- ==========================================
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- كشف المحاكي المستخدم
local executorName = "Unknown"
if identifyexecutor then 
    executorName = identifyexecutor()
elseif fluxus then
    executorName = "Fluxus"
end

if CoreGui:FindFirstChild("BuggyHubGui") then CoreGui.BuggyHubGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BuggyHubGui"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true 

-- 🔊 صوت الضغط على الأزرار
local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://6895079853"
ClickSound.Volume = 1.5
ClickSound.Parent = SoundService

local function playClick() pcall(function() ClickSound:Play() end) end

-- 🎬 [1] المشهد السينمائي (Intro - 12 ثانية)
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroFrame.ZIndex = 100
IntroFrame.Parent = ScreenGui

local BHLogo = Instance.new("TextLabel")
BHLogo.Size = UDim2.new(0, 200, 0, 100)
BHLogo.Position = UDim2.new(0.5, -100, 0.25, 0)
BHLogo.BackgroundTransparency = 1
BHLogo.Text = "BH"
BHLogo.TextColor3 = Color3.fromRGB(50, 255, 50)
BHLogo.TextSize = 70
BHLogo.Font = Enum.Font.FredokaOne
BHLogo.ZIndex = 101
BHLogo.Parent = IntroFrame

local BHStroke = Instance.new("UIStroke")
BHStroke.Color = Color3.fromRGB(0, 255, 100)
BHStroke.Thickness = 3
BHStroke.Parent = BHLogo

local TopText = Instance.new("TextLabel")
TopText.Size = UDim2.new(1, 0, 0, 50)
TopText.Position = UDim2.new(0, 0, 0.45, 0)
TopText.BackgroundTransparency = 1
TopText.Text = "⚡ Buggy Hub on top ⚡"
TopText.TextColor3 = Color3.fromRGB(255, 255, 255)
TopText.TextSize = 26
TopText.Font = Enum.Font.SourceSansBold
TopText.ZIndex = 101
TopText.Parent = IntroFrame

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 300, 0, 12)
LoadingBar.Position = UDim2.new(0.5, -150, 0.65, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(20, 30, 20)
LoadingBar.ZIndex = 101
LoadingBar.Parent = IntroFrame

local LoadingFill = Instance.new("Frame")
LoadingFill.Size = UDim2.new(0, 0, 1, 0)
LoadingFill.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
LoadingFill.ZIndex = 102
LoadingFill.Parent = LoadingBar

local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(1, 0, 0, 30)
LoadingText.Position = UDim2.new(0, 0, 0.72, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading... 0%"
LoadingText.TextColor3 = Color3.fromRGB(150, 255, 150)
LoadingText.TextSize = 18
LoadingText.Font = Enum.Font.SourceSans
LoadingText.ZIndex = 101
LoadingText.Parent = IntroFrame

local PhonkMusic = Instance.new("Sound")
PhonkMusic.SoundId = "rbxassetid://95131770144654"
PhonkMusic.Volume = 2
PhonkMusic.Parent = SoundService
PhonkMusic:Play()

-- 🛢️ [2] النافذة الرئيسية
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 270)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -135)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 30, 20)
MainFrame.Active = true
MainFrame.Draggable = false
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(50, 205, 50)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Position = UDim2.new(0, 20, 0, 12)
Title.Size = UDim2.new(1, -80, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "☢️ Buggy Hub | Brainrot"
Title.TextColor3 = Color3.fromRGB(120, 255, 120)
Title.TextSize = 20
Title.Font = Enum.Font.FredokaOne
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "❌"
CloseButton.TextSize = 18
CloseButton.Parent = MainFrame

local SidebarContainer = Instance.new("ScrollingFrame")
SidebarContainer.Position = UDim2.new(0, 15, 0, 55)
SidebarContainer.Size = UDim2.new(0, 105, 1, -70)
SidebarContainer.BackgroundTransparency = 1
SidebarContainer.ScrollBarThickness = 2
SidebarContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
SidebarContainer.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 8)
UIList.Parent = SidebarContainer

local ScriptsButton = Instance.new("TextButton")
ScriptsButton.Size = UDim2.new(1, -5, 0, 36)
ScriptsButton.Text = "SCRIPTS 📃"
ScriptsButton.BackgroundColor3 = Color3.fromRGB(35, 65, 38)
ScriptsButton.TextColor3 = Color3.fromRGB(200, 255, 200)
ScriptsButton.Font = Enum.Font.SourceSansBold
ScriptsButton.TextSize = 14
ScriptsButton.Parent = SidebarContainer
Instance.new("UICorner", ScriptsButton).CornerRadius = UDim.new(0, 8)

local SettingsButton = Instance.new("TextButton")
SettingsButton.Size = UDim2.new(1, -5, 0, 36)
SettingsButton.Text = "SETTINGS ⚙️"
SettingsButton.BackgroundColor3 = Color3.fromRGB(20, 35, 22)
SettingsButton.TextColor3 = Color3.fromRGB(120, 180, 120)
SettingsButton.Font = Enum.Font.SourceSansBold
SettingsButton.TextSize = 14
SettingsButton.Parent = SidebarContainer
Instance.new("UICorner", SettingsButton).CornerRadius = UDim.new(0, 8)

local ContentArea = Instance.new("Frame")
ContentArea.Position = UDim2.new(0, 130, 0, 55)
ContentArea.Size = UDim2.new(1, -145, 1, -70)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- 📜 تبويب السكربتات (ترتيب الأزرار تحت بعضها)
local ScriptsPage = Instance.new("ScrollingFrame")
ScriptsPage.Size = UDim2.new(1, 0, 1, 0)
ScriptsPage.BackgroundTransparency = 1
ScriptsPage.ScrollBarThickness = 4
ScriptsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScriptsPage.Parent = ContentArea

local ScriptsListLayout = Instance.new("UIListLayout")
ScriptsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScriptsListLayout.Padding = UDim.new(0, 10)
ScriptsListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ScriptsListLayout.Parent = ScriptsPage

-- [1] الزر الأول
local TacoFarmButton = Instance.new("TextButton")
TacoFarmButton.LayoutOrder = 1
TacoFarmButton.Size = UDim2.new(0.92, 0, 0, 42)
TacoFarmButton.BackgroundColor3 = Color3.fromRGB(30, 45, 30)
TacoFarmButton.Text = "EXECUTE AUTO TACO FARM 🌮"
TacoFarmButton.TextColor3 = Color3.fromRGB(200, 255, 200)
TacoFarmButton.Font = Enum.Font.SourceSansBold
TacoFarmButton.TextSize = 14
TacoFarmButton.Parent = ScriptsPage
Instance.new("UICorner", TacoFarmButton).CornerRadius = UDim.new(0, 10)
local TacoStroke = Instance.new("UIStroke")
TacoStroke.Color = Color3.fromRGB(50, 205, 50)
TacoStroke.Thickness = 1.5
TacoStroke.Parent = TacoFarmButton

-- [2] الزر الثاني
local SpinRngButton = Instance.new("TextButton")
SpinRngButton.LayoutOrder = 2
SpinRngButton.Size = UDim2.new(0.92, 0, 0, 42)
SpinRngButton.BackgroundColor3 = Color3.fromRGB(30, 45, 30)
SpinRngButton.Text = "EXECUTE AUTO SPIN RNG 🔄"
SpinRngButton.TextColor3 = Color3.fromRGB(200, 255, 200)
SpinRngButton.Font = Enum.Font.SourceSansBold
SpinRngButton.TextSize = 14
SpinRngButton.Parent = ScriptsPage
Instance.new("UICorner", SpinRngButton).CornerRadius = UDim.new(0, 10)
local SpinStroke = Instance.new("UIStroke")
SpinStroke.Color = Color3.fromRGB(50, 205, 50)
SpinStroke.Thickness = 1.5
SpinStroke.Parent = SpinRngButton

-- [3] الزر الثالث
local AutoGrabButton = Instance.new("TextButton")
AutoGrabButton.LayoutOrder = 3
AutoGrabButton.Size = UDim2.new(0.92, 0, 0, 42)
AutoGrabButton.BackgroundColor3 = Color3.fromRGB(30, 45, 30)
AutoGrabButton.Text = "EXECTUE AUTO GRAB 🫲"
AutoGrabButton.TextColor3 = Color3.fromRGB(200, 255, 200)
AutoGrabButton.Font = Enum.Font.SourceSansBold
AutoGrabButton.TextSize = 14
AutoGrabButton.Parent = ScriptsPage
Instance.new("UICorner", AutoGrabButton).CornerRadius = UDim.new(0, 10)
local GrabStroke = Instance.new("UIStroke")
GrabStroke.Color = Color3.fromRGB(50, 205, 50)
GrabStroke.Thickness = 1.5
GrabStroke.Parent = AutoGrabButton

-- [4] الزر الرابع (الجديد)
local CodeRedeemerButton = Instance.new("TextButton")
CodeRedeemerButton.LayoutOrder = 4
CodeRedeemerButton.Size = UDim2.new(0.92, 0, 0, 42)
CodeRedeemerButton.BackgroundColor3 = Color3.fromRGB(30, 45, 30)
CodeRedeemerButton.Text = "CODE REDEEMER 🏷️"
CodeRedeemerButton.TextColor3 = Color3.fromRGB(200, 255, 200)
CodeRedeemerButton.Font = Enum.Font.SourceSansBold
CodeRedeemerButton.TextSize = 14
CodeRedeemerButton.Parent = ScriptsPage
Instance.new("UICorner", CodeRedeemerButton).CornerRadius = UDim.new(0, 10)
local CodeStroke = Instance.new("UIStroke")
CodeStroke.Color = Color3.fromRGB(50, 205, 50)
CodeStroke.Thickness = 1.5
CodeStroke.Parent = CodeRedeemerButton

-- ⚙️ تبويب الإعدادات
local SettingsPage = Instance.new("ScrollingFrame")
SettingsPage.Size = UDim2.new(1, 0, 1, 0)
SettingsPage.BackgroundTransparency = 1
SettingsPage.ScrollBarThickness = 4
SettingsPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
SettingsPage.Visible = false
SettingsPage.Parent = ContentArea

local SettingsListLayout = Instance.new("UIListLayout")
SettingsListLayout.Padding = UDim.new(0, 8)
SettingsListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SettingsListLayout.Parent = SettingsPage

local ExecutorLabel = Instance.new("TextLabel")
ExecutorLabel.Size = UDim2.new(0.92, 0, 0, 30)
ExecutorLabel.BackgroundColor3 = Color3.fromRGB(30, 45, 30)
ExecutorLabel.Text = "Executor: " .. executorName
ExecutorLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
ExecutorLabel.Font = Enum.Font.SourceSansBold
ExecutorLabel.TextSize = 14
ExecutorLabel.Parent = SettingsPage
Instance.new("UICorner", ExecutorLabel).CornerRadius = UDim.new(0, 6)

local ThemeTitle = Instance.new("TextLabel")
ThemeTitle.Size = UDim2.new(0.92, 0, 0, 25)
ThemeTitle.BackgroundTransparency = 1
ThemeTitle.Text = "🎨 Change Theme"
ThemeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeTitle.Font = Enum.Font.SourceSansBold
ThemeTitle.TextSize = 16
ThemeTitle.TextXAlignment = Enum.TextXAlignment.Left
ThemeTitle.Parent = SettingsPage

-- 🛠️ أنيميشن الضغط
local function applyButtonAnimation(button, callback)
    button.MouseButton1Down:Connect(function()
        playClick()
        TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(button.Size.X.Scale * 0.95, button.Size.X.Offset, button.Size.Y.Scale * 0.95, button.Size.Y.Offset)
        }):Play()
    end)
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(button.Size.X.Scale / 0.95, button.Size.X.Offset, button.Size.Y.Scale / 0.95, button.Size.Y.Offset)
        }):Play()
        if callback then callback() end
    end)
end

applyButtonAnimation(TacoFarmButton, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/api-jnkie-com/scripts/main/AUTO_FARM_TACO.lua"))() end)
applyButtonAnimation(SpinRngButton, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/api-jnkie-com/scripts/main/Spin_Rng.lua"))() end)
applyButtonAnimation(AutoGrabButton, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/api-jnkie-com/scripts/main/Auto_grab.lua"))() end)
applyButtonAnimation(CodeRedeemerButton, function() loadstring(game:HttpGet("https://raw.githubusercontent.com/api-jnkie-com/scripts/main/Code_Redeemer.lua"))() end)

-- 🎨 نظام الثيمات
local activeThemeConnection = nil
local function stopAnim() if activeThemeConnection then activeThemeConnection:Disconnect() activeThemeConnection = nil end end

local function applyFullThemeColors(mainBg, strokeCol, textCol, btnBg, btnText)
    MainFrame.BackgroundColor3 = mainBg
    MainStroke.Color = strokeCol
    Title.TextColor3 = textCol
    ThemeTitle.TextColor3 = textCol
    ExecutorLabel.BackgroundColor3 = btnBg
    ExecutorLabel.TextColor3 = btnText
    ScriptsButton.BackgroundColor3 = btnBg
    ScriptsButton.TextColor3 = btnText
    SettingsButton.BackgroundColor3 = mainBg
    SettingsButton.TextColor3 = textCol
    TacoFarmButton.BackgroundColor3 = btnBg
    TacoFarmButton.TextColor3 = btnText
    TacoStroke.Color = strokeCol
    SpinRngButton.BackgroundColor3 = btnBg
    SpinRngButton.TextColor3 = btnText
    SpinStroke.Color = strokeCol
    AutoGrabButton.BackgroundColor3 = btnBg
    AutoGrabButton.TextColor3 = btnText
    GrabStroke.Color = strokeCol
    CodeRedeemerButton.BackgroundColor3 = btnBg
    CodeRedeemerButton.TextColor3 = btnText
    CodeStroke.Color = strokeCol
end

local function applyTheme(themeName)
    stopAnim()
    if themeName == "Default" then
        applyFullThemeColors(Color3.fromRGB(18, 30, 20), Color3.fromRGB(50, 205, 50), Color3.fromRGB(120, 255, 120), Color3.fromRGB(35, 65, 38), Color3.fromRGB(200, 255, 200))
    elseif themeName == "Glacier" then
        applyFullThemeColors(Color3.fromRGB(15, 25, 35), Color3.fromRGB(100, 200, 255), Color3.fromRGB(150, 220, 255), Color3.fromRGB(25, 45, 65), Color3.fromRGB(200, 240, 255))
    elseif themeName == "Obsidian" then
        applyFullThemeColors(Color3.fromRGB(15, 15, 15), Color3.fromRGB(80, 80, 80), Color3.fromRGB(220, 220, 220), Color3.fromRGB(35, 35, 35), Color3.fromRGB(255, 255, 255))
    elseif themeName == "Arctic" then
        applyFullThemeColors(Color3.fromRGB(30, 35, 45), Color3.fromRGB(200, 230, 255), Color3.fromRGB(220, 240, 255), Color3.fromRGB(50, 60, 80), Color3.fromRGB(255, 255, 255))
    elseif themeName == "Prism" then
        activeThemeConnection = RunService.RenderStepped:Connect(function()
            local hue = (tick() % 3) / 3
            local col = Color3.fromHSV(hue, 0.8, 1)
            local darkCol = Color3.fromHSV(hue, 0.8, 0.3)
            applyFullThemeColors(Color3.fromRGB(15, 15, 20), col, col, darkCol, Color3.fromRGB(255, 255, 255))
        end)
    elseif themeName == "Radiant" then
        activeThemeConnection = RunService.RenderStepped:Connect(function()
            local hue = (math.sin(tick() * 2) + 1) / 2
            local col = Color3.fromHSV(0.8 + hue * 0.15, 0.9, 1)
            local darkCol = Color3.fromHSV(0.8 + hue * 0.15, 0.9, 0.3)
            applyFullThemeColors(Color3.fromRGB(25, 15, 25), col, col, darkCol, Color3.fromRGB(255, 255, 255))
        end)
    elseif themeName == "Volcano" then
        activeThemeConnection = RunService.RenderStepped:Connect(function()
            local hue = (math.sin(tick() * 3) + 1) / 2
            local col = Color3.fromHSV(hue * 0.1, 1, 1)
            local darkCol = Color3.fromHSV(hue * 0.1, 1, 0.3)
            applyFullThemeColors(Color3.fromRGB(25, 15, 15), col, col, darkCol, Color3.fromRGB(255, 255, 255))
        end)
    end
end

applyButtonAnimation(ScriptsButton, function() ScriptsPage.Visible = true SettingsPage.Visible = false end)
applyButtonAnimation(SettingsButton, function() ScriptsPage.Visible = false SettingsPage.Visible = true end)

local themes = {"Default", "Glacier", "Radiant", "Obsidian", "Prism", "Volcano", "Arctic"}
for _, name in ipairs(themes) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.92, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Parent = SettingsPage
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Thickness = 1
    btnStroke.Parent = btn
    
    if name == "Radiant" then btnStroke.Color = Color3.fromRGB(255, 0, 150)
    elseif name == "Prism" then btnStroke.Color = Color3.fromRGB(0, 150, 255)
    elseif name == "Volcano" then btnStroke.Color = Color3.fromRGB(255, 80, 0)
    elseif name == "Glacier" then btnStroke.Color = Color3.fromRGB(100, 200, 255)
    elseif name == "Arctic" then btnStroke.Color = Color3.fromRGB(200, 230, 255)
    else btnStroke.Color = Color3.fromRGB(60, 60, 60) end
    
    applyButtonAnimation(btn, function() applyTheme(name) end)
end

-- 🔘 الزر العائم (Show UI)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Position = UDim2.new(0.05, 0, 0.3, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "☢️"
ToggleButton.TextSize = 25
ToggleButton.Visible = false
ToggleButton.Draggable = true 
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

-- 🎬 أنيميشن الفتح والإغلاق
local isAnimating = false
local function hideUI()
    if isAnimating then return end
    isAnimating = true
    playClick()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    task.wait(0.3)
    MainFrame.Visible = false
    ToggleButton.Visible = true
    ToggleButton.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 50, 0, 50)
    }):Play()
    isAnimating = false
end

local function showUI()
    if isAnimating then return end
    isAnimating = true
    playClick()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    task.wait(0.2)
    ToggleButton.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 480, 0, 270), Position = UDim2.new(0.5, -240, 0.5, -135)
    }):Play()
    task.wait(0.4)
    isAnimating = false
end

CloseButton.MouseButton1Click:Connect(hideUI)
ToggleButton.MouseButton1Click:Connect(showUI)

-- 🚀 تشغيل الـ Intro
task.spawn(function()
    local totalTime = 12
    local steps = 100
    local waitTime = totalTime / steps
    
    for i = 1, steps do
        LoadingFill.Size = UDim2.new(i/100, 0, 1, 0)
        LoadingText.Text = "Loading... " .. i .. "%"
        task.wait(waitTime)
    end
    
    PhonkMusic:Stop()
    PhonkMusic:Destroy()
    IntroFrame:Destroy()
    
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 480, 0, 270), Position = UDim2.new(0.5, -240, 0.5, -135)
    }):Play()
    
    ToggleButton.Visible = false
end)
