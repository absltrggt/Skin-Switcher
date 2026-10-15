vanilla_model.PLAYER:setVisible(false)


-- DIMENSIONS
-- Choose which dimensions use each outfit.
-- You can use a mod's namespace or a specific dimension ID.


-- Model roots:
-- root_normal = normal outfit
-- root_darkworld = alternative outfit
-- root_extra = extra outfit


local DARKWORLDS = {
    "penumbra_phantasm",
    "roaring",
    "turnbattle",
    -- "namespace"
    -- "namespace:dimension_name"
}

local EXTRAWORLDS = {
    -- "namespace"
    -- "namespace:dimension_name"
}

local lastDim = nil




local function updateModel(dim)

    local isDarkworld = false
    local isExtraworld = false

    -- Check EXTRA dimensions
    for _, dimension in ipairs(EXTRAWORLDS) do
        if string.find(dim, dimension, 1, true) then
            isExtraworld = true
            break
        end
    end

    -- Check DARKWORLD dimensions
    for _, dimension in ipairs(DARKWORLDS) do
        if string.find(dim, dimension, 1, true) then
            isDarkworld = true
            break
        end
    end

    -- EXTRA SKIN
    if isExtraworld then
        models.model.root_normal:setVisible(false)
        models.model.root_darkworld:setVisible(false)
        models.model.root_extra:setVisible(true)

    -- DARKWORLD SKIN
    elseif isDarkworld then
        models.model.root_normal:setVisible(false)
        models.model.root_darkworld:setVisible(true)
        models.model.root_extra:setVisible(false)

    -- NORMAL SKIN
    else
        models.model.root_normal:setVisible(true)
        models.model.root_darkworld:setVisible(false)
        models.model.root_extra:setVisible(false)
    end
end



-- Check the current dimension. Don't touch.

function events.entity_init()
    local dim = world.getDimension()
    lastDim = dim
    updateModel(dim)
end


function events.tick()
    local dim = world.getDimension()

    if dim ~= lastDim then
        lastDim = dim
        updateModel(dim)
    end
end