Config = {
    -- Digging configuration
    DigItem = 'trowel',
    Scenario = 'WORLD_HUMAN_GARDENER_PLANT',
    DigTimeMin = 10000, -- How long should it take at least to dig something up? 1000 = 1 second
    DigTimeMax = 20000, -- How long should it take at most to dig something up? 1000 = 1 second
    RandomTime = true, -- Set to true for random dig time between DigTimeMin and DigTimeMax, if false DigTimeMax will be used
    MinDistanceBetweenSites = 2.5, -- Distance between each dig site (player only, not shared) - 1.0 = 1 vector unit
    RareItems = {
        -- Must be arranged in asc order 
        -- Range is from 0 to 1000
        -- The lower the value, the rarer the item             
        [1] = { value = 10, item = 'dinoegg', label = "dinosaur egg" },
        [2] = { value = 30, item = 'pricelessjewel', label = "priceless jewel" },
        [3] = { value = 50, item = 'mythicfossil', label = "mythic fossil" },
        [4] = { value = 80, item = 'rarefossil', label = "rare fossil" },
        [5] = { value = 120, item = 'necklace', label = "necklace" },
        [6] = { value = 150, item = 'skull', label = "skull" },
        [7] = { value = 180, item = 'bracelet', label = "bracelet" }
    },
    MaxGroundAngle = 0.6, -- Ground angle before it becomes undiggable (honestly just to avoid exploiting odd places)
    Ground = {
        -- Define ground hashes where digging can take place     
        -- Floating point values define 2nd value in RNG for reward, lower values increases the odds   
        [2409420175] = 1000, -- grass
        [3833216577] = 1000, -- grass
        [1333033863] = 1000, -- grass
        [4170197704] = 1000, -- grass
        [1109728704] = 1000, -- grass
        [2352068586] = 1000, -- grass
        [581794674] = 1000, -- grass
        [-461750719] = 1000, -- grass
        [-1286696947] = 1000, -- grass
        [3008270349] = 850, -- sand
        [223086562] = 850, -- sand
        [3594309083] = 850, -- sand
        [2461440131] = 850, -- sand
        [1144315879] = 850, -- sand
        [2128369009] = 850 -- sand     
    },
    RequiredTool = { item = 'trowel', label = 'Trowel' }, -- Item required for digging      
}