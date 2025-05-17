print("🧪 Экспериментальный Hatch/Fuse запущен")

local RS = game:GetService("ReplicatedStorage")
local R = RS.Remotes
local CG = game:GetService("CoreGui")
local P = game.Players.LocalPlayer

local UI = Instance.new("ScreenGui", CG)
UI.Name = "TestHatchFuse"
UI.ResetOnSpawn = false

local function makeButton(text, pos, callback)
    local b = Instance.new("TextButton", UI)
    b.Size = UDim2.new(0, 200, 0, 40)
    b.Position = pos
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(35, 150, 255)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 18
    b.MouseButton1Click:Connect(callback)
end

-- 🥚 Симулировать HatchEgg
makeButton("🔁 HatchEgg Test", UDim2.new(0, 20, 0, 100), function()
    print("➡️ Fire: HatchEgg")
    R.HatchEgg:FireServer(3, "Spirit_Angelic", 215, 215, false, nil, false, false, false, 0, false, nil)
end)

-- 🧬 Симулировать FusePets
makeButton("🧬 FusePets Test", UDim2.new(0, 20, 0, 150), function()
    print("➡️ Fire: FusePets")
    R.FusePets:FireServer("VampireBat_1", 221, 221, false, false, false, false, false, nil)
end)

-- 🔎 Поиск и вывод всех RemoteEvent с "Egg" и "Fuse"
for _, r in pairs(R:GetChildren()) do
    if r:IsA("RemoteEvent") and (r.Name:lower():find("egg") or r.Name:lower():find("fuse")) then
        print("📡 Найден Remote:", r.Name)
    end
end

-- 🔄 Слушать все OnClientEvent для анализа
for _, remote in pairs(R:GetChildren()) do
    if remote:IsA("RemoteEvent") then
        pcall(function()
            remote.OnClientEvent:Connect(function(...)
                warn("📡 OnClientEvent:", remote.Name, ...)
            end)
        end)
    end
end
