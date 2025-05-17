print("🧪 Remote Tester2 + Instant GUI AutoClose (no wait)")

local RS = game:GetService("ReplicatedStorage")
local R = RS.Remotes
local CG = game:GetService("CoreGui")
local P = game:GetService("Players").LocalPlayer

local UI = Instance.new("ScreenGui", CG)
UI.Name = "RemoteTesterInstantClose"
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

makeBtn("🛍 Открыть 3 яйца (ID 5)", 100, function()
    print("➡️ Покупка 3 яиц подряд")
    for i = 1, 3 do
        pcall(function() R.BuyEgg:FireServer(5) end)
        wait(0.2)
    end
end)

makeBtn("🎲 HatchEgg (рандом)", 160, function()
    local petName = "RandomPet_" .. math.random(1000, 9999)
    local val1 = math.random(1, 300)
    local val2 = math.random(1, 300)
    print("➡️ HatchEgg:", petName, val1, val2)
    pcall(function()
        R.HatchEgg:FireServer(3, petName, val1, val2, false, nil, false, false, false, 0, false, nil)
    end)
end)

makeBtn("🎲 AutoFuse → random bool", 200, function()
    local value = (math.random() > 0.5)
    print("➡️ AutoFuse:", value)
    pcall(function() R.AutoFuse:FireServer(value) end)
end)

makeBtn("🎲 SetAutoFuse → random bool", 240, function()
    local value = (math.random() > 0.5)
    print("➡️ SetAutoFuse:", value)
    pcall(function() R.SetAutoFuse:FireServer(value) end)
end)

makeBtn("⚙ SetFilterSetting_Fuse → {}", 280, function()
    print("➡️ SetFilterSetting_Fuse: {}")
    pcall(function() R.SetFilterSetting_Fuse:FireServer({}) end)
end)

makeBtn("🥚 SetGeneratorEgg → MythicEgg", 320, function()
    print("➡️ SetGeneratorEgg: MythicEgg")
    pcall(function() R.SetGeneratorEgg:FireServer("MythicEgg") end)
end)

-- Реагировать сразу на появление кнопки "Continue"
P.PlayerGui.ChildAdded:Connect(function(child)
    child.DescendantAdded:Connect(function(desc)
        if desc:IsA("TextButton") and desc.Text == "Continue" then
            print("✅ Автонажатие на 'Continue'")
            desc:Activate()
        end
    end)
end)

-- Шпионим за OnClientEvent
for _, remote in pairs(R:GetChildren()) do
    if remote:IsA("RemoteEvent") then
        pcall(function()
            remote.OnClientEvent:Connect(function(...)
                print("🕵️‍♂️ OnClientEvent ▶", remote.Name, ...)
            end)
        end)
    end
end
