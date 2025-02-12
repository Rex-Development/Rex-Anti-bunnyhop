local jumpCount = 0
local lastJumpTime = 0
local maxJumps = 3        -- Maximale Anzahl an Sprüngen, bevor man hinfällt
local resetTime = 1.5     -- Zeitfenster, in dem Sprünge gezählt werden

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        local player = PlayerPedId()

        if IsPedJumping(player) then
            local currentTime = GetGameTimer() / 1000.0 -- Zeit in Sekunden

            if currentTime - lastJumpTime < resetTime then
                jumpCount = jumpCount + 1
            else
                jumpCount = 1
            end

            lastJumpTime = currentTime

            if jumpCount >= maxJumps then
                -- Spieler fällt hin
                SetPedToRagdoll(player, 2000, 2000, 0, true, true, false)
                jumpCount = 0 -- Zähler zurücksetzen
            end
        end
    end
end)
