local R = game:GetService("ReplicatedStorage").Remotes
local s = 0

warn("🧪 НАЧИНАЕМ ТЕСТЫ ПОЛНОГО ВЗЛОМА...")

-- 1. OnGeneratePet
if R:FindFirstChild("OnGeneratePet") then
    R.OnGeneratePet:FireServer()
    warn("🧬 OnGeneratePet: УСПЕХ")
    s += 1
else
    warn("⚠️ OnGeneratePet НЕ найден")
end
wait(1)

-- 2. ClaimDailyEgg
if R:FindFirstChild("ClaimDailyEgg") then
    R.ClaimDailyEgg:FireServer()
    warn("🎁 DailyEgg: вызван")
    s += 1
end
wait(1)

-- 3. ClaimQuestReward x3
if R:FindFirstChild("ClaimQuestReward") then
    for i = 1, 3 do
        R.ClaimQuestReward:FireServer()
        warn("🎯 QuestReward: #" .. i)
        wait(0.2)
    end
    s += 1
end

-- 4. Mush/Sub Boost
if R:FindFirstChild("ClaimMushBoost") then R.ClaimMushBoost:FireServer() warn("🌿 MushBoost") s += 1 end
if R:FindFirstChild("ClaimSubBoost") then R.ClaimSubBoost:FireServer() warn("🔋 SubBoost") s += 1 end
wait(1)

-- 5. Генератор
if R:FindFirstChild("SetGeneratorOn") then
    R.SetGeneratorOn:FireServer()
    warn("⚙️ Генератор: активирован")
    s += 1
else
    warn("⚠️ Генератор НЕ найден")
end
if R:FindFirstChild("SetGeneratorEgg") then
    R.SetGeneratorEgg:FireServer("Basic")
    warn("🥚 GeneratorEgg: Basic отправлено")
    s += 1
end
wait(1)

-- 6. Подмена HatchSpeed через глобал
getgenv().HatchSpeed = 100
warn("🌐 HatchSpeed установлен вручную = 100")

-- 7. Поиск и hook updateHatchSpeed
local hooked = false
for _,v in pairs(getgc(true)) do
    if typeof(v)=="function" and islclosure(v) then
        local info = debug.getinfo(v)
        if info.name and info.name:lower():find("updatehatchspeed") then
            hookfunction(v, function(...)
                warn("🧠 Hook: updateHatchSpeed — подмена на 0.01")
                return 0.01
            end)
            warn("✅ Hook установлен: "..info.name)
            hooked = true
            s += 1
            break
        end
    end
end
if not hooked then warn("⚠️ updateHatchSpeed не найден для hook") end

-- Финал
warn("✅ Тест завершён. Всего успешных операций: "..s)
