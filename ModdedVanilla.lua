-- globals
G.coreactive = 0

-- functions


-- Atlases

-- students

SMODS.Atlas {
    key = "shiroko",           -- unique key for your atlas
    path = "shiroko.png",-- relative path to your atlas image
    px = 71,                          -- width of atlas image in pixels
    py = 95,                          -- height of atlas image in pixels
}

SMODS.Atlas {
    key = "hoshino",           -- unique key for your atlas
    path = "hoshino.png",-- relative path to your atlas image
    px = 71,                          -- width of atlas image in pixels
    py = 95,                          -- height of atlas image in pixels
}

SMODS.Atlas {
    key = "nonomi",
    path = "nonomi.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "serika",
    path = "serika.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "ayane",
    path = "ayane.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "hina",
    path = "hina.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "ako",
    path = "ako.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "iori",
    path = "iori.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "chinatsu",
    path = "chinatsu.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "aru",
    path = "aru.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "haruka",
    path = "haruka.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "mutsuki",
    path = "mutsuki.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "kayoko",
    path = "kayoko.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "makoto",
    path = "makoto.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "ibuki",
    path = "ibuki.png",
    px = 71,
    py = 95,
}



-- bosses
SMODS.Atlas {
	key = "tiphareth",
	path = "tiphareth.png",
	atlas_table = "ANIMATION_ATLAS",
    px = 34, 
    py = 34,
    frames = 21
}

-- rarities

SMODS.Rarity {
    key = "star1",
    loc_txt = { name = "1 Star" },
    badge_colour = {0.2, 0.4, 1, 1},        -- blue
    price_mult = 1, 
}

SMODS.Rarity {
    key = "star2",
    loc_txt = { name = "2 Star" },
    badge_colour = {1, 0.84, 0, 1},         -- gold, alpha 1
    price_mult = 1.5, 
}

SMODS.Rarity {
    key = "star3",
    loc_txt = { name = "3 Star" },
    badge_colour = {0.7, 0.3, 0.9, 1},
    price_mult = 2,
}

-- Abydos jokers

