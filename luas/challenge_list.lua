-- Custom Challenge Menu

-- Store the original function
local original_challenge_list = nil

-- Current boss blind index
G.BA_CURRENT_BOSS = G.BA_CURRENT_BOSS or 1

-- Custom challenge list
local function custom_challenge_list(from_game_over)
    -- Boss blind data
    local boss_data = {
        {name = "Tiphareth", key = "bl_ba_tiphareth"},
        {name = "Small Blind", key = "bl_small"}
    }
    
    local blind_obj = G.P_BLINDS[boss_data[G.BA_CURRENT_BOSS].key]
    if not blind_obj then
        blind_obj = G.P_BLINDS.bl_small
    end
    
    -- Create Hina's joker card
    local card = Card(0, 0, G.CARD_W * 1.7, G.CARD_H * 1.7, nil, G.P_CENTERS.j_ba_rin)
    card.states.drag.can = true
    
    -- Create difficulty buttons
    local difficulties = {"Normal", "Hard", "Very Hard", "Hardcore", "Extreme"}
    local difficulty_buttons = {}
    
    for i = 1, #difficulties do
        -- Create blind chip for this button
        local button_blind = Sprite(0, 0, 0.6, 0.6, G.ANIMATION_ATLAS['ba_tiphareth'] or G.ANIMATION_ATLAS['tiphareth'], blind_obj.pos)
        button_blind.states.hover.can = false
        button_blind.states.drag.can = false
        
        table.insert(difficulty_buttons, {
            n = G.UIT.R,
            config = {align = "cm", padding = 0.03},
            nodes = {
                {n = G.UIT.C, config = {align = "cm", padding = 0.04, r = 0.1, colour = G.C.BLACK, minw = 8, minh = 2, offset = {x = -5, y = 0}}, nodes = {
                    {n = G.UIT.R, config = {align = "tl", padding = 0.05}, nodes = {
                        -- Left: Boss blind chip
                        {n = G.UIT.C, config = {align = "cm", padding = 0.05}, nodes = {
                            {n = G.UIT.O, config = {object = button_blind}}
                        }},
                        -- Middle: Difficulty name + Boss name (stacked)
                        {n = G.UIT.C, config = {align = "tl", padding = 0.05}, nodes = {
                            {n = G.UIT.R, config = {align = "tl", padding = 0}, nodes = {
                                {n = G.UIT.O, config = {object = DynaText({string = difficulties[i], colours = {G.C.WHITE}, shadow = true, hover = true, rotate = false, bump = true, scale = 0.5, maxw = 3})}}
                            }},
                            {n = G.UIT.R, config = {align = "tl", padding = 0}, nodes = {
                                {n = G.UIT.O, config = {object = DynaText({string = boss_data[G.BA_CURRENT_BOSS].name, colours = {G.C.WHITE}, hover = true, shadow = true, rotate = false, bump = true, scale = 0.7, maxw = 3})}}
                            }}
                        }},
                        -- Spacer
                        {n = G.UIT.C, config = {align = "cm", minw = 1.5}, nodes = {}},
                        -- Right: Enter button
                        {n = G.UIT.C, config = {align = "cr", padding = 0.15, r = 0.08, colour = {0.95, 0.85, 0.35, 1}, minw = 1.7, minh = 1.2, shadow = true, hover = true, button = "exit_overlay_menu"}, nodes = {
                            {n = G.UIT.O, config = {object = DynaText({string = "ENTER", colours = {{0.1, 0.1, 0.1, 1}}, shadow = false, rotate = false, bump = false, scale = 1, maxw = 2})}}
                        }}
                    }}
                }}
            }
        })
    end
    
    -- Create sidebar with title and buttons
    local sidebar = {
        n = G.UIT.C,
        config = {align = "cm", padding = 0.3, r = 0.15, colour = {0.15, 0.2, 0.3, 0.9}, emboss = 0.1, minw = 5.5, minh = 7},
        nodes = {
            -- Difficulty buttons
            {n = G.UIT.C, config = {align = "cm", padding = 0.1}, nodes = difficulty_buttons}
        }
    }
    
    -- Create fresh blind sprite for boss info bar
    local info_bar_blind = Sprite(0, 0, 0.7, 0.7, G.ANIMATION_ATLAS['ba_tiphareth'] or G.ANIMATION_ATLAS['tiphareth'], blind_obj.pos)
    info_bar_blind.states.hover.can = true
    info_bar_blind.states.drag.can = true
    
    return {
        n = G.UIT.ROOT,
        config = {id = 'ba_challenge_list', align = "cm", colour = {0, 0, 0.5, 0.5}, minh = 25, minw = 27},
        nodes = {
            {n = G.UIT.R, config = {align = "cm", padding = 0.5}, nodes = {
                -- Left: Card
                {n = G.UIT.C, config = {align = "cm", padding = 2}, nodes = {
                    {n = G.UIT.O, config = {object = card}}
                }},
                -- Spacer
                {n = G.UIT.C, config = {align = "cm", minw = 2}, nodes = {}},
                -- Right: Difficulty buttons
                {n = G.UIT.C, config = {align = "cr", padding = 0.1, r = 0.5, colour = {1, 1, 1, 0.3}}, nodes = difficulty_buttons}
            }}
        }
    }
end

-- Navigation functions
G.FUNCS.ba_prev_boss = function(e)
    G.BA_CURRENT_BOSS = G.BA_CURRENT_BOSS - 1
    if G.BA_CURRENT_BOSS < 1 then G.BA_CURRENT_BOSS = 1 end
    -- Refresh the UI by recreating overlay menu
    local overlay = G.OVERLAY_MENU
    if overlay and overlay.parent then
        overlay.parent.config.object:remove()
        overlay.parent.config.object = UIBox{
            definition = G.UIDEF.challenge_list(),
            config = {offset = {x=0,y=0}, align = 'cm', parent = overlay.parent}
        }
    end
end

G.FUNCS.ba_next_boss = function(e)
    G.BA_CURRENT_BOSS = G.BA_CURRENT_BOSS + 1
    if G.BA_CURRENT_BOSS > 1 then G.BA_CURRENT_BOSS = 1 end
    -- Refresh the UI by recreating overlay menu
    local overlay = G.OVERLAY_MENU
    if overlay and overlay.parent then
        overlay.parent.config.object:remove()
        overlay.parent.config.object = UIBox{
            definition = G.UIDEF.challenge_list(),
            config = {offset = {x=0,y=0}, align = 'cm', parent = overlay.parent}
        }
    end
end

-- Hook into the challenge list
original_challenge_list = G.UIDEF.challenge_list
G.UIDEF.challenge_list = custom_challenge_list

return {}
