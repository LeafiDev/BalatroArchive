-- Track win screen state
G.WIN_SCREEN_SHOWING = false

-- Hook into the win screen creation
local create_UIBox_win_ref = create_UIBox_win

function create_UIBox_win()
    G.WIN_SCREEN_SHOWING = true
    
    -- Use gold/yellow color for victory
    local victory_color = G.C.GOLD
    
    -- Create a minimal win screen with semi-transparent black background
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
            
            -- Big "VICTORY" text in the center with gold boxes on sides
            {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes={
                -- Left gold box extending off screen
                {n=G.UIT.C, config={align = "cm", padding = 0, r = 0, colour = victory_color}, nodes={
                    {n=G.UIT.B, config={w = 20, h = 1.5}}
                }},
                
                -- Spacer
                {n=G.UIT.C, config={align = "cm", padding = 2, no_fill = true}, nodes={}},
                
                -- VICTORY text
                {n=G.UIT.C, config={align = "cm", padding = 0, no_fill = true}, nodes={
                    {n=G.UIT.O, config={object = DynaText({
                        string = {"VICTORY"},
                        colours = {victory_color},
                        float = true,
                        scale = 2.5,
                        pop_in = 0.4,
                        maxw = 8,
                    })}}
                }},
                
                -- Spacer
                {n=G.UIT.C, config={align = "cm", padding = 2, no_fill = true}, nodes={}},
                
                -- Right gold box extending off screen
                {n=G.UIT.C, config={align = "cm", padding = 0, r = 0, colour = victory_color}, nodes={
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
                -- Endless Mode button
                {n=G.UIT.C, config={align = "cm", padding = 0.15}, nodes={
                    {n=G.UIT.R, config={
                        align = "cm",
                        minw = 4.5,
                        padding = 0.2,
                        r = 0.1,
                        hover = true,
                        colour = G.C.BLUE,
                        button = "exit_overlay_menu",
                        pop_in = 15,
                        focus_args = {nav = 'wide', snap_to = true}
                    }, nodes={
                        {n=G.UIT.T, config={
                            text = localize('b_endless'),
                            scale = 0.5,
                            colour = G.C.UI.TEXT_LIGHT
                        }}
                    }}
                }},
                
                -- New Run button
                {n=G.UIT.C, config={align = "cm", padding = 0.15}, nodes={
                    {n=G.UIT.R, config={
                        id = 'from_game_won',
                        align = "cm",
                        minw = 4.5,
                        padding = 0.2,
                        r = 0.1,
                        hover = true,
                        colour = victory_color,
                        button = "notify_then_setup_run",
                        pop_in = 15,
                        focus_args = {nav = 'wide'}
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
                        colour = victory_color,
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
