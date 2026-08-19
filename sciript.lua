
-- Solara PC Uyumlu Ultimate Hub (Tuş Atama Eklendi)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("VrexhalHub") then
    CoreGui.VrexhalHub:Destroy()
end

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Vrexhal Hub",
    Text = "PC Modu Aktif!",
    Duration = 3
})

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VrexhalHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 540, 0, 400)
MainFrame.Position = UDim2.new(0.5, -270, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Sürükleme
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Position = UDim2.new(0.03, 0, 0, 0)
TitleLabel.Text = "Vrexhal Hub | PC Edition"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0.92, 0, 0.05, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
CloseBtn.TextSize = 16
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local TabList = Instance.new("ScrollingFrame")
TabList.Size = UDim2.new(0, 135, 1, -85)
TabList.Position = UDim2.new(0, 5, 0, 40)
TabList.BackgroundTransparency = 1
TabList.CanvasSize = UDim2.new(0, 0, 1.8, 0)
TabList.ScrollBarThickness = 4
TabList.Parent = MainFrame

local Container = Instance.new("Folder")
Container.Parent = MainFrame

local UserInfoBox = Instance.new("Frame")
UserInfoBox.Size = UDim2.new(0, 135, 0, 40)
UserInfoBox.Position = UDim2.new(0, 5, 1, -45)
UserInfoBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
UserInfoBox.Parent = MainFrame

local UserLabel = Instance.new("TextLabel")
UserLabel.Size = UDim2.new(1, -6, 1, 0)
UserLabel.Position = UDim2.new(0, 3, 0, 0)
UserLabel.Text = "User: " .. LocalPlayer.Name
UserLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
UserLabel.TextSize = 10
UserLabel.BackgroundTransparency = 1
UserLabel.Parent = UserInfoBox

local function createTabContent()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -145, 1, -45)
    page.Position = UDim2.new(0, 145, 0, 40)
    page.BackgroundTransparency = 1
    page.CanvasSize = UDim2.new(0, 0, 3, 0)
    page.ScrollBarThickness = 4
    page.Visible = false
    page.Parent = Container
    return page
end

local AimbotPage = createTabContent()
local ScriptsPage = createTabContent()
local ExtraPage = createTabContent()
local TrollPage = createTabContent()
AimbotPage.Visible = true

local function createTabButton(text, yPos, targetPage)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 35)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    btn.TextSize = 13
    btn.Font = Enum.Font.Gotham
    btn.Parent = TabList
    btn.MouseButton1Click:Connect(function()
        for _, page in pairs(Container:GetChildren()) do page.Visible = false end
        targetPage.Visible = true
    end)
end

createTabButton("Aimbot & Tuş", 0, AimbotPage)
createTabButton("Scripts & Dex", 40, ScriptsPage)
createTabButton("PC Ekstra", 80, ExtraPage)
createTabButton("Troll & Fling", 120, TrollPage)

-- 1. AIMBOT, TUŞ ATAMA & LOCK POSE
local aimbotEnabled, isAiming, lockedTarget = false, false, nil
local aimKey = Enum.UserInputType.MouseButton2
local aimPart = "Head"

local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Size = UDim2.new(0.9, 0, 0, 35)
AimbotToggle.Position = UDim2.new(0.05, 0, 0.02, 0)
AimbotToggle.Text = "Aimbot: OFF"
AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggle.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
AimbotToggle.Parent = AimbotPage

AimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = aimbotEnabled and "Aimbot: ON" or "Aimbot: OFF"
    AimbotToggle.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(150, 40, 40)
    if not aimbotEnabled then lockedTarget = nil end
end)

local KeyBindBtn = Instance.new("TextButton")
KeyBindBtn.Size = UDim2.new(0.9, 0, 0, 35)
KeyBindBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
KeyBindBtn.Text = "Aimbot Tuş: Sağ Tık"
KeyBindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBindBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
KeyBindBtn.Parent = AimbotPage

local bindingKey = false
KeyBindBtn.MouseButton1Click:Connect(function()
    KeyBindBtn.Text = "Bir Tuşa Bas..."
    bindingKey = true
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if bindingKey then
        if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.MouseButton3 then
            aimKey = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType
            KeyBindBtn.Text = "Tuş: " .. (input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode.Name or input.UserInputType.Name)
            bindingKey = false
        end
    else
        if not gp and (input.UserInputType == aimKey or input.KeyCode == aimKey) then
            isAiming = not isAiming
            if not isAiming then lockedTarget = nil end
        end
    end
end)

local PartSelectBtn = Instance.new("TextButton")
PartSelectBtn.Size = UDim2.new(0.9, 0, 0, 35)
PartSelectBtn.Position = UDim2.new(0.05, 0, 0.22, 0)
PartSelectBtn.Text = "Hedef Bölge: Kafa (Head)"
PartSelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PartSelectBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
PartSelectBtn.Parent = AimbotPage

