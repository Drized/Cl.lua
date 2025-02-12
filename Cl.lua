local Player = game:GetService("Players").LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Drized/IDK-i-just-wanna-use/refs/heads/main/main.lua"))()
local Window = Library.CreateLib("Drized GUI | Not for pubilc |", "BloodTheme")

local ATab = Window:NewTab("Autofarm")
local ASection = ATab:NewSection("Autofarm")

local Enemies = workspace.Enemies:GetDescendants()
local Mobs = {}

for i,v in pairs(Enemies) do
if v:IsA("ObjectValue") and v.Parent.Name == "Enemy" and v.Parent:IsA("Model") and v.Name == "Model" then
    if not table.find(Mobs,tostring(v.Value)) then
        table.insert(Mobs,tostring(v.Value))
    end
end
end
-- Utility Function to Teleport to a Specific Position
local function teleportToPosition(target, conditions)
    if target and conditions() then
        local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
        if HRP then
            HRP.CFrame = target.CFrame
        end
    end
end

-- Auto-Teleport to Mob Dropdown
ASection:NewDropdown("Autoteleport To Mob", "Automatically teleports you to the mob selected", Mobs, function(CurrentOption)
    spawn(function()
        while not stopautotpmobloop and wait(0.5) do
            local Enemies = workspace.Enemies:GetDescendants()
            local CombatFolder = workspace:FindFirstChild("CombatFolder")
            if not CombatFolder then
                for _, v in next, Enemies do
                    if v.Parent.Name == "Enemy" and v:IsA("BasePart") and v.Name == "EnemyLocation" and tostring(v.Parent.Model.Value) == CurrentOption and v.Parent.InCombat.Value == false and v.Parent:FindFirstChild("EnemyDefeat") ~= true then
                        teleportToPosition(v, function() return true end)
                        break
                    end
                end
            end
        end
    end)
end)

-- Auto-Orb Teleport Toggle
ASection:NewToggle("Auto OrbTP", "Teleports you to orbs automatically (portal relic)", function(State)
    Tp = State
    task.spawn(function()
        while Tp and wait(0.001) do
            local CombatFolder = workspace:FindFirstChild("CombatFolder")
            if CombatFolder and CombatFolder:FindFirstChild(Player.Name) then
                local MyFol = CombatFolder:FindFirstChild(Player.Name):GetDescendants()
                for _, v in pairs(MyFol) do
                    if v:IsA("BasePart") and (v.Name == "HitBox" or v.Name == "Base") then
                        teleportToPosition(v, function() return true end)
                    end
                end
            end
        end
    end)
end)


ASection:NewButton("Stop AutoMobTP", "Stops automatically teleporting to the mob selected", function()
getgenv().stopautotpmobloop = true
wait(0.4)
getgenv().stopautotpmobloop = false
end)

local Tp = true

ASection:NewToggle("Auto OrbTP", "Teleports you to orbs automatically (portal relic)", function(State)
    Tp = State
    task.spawn(function()
        while Tp and wait() do
            local Player = game:GetService("Players").LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local HRP = Character:FindFirstChild("HumanoidRootPart")
            local CombatFolder = workspace:FindFirstChild("CombatFolder")
            if CombatFolder then
                local MyFol = CombatFolder:FindFirstChild(Player.Name)
                if MyFol then
                    local MyDescendants = MyFol:GetDescendants()
                    for _, v in pairs(MyDescendants) do
                        if v:IsA("BasePart") and (v.Name == "HitBox" or v.Name == "Base") then
                            HRP.CFrame = v.CFrame
                        end
                    end
                end
            end
        end
    end)
end)

local Acts = true

ASection:NewToggle("Spam All Actives", "Spams all Actives", function(State)
Acts = State

while Acts and wait() do
local args = {
[1] = "UseItem",
[2] = 1,
[3] = { ["MouseHit"] = Vector3.new(-46,50,43)}
}

game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))

local args = {
[1] = "UseItem",
[2] = 2,
[3] = { ["MouseHit"] = Vector3.new(-46,50,43)}
}

game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))

local args = {
[1] = "UseItem",
[2] = 3,
[3] = { ["MouseHit"] = Vector3.new(-46,50,43)}
} 
game:GetService("ReplicatedStorage"):WaitForChild("Server"):FireServer(unpack(args))
end
end)

