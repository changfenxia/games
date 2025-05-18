print("🧪 Remote Tester2 + 4 вызова → пауза → компактные кнопки")

local RS = game:GetService("ReplicatedStorage")
local R = RS.Remotes
local CG = game:GetService("CoreGui")
local P = game:GetService("Players").LocalPlayer

local UI = Instance.new("ScreenGui", CG)
UI.Name = "RemoteTesterCompact"
UI.ResetOnSpawn = false

local flags = {}

local function makeBtn(label, y, key, action)
    local B = Instance.new("TextButton", UI)
    B.Size = UDim2.new(0, 140, 0, 36)
    B.Position = UDim2.new(0, 20, 0, y)
    B.Text = label
    B.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    B.TextColor3 = Color3.new(1,1,1)
    B.Font = Enum.Font.SourceSansBold
    B.TextSize = 14
    B.TextWrapped = true
    B.MouseButton1Click:Connect(function()
        if flags[key] then return end
        flags[key] = true
        print("▶️ Старт цикла по 4 вызова:", key)
        spawn(function()
            while flags[key] do
                pcall(action)
                pcall(action)
                pcall(action)
                pcall(action)
                wait(0.01)
            end
        end)
    end)
end

makeBtn("Яйцо ID 2", 80, "egg2", function() R.BuyEgg:FireServer(2) end)
makeBtn("Яйцо ID 7", 120, "egg7", function() R.BuyEgg:FireServer(7) end)
makeBtn("Яйцо ID 6", 160, "egg6", function() R.BuyEgg:FireServer(6) end)
makeBtn("Яйцо ID 5", 200, "egg5", function() R.BuyEgg:FireServer(5) end)

local stopBtn = Instance.new("TextButton", UI)
stopBtn.Size = UDim2.new(0, 140, 0, 36)
stopBtn.Position = UDim2.new(0, 20, 0, 250)
stopBtn.Text = "🛑 Стоп"
stopBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.SourceSansBold
stopBtn.TextSize = 14
stopBtn.TextWrapped = true
stopBtn.MouseButton1Click:Connect(function()
    for k in pairs(flags) do
        flags[k] = false
    end
    print("⛔ Все циклы остановлены")
end)

P.PlayerGui.ChildAdded:Connect(function(child)
    child.DescendantAdded:Connect(function(desc)
        if desc:IsA("TextButton") and desc.Text == "Continue" then
            print("✅ Автонажатие на 'Continue'")
            desc:Activate()
        end
    end)
end)

for _, remote in pairs(R:GetChildren()) do
    if remote:IsA("RemoteEvent") then
        pcall(function()
            remote.OnClientEvent:Connect(function(...)
                print("🕵️‍♂️ OnClientEvent ▶", remote.Name, ...)
            end)
        end)
    end
end
