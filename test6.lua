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

makeBtn("🛍 Открыть 100 яйца (ID 8)", 80, function()
    print("➡️ Покупка 99 яиц подряд")
    for i = 1, 100 do
        pcall(function() R.BuyEgg:FireServer(8) end)
    end
end)

makeBtn("🛍 Открыть 100 яйца (ID 7)", 110, function()
    print("➡️ Покупка 3 яиц подряд")
    for i = 1, 100 do
        pcall(function() R.BuyEgg:FireServer(7) end)
    end
end)

makeBtn("🛍 Открыть 3 яйца (ID 6)", 140, function()
    print("➡️ Покупка 3 яиц подряд")
    for i = 1, 10 do
        pcall(function() R.BuyEgg:FireServer(6) end)
    end
end)

makeBtn("🛍 Открыть 3 яйца (ID 5)", 170, function()
    print("➡️ Покупка 3 яиц подряд")
    for i = 1, 10 do
        pcall(function() R.BuyEgg:FireServer(5) end)
    end
end)

-- makeBtn("🎲 HatchEgg (рандом)", 160, function()
--     local petName = "RandomPet_" .. math.random(1000, 9999)
--     local val1 = math.random(1, 300)
--     local val2 = math.random(1, 300)
--     print("➡️ HatchEgg:", petName, val1, val2)
--     pcall(function()
--         R.HatchEgg:FireServer(1)
--     end)
-- end)

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
