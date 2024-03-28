--this is a bucket

-- Workbench
local WB_SLOT1 = peripheral.wrap("create:mechanical_crafter_0")
local WB_SLOT2 = peripheral.wrap("create:mechanical_crafter_1")
local WB_SLOT3 = peripheral.wrap("create:mechanical_crafter_2")
local WB_SLOT4 = peripheral.wrap("create:mechanical_crafter_3")
local WB_SLOT5 = peripheral.wrap("create:mechanical_crafter_4")
local WB_SLOT6 = peripheral.wrap("create:mechanical_crafter_5")
local WB_SLOT7 = peripheral.wrap("create:mechanical_crafter_6")
local WB_SLOT8 = peripheral.wrap("create:mechanical_crafter_7")
local WB_SLOT9 = peripheral.wrap("create:mechanical_crafter_8")

local WB_SLOTS = {WB_SLOT1,WB_SLOT2,WB_SLOT3,WB_SLOT4,WB_SLOT5,WB_SLOT6,WB_SLOT7,WB_SLOT8,WB_SLOT9}
local WB_BUTTON = peripheral.wrap("redrouter_1")
local WB_OUTPUT = peripheral.wrap("ironchests:copper_barrel_9")

local COMPR_INPUT = peripheral.wrap("minecraft:hopper_0")
local COMPR_OUTPUT = peripheral.wrap("ironchests:iron_barrel_0")

local CUTTER_INPUT = peripheral.wrap("minecraft:hopper_1")
local CUTTER_OUTPUT = peripheral.wrap("ironchests:iron_barrel_1")

local TOMS = peripheral.wrap("toms_storage:ts.inventory_connector_1")

local TANK_1 = peripheral.wrap("modern_industrialization:quantum_tank_0")
local TANK_2 = peripheral.wrap("modern_industrialization:quantum_tank_1")
local TANK_3 = peripheral.wrap("modern_industrialization:quantum_tank_2")
local TANK_4 = peripheral.wrap("modern_industrialization:quantum_tank_3")
local TANK_5 = peripheral.wrap("modern_industrialization:quantum_tank_4")
local TANK_6 = peripheral.wrap("modern_industrialization:quantum_tank_5")
local TANK_7 = peripheral.wrap("modern_industrialization:quantum_tank_6")
local TANK_8 = peripheral.wrap("modern_industrialization:quantum_tank_7")
local TANK_9 = peripheral.wrap("modern_industrialization:quantum_tank_8")
local TANK_10 = peripheral.wrap("modern_industrialization:quantum_tank_9")
local TANK_11 = peripheral.wrap("modern_industrialization:quantum_tank_10")
local TANK_12 = peripheral.wrap("modern_industrialization:quantum_tank_11")
local TANK_13 = peripheral.wrap("modern_industrialization:quantum_tank_12")
local TANK_14 = peripheral.wrap("modern_industrialization:quantum_tank_13")
local TANK_15 = peripheral.wrap("modern_industrialization:quantum_tank_14")

