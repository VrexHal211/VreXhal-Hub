-- VreX Hub - Ultimate All-Game Script Hub, Custom Executor & Advanced Aimbot (PC Only)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- TELEFON KONTROLÜ (Sadece Bilgisayarda Çalışır Hata Koruması)
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    local ErrorScreen = Instance.new("ScreenGui")
    ErrorScreen.Name = "VreXError"
    ErrorScreen.Parent = CoreGui

    local ErrorFrame = Instance.new("Frame")
    ErrorFrame.Size = UDim2.new(0, 320, 0, 140)
    ErrorFrame.Position = UDim2.new(0.5, -160, 0.5, -70)
    ErrorFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ErrorFrame.BorderSizePixel = 0
    ErrorFrame.Parent = ErrorScreen

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = ErrorFrame

    local ErrorText = Instance.new("TextLabel")
    ErrorText.Size = UDim2.new(1, -20, 1, -20)
    ErrorText.Position = UDim2.new(0, 10, 0, 10)
    ErrorText.BackgroundTransparency = 1
    ErrorText.Font = Enum.Font.SourceSansBold
    ErrorText.TextSize = 16
    ErrorText.TextColor3 = Color3.fromRGB(255, 50, 50)
    ErrorText.TextWrapped = true
    ErrorText.Text = "HATA: Bu hile sadece bilgisayarda (PC) çalışacaktır! Mobil/Telefon cihazlar desteklenmemektedir."
    ErrorText.Parent = ErrorFrame
    return
end

-- Eski GUI varsa temizle
if CoreGui:FindFirstChild("VreXHubMain") then
    CoreGui.VreXHubMain:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VreXHubMain"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Günlük Dinamik Key Hesaplama
local function getDailyKey()
    local dayOfYear = os.date("!*t").yday
    local mod = dayOfYear % 4
    if mod == 0 then
        return "VreX0156"
    elseif mod == 1 then
        return "VreX1"
    elseif mod == 2 then
        return "VreXXX"
    else
        return "HITQIflqwfkqfoıqr1rkVreXXX"
    end
end

-- Klasik Roblox Ölme Sesi (Oof)
local function playDeathSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://12222216"
    sound.Volume = 1
    sound.Parent = ScreenGui
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- Sağ Alttan Gelen Rozet Bildirimi
local function sendBadgeNotification()
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Script Çalıştırıldı!",
            Text = "Her şey uygulandı.",
            Icon = "rbxassetid://11180945609",
            Duration = 5
        })
    end)
end

-- Üst Bildirim (Spawn / Yok Olma)
local TopNotify = Instance.new("TextLabel")
TopNotify.Size = UDim2.new(0, 500, 0, 40)
TopNotify.Position = UDim2.new(0.5, -250, -0.1, 0)
TopNotify.BackgroundTransparency = 1
TopNotify.Font = Enum.Font.SourceSansBold
TopNotify.TextSize = 24
TopNotify.TextStrokeTransparency = 0
TopNotify.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TopNotify.Text = ""
TopNotify.Parent = ScreenGui

local function showTopAlert(msg, color)
    TopNotify.Text = msg
    TopNotify.TextColor3 = color
    TweenService:Create(TopNotify, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -250, 0.08, 0)}):Play()
    task.delay(4, function()
        TweenService:Create(TopNotify, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -250, -0.1, 0)}):Play()
    end)
end

