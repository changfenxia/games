print("🧪 Remote Tester + Spy запущен")

local RS = game:GetService("ReplicatedStorage")
local R = RS.Remotes
local CG = game:GetService("CoreGui")

local UI = Instance.new("ScreenGui", CG)
UI.Name = "RemoteTesterSpy"
UI.ResetOnSpawn = false

local function makeBtn(label, y, fn)
    local B = Instance.new("TextButton", UI)
    B.Size = UDim2.new(0, 240, 0, 36)
    B.Position = UDim2.new(0, 20, 0, y)
    B.Text = label
    B.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    B.TextColor3 = Color3.new(1,1,1)
    B.Font = Enum.Font.SourceSansBold
    B.TextSize = 16
    B.MouseButton1Click:Connect(fn)
end

makeBtn("🧬 AutoFuse → true", 100, function()
    print("➡️ AutoFuse: true")
    pcall(function() R.AutoFuse:FireServer(true) end)
end)

makeBtn("🛠 SetAutoFuse → true", 140, function()
    print("➡️ SetAutoFuse: true")
    pcall(function() R.SetAutoFuse:FireServer(true) end)
end)

makeBtn("⚙ SetFilterSetting_Fuse → {}", 180, function()
    print("➡️ SetFilterSetting_Fuse: {}")
    pcall(function() R.SetFilterSetting_Fuse:FireServer({}) end)
end)

makeBtn("🥚 SetGeneratorEgg → MythicEgg", 220, function()
    print("➡️ SetGeneratorEgg: MythicEgg")
    pcall(function() R.SetGeneratorEgg:FireServer("MythicEgg") end)
end)

makeBtn("🐣 HatchFirstEgg", 260, function()
    print("➡️ HatchFirstEgg")
    pcall(function() R.HatchFirstEgg:FireServer() end)
end)

makeBtn("🛍 BuyEgg → 3", 300, function()
    print("➡️ BuyEgg: 3")
    pcall(function() R.BuyEgg:FireServer(3) end)
end)

-- 🔍 Подключаемся ко всем RemoteEvent.OnClientEvent для шпионажа
for _, remote in pairs(R:GetChildren()) do
    if remote:IsA("RemoteEvent") then
        pcall(function()
            remote.OnClientEvent:Connect(function(...)
                print("🕵️‍♂️ OnClientEvent ▶", remote.Name, ...)
            end)
        end)
    end
end