ITEMS = {
    {name="minecraft:oak_log",craftType="none"},
    {name="minecraft:oak_planks",craftType="workbench",craftID=1,count=4},
    {name="minecraft:crafting_table",craftType="workbench",craftID=2,count=4},
    {name="minecraft:stick",craftType="workbench",craftID=3,count=4},
    {name="minecraft:wooden_sword",craftType="workbench",craftID=4,count=1},
    {name="minecraft:chest",craftType="workbench",craftID=5,count=1},
    {name="minecraft:glass",craftType="none"},
    {name="minecraft:glass_pane",craftType="workbench",craftID=17,count=16},
    -- steel
    {name="ad_astra:steel_ingot",craftType="none"},
    {name="modern_industrialization:steel_plate",craftType="compressor",craftID=1,count=1},
    {name="modern_industrialization:steel_rod",craftType="cutter",craftID=1,count=2},
    {name="modern_industrialization:steel_bolt",craftType="cutter",craftID=2,count=2},
    {name="modern_industrialization:steel_ring",craftType="compressor",craftID=2,count=1},
    {name="modern_industrialization:steel_gear",craftType="workbench",craftID=6,count=1},
    {name="modern_industrialization:steel_curved_plate",craftType="compressor",craftID=3,count=1},
    {name="modern_industrialization:steel_drill_head",craftType="workbench",craftID=7,count=1},
    -- iron 
    {name="minecraft:iron_ingot",craftType="none"},
    {name="modern_industrialization:iron_plate",craftType="compressor",craftID=4,count=1},
    {name="modern_industrialization:iron_rod",craftType="cutter",craftID=3,count=2},
    {name="modern_industrialization:iron_bolt",craftType="cutter",craftID=4,count=2},
    {name="modern_industrialization:iron_ring",craftType="compressor",craftID=5,count=1},
    {name="modern_industrialization:iron_gear",craftType="workbench",craftID=8,count=1},
    -- bronze
    {name="modern_industrialization:bronze_ingot",craftType="none"},
    {name="modern_industrialization:bronze_plate",craftType="compressor",craftID=6,count=1},
    {name="modern_industrialization:bronze_rod",craftType="cutter",craftID=5,count=2},
    {name="modern_industrialization:bronze_bolt",craftType="cutter",craftID=6,count=2},
    {name="modern_industrialization:bronze_ring",craftType="compressor",craftID=7,count=1},
    {name="modern_industrialization:bronze_gear",craftType="workbench",craftID=9,count=1},
    {name="modern_industrialization:bronze_curved_plate",craftType="compressor",craftID=8,count=1},
    {name="modern_industrialization:bronze_drill_head",craftType="workbench",craftID=10,count=1},
    {name="modern_industrialization:bronze_drill",craftType="workbench",craftID=18,count=4},
    -- copper
    {name="minecraft:copper_ingot",craftType="none"},
    {name="modern_industrialization:copper_plate",craftType="compressor",craftID=9,count=1},
    {name="modern_industrialization:copper_rod",craftType="cutter",craftID=7,count=2},
    {name="modern_industrialization:copper_bolt",craftType="cutter",craftID=8,count=2},
    {name="modern_industrialization:copper_ring",craftType="compressor",craftID=10,count=1},
    {name="modern_industrialization:copper_gear",craftType="workbench",craftID=12,count=1},
    {name="modern_industrialization:copper_curved_plate",craftType="compressor",craftID=11,count=1},
    {name="modern_industrialization:copper_drill_head",craftType="workbench",craftID=13,count=1},
    {name="modern_industrialization:copper_blade",craftType="workbench",craftID=14,count=4},
    {name="modern_industrialization:copper_rotor",craftType="workbench",craftID=15,count=1},
    -- components
    {name="modern_industrialization:item_pipe",craftType="workbench",craftID=11,count=16},
    {name="modern_industrialization:fluid_pipe",craftType="workbench",craftID=16,count=16},
}

