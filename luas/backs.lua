


SMODS.Back {
    key = "sdeck",
    loc_txt = {
        name = "Schale Deck",
        text = {
            "{C:blue,E:1}Ah! There you are, Sensei!{}",
            "{S:1}Allows for retrieving students out of Recruitment Packs{}"
        }
    },
    loc_vars = function()
        return {  }
    end,
    atlas = "backs",
    pos = {x = 0, y = 0},
    apply = function(self, back)
    G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                
                return true
            end
        }))
end
}