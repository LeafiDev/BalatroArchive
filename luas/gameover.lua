-- Hook into the game over UI definition and prevent pitch changes
local create_UIBox_game_over_ref = create_UIBox_game_over

-- Hook into Game:update_game_over to prevent pitch down at the source
local game_update_game_over_ref = Game.update_game_over
function Game:update_game_over(dt)
    -- Call the original function
    game_update_game_over_ref(self, dt)
    G.BA_TIMER.active = false
    
    -- Also set the global pitch mod to 1
    G.PITCH_MOD = 1
end

function create_UIBox_game_over()
    -- Determine if it's endless mode (ante > win_ante)
    local is_endless = G.GAME.round_resets.ante > G.GAME.win_ante
    local defeat_color = is_endless and G.C.BLUE or G.C.RED
    
    -- Create a minimal game over screen with semi-transparent black background
    local eased_black = {0, 0, 0, 0}
    ease_value(eased_black, 4, 0.5, nil, nil, true) -- 0.5 alpha for half transparency
    
    local t = {
        n = G.UIT.ROOT,
        config = {
            align = "cm",
            colour = eased_black,
            padding = 0,
            minh = G.ROOM.T.h + 10,
            minw = G.ROOM.T.w + 10,
            r = 0
        },
        nodes = {
            -- Spacer to push content down
            {n=G.UIT.R, config={align = "cm", padding = 0, minh = 4, no_fill = true}, nodes={}},
            
            -- Big "DEFEAT" text in the center with colored boxes on sides
            {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes={
                -- Left colored box extending off screen
                {n=G.UIT.C, config={align = "cm", padding = 0, r = 0, colour = defeat_color}, nodes={
                    {n=G.UIT.B, config={w = 20, h = 1.5}}
                }},
                
                -- Spacer
                {n=G.UIT.C, config={align = "cm", padding = 2, no_fill = true}, nodes={}},
                
                -- DEFEAT text
                {n=G.UIT.C, config={align = "cm", padding = 0, no_fill = true}, nodes={
                    {n=G.UIT.O, config={object = DynaText({
                        string = {"DEFEAT"},
                        colours = {defeat_color},
                        float = true,
                        scale = 2.5,
                        pop_in = 0.4,
                        maxw = 8,
                    })}}
                }},
                
                -- Spacer
                {n=G.UIT.C, config={align = "cm", padding = 2, no_fill = true}, nodes={}},
                
                -- Right colored box extending off screen
                {n=G.UIT.C, config={align = "cm", padding = 0, r = 0, colour = defeat_color}, nodes={
                    {n=G.UIT.B, config={w = 20, h = 1.5}}
                }}
            }},
            
            -- Spacer to push buttons to bottom
            {n=G.UIT.R, config={align = "cm", padding = 0, minh = 3, no_fill = true}, nodes={}},
            
            -- Seed display above buttons
            {n=G.UIT.R, config={align = "cm", padding = 0.1, no_fill = true}, nodes={
                {n=G.UIT.T, config={
                    text = localize('k_seed')..': ',
                    scale = 0.35,
                    colour = G.C.UI.TEXT_LIGHT
                }},
                {n=G.UIT.T, config={
                    text = G.GAME.pseudorandom.seed,
                    scale = 0.35,
                    colour = G.C.WHITE
                }}
            }},
            
            -- Button row at the bottom
            {n=G.UIT.R, config={align = "cm", padding = 0.3, no_fill = true, pop_in = 15}, nodes={
                -- New Run button
                {n=G.UIT.C, config={align = "cm", padding = 0.15}, nodes={
                    {n=G.UIT.R, config={
                        id = 'from_game_over',
                        align = "cm",
                        minw = 4.5,
                        padding = 0.2,
                        r = 0.1,
                        hover = true,
                        colour = defeat_color,
                        button = "notify_then_setup_run",
                        pop_in = 15,
                        focus_args = {nav = 'wide', snap_to = true}
                    }, nodes={
                        {n=G.UIT.T, config={
                            text = localize('b_start_new_run'),
                            scale = 0.5,
                            colour = G.C.UI.TEXT_LIGHT
                        }}
                    }}
                }},
                
                -- Main Menu button
                {n=G.UIT.C, config={align = "cm", padding = 0.15}, nodes={
                    {n=G.UIT.R, config={
                        align = "cm",
                        minw = 4.5,
                        padding = 0.2,
                        r = 0.1,
                        pop_in = 15,
                        hover = true,
                        colour = defeat_color,
                        button = "go_to_menu",
                        focus_args = {nav = 'wide'}
                    }, nodes={
                        {n=G.UIT.T, config={
                            text = localize('b_main_menu'),
                            scale = 0.5,
                            colour = G.C.UI.TEXT_LIGHT
                        }}
                    }}
                }}
            }}
        }
    }
    
    return t
end
