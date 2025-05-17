local RS = game:GetService("ReplicatedStorage")
local R = RS.Remotes
local P = game:GetService("Players").LocalPlayer
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/1f0yt/community/main/Uilibs/fluxlib.txt"))()
local UI = Core:Window("🐲 PetCore v1.0", "Created by Artyom & GPT", Color3.fromRGB(87, 136, 255), Enum.KeyCode.RightControl)
local Main = UI:Tab("🚀 Генерация", "rbxassetid://6026568198")
local Stats = UI:Tab("📊 Статистика", "rbxassetid://6026568198")

-- Метрика
local counter = 0
local turboOn = false

-- 🔁 Turbo генерация
Main:Toggle("🔥 Turbo генерация яиц (OnGeneratePet)", false, function(state)
    turboOn = state
    task.spawn(function()
        while turboOn do
            if R:FindFirstChild("OnGeneratePet") then
                R.OnGeneratePet:FireServer()
                counter += 1
            end
            task.wait(0.05)
        end
    end)
end)

-- 🧠 Подмена функции updateHatchSpeed
Main:Button("🧠 Hook updateHatchSpeed", function()
    for _,v in pairs(getgc(true)) do
        if typeof(v)=="function" and islclosure(v) then
            local info = debug.getinfo(v)
            if info.name and info.name:lower():find("updatehatchspeed") then
                hookfunction(v, function(...)
                    warn("🧠 Hook: updateHatchSpeed подавлен")
                    return 0.01
                end)
                warn("✅ Hook установлен на:", info.name)
                break
            end
        end
    end
end)

-- 🌐 Глобальная подмена HatchSpeed
Main:Button("🌐 getgenv().HatchSpeed = 100", function()
    getgenv().HatchSpeed = 100
    warn("🌐 HatchSpeed установлен вручную: 100")
end)

-- 🧪 Получить DailyEgg и Boosts
Main:Button("🎁 ClaimDailyEgg + Boosts", function()
    if R.ClaimDailyEgg then R.ClaimDailyEgg:FireServer() end
    if R.ClaimMushBoost then R.ClaimMushBoost:FireServer() end
    if R.ClaimSubBoost then R.ClaimSubBoost:FireServer() end
    warn("🎁 Бонусы активированы")
end)

-- 🧬 Включить генератор
Main:Button("⚙️ Generator ON", function()
    if R.SetGeneratorOn then R.SetGeneratorOn:FireServer() end
    if R.SetGeneratorEgg then R.SetGeneratorEgg:FireServer("Basic") end
    warn("⚙️ Генератор активирован")
end)

-- 📈 ClaimQuestReward loop
Main:Button("🔁 10x ClaimQuestReward", function()
    for i=1,10 do
        if R.ClaimQuestReward then
            R.ClaimQuestReward:FireServer()
            warn("🎯 QuestReward #" .. i)
            wait(0.1)
        end
    end
end)

-- 📊 Отображение статистики
Stats:Label("📦 Генераций выполнено:")
Stats:Button("🔄 Обновить счётчик", function()
    warn("📦 Генераций:", counter)
end)

Stats:Button("🔄 Сбросить счётчик", function()
    counter = 0
    warn("📦 Счётчик обнулён")
end)

Main:Button("❌ Убрать интерфейс", function()
    for _,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name:lower():find("flux") then
            v:Destroy()
        end
    end
end)
