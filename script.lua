local DeltaItemSpawner = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")

local correctKey = "house"
local keyVerified = false
local selectedItem = nil

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaItemSpawnerUI"
ScreenGui.Parent = game.CoreGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 350, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyFrame.BorderSizePixel = 0
KeyFrame.Visible = true
KeyFrame.Parent = ScreenGui

local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(0, 8)
UICorner1.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Position = UDim2.new(0, 0, 0, 10)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "DELTA ITEM SPAWNER"
KeyTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 20
KeyTitle.Parent = KeyFrame

local KeyLabel = Instance.new("TextLabel")
KeyLabel.Size = UDim2.new(1, 0, 0, 25)
KeyLabel.Position = UDim2.new(0, 0, 0, 60)
KeyLabel.BackgroundTransparency = 1
KeyLabel.Text = "Enter Access Key:"
KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyLabel.Font = Enum.Font.Gotham
KeyLabel.TextSize = 14
KeyLabel.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0, 250, 0, 35)
KeyBox.Position = UDim2.new(0.5, -125, 0, 90)
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderText = "Enter key here..."
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.Parent = KeyFrame

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 6)
UICorner2.Parent = KeyBox

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0, 120, 0, 35)
SubmitButton.Position = UDim2.new(0.5, -60, 0, 140)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitButton.Text = "VERIFY KEY"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 14
SubmitButton.Parent = KeyFrame

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 6)
UICorner3.Parent = SubmitButton

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Position = UDim2.new(0.1, 10, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 8)
UICorner4.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
Title.Text = "ITEM SPAWNER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local UICorner5 = Instance.new("UICorner")
UICorner5.CornerRadius = UDim.new(0, 8)
UICorner5.CornerRadius = UDim.new(0, 8)
UICorner5.Parent = Title

local ItemsList = {
    "Combat Rifle",
    "Shotgun", 
    "Pistol",
    "Sniper",
    "Medkit",
    "Bandages",
    "Armor",
    "Ammo Pack",
    "Grenade",
    "C4 Explosive"
}

local ItemButtonsFrame = Instance.new("ScrollingFrame")
ItemButtonsFrame.Size = UDim2.new(0, 280, 0, 150)
ItemButtonsFrame.Position = UDim2.new(0, 10, 0, 50)
ItemButtonsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ItemButtonsFrame.BorderSizePixel = 0
ItemButtonsFrame.CanvasSize = UDim2.new(0, 0, 0, #ItemsList * 35)
ItemButtonsFrame.Parent = MainFrame

local UICorner6 = Instance.new("UICorner")
UICorner6.CornerRadius = UDim.new(0, 6)
UICorner6.Parent = ItemButtonsFrame

local ItemsLayout = Instance.new("UIListLayout")
ItemsLayout.Padding = UDim.new(0, 5)
ItemsLayout.Parent = ItemButtonsFrame

for i, itemName in pairs(ItemsList) do
    local ItemButton = Instance.new("TextButton")
    ItemButton.Size = UDim2.new(0, 260, 0, 30)
    ItemButton.Position = UDim2.new(0, 10, 0, (i-1)*35)
    ItemButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    ItemButton.Text = itemName
    ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ItemButton.Font = Enum.Font.Gotham
    ItemButton.TextSize = 14
    ItemButton.Parent = ItemButtonsFrame
    
    local UICornerBtn = Instance.new("UICorner")
    UICornerBtn.CornerRadius = UDim.new(0, 4)
    UICornerBtn.Parent = ItemButton
    
    ItemButton.MouseButton1Click:Connect(function()
        selectedItem = itemName
        for _, btn in pairs(ItemButtonsFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                if btn.Text == itemName then
                    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                else
                    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                end
            end
        end
    end)
end

local SpawnButton = Instance.new("TextButton")
SpawnButton.Size = UDim2.new(0, 200, 0, 35)
SpawnButton.Position = UDim2.new(0.5, -100, 0, 210)
SpawnButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
SpawnButton.Text = "SPAWN SELECTED ITEM"
SpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnButton.Font = Enum.Font.GothamBold
SpawnButton.TextSize = 14
SpawnButton.Parent = MainFrame

local UICorner7 = Instance.new("UICorner")
UICorner7.CornerRadius = UDim.new(0, 6)
UICorner7.Parent = SpawnButton

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 220)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Select an item to spawn"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.Parent = MainFrame

function DeltaItemSpawner.spawnItem(itemName)
    if not itemName then
        StatusLabel.Text = "Error: No item selected"
        return false
    end
    
    StatusLabel.Text = "Spawning: " .. itemName
    wait(0.5)
    
    local character = LocalPlayer.Character
    if not character then
        StatusLabel.Text = "Error: No character found"
        return false
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        StatusLabel.Text = "Error: Cannot find root part"
        return false
    end
    
    local spawnPosition = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 5
    
    local tool = Instance.new("Tool")
    tool.Name = itemName
    tool.Parent = LocalPlayer.Backpack
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.BrickColor = BrickColor.new("Bright blue")
    handle.Parent = tool
    
    StatusLabel.Text = "Success: " .. itemName .. " spawned!"
    
    wait(2)
    StatusLabel.Text = "Ready - Select another item"
    
    return true
end

SubmitButton.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text
    
    if enteredKey == correctKey then
        keyVerified = true
        KeyFrame.Visible = false
        MainFrame.Visible = true
        StatusLabel.Text = "Welcome! Select an item to spawn"
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Invalid key! Try again..."
    end
end)

KeyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        SubmitButton.MouseButton1Click:Connect()
    end
end)

SpawnButton.MouseButton1Click:Connect(function()
    if keyVerified and selectedItem then
        DeltaItemSpawner.spawnItem(selectedItem)
    else
        StatusLabel.Text = "Please select an item first!"
    end
end)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = MainFrame

local UICorner8 = Instance.new("UICorner")
UICorner8.CornerRadius = UDim.new(0, 4)
UICorner8.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local DragToggle = Instance.new("TextButton")
DragToggle.Size = UDim2.new(1, 0, 0, 40)
DragToggle.Position = UDim2.new(0, 0, 0, 0)
DragToggle.BackgroundTransparency = 1
DragToggle.Text = ""
DragToggle.Parent = MainFrame

local dragging = false
local dragInput, dragStart, startPos

DragToggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

DragToggle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

RunService.Heartbeat:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("Delta Item Spawner loaded successfully!")
print("Please enter the key to access the spawner")

return DeltaItemSpawnelocal DeltaItemSpawner = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")

local correctKey = "DELTA2024"
local keyVerified = false
local selectedItem = nil

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaItemSpawnerUI"
ScreenGui.Parent = game.CoreGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 350, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyFrame.BorderSizePixel = 0
KeyFrame.Visible = true
KeyFrame.Parent = ScreenGui

local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(0, 8)
UICorner1.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Position = UDim2.new(0, 0, 0, 10)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "DELTA ITEM SPAWNER"
KeyTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 20
KeyTitle.Parent = KeyFrame

local KeyLabel = Instance.new("TextLabel")
KeyLabel.Size = UDim2.new(1, 0, 0, 25)
KeyLabel.Position = UDim2.new(0, 0, 0, 60)
KeyLabel.BackgroundTransparency = 1
KeyLabel.Text = "Enter Access Key:"
KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyLabel.Font = Enum.Font.Gotham
KeyLabel.TextSize = 14
KeyLabel.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0, 250, 0, 35)
KeyBox.Position = UDim2.new(0.5, -125, 0, 90)
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderText = "Enter key here..."
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.Parent = KeyFrame

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 6)
UICorner2.Parent = KeyBox

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0, 120, 0, 35)
SubmitButton.Position = UDim2.new(0.5, -60, 0, 140)
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitButton.Text = "VERIFY KEY"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 14
SubmitButton.Parent = KeyFrame

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 6)
UICorner3.Parent = SubmitButton

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Position = UDim2.new(0.1, 10, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 8)
UICorner4.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
Title.Text = "ITEM SPAWNER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local UICorner5 = Instance.new("UICorner")
UICorner5.CornerRadius = UDim.new(0, 8)
UICorner5.CornerRadius = UDim.new(0, 8)
UICorner5.Parent = Title

local ItemsList = {
    "Combat Rifle",
    "Shotgun", 
    "Pistol",
    "Sniper",
    "Medkit",
    "Bandages",
    "Armor",
    "Ammo Pack",
    "Grenade",
    "C4 Explosive"
}

