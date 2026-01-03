SMODS.Blind {
    key = "tiphareth",
    atlas = "tiphareth",
    loc_txt = {
        name = "Tiphareth",
        text = {""}
    },
    boss = { min = 8, showdown = true },
    dollars = 10,
    mult = 10,
    boss_colour = HEX('F4AF09'), 

    set_blind = function(self)
        
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        if G.coreactive == 2 and not (card.config and card.config.center and card.config.center.set == "Joker") then
		for _, card in ipairs(G.hand.cards) do
        return type(card.base.value) == "number"
        end
        end
    end
}