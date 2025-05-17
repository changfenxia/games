local RS=game:GetService("ReplicatedStorage") local P=game:GetService("Players") local LP=P.LocalPlayer local R=RS:FindFirstChild("Remotes") or RS

warn("🚀 Init")
for _,o in pairs(R:GetDescendants()) do if o:IsA("RemoteEvent") or o:IsA("RemoteFunction") then warn("📍",o.ClassName,o:GetFullName()) end end

local d=R:FindFirstChild("Drop") if d then d.OnClientEvent:Connect(function(...) warn("💎 Drop:",...) end) end
local m=R:FindFirstChild("MineRemote") if m then m.OnClientEvent:Connect(function(...) warn("⛏️ Mine:",...) end) end

if m then for i=1,5 do m:FireServer(Vector3.new(100+i*10,0,100)) warn("⛏️",i) wait(0.3) end else warn("❌ MineRemote missing") end

for _,f in pairs(getgc(true)) do
    if typeof(f)=="function" and islclosure(f) then
        local i=debug.getinfo(f) if i.name and i.source then
            local n=i.name:lower()
            if n:find("egg") or n:find("hatch") or n:find("shiny") or n:find("giant") or n:find("mine") or n:find("gen") or n:find("drop") or n:find("stat") or n:find("quest") or n:find("reward") then
                warn("🧠",i.name,"|",i.source)
            end
        end
    end
end

LP.PlayerScripts.ChildAdded:Connect(function(c) if c.Name=="Drop" then warn("📥 Drop:",c:GetFullName()) if c:FindFirstChild("ID") then warn("➡️ ID:",c.ID.Value) end end end)

local cq=R:FindFirstChild("ClaimQuestReward") if cq then warn("🎁 ClaimQuestReward найден") for i=1,3 do cq:FireServer() warn("🎁",i) wait(0.5) end else warn("❌ ClaimQuestReward не найден") end

for _,r in pairs(R:GetChildren()) do
    if r:IsA("RemoteEvent") and r.Name:lower():find("quest") then
        r.OnClientEvent:Connect(function(...) warn("📡 Квест:",r.Name,...) end)
    end
end

local s=LP:FindFirstChild("leaderstats") or LP:FindFirstChild("Stats") or LP
for _,v in pairs(s:GetChildren()) do
    if v:IsA("IntValue") or v:IsA("NumberValue") then warn("📊",v.Name,"=",v.Value) end
end

warn("✅ Готово.")
