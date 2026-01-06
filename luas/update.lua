-- Initialize timer variables
G.BA_TIMER = {
    active = false,  -- Boolean to control if timer counts down
    time = 0,
    ui_element = nil
}

-- Function to create timer UI
local function create_timer_ui()
    if G.BA_TIMER.ui_element then
        G.BA_TIMER.ui_element:remove()
        G.BA_TIMER.ui_element = nil
    end
    
    -- Determine color based on time remaining
    local time_color = G.C.WHITE
    if G.BA_TIMER.time <= 10 then
        time_color = G.C.RED
    elseif G.BA_TIMER.time <= 30 then
        time_color = G.C.ORANGE
    end
    
    -- Format time as MM:SS.mmm
    local minutes = math.floor(G.BA_TIMER.time / 60)
    local seconds = math.floor(G.BA_TIMER.time % 60)
    local milliseconds = math.floor((G.BA_TIMER.time % 1) * 1000)
    local time_string = string.format("%02d:%02d.%03d", minutes, seconds, milliseconds)
    
    local timer_node = {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            colour = {0, 0, 0, 0},
            padding = 0.15,
            r = 0.1,
            minh = 0.8,
            minw = 3.5
        },
        nodes = {
            {n = G.UIT.T, config = {
                text = time_string,
                scale = 0.6,
                colour = time_color,
                shadow = true,
                hover = true
            }}
        }
    }
    
    G.BA_TIMER.ui_element = UIBox{
        definition = timer_node,
        config = {
            align = "tm",
            offset = {x = 0, y = 0.3},
            major = G.ROOM_ATTACH,
            bond = 'Weak'
        }
    }
end

-- Function to update timer UI
local function update_timer_ui()
    if G.BA_TIMER.ui_element and G.BA_TIMER.ui_element.UIRoot and G.BA_TIMER.ui_element.UIRoot.children[1] then
        -- Determine color based on time remaining
        local time_color = G.C.WHITE
        if G.BA_TIMER.time <= 10 then
            time_color = G.C.RED
        end
        
        -- Format time as MM:SS.mmm
        local minutes = math.floor(G.BA_TIMER.time / 60)
        local seconds = math.floor(G.BA_TIMER.time % 60)
        local milliseconds = math.floor((G.BA_TIMER.time % 1) * 1000)
        local time_string = string.format("%02d:%02d.%03d", minutes, seconds, milliseconds)
        
        G.BA_TIMER.ui_element.UIRoot.children[1].config.text = time_string
        G.BA_TIMER.ui_element.UIRoot.children[1].config.colour = time_color
    end
end

