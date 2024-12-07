-- Variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local toolName = "ClassicSword" -- Name of the sword
local loopActive = false

-- Function to check if a player is a friend
local function isFriend(player)
    return LocalPlayer:IsFriendsWith(player.UserId)
end

-- Function to attack players
local function attackPlayers()
    while loopActive do
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and not isFriend(player) then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid and player.Character:FindFirstChild("ForceField") == nil then
                    humanoid.Health = 0 -- Kills the player
                end
            end
        end
        task.wait(0.1) -- Delay to prevent overloading the server
    end
end

-- Tool equip event
LocalPlayer.CharacterAdded:Connect(function(character)
    character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") and child.Name == toolName then
            print("ClassicSword equipped, starting loop!")
            loopActive = true
            attackPlayers()
        end
    end)

    character.ChildRemoved:Connect(function(child)
        if child:IsA("Tool") and child.Name == toolName then
            print("ClassicSword unequipped, stopping loop!")
            loopActive = false
        end
    end)
end)
