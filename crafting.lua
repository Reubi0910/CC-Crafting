--this is another bucket

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
local WB_BUTTON = peripheral.wrap("redrouter_0")
local WB_OUTPUT = peripheral.wrap("minecraft:barrel_0")

local CRAFT_BUFFER = peripheral.wrap("create:item_vault_0")

local COMPRESSOR = peripheral.wrap("modern_industrialization:steel_compressor_0")

local CUTTER = peripheral.wrap("modern_industrialization:steel_cutting_machine_0")

local WIREMILL = peripheral.wrap("modern_industrialization:steel_wiremill_0")

local MACERATOR = peripheral.wrap("modern_industrialization:steel_macerator_0")

local FURNACE = peripheral.wrap("modern_industrialization:steel_furnace_0")

local MIXER = peripheral.wrap("modern_industrialization:electric_mixer_0")

local POLARIZER = peripheral.wrap("modern_industrialization:polarizer_0")

local TOMS = peripheral.wrap("toms_storage:ts.inventory_connector_0")
local next = next

local RECIPES = {}

--clears the workbench of all items
function clearWorkbench()
    for index = 1, 9 do
        WB_SLOTS[index].pushItem(peripheral.getName(TOMS))
    end
end

--moves items from tom's storage to the given location
--returns true if successful, false if not
function moveItemFromStorage(itemName, location, count)
    count = count or 1
    if TOMS.pushItem(peripheral.getName(location),itemName,count) == count then
        return true
    else
        return false
    end
end

--waits for the machine to finish its task
function waitForMachine(machine)
    while machine.isBusy() do
        sleep(0.1)
    end
end

--crafts the item using the workbench
function craftWorkbench(recipe)
    ::reset::
    clearWorkbench()
    for index = 1, #recipe.pattern do
        if recipe.pattern[index] ~= 0 then
            if moveItemFromStorage(recipe.requiredItems[recipe.pattern[index]], WB_SLOTS[index]) then
                print("pushed to slot " .. index)
            else
                print("item " .. recipe.requiredItems[recipe.pattern[index]] .. " not found")
                if craft(recipe.requiredItems[recipe.pattern[index]]) then
                    print("item " .. recipe.requiredItems[recipe.pattern[index]] .. " crafted")
                else
                    return false
                end
                goto reset
            end
        end
    end
    sleep(0.2)
    WB_BUTTON.setOutput("left", true)
    sleep(0.2)
    WB_BUTTON.setOutput("left", false)
    sleep(1.8)
    WB_OUTPUT.pushItems(peripheral.getName(TOMS),1)
    return true
end

function craftMixer(recipe)
    ::reset::
    CRAFT_BUFFER.pushItem(peripheral.getName(TOMS))
    for i, item in ipairs(recipe.requiredItems) do
        if moveItemFromStorage(item.name, CRAFT_BUFFER, item.count) then
            print(item.count .. " ".. item.name .. " pushed into BUFFER")
        else
            print("not enough " .. item.name .. " found")
            if craft(item.name) then
                print("item " .. item.name .. " crafted")
            else
                return false
            end
            goto reset
        end
    end
    CRAFT_BUFFER.pushItem(peripheral.getName(MIXER))
    waitForMachine(MIXER)
    return MIXER.pushItem(peripheral.getName(TOMS))
    
end

function craftPolarizer(recipe)
    ::reset::
    CRAFT_BUFFER.pushItem(peripheral.getName(TOMS))
    for i, item in ipairs(recipe.requiredItems) do
        if moveItemFromStorage(item.name, CRAFT_BUFFER, item.count) then
            print(item.count .. " ".. item.name .. " pushed into BUFFER")
        else
            print("not enough " .. item.name .. " found")
            if craft(item.name) then
                print("item " .. item.name .. " crafted")
            else
                return false
            end
            goto reset
        end
    end
    CRAFT_BUFFER.pushItem(peripheral.getName(POLARIZER))
    waitForMachine(POLARIZER)
    return POLARIZER.pushItem(peripheral.getName(TOMS))
    
end

--crafts the item using a simple 1 item input machine
function craftSimpleMachine(recipe, machine)
    ::reset::
    if moveItemFromStorage(recipe.requiredItem, machine) then
        print("item pushed into machine")
    else
        print("item " .. recipe.requiredItem .. " not found")
        if not craft(recipe.requiredItem) then
            return false
        end
        goto reset
    end
    waitForMachine(machine)
    return machine.pushItem(peripheral.getName(TOMS))
end

function getItemRecipes(itemname)
    local itemRecipes = nil
    for i, recipe in ipairs(RECIPES) do
        if recipe.name == itemname then
            itemRecipes = recipe.recipes
            break
        end
    end
    return itemRecipes
end

function craft(itemname, count) 
    count = count or 1
    local recipes = getItemRecipes(itemname)
    if recipes == nil then
        print("item not found : " .. itemname)
        return false
    end
    if next(recipes) == nil then
        print("no recipes found for item : " .. itemname)
        return false
    end
    for i, recipe in ipairs(recipes) do
        if recipe.craftType == "workbench" then
            if craftWorkbench(recipe) then
                print("item " .. itemname .. " crafted")
                return true 
            end
        end
        if recipe.craftType == "compressor" then
            if craftSimpleMachine(recipe, COMPRESSOR) then
                print("item " .. itemname .. " crafted")
                return true 
            end
        end
        if recipe.craftType == "cutter" then
            if craftSimpleMachine(recipe, CUTTER) then
                print("item " .. itemname .. " crafted")
                return true 
            end
        end
        if recipe.craftType == "wiremill" then
            if craftSimpleMachine(recipe, WIREMILL) then
                print("item " .. itemname .. " crafted")
                return true 
            end
        end
        if recipe.craftType == "macerator" then
            if craftSimpleMachine(recipe, MACERATOR) then
                print("item " .. itemname .. " crafted")
                return true 
            end
        end
        if recipe.craftType == "furnace" then
            if craftSimpleMachine(recipe, FURNACE) then
                print("item " .. itemname .. " crafted")
                return true 
            end
        end
        if recipe.craftType == "mixer" then
            if craftMixer(recipe) then
                print("item " .. itemname .. " crafted")
                return true 
            end
        end
        if recipe.craftType == "polarizer" then
            if craftPolarizer(recipe) then
                print("item " .. itemname .. " crafted")
                return true 
            end
        end
    end
    return false
end

function loadItems()
    io.input(shell.dir() .. "/items.json")
    RECIPES = textutils.unserialiseJSON(io.read("a"))
    
end
loadItems()
craft("minecraft:chest")