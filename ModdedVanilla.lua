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



