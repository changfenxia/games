print("✅ Collect All Pets: скрипт запущен")

local RS = game:GetService("ReplicatedStorage")
local R = RS.Remotes
local P = game:GetService("Players").LocalPlayer

local U = Instance.new("ScreenGui")
U.Name = "AutoEggGUI"
U.ResetOnSpawn = false
U.Parent = game:GetService("CoreGui")

local B = Instance.new("TextButton")
B.Parent = U
B.Size = UDim2.new(0, 150, 0, 40)
B.Position = UDim2.new(0, 20, 0, 200)
B.Text = "🔄 Собрать яйца"
B.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
B.TextColor3 = Color3.new(1, 1, 1)
B.Font = Enum.Font.SourceSansBold
B.TextSize = 18

local function collectEggs()
    for i = 1, 60 do
        local ok, err = pcall(function()
            R.CollectHiddenEgg:FireServer(i)
            print("🥚 Сбор яйца ID", i)
        end)
        wait(0.1)
    end
end

B.MouseButton1Click:Connect(collectEggs)
collectEggs()

for _, remote in pairs(R:GetChildren()) do
    if remote:IsA("RemoteEvent") then
        pcall(function()
            remote.OnClientEvent:Connect(function(...)
                warn("📡 OnClientEvent:", remote.Name, ...)
            end)
        end)
    end
end

spawn(function()
    while wait(1) do
        for _, drop in pairs(workspace:GetDescendants()) do
            if drop:IsA("Part") and drop.Name:lower():find("drop") then
                pcall(function()
                    R.StoneDrop:FireServer(drop)
                end)
            end
        end
    end
end)

spawn(function()
    local upgs = {"Damage", "Speed", "Range", "DropRate"}
    while wait(2) do
        for _, u in ipairs(upgs) do
            pcall(function()
                R.BuyUpgrade:FireServer(u)
            end)
        end
    end
end)

spawn(function()
    while wait(5) do
        pcall(function() R.ClaimDailyEgg:FireServer() end)
        pcall(function() R.ClaimQuestReward:FireServer() end)
        pcall(function() R.ClaimMushBoost:FireServer() end)
        pcall(function() R.ClaimSubBoost:FireServer() end)
    end
end)

spawn(function()
    local eq = P:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("Main"):WaitForChild("Pets")
    local inv = eq:WaitForChild("PetsContainer"):WaitForChild("ScrollingFrame")
    while wait(2) do
        local counts = {}
        for _, v in pairs(inv:GetChildren()) do
            if v:IsA("Frame") and v:FindFirstChild("NameLabel") then
                local name = v.NameLabel.Text
                counts[name] = (counts[name] or 0) + 1
                if counts[name] >= 3 then
                    R.Fuse:FireServer(name)
                    print("🧬 AutoFuse:", name)
                end
            end
        end
    end
end)

pcall(function() R.SetMuteGenerationSounds:FireServer(true) end)

local vu = game:service'VirtualUser'
P.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