-- ANA MENÜYÜ OLUŞTURMA FONKSİYONU
local function buildMainHub()
    playDeathSound()
    sendBadgeNotification()

    -- Bleh Cat Yükleme Ekranı
    local LoadFrame = Instance.new("Frame")
    LoadFrame.Size = UDim2.new(0, 360, 0, 220)
    LoadFrame.Position = UDim2.new(0.5, -180, 0.5, -110)
    LoadFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    LoadFrame.BorderSizePixel = 0
    LoadFrame.Parent = ScreenGui
    Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 12)

    local LoadImg = Instance.new("ImageLabel")
    LoadImg.Size = UDim2.new(0, 90, 0, 90)
    LoadImg.Position = UDim2.new(0.5, -45, 0.15, 0)
    LoadImg.BackgroundTransparency = 1
    LoadImg.Image = "rbxassetid://11180945609"
    LoadImg.Parent = LoadFrame

    local LoadText = Instance.new("TextLabel")
    LoadText.Size = UDim2.new(1, 0, 0, 40)
    LoadText.Position = UDim2.new(0, 0, 0.62, 0)
    LoadText.BackgroundTransparency = 1
    LoadText.Font = Enum.Font.SourceSansBold
    LoadText.TextSize = 22
    LoadText.TextColor3 = Color3.fromRGB(0, 255, 127)
    LoadText.Text = "Yükleniyor..."
    LoadText.Parent = LoadFrame

    task.wait(1.5)
    LoadText.Text = "Yüklendi!"
    task.wait(1.2)
    LoadFrame:Destroy()

    -- Ana Menü Çerçevesi
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 520, 0, 480)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -240)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Header.Font = Enum.Font.SourceSansBold
    Header.TextSize = 18
    Header.TextColor3 = Color3.fromRGB(255, 50, 50)
    Header.Text = "💀 VreX Hub 💀 [Ultimate Roblox Hile & Aimbot Menüsü]"
    Header.Parent = MainFrame

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 10)
    HeaderCorner.Parent = Header

    -- Sekme Sistemi (Tab Menü)
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(0.9, 0, 0.08, 0)
    TabContainer.Position = UDim2.new(0.05, 0, 0.12, 0)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame

    local TabScriptsBtn = Instance.new("TextButton")
    TabScriptsBtn.Size = UDim2.new(0.23, 0, 1, 0)
    TabScriptsBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 120)
    TabScriptsBtn.Font = Enum.Font.SourceSansBold
    TabScriptsBtn.TextSize = 13
    TabScriptsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabScriptsBtn.Text = "Oyun Hileleri"
    TabScriptsBtn.Parent = TabContainer
    Instance.new("UICorner", TabScriptsBtn).CornerRadius = UDim.new(0, 6)

    local TabAimbotBtn = Instance.new("TextButton")
    TabAimbotBtn.Size = UDim2.new(0.23, 0, 1, 0)
    TabAimbotBtn.Position = UDim2.new(0.25, 0, 0, 0)
    TabAimbotBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabAimbotBtn.Font = Enum.Font.SourceSansBold
    TabAimbotBtn.TextSize = 13
    TabAimbotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabAimbotBtn.Text = "Aimbot Ayarları"
    TabAimbotBtn.Parent = TabContainer
    Instance.new("UICorner", TabAimbotBtn).CornerRadius = UDim.new(0, 6)

    local TabColorBtn = Instance.new("TextButton")
    TabColorBtn.Size = UDim2.new(0.23, 0, 1, 0)
    TabColorBtn.Position = UDim2.new(0.50, 0, 0, 0)
    TabColorBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabColorBtn.Font = Enum.Font.SourceSansBold
    TabColorBtn.TextSize = 13
    TabColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabColorBtn.Text = "Renkler"
    TabColorBtn.Parent = TabContainer
    Instance.new("UICorner", TabColorBtn).CornerRadius = UDim.new(0, 6)

    local TabExecBtn = Instance.new("TextButton")
    TabExecBtn.Size = UDim2.new(0.23, 0, 1, 0)
    TabExecBtn.Position = UDim2.new(0.75, 0, 0, 0)
    TabExecBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TabExecBtn.Font = Enum.Font.SourceSansBold
    TabExecBtn.TextSize = 13
    TabExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabExecBtn.Text = "Executor"
    TabExecBtn.Parent = TabContainer
    Instance.new("UICorner", TabExecBtn).CornerRadius = UDim.new(0, 6)

    -- 1. Sayfa: Oyun Scriptleri Bölümü (ScrollingFrame)
    local ScriptsPage = Instance.new("ScrollingFrame")
    ScriptsPage.Size = UDim2.new(0.9, 0, 0.7, 0)
    ScriptsPage.Position = UDim2.new(0.05, 0, 0.22, 0)
    ScriptsPage.BackgroundTransparency = 1
    ScriptsPage.BorderSizePixel = 0
    ScriptsPage.CanvasSize = UDim2.new(0, 0, 0, 2600)
    ScriptsPage.ScrollBarThickness = 6
    ScriptsPage.Visible = true
    ScriptsPage.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = ScriptsPage

    -- 2. Sayfa: Aimbot Ayarları Sayfası
    local AimbotPage = Instance.new("Frame")
    AimbotPage.Size = UDim2.new(0.9, 0, 0.7, 0)
    AimbotPage.Position = UDim2.new(0.05, 0, 0.22, 0)
    AimbotPage.BackgroundTransparency = 1
    AimbotPage.Visible = false
    AimbotPage.Parent = MainFrame

    -- Aimbot Değişkenleri
    local aimbotEnabled = false
    local aimPartOption = "Head"
    local circleRadius = 150
    local smoothness = 0.15
    local aimbotMode = "Hold"
    local activationKey = Enum.UserInputType.MouseButton2
    local espEnabled = false
    local teamEspEnabled = false
    local defaultESPColor = Color3.fromRGB(255,255,255)
    local holdingKey = false
    local target = nil
    local toggleActive = false
    local playerESPs = {}
    local aimCandidates = {"Head", "Torso"}

    -- FOV Çemberi
    local circle = Drawing.new("Circle")
    circle.Thickness = 1.5
    circle.NumSides = 64
    circle.Radius = circleRadius
    circle.Color = Color3.fromRGB(0, 255, 255)
    circle.Filled = false
    circle.Visible = true
    circle.Transparency = 0.8

    -- Aimbot Arayüz Elemanları
    local aimToggleBtn = Instance.new("TextButton", AimbotPage)
    aimToggleBtn.Size = UDim2.new(0.48, 0, 0, 35)
    aimToggleBtn.Position = UDim2.new(0, 0, 0, 10)
    aimToggleBtn.Text = "Aimbot: OFF"
    aimToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    aimToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    aimToggleBtn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", aimToggleBtn).CornerRadius = UDim.new(0, 6)

    aimToggleBtn.MouseButton1Click:Connect(function()
        aimbotEnabled = not aimbotEnabled
        if aimbotEnabled then
            aimToggleBtn.Text = "Aimbot: ON"
            aimToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        else
            aimToggleBtn.Text = "Aimbot: OFF"
            aimToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            toggleActive = false
            target = nil
        end
    end)

    local modeBtn = Instance.new("TextButton", AimbotPage)
    modeBtn.Size = UDim2.new(0.48, 0, 0, 35)
    modeBtn.Position = UDim2.new(0.52, 0, 0, 10)
    modeBtn.Text = "Mode: Hold"
    modeBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    modeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    modeBtn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", modeBtn).CornerRadius = UDim.new(0, 6)

    modeBtn.MouseButton1Click:Connect(function()
        aimbotMode = (aimbotMode == "Hold" and "Toggle" or "Hold")
        modeBtn.Text = "Mode: " .. aimbotMode
        toggleActive = false
        target = nil
    end)

    local keyBtn = Instance.new("TextButton", AimbotPage)
    keyBtn.Size = UDim2.new(1, 0, 0, 35)
    keyBtn.Position = UDim2.new(0, 0, 0, 55)
    keyBtn.Text = "Activation Key: Right Click"
    keyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBtn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6)

    local waitingForKey = false
    keyBtn.MouseButton1Click:Connect(function()
        waitingForKey = true
        keyBtn.Text = "Press any key..."
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if waitingForKey and not gameProcessed then
            waitingForKey = false
            if input.UserInputType == Enum.UserInputType.Keyboard then
                activationKey = input.KeyCode
                keyBtn.Text = "Key: " .. activationKey.Name
            else
                activationKey = input.UserInputType
                keyBtn.Text = "Key: " .. tostring(activationKey):gsub("Enum.UserInputType.", "")
            end
        end
    end)

    -- Range Controls
    local leftArrow = Instance.new("TextButton", AimbotPage)
    leftArrow.Size = UDim2.new(0.15, 0, 0, 35)
    leftArrow.Position = UDim2.new(0, 0, 0, 100)
    leftArrow.Text = "<"
    leftArrow.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    leftArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", leftArrow).CornerRadius = UDim.new(0, 6)

    local rightArrow = Instance.new("TextButton", AimbotPage)
    rightArrow.Size = UDim2.new(0.15, 0, 0, 35)
    rightArrow.Position = UDim2.new(0.85, 0, 0, 100)
    rightArrow.Text = ">"
    rightArrow.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    rightArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", rightArrow).CornerRadius = UDim.new(0, 6)

    local rangeLbl = Instance.new("TextLabel", AimbotPage)
    rangeLbl.Size = UDim2.new(0.65, 0, 0, 35)
    rangeLbl.Position = UDim2.new(0.175, 0, 0, 100)
    rangeLbl.Text = "Range (FOV): " .. circleRadius
    rangeLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    rangeLbl.BackgroundTransparency = 1
    rangeLbl.Font = Enum.Font.SourceSansBold

    leftArrow.MouseButton1Click:Connect(function()
        circleRadius = math.clamp(circleRadius - 10, 50, 800)
        rangeLbl.Text = "Range (FOV): " .. circleRadius
        circle.Radius = circleRadius
    end)

    rightArrow.MouseButton1Click:Connect(function()
        circleRadius = math.clamp(circleRadius + 10, 50, 800)
        rangeLbl.Text = "Range (FOV): " .. circleRadius
        circle.Radius = circleRadius
    end)

    -- Aim Part Selector
    local aimCycleBtn = Instance.new("TextButton", AimbotPage)
    aimCycleBtn.Size = UDim2.new(1, 0, 0, 35)
    aimCycleBtn.Position = UDim2.new(0, 0, 0, 145)
    aimCycleBtn.Text = "Aim Part: Head (Click to Change)"
    aimCycleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    aimCycleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    aimCycleBtn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", aimCycleBtn).CornerRadius = UDim.new(0, 6)

    aimCycleBtn.MouseButton1Click:Connect(function()
        if aimPartOption == "Head" then
            aimPartOption = "Torso"
        elseif aimPartOption == "Torso" then
            aimPartOption = "Random"
        else
            aimPartOption = "Head"
        end
        aimCycleBtn.Text = "Aim Part: " .. aimPartOption .. " (Click to Change)"
    end)

    -- ESP Toggles
    local espBtn = Instance.new("TextButton", AimbotPage)
    espBtn.Size = UDim2.new(0.48, 0, 0, 35)
    espBtn.Position = UDim2.new(0, 0, 0, 195)
    espBtn.Text = "ESP: OFF"
    espBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    espBtn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 6)

    espBtn.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        if espEnabled then
            espBtn.Text = "ESP: ON"
            espBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        else
            espBtn.Text = "ESP: OFF"
            espBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            for pl, obj in pairs(playerESPs) do
                if obj.gui then obj.gui:Destroy() end
            end
            playerESPs = {}
        end
    end)

    local teamEspBtn = Instance.new("TextButton", AimbotPage)
    teamEspBtn.Size = UDim2.new(0.48, 0, 0, 35)
    teamEspBtn.Position = UDim2.new(0.52, 0, 0, 195)
    teamEspBtn.Text = "Team ESP: OFF"
    teamEspBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    teamEspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    teamEspBtn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", teamEspBtn).CornerRadius = UDim.new(0, 6)

    teamEspBtn.MouseButton1Click:Connect(function()
        teamEspEnabled = not teamEspEnabled
        if teamEspEnabled then
            teamEspBtn.Text = "Team ESP: ON"
            teamEspBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        else
            teamEspBtn.Text = "Team ESP: OFF"
            teamEspBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end
    end)

    -- 3. Sayfa: Renk Ayarlama Sayfası
    local ColorPage = Instance.new("Frame")
    ColorPage.Size = UDim2.new(0.9, 0, 0.7, 0)
    ColorPage.Position = UDim2.new(0.05, 0, 0.22, 0)
    ColorPage.BackgroundTransparency = 1
    ColorPage.Visible = false
    ColorPage.Parent = MainFrame

    local ColorLbl = Instance.new("TextLabel", ColorPage)
    ColorLbl.Size = UDim2.new(1, 0, 0, 40)
    ColorLbl.BackgroundTransparency = 1
    ColorLbl.Font = Enum.Font.SourceSansBold
    ColorLbl.TextSize = 16
    ColorLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    ColorLbl.Text = "Hile Menüsü Tema Rengini Seçin:"

    local function createColorThemeButton(name, col, posY)
        local btn = Instance.new("TextButton", ColorPage)
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.Position = UDim2.new(0, 0, 0, posY)
        btn.BackgroundColor3 = col
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 16
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Text = name
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            Header.BackgroundColor3 = col
            TabScriptsBtn.BackgroundColor3 = col
            TabAimbotBtn.BackgroundColor3 = col
            TabColorBtn.BackgroundColor3 = col
            TabExecBtn.BackgroundColor3 = col
        end)
    end

    createColorThemeButton("🔴 Kırmızı Tema (Kuru Kafa Stili)", Color3.fromRGB(180, 30, 30), 50)
    createColorThemeButton("🔵 Mavi Tema (Cyber Stili)", Color3.fromRGB(30, 100, 200), 100)
    createColorThemeButton("🟢 Yeşil Tema (Hacker Stili)", Color3.fromRGB(0, 150, 70), 150)
    createColorThemeButton("🟣 Mor Tema (Dark Stili)", Color3.fromRGB(120, 30, 180), 200)
    createColorThemeButton("🟡 Turuncu Tema (Neon Stili)", Color3.fromRGB(200, 120, 0), 250)

    -- 4. Sayfa: Özel Executor Sayfası
    local ExecPage = Instance.new("Frame")
    ExecPage.Size = UDim2.new(0.9, 0, 0.7, 0)
    ExecPage.Position = UDim2.new(0.05, 0, 0.22, 0)
    ExecPage.BackgroundTransparency = 1
    ExecPage.Visible = false
    ExecPage.Parent = MainFrame

    local ScriptBox = Instance.new("TextBox", ExecPage)
    ScriptBox.Size = UDim2.new(1, 0, 0.75, 0)
    ScriptBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ScriptBox.Font = Enum.Font.Code
    ScriptBox.TextSize = 14
    ScriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptBox.PlaceholderText = "-- Buraya kendi Lua script kodunuzu yazın...\nprint('VreX Executor Aktif')"
    ScriptBox.Text = ""
    ScriptBox.MultiLine = true
    ScriptBox.ClearTextOnFocus = false
    ScriptBox.TextXAlignment = Enum.TextXAlignment.Left
    ScriptBox.TextYAlignment = Enum.TextYAlignment.Top
    Instance.new("UICorner", ScriptBox).CornerRadius = UDim.new(0, 6)

    local ExecuteBtn = Instance.new("TextButton", ExecPage)
    ExecuteBtn.Size = UDim2.new(0.48, 0, 0, 40)
    ExecuteBtn.Position = UDim2.new(0, 0, 0.79, 0)
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
    ExecuteBtn.Font = Enum.Font.SourceSansBold
    ExecuteBtn.TextSize = 16
    ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteBtn.Text = "Execute (Çalıştır)"
    Instance.new("UICorner", ExecuteBtn).CornerRadius = UDim.new(0, 6)

    local ClearBtn = Instance.new("TextButton", ExecPage)
    ClearBtn.Size = UDim2.new(0.48, 0, 0, 40)
    ClearBtn.Position = UDim2.new(0.52, 0, 0.79, 0)
    ClearBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    ClearBtn.Font = Enum.Font.SourceSansBold
    ClearBtn.TextSize = 16
    ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ClearBtn.Text = "Temizle"
    Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 6)

    ExecuteBtn.MouseButton1Click:Connect(function()
        local code = ScriptBox.Text
        if code and code ~= "" then
            local success, err = pcall(function()
                loadstring(code)()
            end)
            if success then
                ExecuteBtn.Text = "Script Uygulandı!"
                task.wait(2)
                ExecuteBtn.Text = "Execute (Çalıştır)"
            else
                ExecuteBtn.Text = "Hata Oluştu!"
                warn(err)
                task.wait(2)
                ExecuteBtn.Text = "Execute (Çalıştır)"
            end
        end
    end)

    ClearBtn.MouseButton1Click:Connect(function()
        ScriptBox.Text = ""
    end)

    -- Sekme Geçiş Mantıkları
    TabScriptsBtn.MouseButton1Click:Connect(function()
        ScriptsPage.Visible = true
        AimbotPage.Visible = false
        ColorPage.Visible = false
        ExecPage.Visible = false
        TabScriptsBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 120)
        TabAimbotBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabColorBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabExecBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)

    TabAimbotBtn.MouseButton1Click:Connect(function()
        ScriptsPage.Visible = false
        AimbotPage.Visible = true
        ColorPage.Visible = false
        ExecPage.Visible = false
        TabAimbotBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 120)
        TabScriptsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabColorBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabExecBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)

    TabColorBtn.MouseButton1Click:Connect(function()
        ScriptsPage.Visible = false
        AimbotPage.Visible = false
        ColorPage.Visible = true
        ExecPage.Visible = false
        TabColorBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 120)
        TabScriptsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabAimbotBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabExecBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)

    TabExecBtn.MouseButton1Click:Connect(function()
        ScriptsPage.Visible = false
        AimbotPage.Visible = false
        ColorPage.Visible = false
        ExecPage.Visible = true
        TabExecBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 120)
        TabScriptsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabAimbotBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabColorBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)

    local function createScriptButton(name, callback)
        local btn = Instance.new("TextButton", ScriptsPage)
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 15
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Text = name
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            callback(btn)
        end)
    end

    local function createCategoryLabel(text)
        local lbl = Instance.new("TextLabel", ScriptsPage)
        lbl.Size = UDim2.new(1, 0, 0, 25)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.SourceSansBold
        lbl.TextSize = 14
        lbl.TextColor3 = Color3.fromRGB(255, 50, 50)
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Text = "--- " .. text .. " ---"
    end

    ---------------------------------------------------------
    -- OYUN LİSTESİ VE NOTIFIER
    ---------------------------------------------------------
    createCategoryLabel("Blox Fruits & Özel Notifier")

    local fruitEspActive = false
    local BottomLabel = Instance.new("TextLabel")
    BottomLabel.Size = UDim2.new(0, 400, 0, 50)
    BottomLabel.Position = UDim2.new(0.5, -200, 0.85, 0)
    BottomLabel.BackgroundTransparency = 1
    BottomLabel.Font = Enum.Font.SourceSansBold
    BottomLabel.TextSize = 22
    BottomLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    BottomLabel.TextStrokeTransparency = 0
    BottomLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    BottomLabel.Text = ""
    BottomLabel.Visible = false
    BottomLabel.Parent = ScreenGui

    local function createFruitESP(fruit)
        if fruit:FindFirstChild("Handle") and not fruit:FindFirstChild("FruitESP") then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "FruitESP"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.AlwaysOnTop = true
            billboard.Adornee = fruit.Handle

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            textLabel.TextStrokeTransparency = 0
            textLabel.TextSize = 14
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.Text = fruit.Name
            textLabel.Parent = billboard
            billboard.Parent = fruit
        end
    end

    createScriptButton("Fruit Notifier ESP: KAPALI", function(btn)
        fruitEspActive = not fruitEspActive
        if fruitEspActive then
            btn.Text = "Fruit Notifier ESP: AÇIK"
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj.Name:find("Fruit") and obj:FindFirstChild("Handle") then
                    createFruitESP(obj)
                end
            end
        else
            btn.Text = "Fruit Notifier ESP: KAPALI"
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            BottomLabel.Visible = false
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj:FindFirstChild("FruitESP") then
                    obj.FruitESP:Destroy()
                end
            end
        end
    end)

    Workspace.ChildAdded:Connect(function(obj)
        if obj.Name:find("Fruit") then
            task.wait(0.5)
            if obj:FindFirstChild("Handle") then
                if fruitEspActive then
                    createFruitESP(obj)
                end
                showTopAlert("FRUIT SPAWNLANDI! ESP AÇILDI!", Color3.fromRGB(0, 255, 0))
            end
        end
    end)

    Workspace.ChildRemoved:Connect(function(obj)
        if obj.Name:find("Fruit") then
            showTopAlert("FRUIT YOK OLDU!", Color3.fromRGB(255, 50, 50))
        end
    end)

    task.spawn(function()
        while ScreenGui.Parent do
            if fruitEspActive then
                local closest = nil
                local shortestDist = math.huge

                for _, obj in ipairs(Workspace:GetChildren()) do
                    if obj.Name:find("Fruit") and obj:FindFirstChild("Handle") then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - obj.Handle.Position).Magnitude
                            if dist < shortestDist then
                                shortestDist = dist
                                closest = obj
                            end
                        end
                    end
                end

                if closest then
                    BottomLabel.Text = "FRUIT DETECTED: " .. math.floor(shortestDist) .. "m away"
                    BottomLabel.Visible = true
                else
                    BottomLabel.Visible = false
                end
            end
            task.wait(0.5)
        end
    end)

    createCategoryLabel("Admin Komutları & Universal Araçlar")
    createScriptButton("HD Admin Komutları Yükle", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/robloxscripts/hdadmin/main/loader.lua")))
        btn.Text = "HD Admin Yüklendi!"
    end)

    createScriptButton("Infinite Yield (Uçma, Noclip vb.)", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source')))
        btn.Text = "Infinite Yield Yüklendi!"
    end)

    createScriptButton("Dex Explorer (Oyun Kod İnceleme)", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua")))
        btn.Text = "Dex Yüklendi!"
    end)

    createCategoryLabel("Brookhaven RP Hileleri")
    createScriptButton("Brookhaven RP (GUI Hub & Music ID)", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMaestroc/IceHub/main/Brookhaven")))
        btn.Text = "Brookhaven Hub Yüklendi!"
    end)

    createScriptButton("Brookhaven RP (Admin & Özel Özellikler)", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkraiHub/Brookhaven/main/Main.lua")))
        btn.Text = "Brookhaven Admin Yüklendi!"
    end)

    createCategoryLabel("Popüler Anime & Dövüş Oyunları")
    createScriptButton("Blox Fruits (Redz Hub / Auto Farm)", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BloxFruits/main/init.lua")))
        btn.Text = "Blox Fruits Yüklendi!"
    end)

    createScriptButton("The Strongest Battlegrounds", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/ATOMICHUB/Main/main/TSB.lua")))
        btn.Text = "TSB Yüklendi!"
    end)

    createScriptButton("Your Bizarre Adventure (YBA)", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/KryptonHub/YBA/main/Main.lua")))
        btn.Text = "YBA Yüklendi!"
    end)

    createScriptButton("Anime Vanguards", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/AbsoluteX/AnimeVanguards/main/Main.lua")))
        btn.Text = "Anime Vanguards Yüklendi!"
    end)

    createScriptButton("King Legacy", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/Zepsis/KingLegacy/main/Main.lua")))
        btn.Text = "King Legacy Yüklendi!"
    end)

    createCategoryLabel("Simülatör & Para Oyunları")
    createScriptButton("Pet Simulator 99", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/ZenHubs/PS99/main/Main.lua")))
        btn.Text = "PS99 Yüklendi!"
    end)

    createScriptButton("Blade Ball", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/BladeBall%20Hub.lua")))
        btn.Text = "Blade Ball Yüklendi!"
    end)

    createScriptButton("Bee Swarm Simulator", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/HubScripter/BSS/main/Main.lua")))
        btn.Text = "Bee Swarm Yüklendi!"
    end)

    createScriptButton("Driving Empire", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/FastHub/DrivingEmpire/main/Main.lua")))
        btn.Text = "Driving Empire Yüklendi!"
    end)

    createCategoryLabel("Hayatta Kalma, Korku & Diğer Oyunlar")
    createScriptButton("BedWars (VAPE V4)", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true)))
        btn.Text = "BedWars VAPE Yüklendi!"
    end)

    createScriptButton("Murder Mystery 2 (MM2)", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/DoggoHub/MM2/main/Loader.lua")))
        btn.Text = "MM2 Yüklendi!"
    end)

    createScriptButton("Doors (Entity / ESP)", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://rawscripts.net/raw/DOORS-Blackout-Hub-or-Entity-Notifier-14532")))
        btn.Text = "Doors Yüklendi!"
    end)

    createScriptButton("Tower of Hell", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://rawscripts.net/raw/Tower-of-Hell-TOH-GUI-5341")))
        btn.Text = "Tower of Hell Yüklendi!"
    end)

    createScriptButton("Adopt Me!", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/AdoptMeHub/Main/main/Loader.lua")))
        btn.Text = "Adopt Me Yüklendi!"
    end)

    createScriptButton("Evade", function(btn)
        btn.Text = "Yükleniyor..."
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/EvadeHub/Main/main/Loader.lua")))
        btn.Text = "Evade Yüklendi!"
    end)

    createCategoryLabel("Menü Kontrolleri")

    createScriptButton("Hileyi Gizle (P tuşu)", function()
        MainFrame.Visible = false
        BottomLabel.Visible = false
        
        local HiddenNotice = Instance.new("TextLabel")
        HiddenNotice.Name = "HiddenNotice"
        HiddenNotice.Size = UDim2.new(0, 300, 0, 40)
        HiddenNotice.Position = UDim2.new(0.5, -150, 0.05, 0)
        HiddenNotice.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        HiddenNotice.BackgroundTransparency = 0.5
        HiddenNotice.Font = Enum.Font.SourceSansBold
        HiddenNotice.TextSize = 14
        HiddenNotice.TextColor3 = Color3.fromRGB(255, 255, 255)
        HiddenNotice.Text = "Hile gizlendi. Geri getirmek için P tuşuna basın."
        HiddenNotice.Parent = ScreenGui
        
        Instance.new("UICorner", HiddenNotice).CornerRadius = UDim.new(0, 6)
    end)

    createScriptButton("Hileyi Kapat", function()
        local ConfirmFrame = Instance.new("Frame")
        ConfirmFrame.Size = UDim2.new(0, 260, 0, 120)
        ConfirmFrame.Position = UDim2.new(0.5, -130, 0.5, -60)
        ConfirmFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        ConfirmFrame.BorderSizePixel = 0
        ConfirmFrame.Parent = ScreenGui
        Instance.new("UICorner", ConfirmFrame).CornerRadius = UDim.new(0, 6)

        local cText = Instance.new("TextLabel")
        cText.Size = UDim2.new(1, 0, 0, 50)
        cText.BackgroundTransparency = 1
        cText.Font = Enum.Font.SourceSansBold
        cText.TextSize = 16
        cText.TextColor3 = Color3.fromRGB(255, 255, 255)
        cText.Text = "Hileyi kapatmak istediğine emin misin?"
        cText.Parent = ConfirmFrame

        local YesBtn = Instance.new("TextButton")
        YesBtn.Size = UDim2.new(0.4, 0, 0, 35)
        YesBtn.Position = UDim2.new(0.075, 0, 0.6, 0)
        YesBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        YesBtn.Font = Enum.Font.SourceSansBold
        YesBtn.TextSize = 14
        YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        YesBtn.Text = "Evet, Kapat"
        YesBtn.Parent = ConfirmFrame
        Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0, 6)

        local NoBtn = Instance.new("TextButton")
        NoBtn.Size = UDim2.new(0.4, 0, 0, 35)
        NoBtn.Position = UDim2.new(0.525, 0, 0.6, 0)
        NoBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        NoBtn.Font = Enum.Font.SourceSansBold
        NoBtn.TextSize = 14
        NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        NoBtn.Text = "İptal"
        NoBtn.Parent = ConfirmFrame
        Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0, 6)

        YesBtn.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)

        NoBtn.MouseButton1Click:Connect(function()
            ConfirmFrame:Destroy()
        end)
    end)

    -- Aimbot Yardımcı Fonksiyonları
    local function findAimPartInCharacter(character, wantPartName)
        if not character then return nil end
        if wantPartName == "Head" then
            return character:FindFirstChild("Head")
        elseif wantPartName == "Torso" then
            return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("LowerTorso")
        else
            local choice = aimCandidates[math.random(1, #aimCandidates)]
            return findAimPartInCharacter(character, choice)
        end
    end

    local function isPartValid(p)
        if not p then return false end
        if not p:IsDescendantOf(Workspace) then return false end
        local model = p:FindFirstAncestorOfClass("Model")
        if not model then return false end
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        if humanoid.Health <= 0 then return false end
        return true
    end

    local function getClosestToMouse()
        local closest, dist = nil, circleRadius
        local mousePos = UserInputService:GetMouseLocation()

        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= LocalPlayer and otherPlayer.Character then
                local part = findAimPartInCharacter(otherPlayer.Character, aimPartOption)
                if part then
                    local screenPoint, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local mag = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude
                        if mag < dist then
                            dist = mag
                            closest = part
                        end
                    end
                end
            end
        end
        return closest
    end

    local function acquireTarget()
        local p = getClosestToMouse()
        if isPartValid(p) then
            target = p
            return true
        end
        target = nil
        return false
    end

    local function clearTarget()
        target = nil
    end

    local function createESP(playerObj)
        if not playerObj or not playerObj.Character then return nil end
        local char = playerObj.Character
        if playerESPs[playerObj] and playerESPs[playerObj].gui then
            return playerESPs[playerObj]
        end

        local head = char:FindFirstChild("Head")
        local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        local attachPart = head or root
        if not attachPart then return nil end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Billboard"
        billboard.Adornee = attachPart
        billboard.Size = UDim2.new(0, 120, 0, 48)
        billboard.AlwaysOnTop = true
        billboard.MaxDistance = 1000
        billboard.Parent = ScreenGui

        local frame = Instance.new("Frame", billboard)
        frame.Size = UDim2.new(1,0,1,0)
        frame.BackgroundTransparency = 1

        local nameLabel = Instance.new("TextLabel", frame)
        nameLabel.Size = UDim2.new(1,0,0.6,0)
        nameLabel.Position = UDim2.new(0,0,0,0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.new(0,0,0)
        nameLabel.Text = playerObj.Name
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextSize = 14
        nameLabel.TextColor3 = defaultESPColor

        local distLabel = Instance.new("TextLabel", frame)
        distLabel.Size = UDim2.new(1,0,0.4,0)
        distLabel.Position = UDim2.new(0,0,0.6,0)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = ""
        distLabel.Font = Enum.Font.SourceSans
        distLabel.TextSize = 12
        distLabel.TextColor3 = defaultESPColor

        playerESPs[playerObj] = {
            gui = billboard,
            nameLabel = nameLabel,
            distLabel = distLabel,
            attachedPart = attachPart
        }
        return playerESPs[playerObj]
    end

    local function removeESP(playerObj)
        if playerESPs[playerObj] then
            if playerESPs[playerObj].gui then
                playerESPs[playerObj].gui:Destroy()
            end
            playerESPs[playerObj] = nil
        end
    end

    local function updateESPForPlayer(playerObj)
        local data = playerESPs[playerObj]
        if not data or not data.attachedPart then return end
        local char = playerObj.Character
        if not char then removeESP(playerObj) return end

        local root = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character:FindFirstChild("Torso"))
        local dist = root and (root.Position - Camera.CFrame.Position).Magnitude or 0
        data.distLabel.Text = string.format("%.0f stud", dist)

        local color = defaultESPColor
        if teamEspEnabled and playerObj.Team and playerObj.TeamColor then
            color = playerObj.TeamColor.Color
        end
        data.nameLabel.TextColor3 = color
        data.distLabel.TextColor3 = color
    end

    local function refreshAllESP()
        if not espEnabled then return end
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= LocalPlayer and pl.Character and pl.Character:FindFirstChildOfClass("Humanoid") and pl.Character:FindFirstChild("Humanoid").Health > 0 then
                if not playerESPs[pl] then
                    createESP(pl)
                end
            else
                removeESP(pl)
            end
        end
    end

    Players.PlayerAdded:Connect(function(pl)
        pl.CharacterAdded:Connect(function()
            if espEnabled then
                task.wait(0.05)
                createESP(pl)
            end
        end)
    end)

    Players.PlayerRemoving:Connect(function(pl)
        removeESP(pl)
    end)

    for _, pl in ipairs(Players:GetPlayers()) do
        pl.CharacterAdded:Connect(function()
            if espEnabled then
                task.wait(0.05)
                createESP(pl)
            end
        end)
    end

    RunService.RenderStepped:Connect(function()
        local mousePos = UserInputService:GetMouseLocation()
        circle.Position = Vector2.new(mousePos.X, mousePos.Y)

        if espEnabled then
            refreshAllESP()
            for pl, _ in pairs(playerESPs) do
                updateESPForPlayer(pl)
            end
        end

        if not aimbotEnabled then return end

        if aimbotMode == "Hold" then
            if holdingKey then
                local targetPart = getClosestToMouse()
                if targetPart then
                    local targetPos = targetPart.Position
                    local newCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
                    Camera.CFrame = Camera.CFrame:Lerp(newCFrame, smoothness)
                end
            end
        else
            if toggleActive then
                if isPartValid(target) then
                    local targetPos = target.Position
                    local newCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
                    Camera.CFrame = Camera.CFrame:Lerp(newCFrame, smoothness)
                else
                    if not acquireTarget() then
                    end
                end
            end
        end
    end)

    local function matchesActivation(input)
        if typeof(activationKey) == "EnumItem" then
            if activationKey.EnumType == Enum.KeyCode then
                return input.KeyCode == activationKey
            else
                return input.UserInputType == activationKey
            end
        else
            return (input.UserInputType == activationKey or input.KeyCode == activationKey)
        end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if waitingForKey then return end

        if matchesActivation(input) then
            if aimbotMode == "Hold" then
                holdingKey = true
            else
                toggleActive = not toggleActive
                if toggleActive then
                    acquireTarget()
                else
                    clearTarget()
                end
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if matchesActivation(input) then
            if aimbotMode == "Hold" then
                holdingKey = false
            end
        end
    end)
end

-- Tuş Dinleme (P tuşu ile gizleme / açma)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.P then
        for _, child in ipairs(ScreenGui:GetChildren()) do
            if child:IsA("Frame") and child.Name ~= "KeyFrame" then
                child.Visible = not child.Visible
            end
        end
        if ScreenGui:FindFirstChild("HiddenNotice") then
            ScreenGui.HiddenNotice:Destroy()
        end
    end
end)

