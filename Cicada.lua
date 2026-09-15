local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local CORRECT_PASSWORD = "CLANKP123"

local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 2)

if PlayerGui:FindFirstChild("KP_Login_Gui") then
    PlayerGui.KP_Login_Gui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KP_Login_Gui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 180)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

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

Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 35)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.68, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "XÁC NHẬN"
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.Parent = MainFrame

Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 6)

local ErrorLabel = Instance.new("TextLabel")
ErrorLabel.Size = UDim2.new(1, 0, 0, 20)
ErrorLabel.Position = UDim2.new(0, 0, 0.88, 0)
ErrorLabel.BackgroundTransparency = 1
ErrorLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
ErrorLabel.TextSize = 12
ErrorLabel.Font = Enum.Font.SourceSans
ErrorLabel.Text = ""
ErrorLabel.Parent = MainFrame

SubmitBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CORRECT_PASSWORD then
        ScreenGui:Destroy()
        task.spawn(function()
            local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
            local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
            
            local Window = Library:CreateWindow({
                Title = "KP Hub - Lag & Kick",
                Footer = "Delta Executor",
                NotifySide = "Right",
                ShowCustomCursor = true,
            })
            
            local Tabs = {
                Main = Window:AddTab("Chức Năng", "clock")
            }
            
            local MainGroup = Tabs.Main:AddLeftGroupbox("Điều Khiển Chính")
            
            MainGroup:AddToggle("ThirdPersonToggle", {
                Text = "📹 Góc Nhìn Thứ Ba",
                Default = false,
                Callback = function(v)
                    if v then
                        LocalPlayer.CameraMode = Enum.CameraMode.Classic
                        Camera.CameraType = Enum.CameraType.Custom
                    else
                        LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
                    end
                end
            })
        end)
    else
        ErrorLabel.Text = "Mật khẩu không đúng!"
    end
end)