local WORKBENCH_CRAFT = {
    {requiredItems={"minecraft:oak_log"},craftPattern={1,0,0,0,0,0,0,0,0}},
    {requiredItems={"minecraft:oak_planks"},craftPattern={1,1,0,1,1,0,0,0,0}},
    {requiredItems={"minecraft:oak_planks"},craftPattern={1,0,0,1,0,0,0,0,0}},
    {requiredItems={"minecraft:oak_planks","minecraft:stick"},craftPattern={1,0,0,1,0,0,2,0,0}},
    {requiredItems={"minecraft:oak_planks"},craftPattern={1,1,1,1,0,1,1,1,1}},
    {requiredItems={"modern_industrialization:steel_plate","modern_industrialization:steel_bolt","modern_industrialization:steel_ring"},craftPattern={1,2,1,2,3,2,1,2,1}},
    {requiredItems={"modern_industrialization:steel_bolt","modern_industrialization:steel_curved_plate","modern_industrialization:steel_plate","modern_industrialization:steel_gear","modern_industrialization:steel_rod"},craftPattern={1,2,3,4,5,2,1,4,1}},
    {requiredItems={"modern_industrialization:iron_plate","modern_industrialization:iron_bolt","modern_industrialization:iron_ring"},craftPattern={1,2,1,2,3,2,1,2,1}},
    {requiredItems={"modern_industrialization:bronze_plate","modern_industrialization:bronze_bolt","modern_industrialization:bronze_ring"},craftPattern={1,2,1,2,3,2,1,2,1}},
    {requiredItems={"modern_industrialization:bronze_bolt","modern_industrialization:bronze_curved_plate","modern_industrialization:bronze_plate","modern_industrialization:bronze_gear","modern_industrialization:bronze_rod"},craftPattern={1,2,3,4,5,2,1,4,1}},
    {requiredItems={"modern_industrialization:bronze_curved_plate","modern_industrialization:steel_gear"},craftPattern={1,1,1,2,0,2,1,1,1}},
    {requiredItems={"modern_industrialization:copper_plate","modern_industrialization:copper_bolt","modern_industrialization:copper_ring"},craftPattern={1,2,1,2,3,2,1,2,1}},
    {requiredItems={"modern_industrialization:copper_bolt","modern_industrialization:copper_curved_plate","modern_industrialization:copper_plate","modern_industrialization:copper_gear","modern_industrialization:copper_rod"},craftPattern={1,2,3,4,5,2,1,4,1}},
    {requiredItems={"modern_industrialization:copper_curved_plate","modern_industrialization:copper_rod"},craftPattern={1,0,0,1,0,0,2,0,0}},
    {requiredItems={"modern_industrialization:copper_bolt","modern_industrialization:copper_blade","modern_industrialization:copper_ring"},craftPattern={1,2,1,2,3,2,1,2,1}},
    {requiredItems={"modern_industrialization:bronze_curved_plate","modern_industrialization:copper_rotor","minecraft:glass_pane"},craftPattern={1,1,1,2,3,2,1,1,1}},
    {requiredItems={"minecraft:glass"},craftPattern={1,1,1,1,1,1,0,0,0}},
    {requiredItems={"modern_industrialization:bronze_drill_head","modern_industrialization:iron_gear","modern_industrialization:item_pipe","modern_industrialization:fluid_pipe"},craftPattern={0,0,1,2,3,0,4,2,0}},
}

local COMPRESSOR_CRAFT = {
    {requiredItem="ad_astra:steel_ingot",craftTime=3},
    {requiredItem="modern_industrialization:steel_rod",craftTime=2.5},
    {requiredItem="modern_industrialization:steel_plate",craftTime=3},
    {requiredItem="minecraft:iron_ingot",craftTime=3},
    {requiredItem="modern_industrialization:iron_rod",craftTime=2.5},
    {requiredItem="modern_industrialization:bronze_ingot",craftTime=3},
    {requiredItem="modern_industrialization:bronze_rod",craftTime=2.5},
    {requiredItem="modern_industrialization:bronze_plate",craftTime=3},
    {requiredItem="minecraft:copper_ingot",craftTime=3},
    {requiredItem="modern_industrialization:copper_rod",craftTime=2.5},
    {requiredItem="modern_industrialization:copper_plate",craftTime=3},
}

local CUTTER_CRAFT = {
    {requiredItem="ad_astra:steel_ingot",craftTime=2.5},
    {requiredItem="modern_industrialization:steel_rod",craftTime=2.5},
    {requiredItem="minecraft:iron_ingot",craftTime=2.5},
    {requiredItem="modern_industrialization:iron_rod",craftTime=2.5},
    {requiredItem="modern_industrialization:bronze_ingot",craftTime=2.5},
    {requiredItem="modern_industrialization:bronze_rod",craftTime=2.5},
    {requiredItem="minecraft:copper_ingot",craftTime=2.5},
    {requiredItem="modern_industrialization:copper_rod",craftTime=2.5},
}

--function that moves items from the toms storage to the given location
--returns true if successful, false if not
function moveItem(itemName, location)
    if TOMS.pushItem(peripheral.getName(location),itemName,1) == 1 then
        return true
    else
        return false
    end
end

--function that clears the workbench
function clearWorkbench()
    for index = 1, 9 do
        WB_SLOTS[index].pushItem(peripheral.getName(TOMS))
    end
