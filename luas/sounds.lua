-- musics


SMODS.Sound {
    key = "music_win",          
    path = "music_win.ogg",        
    volume = 0.7,                        
    pitch = 1,
    select_music_track = function(self)
	if G.STATE == 8 and G.GAME.won and G.GAME.round_resets.ante == 9 then
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