SMODS.Joker {
    key = "shiroko",
    atlas = "shiroko",
    loc_txt = {
        name = "Sunaokami Shiroko",
        text = {"{C:red}+32{} Mult",
    "{C:attention}#1# in 5{} for {C:red}+9{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.probabilities.normal}}
    end,
    calculate = function(self, card, context)
    if context.joker_main then
        if math.random(G.GAME.probabilities.normal, 5) < G.GAME.probabilities.normal then
        return {
            mult = 32 + 9,
            message = "32 + 9"
        }
        else
        return {
            mult = 32,
        }
        end
    end
end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Abydos", G.C.BLUE, G.C.WHITE, 1.2 )
end
}

SMODS.Joker {
    key = "hoshino",
    atlas = "hoshino",
    loc_txt = {
        name = "Takanashi Hoshino",
        text = {"{C:red}+4{} Mult",
    "if played hand is {C:attention}last hand{}", 
    "{C:chips}+43{} Chips"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.probabilities.normal}}
    end,
    calculate = function(self, card, context)
    if context.joker_main then
        if G.GAME.current_round.hands_left <= 0 then
        return {
            mult = 4,
            chips = 43
        }
        else
        return {
            mult = 4,
        }
        end
    end
end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Abydos", G.C.BLUE, G.C.WHITE, 1.2 )
    end
}

SMODS.Joker {
    key = "nonomi",
    atlas = "nonomi",
    loc_txt = {
        name = "Izayoi Nonomi",
        text = {"{C:red}X1.5{} Mult", "Every 3 hands will {C:attention}buff{} Mult by {C:red}+6{}", "#4#"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 3,
    pos = { x = 0, y = 0 },
    config = { extra = {buffactive = false, turnsbuff = 3, turnsoff = 2} },
    loc_vars = function(self, info_queue, card)
        local buffactive = card.ability.extra.buffactive
        local turnsbuff = card.ability.extra.turnsbuff
        local turnsoff = card.ability.extra.turnsoff
        local countingwhat
        if buffactive then
            countingwhat = tostring(turnsbuff) .. " hands left"
        else
            countingwhat = tostring(turnsoff) .. " hands left till buff"
        end
        return { vars = {G.GAME.probabilities.normal, turnsoff, turnsbuff, countingwhat} }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.turnsbuff = 3
        card.ability.extra.turnsoff = 2
    end,

    calculate = function(self, card, context)
        local buffactive = card.ability.extra.buffactive
        local turnsbuff = card.ability.extra.turnsbuff
        local turnsoff = card.ability.extra.turnsoff
        if context.joker_main then
            if buffactive then
                card.ability.extra.turnsbuff = turnsbuff - 1
                if card.ability.extra.turnsbuff == 0 then
                    card.ability.extra.buffactive = false
                    card.ability.extra.turnsbuff = 3
                    return { mult = 6, message = "Reset" }
                end
                return { xmult = 4, mult = 6, message = tostring(card.ability.extra.turnsbuff) .. " left" }
            else
                if turnsoff then
                    card.ability.extra.turnsoff = turnsoff - 1
                    if card.ability.extra.turnsoff == 0 then
                        card.ability.extra.buffactive = true
                        card.ability.extra.turnsoff = 2
                        return { xmult = 4, message = "active" }
                    end
                    return { xmult = 4, message = tostring(card.ability.extra.turnsbuff) .. " left" }
                end
            end
        end
    end,

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Abydos", G.C.BLUE, G.C.WHITE, 1.2 )
    end
}

SMODS.Joker {
    key = "serika",
    atlas = "serika",
    loc_txt = {
        name = "Kuromi Serika",
        text = {"{C:blue}+50{} Chips", "If blind is a {C:attention}Boss Blind{} buffs chips by {C:blue}+35{}", "{C:inactive}Works only once every boss blind{}", "#2#"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 3,
    pos = { x = 0, y = 0 },
    config = { extra = {buffactive = false, turnsbuff = 3} },
    loc_vars = function(self, info_queue, card)
        local buffactive = card.ability.extra.buffactive
        local turnsbuff = card.ability.extra.turnsbuff
        local countingwhat
        if buffactive then
            countingwhat = tostring(turnsbuff) .. " hands left"
        else
            countingwhat = "Not Active"
        end
        return { vars = {turnsbuff, countingwhat} }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.turnsbuff = 0
    end,

    calculate = function(self, card, context)
    local buffactive = card.ability.extra.buffactive
    local turnsbuff = card.ability.extra.turnsbuff

    if context.setting_blind then
        if G and G.GAME and G.GAME.blind and G.GAME.blind.boss == true then
            card.ability.extra.buffactive = true
            card.ability.extra.turnsbuff = 3
            return {message = "Active"}
        end
    end

    if context.joker_main then
        if buffactive then
            card.ability.extra.turnsbuff = math.max(turnsbuff - 1, 0)
            if card.ability.extra.turnsbuff == 0 then
                card.ability.extra.buffactive = false
                return { chips = 50 + 35, message = "Reset" }
            end
            return { chips = 50 + 35, message = tostring(card.ability.extra.turnsbuff) .. " left" }
        else
            return { chips = 50 }
        end
    end
end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Abydos", G.C.BLUE, G.C.WHITE, 1.2 )
end
}

SMODS.Joker {
    key = "ayane",
    atlas = "ayane",
    loc_txt = {
        name = "Okusora Ayane",
        text = {"{X:mult,C:white}X1.4{} Mult",
    "{C:blue}+1 hands{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 3,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
    if context.setting_blind then
        G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 1
        return {colour = G.C.BLUE, message = "+1"}
    end
    if context.joker_main then
        return {xmult = 1.4}
    end
end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Abydos", G.C.BLUE, G.C.WHITE, 1.2 )
end
}

SMODS.Joker {
    key = "hina",
    atlas = "hina",
    loc_txt = {
        name = "Sorasaki Hina",
        text = {"{C:red}+6{} Mult.",
    "if played hand is {C:attention}last hand{} {C:red}+2{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
    if context.joker_main then
        if G.GAME.current_round.hands_left == 0 then
            return {mult = 6 + 2}
        else
            return {mult = 6}
        end
    end
end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
end
}

SMODS.Joker {
    key = "ako",
    atlas = "ako",
    loc_txt = {
        name = "Amau Ako",
        text = {"Each {C:attention}played card{} will gain {C:blue}27 chips{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + 27
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
end
}

SMODS.Joker {
    key = "ako",
    atlas = "ako",
    loc_txt = {
        name = "Amau Ako",
        text = {"Each {C:attention}played card{} will", "permanently ", "gain {C:blue}27 chips{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + 27
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
end
}

SMODS.Joker {
    key = "iori",
    atlas = "iori",
    loc_txt = {
        name = "Shiromi Iori",
        text = {"{C:red}+22{} mult", "If hand has exactly {C:attention}3{} cards.", "{C:red}+3-6{} Mult for {C:attention}each card{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and #context.full_hand == 3 then
            return {
                mult = math.random(3, 6)
            }
        end
        if context.joker_main then
            return {
                mult = 22
            }
        end
    end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
end
}

SMODS.Joker {
    key = "chinatsu",
    atlas = "chinatsu",
    loc_txt = {
        name = "Hinomiya Chinatsu",
        text = {"{X:chips,C:white}X1.9{} chips"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star1",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xchips = 1.9
            }
        end
    end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
end
}

SMODS.Joker {
    key = "aru",
    atlas = "aru",
    loc_txt = {
        name = "Rikuhachima Aru",
        text = {"{C:red}+2-5{} Mult for each {C:attention}played card{}{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                mult = math.random(2, 5)
            }
        end
    end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
        badges[#badges+1] = create_badge("Problem Solver 68", G.C.RED, G.C.WHITE, 1 )
end
}

SMODS.Joker {
    key = "haruka",
    atlas = "haruka",
    loc_txt = {
        name = "Igusa Haruka",
        text = {"{C:red}+8{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star1",
    cost = 1,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = 8
            }
        end
    end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
        badges[#badges+1] = create_badge("Problem Solver 68", G.C.RED, G.C.WHITE, 1 )
end
}

SMODS.Joker {
    key = "mutsuki",
    atlas = "mutsuki",
    loc_txt = {
        name = "Asagi Mutsuki",
        text = {"{C:red}+4-7{} Mult for each card if {C:attention}3{} or {C:attention}less{} cards are in hand"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 1,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and #context.full_hand <= 3 then
            return {
                mult = math.random(4, 7)
            }
        end
    end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
        badges[#badges+1] = create_badge("Problem Solver 68", G.C.RED, G.C.WHITE, 1 )
end
}

SMODS.Joker {
    key = "kayoko",
    atlas = "kayoko",
    loc_txt = {
        name = "Onikata Kayoko",
        text = {"{X:mult,C:white}X2{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 1,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = 2
            }
        end
    end,
set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
        badges[#badges+1] = create_badge("Problem Solver 68", G.C.RED, G.C.WHITE, 1 )
end
}

SMODS.Joker {
    key = "makoto",
    atlas = "makoto",
    loc_txt = {
        name = "Hanuma Makoto",
        text = {"{C:red}+15{} Mult if the hand scores exactly {C:attention}2{} cards",
    "{C:red}+31{} Mult if the hand scores exactly {C:attention}4{} cards",
    "{C:red}+51{} Mult if the hand scores exactly {C:attention}5{} cards"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand and #context.scoring_hand == 2 then
        return { mult = 15 }
    end
    if context.joker_main and context.scoring_hand and #context.scoring_hand == 4 then
        return { mult = 31 }
    end
    if context.joker_main and context.scoring_hand and #context.scoring_hand == 5 then
        return { mult = 51 }
    end
end,

set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
        badges[#badges+1] = create_badge("Pamdemomium Society", G.C.UI.TEXT_INACTIVE, G.C.WHITE, 1 )
end
}

SMODS.Joker {
    key = "ibuki",
    atlas = "ibuki",
    loc_txt = {
        name = "Tanga Ibuki",
        text = {"{X:mult,C:white}X1.34{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star1",
    cost = 5,
    pos = { x = 0, y = 0 },
    config = {  },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
    if context.joker_main then
        return { xmult = 1.34 }
    end
end,

set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
        badges[#badges+1] = create_badge("Pamdemomium Society", G.C.UI.TEXT_INACTIVE, G.C.WHITE, 1 )
end
}






-- boss blinds



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

SMODS.Keybind{
    id = "testbind",
    key_pressed = "t",
    action = function(self)
        G.coreactive = math.random(1, 3)
        print(G.coreactive)
    end
}



-- musics


SMODS.Sound {
    key = "music_win",          
    path = "music_win.ogg",        
    volume = 0.7,                        
    pitch = 1,
    select_music_track = function(self)
	if G.STATE == 8 then
        return true
    end
end                   
}

SMODS.Sound {
    key = "music_tiph1",          
    path = "music_tiph1.ogg",        
    volume = 1,                        
    pitch = 1,
    select_music_track = function(self)
	if G and G.GAME and G.GAME.blind and G.GAME.blind.name and G.GAME.blind.name == "bl_ba_tiphareth" and G.GAME.chips <= G.GAME.blind.chips / 2 then
        return 9999
    end
end                   
}

SMODS.Sound {
    key = "music_tiph2",          
    path = "music_tiph2.ogg",        
    volume = 1,                        
    pitch = 1,
    select_music_track = function(self)
	if G and G.GAME and G.GAME.blind and G.GAME.blind.name and G.GAME.blind.name == "bl_ba_tiphareth" and G.GAME.chips >= G.GAME.blind.chips / 2 then
        return 9999
    end
end                   
}

SMODS.Sound {
    key = "music_none",          
    path = "music_tiph2.ogg",        
    volume = 0,                        
    pitch = 0.1,
    select_music_track = function(self)
    if not timer then
        timer = 0
    end
	if timer and G and G.GAME and G.GAME.blind and G.GAME.blind.name and G.GAME.blind.name == "bl_ba_tiphareth" and G.GAME.chips >= G.GAME.blind.chips / 2 then
        timer = (timer or 0) + 1
        if G.GAME.chips >= G.GAME.blind.chips / 2 and timer > (3 - (G.GAME.chips / G.GAME.blind.chips * 10)) then
            G.GAME.chips = G.GAME.chips - 1
            timer = 0
        end
    end
end                   
}