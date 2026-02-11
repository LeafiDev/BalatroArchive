SMODS.Booster {
    key = "recruit1",
    loc_txt = {
    name = "1 Recruitment Pack",
    group_name = "Recruitment",
    text = { "Recieve 1 random student" } 
	},
    atlas = "boosters", -- or your custom atlas key
    pos = { x = 0, y = 0 },
	draw_hand = true,
    cost = 2,
    weight = 99,
    config = { extra = 3, choose = 1 }, -- 3 cards, choose 1
	create_card = function(self, card, i)
        for i = 0, 9 do
            local star = pseudorandom("recruit1")
        return { set = "Joker", area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "ba" }
        end
    end
}

SMODS.Booster {
    key = "recruit10",
    loc_txt = {
    name = "10 Recruitment Pack",
    group_name = "Recruitment",
    text = { "Recieve 10 random students",
    "{C:attention}Last student will always be a 2 star or higher{}" }
	},
    atlas = "boosters", -- or your custom atlas key
    pos = { x = 1, y = 0 },
	draw_hand = true,
    cost = 10,
    weight = 99,
    config = { extra = 10, choose = 10 }, -- 3 cards, choose 1
    create_card = function(self, card, i)
        return {set = "Joker", area = G.pack_cards, rarity = "star1", skip_materialize = true}
    end

}