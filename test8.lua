print("🧪 Remote Tester2 + Repeating Burst Loop")

local RS = game:GetService("ReplicatedStorage")
local R = RS.Remotes
local CG = game:GetService("CoreGui")
local P = game:GetService("Players").LocalPlayer

local UI = Instance.new("ScreenGui", CG)
UI.Name = "RemoteTesterBurstLoop"
UI.ResetOnSpawn = false

local flags = {}

local function makeBtn(label, y, key, action, count)
    local B = Instance.new("TextButton", UI)
    B.Size = UDim2.new(0, 260, 0, 36)
    B.Position = UDim2.new(0, 20, 0, y)
    B.Text = label
    B.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    B.TextColor3 = Color3.new(1,1,1)
    B.Font = Enum.Font.SourceSansBold
    B.TextSize = 16
    B.MouseButton1Click:Connect(function()
        if flags[key] then return end
        flags[key] = true
        print("▶️ Цикл начат:", key)
        spawn(function()
            while flags[key] do
                for i = 1, count do
                    pcall(action)
                end
                wait(5)
            end
        end)
    end)
end

-- Кнопки запуска циклов
makeBtn("🔁 Яйцо ID 2 ×380 каждые 5с", 80, "egg2", function() R.BuyEgg:FireServer(2) end, 380)
makeBtn("🔁 Яйцо ID 7 ×380 каждые 5с", 130, "egg7", function() R.BuyEgg:FireServer(7) end, 380)
makeBtn("🔁 Яйцо ID 6 ×10 каждые 5с", 180, "egg6", function() R.BuyEgg:FireServer(6) end, 10)
makeBtn("🔁 Яйцо ID 5 ×10 каждые 5с", 230, "egg5", function() R.BuyEgg:FireServer(5) end, 10)

-- Кнопка остановки всех циклов
local stopBtn = Instance.new("TextButton", UI)
stopBtn.Size = UDim2.new(0, 260, 0, 36)
stopBtn.Position = UDim2.new(0, 20, 0, 290)
stopBtn.Text = "🛑 Остановить все циклы"
stopBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.SourceSansBold
stopBtn.TextSize = 16
stopBtn.MouseButton1Click:Connect(function()
    for k in pairs(flags) do
        flags[k] = false
    end
    print("⛔ Все циклы остановлены")
end)

-- Автонажатие на кнопку "Continue"
P.PlayerGui.ChildAdded:Connect(function(child)
    child.DescendantAdded:Connect(function(desc)
        if desc:IsA("TextButton") and desc.Text == "Continue" then
            print("✅ Автонажатие на 'Continue'")
            desc:Activate()
        end
    end)
end)

-- Логирование всех OnClientEvent
for _, remote in pairs(R:GetChildren()) do
    if remote:IsA("RemoteEvent") then
        pcall(function()
            remote.OnClientEvent:Connect(function(...)
                print("🕵️‍♂️ OnClientEvent ▶", remote.Name, ...)
            end)
        end)
    end
end
