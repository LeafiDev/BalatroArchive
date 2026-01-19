-- files
assert(SMODS.load_file('luas/atlas.lua'))()
assert(SMODS.load_file('luas/blinds.lua'))()
assert(SMODS.load_file('luas/rarities.lua'))()
assert(SMODS.load_file('luas/sounds.lua'))()
assert(SMODS.load_file('luas/students.lua'))()
assert(SMODS.load_file('luas/update.lua'))()
assert(SMODS.load_file('luas/win.lua'))()
assert(SMODS.load_file('luas/gameover.lua'))()
-- assert(SMODS.load_file('luas/challenge_list.lua'))()

-- globals
G.coreactive = 0

-- functions

SMODS.Keybind{
    id = "testbind",
    key_pressed = "t",
    action = function(self)
        G.coreactive = math.random(1, 3)
        print(G.coreactive)
    end
}

-- Hook into main menu to add Total Assault button
local original_main_menu = G.UIDEF.main_menu

function G.UIDEF.main_menu()
    local definition = original_main_menu()
    
    -- Recursively search for and copy the first button's styling
    local first_button_config = nil
    local button_row = nil
    
    local function find_buttons(node, parent_node)
        if node.nodes then
            for i, subnode in ipairs(node.nodes) do
                -- Check if this is a button node with New Run or Challenges
                if subnode.config and (subnode.config.button == "setup_run" or subnode.config.button == "challenge_list") then
                    if not first_button_config then
                        first_button_config = subnode.config
                        button_row = node
                    end
                    return true
                end
                -- Keep searching recursively
                if find_buttons(subnode, node) then
                    return true
                end
            end
        end
        return false
    end
    
    find_buttons(definition)
    
    -- If we found the button row, add Total Assault with same styling
    if button_row and first_button_config then
        local new_button = {
            n = G.UIT.C,
            config = {
                align = first_button_config.align or "cm",
                padding = first_button_config.padding or 0.15,
                r = first_button_config.r or 0.1,
                colour = first_button_config.colour,
                minw = first_button_config.minw,
                hover = true,
                button = "open_total_assault"
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = "Total Assault",
                        scale = 0.55,
                        colour = G.C.WHITE
                    }
                }
            }
        }
        table.insert(button_row.nodes, new_button)
    end
    
    return definition
end



