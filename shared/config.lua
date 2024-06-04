Config = {
    -- Digging configuration
    ArcCommonPed = 'U_F_O_ProlHost_01',
    ArcCommonPedLocation = vec4(-2273.12, 262.72, 169.57, 131.87),
    DigItem = 'trowel',
    Scenario = 'WORLD_HUMAN_GARDENER_PLANT',
    DigTimeMin = 10000, -- How long should it take at least to dig something up? 1000 = 1 second
    DigTimeMax = 20000, -- How long should it take at most to dig something up? 1000 = 1 second
    RandomTime = true, -- Set to true for random dig time between DigTimeMin and DigTimeMax, if false DigTimeMax will be used
    MinDistanceBetweenSites = 15.0, -- Distance between each dig site (player only, not shared) - 1.0 = 1 vector unit
    RareItems = {
        -- Must be arranged in asc order 
        -- Range is from 0 to 1000
        -- The lower the value, the rarer the item             
        [1] = { value = 10,    item = 'echain',        label = "Broken Gold Chain" },  -- Sell: $10000
        [2] = { value = 15,   item = 'slatetablet',   label = "Slate Tablet" },       -- Sell: $9000
        [3] = { value = 25,   item = 'dinoegg',       label = "Dino Egg" },           -- Sell: $7500
        [4] = { value = 50,   item = 'princeruby',    label = "Ancient Red Gem" },    -- Sell: $5000
        [5] = { value = 75,    item = 'mythicfossil',  label = "Mythic Fossil" },     -- Sell: $2500
        [6] = { value = 100,    item = 'onyxrelic',     label = "Onyx Relic" },         -- Sell: $1000
        [7] = { value = 150,    item = 'rarefossil',    label = "Rare Fossil" },        -- Sell: $750
        [8] = { value = 200,    item = 'timecapsule',   label = "Time Capsule" },       -- Sell: $600
        [9] = { value = 250,    item = 'decoratedpot',  label = "Decorated Pot" },      -- Sell: $500
        [10] = { value = 300,    item = 'fossil',        label = "Fossil" },             -- Sell: $400
        [11] = { value = 350,    item = 'relic',         label = "Relic" },              -- Sell: $300
        [12] = { value = 400,    item = 'pot',           label = "Pot" },                -- Sell: $200
        [13] = { value = 450,    item = 'skull',         label = "Skull" },              -- Sell: $100
        [14] = { value = 800,    item = 'dirtpile',      label = "Pile of Dirt" },       -- NO SELL
    },
    MaxGroundAngle = 0.6, -- Ground angle before it becomes undiggable (honestly just to avoid exploiting odd places)
    Ground = {
        -- Define ground hashes where digging can take place     
        -- Floating point values define 2nd value in RNG for reward, lower values increases the odds   
        [2409420175] = 1500, -- grass
        [3833216577] = 1500, -- grass
        [1333033863] = 1500, -- grass
        [4170197704] = 1500, -- grass
        [1109728704] = 1500, -- grass
        [2352068586] = 1500, -- grass
        [581794674] = 1500, -- grass
        [-461750719] = 1500, -- grass
        [-1286696947] = 1500, -- grass
        [-1885547121] = 1500, -- grass
        [-913351839] = 1500, -- grass
        [-840216541] = 1400, -- zancudo shoreline
        [-2041329971] = 1400, -- dirt
        [-1775485061] = 1400, -- mount chiliad dirt/sand
        [1635937914] = 1400, -- mud path
        [510490462] = 1375, -- sandy path
        [1584636462] = 1350, -- zancudo swamp
        [-1942898710] = 1350, -- zancudo sand
        [1288448767] = 1350, -- wet sand
        [3008270349] = 1350, -- sand
        [223086562] = 1350, -- sand
        [3594309083] = 1350, -- sand
        [2461440131] = 1350, -- sand
        [1144315879] = 1350, -- sand
        [2128369009] = 1350, -- sand     
        [-1595148316] = 1350, -- sand     
        [509508168] = 1350, -- sand     
    },
    RequiredTool = { item = 'trowel', label = 'Trowel' }, -- Item required for digging      
}

-- USE THIS SNIPPET BELOW TO GET THE GROUND HASH (RUN WITH LUA IN-GAME)

--[[ runWhile = true;
coords = GetEntityCoords(PlayerPedId());
print(coords);

while runWhile do
    local color = {r = 80, g = 170, b = 50, a = 255}
    A, B, Coords, D, E = lib.raycast.cam(1, 7, 20)
    SetEntityCoords(containerPlacement, Coords.x, Coords.y, Coords.z, false, false, false, false)
            
    DrawMarker(28, Coords.x, Coords.y, Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.05, 0.05, 0.05, color.r, color.g, color.b, color.a, false, true, 2, false, nil, nil, false)
      
    Citizen.Wait(0)
    if IsControlPressed(2,38) then
        lib.setClipboard(tostring(E))
        print(E)
        runWhile = false;
    end
end ]]