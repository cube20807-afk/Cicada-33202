-- ============================================================
-- MENU SCRIPT DELTA ROBLOX - TÊN: KP (VÀO THẲNG SAU KHI ĐÚNG MK)
-- ============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
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

-- Hàm hiển thị màn hình Boss M-M-ACLAN_KP rồi load thẳng vào menu
local function ShowBossIntro(onComplete)
    MainFrame:Destroy()

    local BossGui = Instance.new("ScreenGui")
    BossGui.Name = "KP_Boss_Intro"
    BossGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    BossGui.ResetOnSpawn = false

    local BossFrame = Instance.new("Frame")
    BossFrame.Size = UDim2.new(1, 0, 1, 0)
    BossFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    BossFrame.BackgroundTransparency = 1
    BossFrame.Parent = BossGui

    local BossText = Instance.new("TextLabel")
    BossText.Size = UDim2.new(1, 0, 0, 100)
    BossText.Position = UDim2.new(0, 0, 0.4, -50)
    BossText.BackgroundTransparency = 1
    BossText.Text = "M-M-ACLAN_KP"
    BossText.TextColor3 = Color3.fromRGB(255, 50, 50)
    BossText.TextSize = 0
    BossText.Font = Enum.Font.SourceSansBold
    BossText.TextTransparency = 1
    BossText.Parent = BossFrame

    task.spawn(function()
        for i = 1, 20 do
            BossText.TextSize = i * 2.5
            BossText.TextTransparency = 1 - (i / 20)
            task.wait(0.02)
        end

        task.wait(1.5)

        for i = 1, 15 do
            BossText.TextTransparency = i / 15
            task.wait(0.02)
        end

        BossGui:Destroy()
        if onComplete then
            onComplete()
        end
    end)
end

-- Hàm chạy menu chính
local function LoadMainScript()
    local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
    local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
    local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
    local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

    local Options = Library.Options
    Library.ForceCheckbox = false

    local Window = Library:CreateWindow({
        Title = "KP Hub - FTAP & Lag & ESP",
        Footer = "Delta Executor",
        NotifySide = "Right",
        ShowCustomCursor = true,
    })

    local Tabs = {
        Main = Window:AddTab("Chức Năng", "clock"),
        ThrowTab = Window:AddTab("Ném Người Chơi", "user-plus"),
        FlingTab = Window:AddTab("Super Fling", "zap"),
        XocuTab = Window:AddTab("Server Xocu", "globe"),
        KickV2Tab = Window:AddTab("Kick V2", "alert-triangle"), -- Thêm khu vực Kick V2 mới
        ProtectTab = Window:AddTab("Bảo Vệ", "shield"),
        Extra2 = Window:AddTab("Tùy Chỉnh Khác", "sliders"),
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
        LocalPlayer.CameraMode = Enum.CameraMode.Cla