local CTab = Window:NewTab("Teleport")
local CSection = CTab:NewSection("Teleport")

local ArsenalTab = {}
local Arsenals = workspace:WaitForChild("Arsenals"):GetDescendants()

for i,v in pairs(Arsenals) do
    if v:IsA("BasePart") and v.Parent.Parent.Name == "Arsenals" then
        if not table.find(ArsenalTab,v.Parent.Name) then
            table.insert(ArsenalTab,v.Parent.Name)
        end
    end
end

table.insert(ArsenalTab,"Void")
table.insert(ArsenalTab,"Land Under The Waterfall")
table.sort(ArsenalTab)

CSection:NewDropdown("Teleport To Arsenal", "Teleports you to the selected arsenal", ArsenalTab, function(CurrentOption)
    local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
    if CurrentOption == "Land Under The Waterfall" then
        HRP.CFrame = CFrame.new(-19912,-110,-6258)
    elseif CurrentOption == "Void" then
        HRP.CFrame = CFrame.new(-19396,-73,-4085)
    else
        HRP.CFrame = workspace.Arsenals:FindFirstChild(CurrentOption):FindFirstChild("Base").CFrame
    end
end)

local NPCs = {}
table.insert(NPCs,"Smile (Hyper)")
table.insert(NPCs,"Bottle of ??? (Hunter)")
table.insert(NPCs,"Blind Grillby (Burning Head)")
table.insert(NPCs,"Cursed Altar (Cursed)")
table.insert(NPCs,"Gabriel (Ocean Glider)")
table.insert(NPCs,"Green Light Green Light (Portal)")
table.insert(NPCs,"Gears (Time Grinders)")
table.insert(NPCs,"Mixed Letter (Ghoul)")
table.insert(NPCs,"Holy Cross (Holy)")
table.insert(NPCs,"Bottle (Gravity Boots)")
table.insert(NPCs,"Ancient Paw (Pull)")
table.insert(NPCs,"Noob (Torch)")
table.insert(NPCs,"Broski (Bounty Hunter)")
table.insert(NPCs,"Jeff (Berserk)")
table.insert(NPCs,"Gem (Crystalized)")
table.insert(NPCs,"Avatar of Radismus (Blood Wipe)")


CSection:NewDropdown("Teleport To Chosen Relic NPC", "Teleports you to the chosen Relic NPC", NPCs, function(CurrentOption)
local HRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if CurrentOption == "Bottle of ??? (Hunter)" then HRP.CFrame = CFrame.new(-1040.1, 195.214, -4722.89)
    elseif CurrentOption == "Blind Grillby (Burning Head)" then HRP.CFrame = CFrame.new(156.598, 162.562, -2334.68)
    elseif CurrentOption == "Cursed Altar (Cursed)" then HRP.CFrame = CFrame.new(-201.773, -98.5357, 2893.72)
    elseif CurrentOption == "Gabriel (Ocean Glider)" then HRP.CFrame = CFrame.new(1721.16, 4.14446, -5437.34)
    elseif CurrentOption == "Green Light Green Light (Portal)" then HRP.CFrame = CFrame.new(-529.14,-92.2,2063.35)
    elseif CurrentOption == "Gears (Time Grinders)" then HRP.CFrame = CFrame.new(-1848,203.5,-3941.5)
    elseif CurrentOption == "Mixed Letter (Ghoul)" then HRP.CFrame = CFrame.new(-1092.88, -101, 2155.55)
    elseif CurrentOption == "Holy Cross (Holy)" then HRP.CFrame = CFrame.new(-1275, 493, 67)
    elseif CurrentOption == "Bottle (Gravity Boots)" then HRP.CFrame = CFrame.new(5319.36, 13.2782, -8510.45)
    elseif CurrentOption == "Ancient Paw (Pull)" then HRP.CFrame = CFrame.new(-904, 70, -2592.5)
    elseif CurrentOption == "Noob (Torch)" then HRP.CFrame = CFrame.new(-124.406, 43.0267, -415.472)
    elseif CurrentOption == "Broski (Bounty Hunter)" then HRP.CFrame = CFrame.new(569.595, 194.855, -2082.55)
    elseif CurrentOption == "Jeff (Berserk)" then HRP.CFrame = CFrame.new(311.894, 66.9847, -1380.45)
    elseif CurrentOption == "Gem (Crystalized)" then HRP.CFrame = CFrame.new(681.1, 34.6, -1334.6)
    elseif CurrentOption == "Avatar of Radismus (Blood Wipe)" then HRP.CFrame = CFrame.new(5230.36, 384.857, 1645.1)
    elseif CurrentOption == "Smile (Hyper)" then HRP.CFrame = CFrame.new(-1201, -123, 2573)
    end
end)

