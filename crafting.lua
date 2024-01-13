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

ITEMS = {
    {name="minecraft:oak_log",craftType="none"},
    {name="minecraft:oak_planks",craftType="workbench",craftID=1,count=4},
    {name="minecraft:crafting_table",craftType="workbench",craftID=2,count=4},
    {name="minecraft:stick",craftType="workbench",craftID=3,count=4},
    {name="minecraft:wooden_sword",craftType="workbench",craftID=4,count=1},
    {name="minecraft:chest",craftType="workbench",craftID=5,count=1},
    {name="ad_astra:steel_ingot",craftType="none"},
    {name="modern_industrialization:steel_plate",craftType="compressor",craftID=1,count=1},
    {name="modern_industrialization:steel_rod",craftType="cutter",craftID=1,count=2},
    {name="modern_industrialization:steel_bolt",craftType="cutter",craftID=2,count=2},
    {name="modern_industrialization:steel_ring",craftType="compressor",craftID=2,count=2},
    {name="modern_industrialization:steel_gear",craftType="workbench",craftID=6,count=1},
    {name="modern_industrialization:steel_curved_plate",craftType="compressor",craftID=3,count=1},
    {name="modern_industrialization:steel_drill_head",craftType="workbench",craftID=7,count=1},
}

local WORKBENCH_CRAFT = {
    {requiredItems={"minecraft:oak_log"},craftPattern={1,0,0,0,0,0,0,0,0}},
    {requiredItems={"minecraft:oak_planks"},craftPattern={1,1,0,1,1,0,0,0,0}},
    {requiredItems={"minecraft:oak_planks"},craftPattern={1,0,0,1,0,0,0,0,0}},
    {requiredItems={"minecraft:oak_planks","minecraft:stick"},craftPattern={1,0,0,1,0,0,2,0,0}},
    {requiredItems={"minecraft:oak_planks"},craftPattern={1,1,1,1,0,1,1,1,1}},
    {requiredItems={"modern_industrialization:steel_plate","modern_industrialization:steel_bolt","modern_industrialization:steel_ring"},craftPattern={1,2,1,2,3,2,1,2,1}},
    {requiredItems={"modern_industrialization:steel_bolt","modern_industrialization:steel_curved_plate","modern_industrialization:steel_plate","modern_industrialization:steel_gear","modern_industrialization:steel_rod"},craftPattern={1,2,3,4,5,2,1,4,1}}
}

local COMPRESSOR_CRAFT = {
    {requiredItem="ad_astra:steel_ingot",craftTime=3},
    {requiredItem="modern_industrialization:steel_rod",craftTime=2.5},
    {requiredItem="modern_industrialization:steel_plate",craftTime=3}
}

local CUTTER_CRAFT = {
    {requiredItem="ad_astra:steel_ingot",craftTime=2.5},
    {requiredItem="modern_industrialization:steel_rod",craftTime=2.5}
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
            if TOMS.pushItem(peripheral.getName(WB_SLOTS[index]),recipe.requiredItems[recipe.craftPattern[index]], 1) == 1 then
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
--[[
if fs.exists("/home/test.json") then
    io.input("/home/test.json")
    ITEMS = textutils.unserialiseJSON(io.read("a"))
    print("buh")
end
]]

--craft("modern_industrialization:steel_gear", 2)
time = os.clock()
craft("modern_industrialization:steel_drill_head", 4)
print("time taken :" .. os.clock() - time)

--[[
for i = 1, 3 do 
    craft("minecraft:oak_planks", 2)
    craft("minecraft:chest")
end
]]
