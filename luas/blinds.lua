SMODS.Blind {
    key = "tiphareth",
    atlas = "tiphareth",
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "Tiphareth",
        text = {"Red core: debuffs all cards", "Yellow Core: Cannot use number cards", "Blue Core: divides round score"}
    },
    boss = { min = 8, showdown = true },
    dollars = 10,
    mult = 10,
    boss_colour = HEX('F4AF09'), 

    set_blind = function(self)
        -- Timer is handled automatically in update.lua
    end,

    debuff_hand = function(self, cards, hand, handname, check)
        if G.coreactive == 2 and not (card.config and card.config.center and card.config.center.set == "Joker") then
		for _, card in ipairs(G.hand.cards) do
        return type(card.base.value) == "number"
        end
        end
    end
}

SMODS.Blind {
    key = "binah",
    atlas = "binah",
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "Binah",
        text = {"Permanently decreases chip value", "by 2 for each in hand card."}
    },
    boss = { min = 8, showdown = true },
    dollars = 12,
    mult = 10,
    boss_colour = HEX('331852'), 

    set_blind = function(self)
        -- Timer is handled automatically in update.lua
    end,

    press_play = function(self, cards, hand, handname, check)
        for _, card in ipairs(G.hand.cards) do
            card.ability.perma_bonus = (card.ability.perma_bonus or 2) - 2
            card:juice_up()
        end
    end
}

SMODS.Blind {
    key = "binah",
    atlas = "binah",
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "Binah",
        text = {"Permanently decreases chip value", "by 2 for each in hand card."}
    },
    boss = { min = 8, showdown = true },
    dollars = 12,
    mult = 10,
    boss_colour = HEX('331852'), 

    set_blind = function(self)
        -- Timer is handled automatically in update.lua
    end,

    press_play = function(self, cards, hand, handname, check)
        for _, card in ipairs(G.hand.cards) do
            card.ability.perma_bonus = (card.ability.perma_bonus or 2) - 2
            card:juice_up()
        end
    end
}

SMODS.Blind {
    key = "greg",
    atlas = "greg",
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "Gregorious",
        text = {""}
    },
    boss = { min = 8, showdown = true },
    dollars = 8,
    mult = 10,
    boss_colour = HEX('331852'), 

    set_blind = function(self)
        gregmode = 1
    end,

    press_play = function(self, cards, hand, handname, check)

        -- actual actions
        SMODS.juice_up_blind()
        gregmode = math.random(1, 2)
        if gregmode == 1 then
            for _, card in ipairs(G.hand.cards) do
            card.ability.perma_bonus = (card.ability.perma_bonus or 1) - 4
            card:juice_up()
            end
        elseif gregmode == 2 then
            for _, card in ipairs(G.hand.cards) do
            card.ability.perma_bonus = math.abs((card.ability.perma_bonus or 1)) * 1.5
            card:juice_up()
            end
        end
    end
}

-- next up: Chesed