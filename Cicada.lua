-- ============================================================
-- MENU SCRIPT DELTA ROBLOX - TÊN: KP (MẬT KHẨU MỚI)
-- ============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local CORRECT_PASSWORD = "CLANKP123"

-- ============================================================
-- HỆ THỐNG XÁC THỰC MẬT KHẨU
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KP_Login_Gui"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 180)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "KP HUB - NHẬP MẬT KHẨU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.85, 0, 0, 40)
TextBox.Position = UDim2.new(0.075, 0, 0.35, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Nhập mật khẩu tại đây..."
TextBox.Text = ""
TextBox.TextSize = 14
TextBox.Font = Enum.Font.SourceSans
TextBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = TextBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 35)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.68, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "XÁC NHẬN"
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = SubmitBtn

local ErrorLabel = Instance.new("TextLabel")
ErrorLabel.Size = UDim2.new(1, 0, 0, 20)
ErrorLabel.Position = UDim2.new(0, 0, 0.88, 0)
ErrorLabel.BackgroundTransparency = 1
ErrorLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
ErrorLabel.TextSize = 12
ErrorLabel.Font = Enum.Font.SourceSans
ErrorLabel.Text = ""
ErrorLabel.Parent = MainFrame

-- Hàm chạy menu chính sau khi nhập đúng mật khẩu
local function LoadMainScript()
    ScreenGui:Destroy()

    local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
    local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
    local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
    local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

    local Options = Library.Options
    Library.ForceCheckbox = false

    local Window = Library:CreateWindow({
        Title = "KP Hub - Lag & Kick",
        Footer = "Delta Executor",
        NotifySide = "Right",
        ShowCustomCursor = true,
    })

    local Tabs = {
        Main = Window:AddTab("Chức Năng", "clock"),
        ["UI Settings"] = Window:AddTab("Cài Đặt UI", "settings")
    }

    local function notify(title, content, duration)
        Library:Notify({ Title = title or "Thông báo", Description = content or "", Time = duration or 5 })
    end

    local GE = ReplicatedStorage:WaitForChild("GrabEvents", 10)
    local SetNetOwner = GE and GE:WaitForChild("SetNetworkOwner", 5)
    local DestroyLine = GE and GE:WaitForChild("DestroyGrabLine", 5)
    local CreateLine = GE and GE:WaitForChild("CreateGrabLine", 5)

    local function SetOwner(part)
        if part then pcall(function() SetNetOwner:FireServer(part, part.CFrame) end) end
    end

    local function SetThirdPerson()
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        LocalPlayer.CameraMaxZoomDistance = 50
        LocalPlayer.CameraMinZoomDistance = 0.5
    end

    local function ResetCamera()
        LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        Camera.CameraType = Enum.CameraType.Custom
        LocalPlayer.CameraMaxZoomDistance = 0
        LocalPlayer.CameraMinZoomDistance = 0
    end

    local MainGroup = Tabs.Main:AddLeftGroupbox("Điều Khiển Chính")

    local lineLagEnabled = false
    local lineLagThread = nil
    local lagRunning = false

    local LAG_RADIUS = 12
    local LAG_HEIGHT = 8

    MainGroup:AddToggle("ThirdPersonToggle", {
        Text = "📹 Góc Nhìn Thứ Ba",
        Default = false,
        Callback = function(v)
            if v then
                SetThirdPerson()
                notify("Góc Nhìn", "Đã bật", 1)
            else
                ResetCamera()
                notify("Góc Nhìn", "Đã tắt", 1)
            end
        end
    })

    MainGroup:AddLabel("----------------------------------------")

    local function StartLineLag()
        if lineLagEnabled then return end
        lineLagEnabled = true
        lineLagThread = coroutine.create(function()
            local cl = CreateLine
            if not cl then return end
            while lineLagEnabled do
                local spawn = Workspace:FindFirstChild("SpawnLocation") or Workspace:FindFirstChild("Spawn")
                if spawn then
                    local rx = math.random(-1e9, 1e9)
                    local rz = math.random(-1e9, 1e9)
                    local directions = {
                        CFrame.new(rx,