G.archive_update = function(dt)

    if not (G and G.GAME) then return end

    -- Check if win screen is showing
    if G.OVERLAY_MENU and G.OVERLAY_MENU.definition and G.OVERLAY_MENU.definition.config and G.OVERLAY_MENU.definition.config.id == 'you_win_UI' then
        G.WIN_SCREEN_SHOWING = true
    else
        G.WIN_SCREEN_SHOWING = false
    end
    
    -- Check if challenge list is open
    if G and G.OVERLAY_MENU and G.OVERLAY_MENU.definition and G.OVERLAY_MENU.definition.config and G.OVERLAY_MENU.definition.config.id == 'ba_challenge_list' then
        if not G.CHALLENGE_LIST_SHOWING then
            -- Just opened - fade background to dark blue
            G.CHALLENGE_LIST_SHOWING = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_background_colour{new_colour = {0.1, 0.2, 0.4, 1}, contrast = 2}

                end
            }))
        end
        
        -- Hide title screen elements
        if G.SPLASH_LOGO then
            G.SPLASH_LOGO.states.visible = false
        end
        if G.title_top and G.title_top.cards and G.title_top.cards[1] then
            G.title_top.cards[1].states.visible = false
        end
        if G.MAIN_MENU_UI then
            G.MAIN_MENU_UI.states.visible = false
        end
        -- Hide all UIBox children attached to the room
        if G.ROOM_ATTACH and G.ROOM_ATTACH.children then
            for _, child in ipairs(G.ROOM_ATTACH.children) do
                if child and child.UIBox and child.UIBox.states then
                    child.UIBox.states.visible = false
                end
            end
        end
    else
        if G.CHALLENGE_LIST_SHOWING then
            -- Just closed - restore background
            G.CHALLENGE_LIST_SHOWING = false
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_background_colour{new_colour = G.C.DYN_UI.MAIN or {0.15, 0.15, 0.15, 1}, contrast = 2}

                end
            }))
        end
        
        -- Restore title screen elements
        if G.SPLASH_LOGO then
            G.SPLASH_LOGO.states.visible = true
        end
        if G.title_top and G.title_top.cards and G.title_top.cards[1] then
            G.title_top.cards[1].states.visible = true
        end
        if G.MAIN_MENU_UI then
            G.MAIN_MENU_UI.states.visible = true
        end
        -- Restore all UIBox children attached to the room
        if G.ROOM_ATTACH and G.ROOM_ATTACH.children then
            for _, child in ipairs(G.ROOM_ATTACH.children) do
                if child and child.UIBox and child.UIBox.states then
                    child.UIBox.states.visible = true
                end
            end
        end
    end

    if G.GAME.blind and G.GAME.blind.name == "bl_ba_tiphareth" then
        -- Timer configuration for Tiphareth
        if not G.BA_TIMER.active and G.STATE == G.STATES.BLIND_SELECT then
            G.BA_TIMER.time = 300  -- 5 minutes
            G.BA_TIMER.active = true
        end
        
        -- Phase system based on time remaining with background changes
        if G.BA_TIMER.time > 100 then
            -- Phase 1 (300-100s)
            G.BA_TIPHARETH_PHASE = 1
            if not G.BA_TIPHARETH_LAST_PHASE or G.BA_TIPHARETH_LAST_PHASE ~= 1 then
                G.BA_TIPHARETH_LAST_PHASE = 1
            end
            -- Continuously apply phase 1 settings to override game's boss blind updates
            ease_background_colour{new_colour = {0.8, 0.4, 0.1, 1}, contrast = 5}  -- Dark orange
            if G.ROOM and G.ROOM.background then
                G.ROOM.background.speed = 0.5
                G.ROOM.background.vel = 0.5
            end
            
        else
            -- Phase 2 (100-0s)
            G.BA_TIPHARETH_PHASE = 2
            if not G.BA_TIPHARETH_LAST_PHASE or G.BA_TIPHARETH_LAST_PHASE ~= 2 then
                G.BA_TIPHARETH_LAST_PHASE = 2
            end
            -- Continuously apply phase 2 settings
            ease_background_colour{new_colour = {0.9, 0.3, 0.2, 1}, contrast = 5}  -- Dark orangish red
            if G.ROOM and G.ROOM.background then
                G.ROOM.background.speed = 3
                G.ROOM.background.vel = 3
            end
        end
    elseif G.GAME.blind and G.GAME.blind.name == "bl_ba_binah" then
        -- Timer configuration for Binah
        if not G.BA_TIMER.active and G.STATE == G.STATES.BLIND_SELECT then
            G.BA_BINAH_PHASE = 1
            G.BA_TIMER.time = 300  -- 5 minutes
            G.BA_TIMER.active = true
        end
    else
        -- Deactivate timer if no matching boss blind
        G.BA_TIMER.active = false
        G.BA_TIPHARETH_PHASE = nil
        G.BA_TIPHARETH_LAST_PHASE = nil
        G.BA_BINAH_PHASE = nil
        G.BA_BINAH_LAST_PHASE = nil
    end

    -- Check if already in game over state and deactivate timer
    if G.STATE == G.STATES.GAME_OVER then
        G.BA_TIMER.active = false
        G.BA_TIPHARETH_PHASE = nil
        G.BA_TIPHARETH_LAST_PHASE = nil

    end
    
    -- Update timer if active
    if G.BA_TIMER.active then
        G.BA_TIMER.time = G.BA_TIMER.time - dt
        
        -- Check if timer ran out
        if G.BA_TIMER.time < 1 then
            G.BA_TIMER.time = 0
            G.BA_TIMER.active = false
            
            -- Trigger game over
            G.STATE = G.STATES.GAME_OVER
            G.STATE_COMPLETE = false
        end
        
        -- Display the timer
        if G.BA_TIMER.ui_element then
            G.BA_TIMER.ui_element:remove()
        end
        create_timer_ui()
    else
        -- Remove UI if timer is not active
        if G.BA_TIMER.ui_element then
            G.BA_TIMER.ui_element:remove()
            G.BA_TIMER.ui_element = nil
        end
    end
end