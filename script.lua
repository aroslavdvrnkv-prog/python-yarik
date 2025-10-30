-- Скрипт спавна предметов для Delta Executor
local function spawnItem(itemId, position)
    local game = game
    local players = game:GetService("Players")
    local workspace = game:GetService("Workspace")
    local localPlayer = players.LocalPlayer
    
    -- Создание нового предмета
    local item = Instance.new("Part")
    item.Name = "SpawnedItem"
    item.Size = Vector3.new(2, 2, 2)
    item.Position = position or localPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
    item.Anchored = true
    item.CanCollide = true
    item.BrickColor = BrickColor.new("Bright green")
    item.Parent = workspace
    
    -- Добавление свечения
    local pointLight = Instance.new("PointLight")
    pointLight.Brightness = 5
    pointLight.Range = 10
    pointLight.Color = Color3.new(0, 1, 0)
    pointLight.Parent = item
    
    return item
end

-- Функция массового спавна
local function massSpawn(amount)
    local startPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    for i = 1, amount do
        local offset = Vector3.new(
            math.random(-10, 10),
            5,
            math.random(-10, 10)
        )
        spawnItem(nil, startPos + offset)
        wait(0.1)
    end
end

-- Интерфейс управления
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Item Spawner Delta",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "DeltaSpawner"
})

local SpawnTab = Window:MakeTab({
    Name = "Спавн предметов",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

SpawnTab:AddButton({
    Name = "Спавн одного предмета",
    Callback = function()
        spawnItem()
    end
})

SpawnTab:AddSlider({
    Name = "Массовый спавн",
    Min = 1,
    Max = 50,
    Default = 5,
    Color = Color3.fromRGB(0, 255, 0),
    Increment = 1,
    ValueName = "предметов",
    Callback = function(Value)
        massSpawn(Value)
    end
})

OrionLib:Init()
