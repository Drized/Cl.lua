local Player = game:GetService("Players").LocalPlayer
 
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Discord : Drized |", "BloodTheme")

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

ASection:NewDropdown("Teleport To Mob", "Teleports you to the mob selected once(repeatable)", Mobs, function(CurrentOption)
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local Enemies = workspace.Enemies:GetDescendants()
   for i,v in next, Enemies do 
      if v.Parent.Name == "Enemy" and v:IsA("BasePart") and v.Name == "EnemyLocation" and tostring(v.Parent.Model.Value) == CurrentOption and v.Parent.InCombat.Value == false and v.Parent:FindFirstChild("EnemyDefeat") ~= true then
         HRP.CFrame = v.CFrame
      end
   end
end)

getgenv().stopautotpmobloop = false

ASection:NewDropdown("Autoteleport To Mob", "Automatically teleports you to the mob selected", Mobs, function(CurrentOption)
spawn(function()
    while not stopautotpmobloop and wait(0.5) do
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local Enemies = workspace.Enemies:GetDescendants()
        if getgenv().stopautotpmobloop == true then
            break
        end
    local CombatFolder = workspace:FindFirstChild("CombatFolder")
        if CombatFolder == nil then
            for i,v in next, Enemies do 
                if v.Parent.Name == "Enemy" and v:IsA("BasePart") and v.Name == "EnemyLocation" and tostring(v.Parent.Model.Value) == CurrentOption and v.Parent.InCombat.Value == false and v.Parent:FindFirstChild("EnemyDefeat") ~= true then
                    HRP.CFrame = v.CFrame
                    break
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
    while Tp and wait(0.001) do
	local MyFol
        local CombatFolder = workspace:FindFirstChild("CombatFolder")
        if CombatFolder ~= nil and CombatFolder:FindFirstChild(Player.Name) then
	    local Player = game:GetService("Players").LocalPlayer	
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local HRP = Character:FindFirstChild("HumanoidRootPart")
            MyFol = CombatFolder:FindFirstChild(Player.Name):GetDescendants()
	    if MyFol then
            for i,v in pairs(MyFol) do
                if v:IsA("BasePart") and v.Name == "HitBox" or v.Name == "Base" then
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

local BTab = Window:NewTab("Fruits/Trees/Pickups")
local BSection = BTab:NewSection("Fruits/Trees/Pickups")

local Mats = true
local MaterialGivers = game:GetService("Workspace"):FindFirstChild("MaterialGivers"):GetDescendants()
BSection:NewButton("Teleport To A Deathbush/SweetLoveBush", "Teleports you to a Deathbush if it exists", function()
local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
local WorkspaceD = workspace:GetDescendants()
   for i,v in next, WorkspaceD do 
      if v.Name == "Middle" and v.Parent.Parent == workspace and v.Parent.Name == "DeathBush" then
         HRP.CFrame = v.CFrame
      end
   end
end)

local CTab = Window:NewTab("Teleport")
local CSection = CTab:NewSection("Teleport")

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

DSection:NewButton("Open all Chests", "Opens all the chests", function()
    local Chests = workspace:FindFirstChild("Chests"):GetDescendants()
local HRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
for i,v in pairs (Chests) do
if v.Name == "TouchInterest" and v.Parent.Name == "Giver" and v.Parent.Parent.Parent.Name == "Chests" and v.Parent.Parent.Parent:IsA("Folder") then
firetouchinterest(HRP,v.Parent,0)
firetouchinterest(HRP,v.Parent,1)
end
end
end)
