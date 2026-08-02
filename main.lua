--// Autofarm Variables
local autoFarmRunning = false
local autoFarmThread = nil

-- Fixed teleport position
local TELEPORT_POS = Vector3.new(-116, 2.5, 44)

-- Helper: teleport to a fixed position
local function teleportTo(position)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = CFrame.new(position.X, position.Y, position.Z)
    end
end

-- Helper: fire the remote
local function fireRemote()
    local remote = game.ReplicatedStorage.Packages.PacketPlus.RemoteEvent
    if remote then
        remote:FireServer(buffer.fromstring("\x08\x03USU\x05Pound\x00"))
    end
end

-- Main autofarm loop
local function startAutofarm()
    -- Teleport once when we start
    teleportTo(TELEPORT_POS)
    print("[Autofarm] Teleported to", TELEPORT_POS)

    autoFarmRunning = true
    while autoFarmRunning do
        fireRemote()
        wait(0.15)  -- fire every 0.15 seconds
    end
end

--// Override the autofarm toggle callback
UI.Toggles.autofarm:SetCallback(function(value)
    print("Autofarm toggled:", value)
    if value then
        -- Stop any previous thread
        if autoFarmThread then
            autoFarmRunning = false
            wait(0.2)
            autoFarmThread = nil
        end
        autoFarmRunning = true
        autoFarmThread = spawn(startAutofarm)
    else
        autoFarmRunning = false
        if autoFarmThread then
            autoFarmThread = nil
        end
    end
end)

print("Main script loaded – ready to cheat!")
