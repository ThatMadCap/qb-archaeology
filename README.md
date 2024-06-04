# Archaeology for QBCore

## Description
An archaeology activity for players. Using a specific tool, players can dig for rare items. Only certain grounds can be dug up. Item rarity is effected by the type of ground.

## MadCap updates.
* Added 14 items of varying rarity, with HQ custom images.
* Digging now spawns a pile of dirt under the player, synced to the server.
* Added selling point for items.
* Added more ground hashes.
* Tweaked loot weights, is profitable when you are lucky, but otherwise not an OP activity (shouldn't break your server's economy)

* Add these items to your shared items.lua
```lua
-- qb archeology
['trowel']  	    = {['name'] = 'trowel', 	    ['label'] = 'Trowel', 	        ['weight'] = 5000, 	['type'] = 'item',  	['image'] = 'marijuana_trowel.png',    ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'Small handheld shovel used for digging', created = nil, decay = 28.0 }, -- 4 weeks
['dirtpile']  	    = {['name'] = 'dirtpile', 	    ['label'] = 'Pile of Dirt', 	['weight'] = 1000, 	['type'] = 'item',  	['image'] = 'clump.png',               ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A pile of dirt. Fun!'},
['skull']  	        = {['name'] = 'skull', 	        ['label'] = 'Skull', 	        ['weight'] = 5000, 	['type'] = 'item',  	['image'] = 'skull.png',               ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'Alas, Poor Yorick!'},
['relic']  	        = {['name'] = 'relic', 	        ['label'] = 'Relic', 	        ['weight'] = 5000, 	['type'] = 'item',  	['image'] = 'relic.png',               ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A unique Relic found underground'},
['onyxrelic']  	    = {['name'] = 'onyxrelic', 	    ['label'] = 'Onyx Relic', 	    ['weight'] = 5000, 	['type'] = 'item',  	['image'] = 'onyxrelic.png',           ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A unique Onyx Relic found underground'},
['fossil']  	    = {['name'] = 'fossil', 	    ['label'] = 'Fossil', 	        ['weight'] = 5000, 	['type'] = 'item',  	['image'] = 'fossil.png',              ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A small piece of material containing a trace of an ancient being'},
['rarefossil']  	= {['name'] = 'rarefossil', 	['label'] = 'Rare Fossil', 	    ['weight'] = 7500, 	['type'] = 'item',  	['image'] = 'rarefossil.png',          ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A large chunk of material containing the remains of an ancient living thing'},
['mythicfossil']  	= {['name'] = 'mythicfossil', 	['label'] = 'Mythic Fossil',    ['weight'] = 9000, 	['type'] = 'item',  	['image'] = 'mythicfossil2.png',       ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A huge chunk of rock containing the unique remains of an ancient... something?'},
['princeruby']      = {['name'] = 'princeruby',     ['label'] = 'Ancient Red Gem',  ['weight'] = 5000,  ['type'] = 'item',  	['image'] = 'princeruby.png',          ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'This large, irregular shaped red gem looks incredibly rare'},
['dinoegg']  	    = {['name'] = 'dinoegg', 	    ['label'] = 'Dino Egg', 	    ['weight'] = 10000, ['type'] = 'item',  	['image'] = 'dinoegg.png',             ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A very large egg with a strange texture. What could possibly have laid this?'},
['pot']  	        = {['name'] = 'pot', 	        ['label'] = 'Pot', 	            ['weight'] = 10000, ['type'] = 'item',  	['image'] = 'pot.png',                 ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'An ancient pot, unearthed from the ground'},
['decoratedpot']  	= {['name'] = 'decoratedpot', 	['label'] = 'Decorated Pot', 	['weight'] = 10000, ['type'] = 'item',  	['image'] = 'decoratedpot.png',        ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A beautiful ancient pot, unearthed from the ground. It has particularly unique decorations'},
['slatetablet']  	= {['name'] = 'slatetablet', 	['label'] = 'Slate Tablet', 	['weight'] = 15000, ['type'] = 'item',  	['image'] = 'slatetablet.png',         ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A heavy slate tablet. There used to be what looks like a set of commandments etched onto the surface, but it\'s impossible to make sense of them anymore'},
['echain']  	    = {['name'] = 'echain', 	    ['label'] = 'Broken Gold Chain',['weight'] = 7000, 	['type'] = 'item',  	['image'] = 'erustchain.png',          ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A heavy gold chain with a large medallion. An insignia can almost be made out, but the chain is bent, scratched and broken beyond recognition.'},
['timecapsule']  	= {['name'] = 'timecapsule', 	['label'] = 'Time Capsule',     ['weight'] = 8500, 	['type'] = 'item',  	['image'] = 'timecapsule.png',         ['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,    ['combinable'] = nil,   ['description'] = 'A historic cache of goods. This capsule has a label attached: \'Ralph Pigeon Snr Snr - 1892\''},
```

## Configuration
* Set min and max task times
* Configure/Add/Remove items that are to be found + their rarity
* Configure/Add/Remove the diggable ground hashes + their respective impact on rarity
* Configure the distance between each spot that gets dug up by a player (Client Sided, Not Server Sided)

## Original Script by Mayo | Update by complexza (made changes for QBCore) | Then forked and updated by MadCap
https://github.com/itsamayo/fivem_archaeology