local ItemButtonsFrame = Instance.new("ScrollingFrame")
ItemButtonsFrame.Size = UDim2.new(0, 280, 0, 150)
ItemButtonsFrame.Position = UDim2.new(0, 10, 0, 50)
ItemButtonsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ItemButtonsFrame.BorderSizePixel = 0
ItemButtonsFrame.CanvasSize = UDim2.new(0, 0, 0, #ItemsList * 35)
ItemButtonsFrame.Parent = MainFrame

local UICorner6 = Instance.new("UICorner")
UICorner6.CornerRadius = UDim.new(0, 6)
UICorner6.Parent = ItemButtonsFrame

local ItemsLayout = Instance.new("UIListLayout")
ItemsLayout.Padding = UDim.new(0, 5)
ItemsLayout.Parent = ItemButtonsFrame

for i, itemName in pairs(ItemsList) do
    local ItemButton = Instance.new("TextButton")
    ItemButton.Size = UDim2.new(0, 260, 0, 30)
    ItemButton.Position = UDim2.new(0, 10, 0, (i-1)*35)
    ItemButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    ItemButton.Text = itemName
    ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ItemButton.Font = Enum.Font.Gotham
    ItemButton.TextSize = 14
    ItemButton.Parent = ItemButtonsFrame
    
    local UICornerBtn = Instance.new("UICorner")
    UICornerBtn.CornerRadius = UDim.new(0, 4)
    UICornerBtn.Parent = ItemButton
    
    ItemButton.MouseButton1Click:Connect(function()
        selectedItem = itemName
        for _, btn in pairs(ItemButtonsFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                if btn.Text == itemName then
                    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                else
                    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                end
            end
        end
    end)
end

local SpawnButton = Instance.new("TextButton")
SpawnButton.Size = UDim2.new(0, 200, 0, 35)
SpawnButton.Position = UDim2.new(0.5, -100, 0, 210)
SpawnButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
SpawnButton.Text = "SPAWN SELECTED ITEM"
SpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnButton.Font = Enum.Font.GothamBold
SpawnButton.TextSize = 14
SpawnButton.Parent = MainFrame

local UICorner7 = Instance.new("UICorner")
UICorner7.CornerRadius = UDim.new(0, 6)
UICorner7.Parent = SpawnButton

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 220)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Select an item to spawn"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.Parent = MainFrame

function DeltaItemSpawner.spawnItem(itemName)
    if not itemName then
        StatusLabel.Text = "Error: No item selected"
        return false
    end
    
    StatusLabel.Text = "Spawning: " .. itemName
    wait(0.5)
    
    local character = LocalPlayer.Character
    if not character then
        StatusLabel.Text = "Error: No character found"
        return false
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        StatusLabel.Text = "Error: Cannot find root part"
        return false
    end
    
    local spawnPosition = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 5
    
    local tool = Instance.new("Tool")
    tool.Name = itemName
    tool.Parent = LocalPlayer.Backpack
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.BrickColor = BrickColor.new("Bright blue")
    handle.Parent = tool
    
    StatusLabel.Text = "Success: " .. itemName .. " spawned!"
    
    wait(2)
    StatusLabel.Text = "Ready - Select another item"
    
    return true
end

SubmitButton.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text
    
    if enteredKey == correctKey then
        keyVerified = true
        KeyFrame.Visible = false
        MainFrame.Visible = true
        StatusLabel.Text = "Welcome! Select an item to spawn"
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Invalid key! Try again..."
    end
end)

KeyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        SubmitButton.MouseButton1Click:Connect()
    end
end)

SpawnButton.MouseButton1Click:Connect(function()
    if keyVerified and selectedItem then
        DeltaItemSpawner.spawnItem(selectedItem)
    else
        StatusLabel.Text = "Please select an item first!"
    end
end)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = MainFrame

local UICorner8 = Instance.new("UICorner")
UICorner8.CornerRadius = UDim.new(0, 4)
UICorner8.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local DragToggle = Instance.new("TextButton")
DragToggle.Size = UDim2.new(1, 0, 0, 40)
DragToggle.Position = UDim2.new(0, 0, 0, 0)
DragToggle.BackgroundTransparency = 1
DragToggle.Text = ""
DragToggle.Parent = MainFrame

local dragging = false
local dragInput, dragStart, startPos

DragToggle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

DragToggle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

RunService.Heartbeat:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("Delta Item Spawner loaded successfully!")
print("Please enter the key to access the spawner")

return DeltaItemSpawner
