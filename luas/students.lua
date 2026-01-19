



-- UI
SMODS.Joker {
    key = "rin",
    atlas = "rin",
    loc_txt = {
        name = "Nanagami Rin",
        text = {"Let's get started."}
    },
    discovered = true,
    unlocked = true,
    no_collection = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 1,
    pos = { x = 0, y = 0 },
    config = {  },
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("GENERAL STUDENT COUNCIL", G.C.BLUE, G.C.WHITE, 1.2 )
    end,
    in_pool = function(self)
        return false
    end
}



-- jokers
SMODS.Joker {
    key = "shiroko",
    atlas = "students",
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
    atlas = "students",
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
    pos = { x = 1, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Izayoi Nonomi",
        text = {"{C:red}X1.5{} Mult", "Every 3 hands will {C:attention}buff{} Mult by {C:red}+6{}", "#4#"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 3,
    pos = { x = 2, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Kuromi Serika",
        text = {"{C:blue}+50{} Chips", "If blind is a {C:attention}Boss Blind{} buffs chips by {C:blue}+35{}", "{C:inactive}Works only once every boss blind{}", "#2#"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 3,
    pos = { x = 3, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Okusora Ayane",
        text = {"{X:mult,C:white}X1.4{} Mult",
    "{C:blue}+1 hands{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 3,
    pos = { x = 4, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Sorasaki Hina",
        text = {"{C:red}+6{} Mult.",
    "if played hand is {C:attention}last hand{} {C:red}+2{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 5, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Amau Ako",
        text = {"Each {C:attention}played card{} will gain {C:blue}27 chips{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 6, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Shiromi Iori",
        text = {"{C:red}+22{} mult", "If hand has exactly {C:attention}3{} cards.", "{C:red}+3-6{} Mult for {C:attention}each card{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 7, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Hinomiya Chinatsu",
        text = {"{X:chips,C:white}X1.9{} chips"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star1",
    cost = 5,
    pos = { x = 8, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Rikuhachima Aru",
        text = {"{C:red}+2-5{} Mult for each {C:attention}played card{}{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 9, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Igusa Haruka",
        text = {"{C:red}+8{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star1",
    cost = 1,
    pos = { x = 10, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Asagi Mutsuki",
        text = {"{C:red}+4-7{} Mult for each card if {C:attention}3{} or {C:attention}less{} cards are in hand"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 1,
    pos = { x = 11, y = 0 },
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
    atlas = "students",
    loc_txt = {
        name = "Onikata Kayoko",
        text = {"{X:mult,C:white}X2{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star2",
    cost = 1,
    pos = { x = 12, y = 0 },
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
    atlas = "students",
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
    pos = { x = 13, y = 0 },
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
        badges[#badges+1] = create_badge("Pandemomium Society", G.C.UI.TEXT_INACTIVE, G.C.WHITE, 1 )
end
}

SMODS.Joker {
    key = "ibuki",
    atlas = "students",
    loc_txt = {
        name = "Tanga Ibuki",
        text = {"{X:mult,C:white}X1.34{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star1",
    cost = 5,
    pos = { x = 14, y = 0 },
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
        badges[#badges+1] = create_badge("Pandemomium Society", G.C.UI.TEXT_INACTIVE, G.C.WHITE, 1 )
end
}

SMODS.Joker {
    key = "Iroha",
    atlas = "students",
    loc_txt = {
        name = "Natsume Iroha",
        text = {"{X:chips,C:white}X11.5{} Chips", "{S:0.5,C:inactive}Tactical Support needs time to deploy{}", "{S:0.5,C:inactive}Activation time differs per student.{}"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 15, y = 0 },
    config = { activation = 2, activation_progress = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)
    if context.setting_blind then
        card.config.activation_progress = 0
        self.debuff = true
    end
    if context.joker_main then
        card.config.activation_progress = card.config.activation_progress + 1
        if card.config.activation_progress >= card.config.activation then
            self.debuff = true
            return { xchips = 11.5 }
        else
            self.debuff = false
            return { message = tostring(card.config.activation - card.config.activation_progress) .. " left" }
        end
    end
end,

set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
        badges[#badges+1] = create_badge("Pandemomium Society", G.C.UI.TEXT_INACTIVE, G.C.WHITE, 1 )
        badges[#badges+1] = create_badge("Tactical Support", G.C.CHIPS, G.C.WHITE, 1 )
end
}

SMODS.Joker {
    key = "Chiaki",
    atlas = "students",
    loc_txt = {
        name = "Motomiya Chiaki",
        text = {"{C:red}+14.5{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 0, y = 1 },
    config = { },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)

    if context.joker_main then
    
    end
end,

set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
        badges[#badges+1] = create_badge("Pandemomium Society", G.C.UI.TEXT_INACTIVE, G.C.WHITE, 1 )
end
}

SMODS.Joker {
    key = "Satsuki",
    atlas = "students",
    loc_txt = {
        name = "Kyougoku Satsuki",
        text = {"{C:red}+8.7{} Mult", "{X:mult,C:white}X1.2{} Mult"}
    },
    unlocked = true,
    blueprint_compat = true,
    rarity = "ba_star3",
    cost = 5,
    pos = { x = 1, y = 1 },
    config = { },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    calculate = function(self, card, context)

    if context.joker_main then
        return {mult = 8.7, xmult = 1.2}
    end
end,

set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Gehenna", G.C.RED, G.C.WHITE, 1.2 )
        badges[#badges+1] = create_badge("Pandemomium Society", G.C.UI.TEXT_INACTIVE, G.C.WHITE, 1 )
end
}