local NPCTable = {}
local NPCFol = workspace.QuestNPCs:GetDescendants()
table.insert(NPCTable,"Grani")
table.insert(NPCTable,"King Blubb")

for i,v in pairs(NPCFol) do
if v.Name == "HumanoidRootPart" and v.Parent:IsA("Model") then
if not table.find(NPCTable,v.Parent.Name) then
table.insert(NPCTable,v.Parent.Name)
end
end
end

CSection:NewDropdown("Teleport To QuestNPC (Grani/Blubb too)", "Teleports you to the chosen Quest NPC", NPCTable, function(CurrentOption)
local Player = game:GetService("Players").LocalPlayer 
local Character = Player.Character or Player.CharacterAdded:Wait()
HRP = Player.Character:FindFirstChild("HumanoidRootPart")
if HRP then
	if CurrentOption == "Grani" then
		HRP.CFrame = CFrame.new(6737.32, 144.011, 9794.26)
	elseif CurrentOption == "King Blubb" then
		HRP.CFrame = CFrame.new(-3723.83, 431.422, -5055.45)
	else  HRP.CFrame = workspace.QuestNPCs:FindFirstChild(CurrentOption).HumanoidRootPart.CFrame
	end
end
end)

local StatuesFol = workspace.Statues:GetDescendants()
local StatuesTable = {}

for i,v in pairs(StatuesFol) do
if v.Name == "ProximityPrompt" and v.Parent.Name == "Attachment" then
if not table.find(StatuesTable,v.Parent.Parent.Parent.Name) then
table.insert(StatuesTable,v.Parent.Parent.Parent.Name)
end
end
end

CSection:NewDropdown("Teleport To Class Statue", "Teleports you to the chosen Class Statue", StatuesTable, function(CurrentOption)
local Player = game:GetService("Players").LocalPlayer 
local Character = Player.Character or Player.CharacterAdded:Wait()
HRP = Player.Character:FindFirstChild("HumanoidRootPart")

if HRP then
HRP.CFrame = workspace.Statues:FindFirstChild(CurrentOption):FindFirstChild("ProximityPrompt", true).Parent.Parent.CFrame
end
end)

CSection:NewButton("Teleport To Blackmarket", "Teleports the player to blackmarket", function()
    local BlackMarket = workspace:FindFirstChild("Stalls"):FindFirstChild("Black Market"):GetDescendants()
for i,v in pairs(BlackMarket) do
if v.Name == "Grani" and v.Parent.Parent.Name == "Grani" then
	local HRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
HRP.CFrame = v.CFrame
end
end
end)

CSection:NewButton("Teleport To Vanessa", "Teleports the player to Vanessa(bluemoon fairy)", function()
local fairy = workspace:FindFirstChild("Vanessa")
if fairy ~= nil then
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:FindFirstChild("HumanoidRootPart")
HRP.CFrame = fairy.HumanoidRootPart.CFrame
end
end)

CSection:NewButton("Teleport To Harvestia", "Teleports the player to Harvestia", function()
local fairy = workspace:FindFirstChild("Harvestia")
if fairy ~= nil then
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:FindFirstChild("HumanoidRootPart")
HRP.CFrame = fairy.HumanoidRootPart.CFrame
end
end)

local DTab = Window:NewTab("Other")
local DSection = DTab:NewSection("Other")

DSection:NewKeybind("Toggle UI Button", "Toggle UI Button", Enum.KeyCode.LeftControl, function()
	Library:ToggleUI()
end)

DSection:NewButton("Get all Chests", "Opens all the chests", function()
    local Chests = workspace:FindFirstChild("Chests"):GetDescendants()
local HRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
for i,v in pairs (Chests) do
if v.Name == "TouchInterest" and v.Parent.Name == "Giver" and v.Parent.Parent.Parent.Name == "Chests" and v.Parent.Parent.Parent:IsA("Folder") then
firetouchinterest(HRP,v.Parent,0)
firetouchinterest(HRP,v.Parent,1)
end
end
end)