-- KEY SİSTEMİ ARAYÜZÜ
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 320, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", KeyFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "VreX Key Sistemi (PC Only)"

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(0.85, 0, 0, 35)
KeyBox.Position = UDim2.new(0.075, 0, 0.3, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyBox.Font = Enum.Font.SourceSans
KeyBox.TextSize = 16
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderText = "Günlük Keyi Giriniz..."
KeyBox.Text = ""
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 6)

local VerifyBtn = Instance.new("TextButton", KeyFrame)
VerifyBtn.Size = UDim2.new(0.4, 0, 0, 35)
VerifyBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
VerifyBtn.Font = Enum.Font.SourceSansBold
VerifyBtn.TextSize = 16
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Text = "Onayla"
Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 6)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.4, 0, 0, 35)
GetKeyBtn.Position = UDim2.new(0.525, 0, 0.65, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
GetKeyBtn.Font = Enum.Font.SourceSansBold
GetKeyBtn.TextSize = 16
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyBtn.Text = "Key Al"
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)

-- Key Al Butonu (Discord Adını Kopyalama)
GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("dc name : vrexhal")
    end
    GetKeyBtn.Text = "Kopyalandı!"
    task.wait(2)
    GetKeyBtn.Text = "Key Al"
end)

-- Onayla Butonu
VerifyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == getDailyKey() then
        KeyFrame:Destroy()
        task.spawn(buildMainHub)
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Hatalı Key! Tekrar Dene."
    end
end)