end

--this function crafts the given recipe
function workbenchCraft(recipeID)
    local recipe = WORKBENCH_CRAFT[recipeID]
    ::reset::
    clearWorkbench()
    for index = 1, #recipe.craftPattern do
        if recipe.craftPattern[index] ~= 0 then
            if moveItem(recipe.requiredItems[recipe.craftPattern[index]], WB_SLOTS[index]) then
                print("pushed to slot " .. index)
            else
                print("item " .. recipe.requiredItems[recipe.craftPattern[index]] .. " not found")
                if craft(recipe.requiredItems[recipe.craftPattern[index]]) then
                    print("item " .. recipe.requiredItems[recipe.craftPattern[index]] .. " crafted")
                else
                    return false
                end
                goto reset
            end
        end
    end
    sleep(0.2)
    WB_BUTTON.setOutput("right", true)
    sleep(0.2)
    WB_BUTTON.setOutput("right", false)
    sleep(1.8)
    WB_OUTPUT.pushItems(peripheral.getName(TOMS),1)
    return true
end

function compressorCraft(recipeID)
    local recipe = COMPRESSOR_CRAFT[recipeID]
    ::reset::
    if moveItem(recipe.requiredItem, COMPR_INPUT) then
        print("item pushed into compressor")
    else
        print("item " .. recipe.requiredItem .. " not found")
        if craft(recipe.requiredItem) then
            print("item " .. recipe.requiredItem .. " crafted")
        else
            return false
        end
        goto reset
    end
    sleep(recipe.craftTime)
    COMPR_OUTPUT.pushItems(peripheral.getName(TOMS),1)
end

function cutterCraft(recipeID)
    local recipe = CUTTER_CRAFT[recipeID]
    ::reset::
    if moveItem(recipe.requiredItem, CUTTER_INPUT) then
        print("item pushed into cutter")
    else
        print("item " .. recipe.requiredItem .. " not found")
        if craft(recipe.requiredItem) then
            print("item " .. recipe.requiredItem .. " crafted")
        else
            print("item " .. recipe.requiredItem .. " not crafted")
            return false
        end
        goto reset
    end
    sleep(recipe.craftTime)
    CUTTER_OUTPUT.pushItems(peripheral.getName(TOMS),1)
end

function craft(itemName, count)
    count = count or 1
    for index, item in ipairs(ITEMS) do
        if item.name == itemName then
            if item.craftType == "none" then
                print("item " .. itemName .. " cannot be crafted")
                return false
            elseif item.craftType == "workbench" then
                for i = 1, count do
                    workbenchCraft(item.craftID)
                end
                return true
            elseif item.craftType == "compressor" then
                for i = 1, count do
                    compressorCraft(item.craftID)
                end
                return true
            elseif item.craftType == "cutter" then
                for i = 1, count do
                    cutterCraft(item.craftID)
                end
                return true
            end
        end
    end
    print("recipe for item " .. itemName .. " not found")
    return false
end 

--function that saves the items table to a file
function saveItems()
    io.output("/reubi/items.json")
    io.write(textutils.serialise(ITEMS))
end
--function that saves the workbench recipes to a file
function saveAllRecipes()
    io.output("/reubi/recipes.json")
    io.write(textutils.serialise(WORKBENCH_CRAFT))
    io.output("/reubi/compressor_recipes.json")
    io.write(textutils.serialise(COMPRESSOR_CRAFT))
    io.output("/reubi/cutter_recipes.json")
    io.write(textutils.serialise(CUTTER_CRAFT))
end
--[[
if fs.exists("/home/test.json") then
    io.input("/home/test.json")
    ITEMS = textutils.unserialiseJSON(io.read("a"))
    print("buh")
end
]]

--craft("modern_industrialization:steel_gear", 2)
--time = os.clock()
--craft("modern_industrialization:bronze_drill")
--print("time taken :" .. os.clock() - time)

--[[
for i = 1, 3 do 
    craft("minecraft:oak_planks", 2)
    craft("minecraft:chest")
end
]]