PartSelectBtn.MouseButton1Click:Connect(function()
    if aimPart == "Head" then
        aimPart = "HumanoidRootPart"
        PartSelectBtn.Text = "Hedef Bölge: Gövde (RootPart)"
    else
        aimPart = "Head"
        PartSelectBtn.Text = "Hedef Bölge: Kafa (Head)"
    end
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and isAiming then
        if lockedTarget and lockedTarget.Parent and lockedTarget.Parent:FindFirstChild("Humanoid") and lockedTarget.Parent.Humanoid.Health > 0 then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, lockedTarget.Position), 0.3)
        else
            lockedTarget = nil
            local nearest, shortest = nil, math.huge
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(aimPart) and v.Character.Humanoid.Health > 0 then
                    local part = v.Character[aimPart]
                    local sp, onScreen = Camera:WorldToScreenPoint(part.Position)
                    if onScreen then
                        local dist = (Vector2.new(sp.X, sp.Y) - UserInputService:GetMouseLocation()).Magnitude
                        if dist < shortest then shortest = dist nearest = part end
                    end
                end
            end
            if nearest then
                lockedTarget = nearest
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, lockedTarget.Position), 0.3)
            end
        end
    else
        lockedTarget = nil
    end
end)

-- 2. SCRIPTS & SOLARA UYUMLU DEX
local DexBtn = Instance.new("TextButton")
DexBtn.Size = UDim2.new(0.9, 0, 0, 35)
DexBtn.Position = UDim2.new(0.05, 0, 0.02, 0)
DexBtn.Text = "Dark Dex V3 (Çalışan Sürüm)"
DexBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DexBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
DexBtn.Parent = ScriptsPage
DexBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua"))()
    end)
end)

local IYBtn = Instance.new("TextButton")
IYBtn.Size = UDim2.new(0.9, 0, 0, 35)
IYBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
IYBtn.Text = "Infinite Yield"
IYBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
IYBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
IYBtn.Parent = ScriptsPage
IYBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end)
end)

local RemoteSpyBtn = Instance.new("TextButton")
RemoteSpyBtn.Size = UDim2.new(0.9, 0, 0, 35)
RemoteSpyBtn.Position = UDim2.new(0.05, 0, 0.22, 0)
RemoteSpyBtn.Text = "SimpleSpy (Remote Spy)"
RemoteSpyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RemoteSpyBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
RemoteSpyBtn.Parent = ScriptsPage
RemoteSpyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremez/SimpleSpy/master/SimpleSpy.lua"))()
    end)
end)

-- 3. PC EKSTRA & REJOIN
local ESPBtn = Instance.new("TextButton")
ESPBtn.Size = UDim2.new(0.9, 0, 0, 35)
ESPBtn.Position = UDim2.new(0.05, 0, 0.02, 0)
ESPBtn.Text = "Player ESP"
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
ESPBtn.Parent = ExtraPage
ESPBtn.MouseButton1Click:Connect(function()
    pcall(function()
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and not v.Character:FindFirstChild("Highlight") then
                local hl = Instance.new("Highlight")
                hl.Adornee = v.Character
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.Parent = v.Character
            end
        end
    end)
end)

local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(0.9, 0, 0, 35)
SpeedBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
SpeedBtn.Text = "WalkSpeed: 120"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
SpeedBtn.Parent = ExtraPage
SpeedBtn.MouseButton1Click:Connect(function()
    pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 120 end)
end)

local NoclipBtn = Instance.new("TextButton")
NoclipBtn.Size = UDim2.new(0.9, 0, 0, 35)
NoclipBtn.Position = UDim2.new(0.05, 0, 0.22, 0)
NoclipBtn.Text = "Noclip: KAPALI"
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
NoclipBtn.Parent = ExtraPage

local noclipi = false
NoclipBtn.MouseButton1Click:Connect(function()
    noclipi = not noclipi
    NoclipBtn.Text = noclipi and "Noclip: AÇIK" or "Noclip: KAPALI"
end)
RunService.Stepped:Connect(function()
    if noclipi and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Size = UDim2.new(0.9, 0, 0, 35)
RejoinBtn.Position = UDim2.new(0.05, 0, 0.32, 0)
RejoinBtn.Text = "Rejoin (Yeniden Giriş)"
RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 40)
RejoinBtn.Parent = ExtraPage
RejoinBtn.MouseButton1Click:Connect(function()
    pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end)

-- 4. TROLL
local FlingBtn = Instance.new("TextButton")
FlingBtn.Size = UDim2.new(0.9, 0, 0, 35)
FlingBtn.Position = UDim2.new(0.05, 0, 0.02, 0)
FlingBtn.Text = "Fling (Herkesi Uçur)"
FlingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
FlingBtn.Parent = TrollPage
FlingBtn.MouseButton1Click:Connect(function()
    pcall(function()
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Velocity = Vector3.new(99999, 99999, 99999)
            end
        end
    end)
end)
