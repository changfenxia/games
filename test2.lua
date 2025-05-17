-- 1. Авто-генерация питомцев (Factory)
spawn(function()
    -- Выбрать самое дорогое доступное яйцо (например, по индексу или ID)
    game.ReplicatedStorage.Remotes.SetGeneratorEgg:FireServer("MythicEgg")
    -- Включить генератор
    game.ReplicatedStorage.Remotes.SetGeneratorOn:FireServer(true)
    -- Периодически крутить Crank, не чаще 1 раза в 5 сек
    while wait(5) do
        game.ReplicatedStorage.Remotes.SetGeneratorCrank:FireServer()
    end
end)

-- 2. При появлении нового питомца – авто-экипировать лучших
game.ReplicatedStorage.Remotes.OnGeneratePet.OnClientEvent:Connect(function(petData)
    game.ReplicatedStorage.Remotes.EquipBest:FireServer()
end)

-- 3. Авто-сбор всех дропов на карте (монеты, камни)
spawn(function()
    while wait(1) do  -- раз в секунду
        for _, drop in pairs(workspace.Drops:GetChildren()) do  -- допустим, дропы хранятся в workspace.Drops
            game.ReplicatedStorage.Remotes.StoneDrop:FireServer(drop.Name) 
            -- В некоторых играх передают имя/ID дропа, либо сам объект: тогда FireServer(drop)
        end
    end
end)

-- 4. Авто-улучшение параметров (Damage, Speed, Range, DropRate)
spawn(function()
    local upgrades = {"Damage", "Speed", "Range", "DropRate"}
    while wait(2) do  -- проверять каждые 2 сек
        for _, upg in ipairs(upgrades) do
            game.ReplicatedStorage.Remotes.BuyUpgrade:FireServer(upg)
        end
    end
end)

-- 5. Автоклейм наград: квесты, ежедневка, бусты
spawn(function()
    -- Предположим, есть глобальные флаги или функции, указывающие на готовность награды
    while wait(5) do
        if _G.DailyEggAvailable then
            game.ReplicatedStorage.Remotes.ClaimDailyEgg:FireServer()
        end
        if _G.QuestCompleted then
            game.ReplicatedStorage.Remotes.ClaimQuestReward:FireServer()
        end
        -- ...аналогично для бустов, если известно когда доступны
    end
end)

-- 6. Сбор скрытых яиц (единоразово, при старте скрипта)
for eggID=1, 50 do  -- предположительно 50 спрятанных яиц
    game.ReplicatedStorage.Remotes.CollectHiddenEgg:FireServer(eggID)
end

-- 7. Выключение звуков генерации (опционально, качество жизни)
game.ReplicatedStorage.Remotes.SetMuteGenerationSounds:FireServer(true)

-- Дополнительно: можно отключить AFK-кик
local vu = game:service'VirtualUser'; game:service'Players'.LocalPlayer.Idled:Connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) wait(1) vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end)
