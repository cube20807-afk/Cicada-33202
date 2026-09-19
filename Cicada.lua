-- [[ KAIDEPTRAIHUB FLING & SMART AIM V3 - CYBER GLOW ]] --
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Khởi tạo Giao diện Premium
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "Kaideptraihub_V3"
ScreenGui.ResetOnSpawn = false

-- Khung Menu Chính (Thiết kế Semi-Transparent cực đẹp)
local MainMenu = Instance.new("Frame", ScreenGui)
MainMenu.Size = UDim2.new(0, 240, 0, 230)
MainMenu.Position = UDim2.new(0.5, -120, 0.3, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
MainMenu.BackgroundTransparency = 0.2
MainMenu.BorderSizePixel = 0
local MainCorner = Instance.new("UICorner", MainMenu)
MainCorner.CornerRadius = UDim.new(0, 14)

-- Hiệu ứng Viền Phát Sáng Neon (Cyber Glow)
local UIStroke = Instance.new("UIStroke", MainMenu)
UIStroke.Color = Color3.fromRGB(0, 255, 204)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.3

-- Thanh Viền Đỉnh Menu mượt mà
local NeonLine = Instance.new("Frame", MainMenu)
NeonLine.Size = UDim2.new(1, 0, 0, 4)
NeonLine.BackgroundColor3 = Color3.fromRGB(0, 255, 204)
NeonLine.BorderSizePixel = 0
Instance.new("UICorner", NeonLine).CornerRadius = UDim.new(0, 14)

-- Tiêu đề Menu (Chạm để Ẩn/Hiện chuyên nghiệp)
local TitleButton = Instance.new("TextButton", MainMenu)
TitleButton.Size = UDim2.new(1, 0, 0, 42)
TitleButton.Position = UDim2.new(0, 0, 0, 4)
TitleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TitleButton.BackgroundTransparency = 0.4
TitleButton.Text = "   ⚡ KAIDEPTRAIHUB V3"
TitleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleButton.Font = Enum.Font.GothamBold
TitleButton.TextSize = 13
TitleButton.TextXAlignment = Enum.TextXAlignment.Left
local TitleCorner = Instance.new("UICorner", TitleButton)
TitleCorner.CornerRadius = UDim.new(0, 12)

-- Trạng thái thu gọn nhỏ ở góc màn hình
local StatusLabel = Instance.new("TextLabel", TitleButton)
StatusLabel.Size = UDim2.new(0, 60, 1, 0)
StatusLabel.Position = UDim2.new(1, -70, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "[ CHẠM ẨN ]"
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 204)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Right

-- Thùng chứa các nút tính năng
local ContentFrame = Instance.new("Frame", MainMenu)
ContentFrame.Size = UDim2.new(1, 0, 1, -46)
ContentFrame.Position = UDim2.new(0, 0, 0, 46)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0

-- Cấu hình hệ thống mặc định
local FlingEnabled = true
local FlingPower = 2000 
local AimEnabled = false
local AimRadius = 110  -- Bo hẹp vòng nhắm để tăng độ chính xác
local Smoothness = 0.035 -- Siêu nhẹ, bám tâm vô cùng tự nhiên không rung lắc
local MenuCollapsed = false

-- Hiệu ứng Tween Thu nhỏ / Mở rộng mượt mà cho Mobile
TitleButton.MouseButton1Click:Connect(function()
    MenuCollapsed = not MenuCollapsed
    if MenuCollapsed then
        MainMenu:TweenSize(UDim2.new(0, 240, 0, 46), "Out", "Quint", 0.3, true)
        ContentFrame.Visible = false
        StatusLabel.Text = "[ HIỆN ]"
        UIStroke.Color = Color3.fromRGB(255, 0, 128) -- Đổi sang màu hồng hồng khi ẩn
    else
        MainMenu:TweenSize(UDim2.new(0, 240, 0, 230), "Out", "Quint", 0.3, true)
        ContentFrame.Visible = true
        StatusLabel.Text = "[ CHẠM ẨN ]"
        UIStroke.Color = Color3.fromRGB(0, 255, 204)
    end
end)

-- Hàm tạo Nút bấm Cao cấp (Bo góc, chuyển màu mượt)
local function CreateButton(name, text, pos, color)
    local btn = Instance.new("TextButton", ContentFrame)
    btn.Name = name
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.15
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    
    -- Thêm viền nhẹ cho từng nút bấm trông sang xịn mịn hơn
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Thickness = 1
    stroke.Transparency = 0.8
    
    return btn
end

-- 1. NÚT FLING
local FlingBtn = CreateButton("FlingBtn", "🟢 FLING MÚC ĐỒ: ON", UDim2.new(0.05, 0, 0, 12), Color3.fromRGB(10, 35, 25))
FlingBtn.UIStroke.Color = Color3.fromRGB(0, 255, 150)
FlingBtn.UIStroke.Transparency = 0.5

FlingBtn.MouseButton1Click:Connect(function()
    FlingEnabled = not FlingEnabled
    if FlingEnabled then
        FlingBtn.Text = "🟢 FLING MÚC ĐỒ: ON"
        FlingBtn.BackgroundColor3 = Color3.fromRGB(10, 35, 25)
        FlingBtn.UIStroke.Color = Color3.fromRGB(0, 255, 150)
    else
        FlingBtn.Text = "🔴 FLING MÚC ĐỒ: OFF"
        FlingBtn.BackgroundColor3 = Color3.fromRGB(40, 15, 20)
        FlingBtn.UIStroke.Color = Color3.fromRGB(255, 50, 80)
    end
end)

-- 2. Ô NHẬP SỨC MẠNH (POWER TEXTBOX)
local PowerInput = Instance.new("TextBox", ContentFrame)
PowerInput.Size = UDim2.new(0.9, 0, 0, 38)
PowerInput.Position = UDim2.new(0.05, 0, 0, 64)
PowerInput.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
PowerInput.BackgroundTransparency = 0.3
PowerInput.Text = "SỨC NÉM: " .. tostring(FlingPower)
PowerInput.TextColor3 = Color3.fromRGB(0, 255, 204)
PowerInput.Font = Enum.Font.GothamBold
PowerInput.TextSize = 12
Instance.new("UICorner", PowerInput).CornerRadius = UDim.new(0, 10)

local InputStroke = Instance.new("UIStroke", PowerInput)
InputStroke.Color = Color3.fromRGB(0, 255, 204)
InputStroke.Thickness = 1
InputStroke.Transparency = 0.7

PowerInput.FocusLost:Connect(function()
    local val = PowerInput.Text:gsub("SỨC NÉM: ", "")
    local num = tonumber(val)
    if num then FlingPower = num else PowerInput.Text = "SỨC NÉM: " .. tostring(FlingPower) end
end)

-- 3. NÚT SMART AIMBOT (SIÊU NHẸ)
