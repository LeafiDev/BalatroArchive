
-- Use a standalone global table to avoid overwriting `G` at load time
COSTHUD = COSTHUD or { value = 0, ui = nil }

function clamp(v, lo, hi)
	if v < lo then return lo end
	if v > hi then return hi end
	return v
end

filled_col = filled_col or {0.2, 0.85, 0.4, 1}   -- greenish
empty_col = empty_col or {0.18, 0.18, 0.2, 0.6} -- dark translucent

function create_ui()
	-- only create if game UI system available
	if not (G and G.UIT and UIBox and G.ROOM_ATTACH) then
		return false
	end
	if COSTHUD.ui then
		COSTHUD.ui:remove()
		COSTHUD.ui = nil
	end

	local cols = {}
	for i = 1, 10 do
		cols[#cols+1] = { n = G.UIT.C, config = { align = "bm", minw = 0.45, minh = 1.2, colour = empty_col, padding = 0.01 } }
	end

	local node = {
		n = G.UIT.ROOT,
		config = { align = "cm", colour = (G.C and G.C.CLEAR) or {0,0,0,0} },
		nodes = {
			{ n = G.UIT.C, config = { align = "tr", padding = 0.02, r = 0.06, colour = (G.C and G.C.L_BLACK) or {0,0,0,0.6} }, nodes = {
				{ n = G.UIT.R, config = { align = "tr", padding = 0.01 }, nodes = cols }
			}}
		}
	}

	COSTHUD.ui = UIBox{
		definition = node,
		config = {
			align = "tr",
			offset = { x = -0.12, y = 0.22 },
			major = G.ROOM_ATTACH,
			bond = 'Weak'
		}
	}
	if COSTHUD.ui.recalculate then COSTHUD.ui:recalculate(true) end
	return true
end

function update_ui()
	if not COSTHUD.ui then return end
	if not (COSTHUD.ui.UIRoot and COSTHUD.ui.UIRoot.children and COSTHUD.ui.UIRoot.children[1] and COSTHUD.ui.UIRoot.children[1].children and COSTHUD.ui.UIRoot.children[1].children[1]) then
		return
	end
	local row = COSTHUD.ui.UIRoot.children[1].children[1]
	local v = clamp(tonumber(COSTHUD.value) or 0, 0, 10)
	for i = 1, 10 do
		local child = row.children and row.children[i]
		if child and child.config then
			child.config.colour = (i <= v) and filled_col or empty_col
		end
	end
end

function SetCost(n)
	COSTHUD.value = clamp(math.floor(tonumber(n) or 0), 0, 10)
	if not COSTHUD.ui then
		if not create_ui() then
			return
		end
	end
	update_ui()
	-- bind into G for convenience if available
	if G then G.SetCost = SetCost end
end

function ShowCost(show)
	if not COSTHUD.ui then
		if not create_ui() then return end
	end
	if COSTHUD.ui and COSTHUD.ui.UIBox and COSTHUD.ui.UIBox.states then
		COSTHUD.ui.UIBox.states.visible = not not show
	end
	if G then G.ShowCost = ShowCost end
end

-- expose on G if available
if G then
	G.SetCost = SetCost
	G.ShowCost = ShowCost
end

-- initialize stored value
SetCost(0)