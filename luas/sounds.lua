-- musics

SMODS.Sound {
    key = "music_challenges",          
    path = "music_challenges.ogg",        
    volume = 0.5,                        
    pitch = 1,
    select_music_track = function(self)
        if G.CHALLENGE_LIST_SHOWING == true and false == true then -- sneaky lock
            return 99999
        end
    end                   
}

SMODS.Sound {
    key = "music_win",          
    path = "music_win.ogg",        
    volume = 0.4,
    pitch = 1,
    select_music_track = function(self)
	if G.WIN_SCREEN_SHOWING then
        return 9999
    end
end                   
}

SMODS.Sound {
    key = "music_loss",          
    path = "music_loss.ogg",        
    volume = 0.4,  -- Keep volume at normal level                     
    pitch = 1,     -- Set to normal pitch (1) instead of 2 to prevent pitch down
    select_music_track = function(self)
        if G.STATE == G.STATES.GAME_OVER then
            return 9999
        end
    end                   
}

SMODS.Sound {
    key = "music_binah",          
    path = "music_binah.ogg",        
    volume = 0.4,                        
    pitch = 1,
    select_music_track = function(self)
	if G.BA_BINAH_PHASE and G.BA_BINAH_PHASE == 1 then
        return 9999
    end
end                   
}

SMODS.Sound {
    key = "music_tiph1",          
    path = "music_tiph1.ogg",        
    volume = 0.4,                        
    pitch = 1,
    select_music_track = function(self)
	if G.BA_TIPHARETH_PHASE and G.BA_TIPHARETH_PHASE == 1 then
        return 9999
    end
end                   
}

SMODS.Sound {
    key = "music_tiph2",          
    path = "music_tiph2.ogg",        
    volume = 0.4,                        
    pitch = 1,
    select_music_track = function(self)
	if G.BA_TIPHARETH_PHASE and G.BA_TIPHARETH_PHASE == 2 then
        return 9999
    end
end                   
}


SMODS.Sound {
    key = "winsfx",          
    path = "winsfx.ogg",        
    volume = 1,                        
    pitch = 1          
}