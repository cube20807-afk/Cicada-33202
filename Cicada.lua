-- ============================================================
-- SCRIPT LAG KICK + DESTROY GRAB LINE (5000 BẢN/GIÂY)
-- ============================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
Library.ForceCheckbox = false

local Window = Library:CreateWindow({
    Title = "Lag Kick Hub",
    Footer = "Delta Executor",
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Main = Window:AddTab("Lag Kick", "clock"),
    ["UI Settings"] = Window:AddTab("UI Cài Đặt", "settings")
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

-- ============================================================
-- CỐ ĐỊNH GÓC NHÌN THỨ BA
-- ============================================================
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

-- ============================================================
-- CHỨC NĂNG LAG KICK + DESTROY GRAB LINE (5000 BẢN/GIÂY)
-- ============================================================
local MainGroup = Tabs.Main:AddLeftGroupbox("Điều Khiển Chính")

local lineLagEnabled = false
local lineLagThread = nil
local lagRunning = false

local LAG_RADIUS = 12
local LAG_HEIGHT = 8

-- Toggle Góc nhìn thứ ba
MainGroup:AddToggle("ThirdPersonToggle", {
    Text = "📹 Góc Nhìn Thứ Ba",
    Default = false,
    Callback = function(v)
        if v then
            SetThirdPerson()
            notify("Góc nhìn", "Đã bật góc nhìn thứ ba", 1)
        else
            ResetCamera()
            notify("Góc nhìn", "Đã tắt", 1)
        end
    end
})

MainGroup:AddLabel("━━━━━━━━━━━━━━━━━━━━━━━━━━━")

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
                    CFrame.new(rx, 0, rz),
                    CFrame.new(-rx, 0, -rz),
                    CFrame.new(rx, 0, -rz),
                    CFrame.new(-rx, 0, rz)
                }
                for _, pos in pairs(directions) do
                    cl:FireServer(spawn, pos)
                end
            end
            task.wait(0.0008)  -- 5000 bản/giây
        end
    end)
    coroutine.resume(lineLagThread)
end

local function StopLineLag()
    lineLagEnabled = false
    if lineLagThread then coroutine.close(lineLagThread); lineLagThread = nil end
end

MainGroup:AddButton({
    Text = "🚀 Lagg Kick + All Destroy (5000 bản/s)",
    Func = function()
        if lagRunning then return end
        lagRunning = true
        task.spawn(function()
            StartLineLag()
            task.wait(1)

            local players = {}
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    table.insert(players, p.Character.HumanoidRootPart)
                end
            end

            if #players == 0 then
                StopLineLag()
                lagRunning = false
                notify("Lag Kick", "Không tìm thấy người chơi nào khác trên server", 2)
                return
            end

            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not myRoot then StopLineLag(); lagRunning = false return end

            for _, hrp in pairs(players) do
                myRoot.CFrame = hrp.CFrame * CFrame.new(0, 5, 5)
                task.wait(0.2)
                SetOwner(hrp)
                task.wait()
            end

            local angleStep = (math.pi * 2) / #players
            for idx, hrp in pairs(players) do
                local angle = (idx - 1) * angleStep
                local x = math.cos(angle) * LAG_RADIUS
                local z = math.sin(angle) * LAG_RADIUS
                pcall(function()
                    hrp.CFrame = CFrame.new(x, LAG_HEIGHT, z)
                    hrp.AssemblyLinearVelocity = Vector3.zero
                end)
                local bp = Instance.new("BodyPosition")
                bp.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                bp.P = 40000000
                bp.Position = Vector3.new(x, LAG_HE
