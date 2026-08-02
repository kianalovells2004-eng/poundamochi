--// Main script – uses UI from _G.UI
local UI = _G.UI
if not UI then
    warn("[Main] UI not found – make sure loader runs first")
    return
end

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
    teleportTo(TELEPORT_POS)
    print("[Autofarm] Teleported to", TELEPORT_POS)
    autoFarmRunning = true
    while autoFarmRunning do
        fireRemote()
        wait(0.15)
    end
end

-- Override the autofarm toggle callback
if UI.Toggles and UI.Toggles.autofarm then
    UI.Toggles.autofarm:SetCallback(function(value)
        print("Autofarm toggled:", value)
        if value then
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
else
    warn("[Main] Autofarm toggle not found in UI")
end

print("Main script loaded – ready to cheat!")
