local rectangle = renderer.rectangle
local gradient = renderer.gradient
local line = renderer.line
local circle = renderer.circle
local getui = ui.get
local reference = ui.reference
local text = renderer.text
local triangle = renderer.triangle
local slider = ui.new_slider
local checkbox = ui.new_checkbox

local w, h = client.screen_size()

local enable = checkbox("Lua", "A", "Visuals preview")
local menuonly = checkbox("Lua", "A", "Display only in menu")
local xslider = slider("Lua", "A", "Slider X", 0, w, w / 2, true)
local yslider = slider("Lua", "A", "Slider Y", 0, h, h / 2, true)

local w = 200
local h = 250
local offset = 29

local localname = entity.get_player_name(entity.get_local_player())

local skeleton, skelcol = reference("Visuals", "Player ESP", "Skeleton")
local bb, bbcol = reference("Visuals", "Player ESP", "Bounding box")
local health = reference("Visuals", "Player ESP", "Health bar")
local name, namecol = reference("Visuals", "Player ESP", "Name")
local weptext = reference("Visuals", "Player ESP", "Weapon text")
local ammo, ammocol = reference("Visuals", "Player ESP", "Ammo")
local wepicon = reference("Visuals", "Player ESP", "Weapon icon")
local dist = reference("Visuals", "Player ESP", "Distance")
local fovarrow, fovarrowcol, size = reference("Visuals", "Player ESP", "Out of FOV arrow")
local money = reference("Visuals", "Player ESP", "Money")
local flags = reference("Visuals", "Player ESP", "Flags")
local glow, glowcol = reference("Visuals", "Player ESP", "Glow")

local function paint(ctx)
	if getui(enable, true) then
		if getui(menuonly, true) then
			if ui.is_menu_open(true) then
				local x = getui(xslider)
				local y = getui(yslider)

				--container
				rectangle(x, y - 68 + 4, w, h - 4, 10, 10, 10, 255)
				rectangle(x + 1, y - 67 + 4, w - 2, h - 2 - 4, 60, 60, 60, 255)
				rectangle(x + 2, y - 66 + 4, w - 4, h - 4 - 4, 40, 40, 40, 255)
				rectangle(x + 5, y - 64 + 4, w - 9, h - 8 - 4, 60, 60, 60, 255)
				rectangle(x + 6, y - 63 + 4, w - 11, h - 10 - 4, 20, 20, 20, 255)
				gradient(x + 7, y - 62 + 4, w / 2 - 11, 1, 56, 176, 218, 255, 201, 72, 205, 255, true)
				gradient(x + 7 + w / 2 - 13, y - 62 + 4, w / 2, 1, 201, 72, 205, 255, 204, 227, 53, 255, true)

				--skeleton
				if getui(skeleton, true) then
					sr, sg, sb, sa = getui(skelcol)
				else
					sr, sg, sb, sa = 238, 238, 238, 255
				end

				line(x + w / 2, y + h / 2 - 110 - offset, x + w / 2, y + h / 2 - 10 - offset, sr, sg, sb, sa)
				line(x + w / 2, y + h / 2 - 10 - offset, x + w / 2 - 25, y + h / 2 + 25 - offset, sr, sg, sb, sa)
				line(x + w / 2, y + h / 2 - 10 - offset, x + w / 2 + 25, y + h / 2 + 25 - offset, sr, sg, sb, sa)
				line(x + w / 2, y + h / 2 - 85 - offset, x + w / 2 - 25, y + h / 2 - 50 - offset, sr, sg, sb, sa)
				line(x + w / 2, y + h / 2 - 85 - offset, x + w / 2 + 25, y + h / 2 - 50 - offset, sr, sg, sb, sa)
				circle(x + w / 2, y + h / 2 - 110 - offset, sr, sg, sb, sa, 14, 0, 1)

				if getui(glow, true) then
					local r, g, b, a = getui(glowcol)
					gradient(x + w / 2, y + h / 2 - 95 - offset, 15, 85, r, g, b, a / 10, r, g, b, 0, true)
					gradient(x + w / 2 - 15, y + h / 2 - 95 - offset, 15, 85, r, g, b, 0, r, g, b, a / 10, true)
				end

				if getui(bb, true) then
					local r, g, b, a = getui(bbcol)
					line(x + w / 2 - 50, y + h / 2 - 135 - offset, x + w / 2 + 50, y + h / 2 - 135 - offset, r, g, b, a)
					line(x + w / 2 - 50, y + h / 2 - 135 - offset, x + w / 2 - 50, y + h / 2 + 35 - offset, r, g, b, a)
					line(x + w / 2 + 50, y + h / 2 - 135 - offset, x + w / 2 + 50, y + h / 2 + 35 - offset, r, g, b, a)
					line(x + w / 2 - 50, y + h / 2 + 35 - offset, x + w / 2 + 50, y + h / 2 + 35 - offset, r, g, b, a)
				end

				if getui(health, true) then
					rectangle(x + w / 2 - 57, y + h / 2 - 135 - offset, 5, 171, 0, 0, 0, 200)
					rectangle(x + w / 2 - 56, y + h / 2 - 114 - offset, 3, 150, 0, 220, 0, 255)
					text(x + w / 2 - 55, y + h / 2 - 143, 238, 238, 238, 255, "c", 0, "86")
				end

				if getui(name, true) then
					local r, g, b, a = getui(namecol)
					text(x + w / 2, y + h / 2 - 143 - offset, r, g, b, a, "c", 0, localname)
				end

				if getui(ammo, true) then
					local r, g, b, a = getui(ammocol)
					rectangle(x + w / 2 - 50, y + h / 2 + 38 - offset, 100, 5, 0, 0, 0, 200)
					rectangle(x + w / 2 - 49, y + h / 2 + 39 - offset, 70, 3, r, g, b, a)
					add = 5
				else
					add = -2
				end

				if getui(dist, true) then
					text(x + w / 2, y + h / 2 + 45 - offset + add, 238, 238, 238, 255, "cb-", 0, "27 FT")
					increase = 10
				else
					increase = 0
				end

				if getui(weptext, true) then
					text(x + w / 2, y + h / 2 + 45 - offset + add + increase, 238, 238, 238, 255, "cb-", 0, "SCAR-20")
					addition = 10
				else
					addition = 0
				end

				if getui(wepicon, true) then
					text(x + w / 2, y + h / 2 + 45 - offset + add + addition + increase, 238, 238, 238, 255, "cb-", 0, "Fuck off I didnt finish yet")
				end

				if getui(fovarrow, true) then
					local r, g, b, a = getui(fovarrowcol)
					triangle(x + w - 20 + getui(size) / 4, y + h / 2 - 50 - offset, x + w - 25 - getui(size) / 4, y + h / 2 - 50 + getui(size) / 2 - offset, x + w - 25 - getui(size) / 4, y + h / 2 - 50 - getui(size) / 2 - offset, r, g, b, a)
				end

				if getui(money, true) then
					text(x + w - 36, y + h / 2 - 131 - offset, 0, 220, 0, 255, "cb-", 0, "$16000")
					additive = 10
				else
					additive = 0
				end

				if getui(flags, true) then
					text(x + w - 41, y + h / 2 - 131 - offset + additive, 238, 238, 238, 255, "cb-", 0, "HK")
					text(x + w - 41, y + h / 2 - 121 - offset + additive, 238, 238, 238, 255, "cb-", 0, "HIT")
				end
			end
		else
			local x = getui(xslider)
				local y = getui(yslider)

				--container
				rectangle(x, y - 68 + 4, w, h - 4, 10, 10, 10, 255)
				rectangle(x + 1, y - 67 + 4, w - 2, h - 2 - 4, 60, 60, 60, 255)
				rectangle(x + 2, y - 66 + 4, w - 4, h - 4 - 4, 40, 40, 40, 255)
				rectangle(x + 5, y - 64 + 4, w - 9, h - 8 - 4, 60, 60, 60, 255)
				rectangle(x + 6, y - 63 + 4, w - 11, h - 10 - 4, 20, 20, 20, 255)
				gradient(x + 7, y - 62 + 4, w / 2 - 11, 1, 56, 176, 218, 255, 201, 72, 205, 255, true)
				gradient(x + 7 + w / 2 - 13, y - 62 + 4, w / 2, 1, 201, 72, 205, 255, 204, 227, 53, 255, true)

				--skeleton
				if getui(skeleton, true) then
					sr, sg, sb, sa = getui(skelcol)
				else
					sr, sg, sb, sa = 238, 238, 238, 255
				end

				line(x + w / 2, y + h / 2 - 110 - offset, x + w / 2, y + h / 2 - 10 - offset, sr, sg, sb, sa)
				line(x + w / 2, y + h / 2 - 10 - offset, x + w / 2 - 25, y + h / 2 + 25 - offset, sr, sg, sb, sa)
				line(x + w / 2, y + h / 2 - 10 - offset, x + w / 2 + 25, y + h / 2 + 25 - offset, sr, sg, sb, sa)
				line(x + w / 2, y + h / 2 - 85 - offset, x + w / 2 - 25, y + h / 2 - 50 - offset, sr, sg, sb, sa)
				line(x + w / 2, y + h / 2 - 85 - offset, x + w / 2 + 25, y + h / 2 - 50 - offset, sr, sg, sb, sa)
				circle(x + w / 2, y + h / 2 - 110 - offset, sr, sg, sb, sa, 14, 0, 1)

				if getui(glow, true) then
					local r, g, b, a = getui(glowcol)
					gradient(x + w / 2, y + h / 2 - 95 - offset, 15, 85, r, g, b, a / 10, r, g, b, 0, true)
					gradient(x + w / 2 - 15, y + h / 2 - 95 - offset, 15, 85, r, g, b, 0, r, g, b, a / 10, true)
				end

				if getui(bb, true) then
					local r, g, b, a = getui(bbcol)
					line(x + w / 2 - 50, y + h / 2 - 135 - offset, x + w / 2 + 50, y + h / 2 - 135 - offset, r, g, b, a)
					line(x + w / 2 - 50, y + h / 2 - 135 - offset, x + w / 2 - 50, y + h / 2 + 35 - offset, r, g, b, a)
					line(x + w / 2 + 50, y + h / 2 - 135 - offset, x + w / 2 + 50, y + h / 2 + 35 - offset, r, g, b, a)
					line(x + w / 2 - 50, y + h / 2 + 35 - offset, x + w / 2 + 50, y + h / 2 + 35 - offset, r, g, b, a)
				end

				if getui(health, true) then
					rectangle(x + w / 2 - 57, y + h / 2 - 135 - offset, 5, 171, 0, 0, 0, 200)
					rectangle(x + w / 2 - 56, y + h / 2 - 114 - offset, 3, 150, 0, 220, 0, 255)
					text(x + w / 2 - 55, y + h / 2 - 143, 238, 238, 238, 255, "c", 0, "86")
				end

				if getui(name, true) then
					local r, g, b, a = getui(namecol)
					text(x + w / 2, y + h / 2 - 143 - offset, r, g, b, a, "c", 0, localname)
				end

				if getui(ammo, true) then
					local r, g, b, a = getui(ammocol)
					rectangle(x + w / 2 - 50, y + h / 2 + 38 - offset, 100, 5, 0, 0, 0, 200)
					rectangle(x + w / 2 - 49, y + h / 2 + 39 - offset, 70, 3, r, g, b, a)
					add = 5
				else
					add = -2
				end

				if getui(dist, true) then
					text(x + w / 2, y + h / 2 + 45 - offset + add, 238, 238, 238, 255, "cb-", 0, "27 FT")
					increase = 10
				else
					increase = 0
				end

				if getui(weptext, true) then
					text(x + w / 2, y + h / 2 + 45 - offset + add + increase, 238, 238, 238, 255, "cb-", 0, "SCAR-20")
					addition = 10
				else
					addition = 0
				end

				if getui(wepicon, true) then
					text(x + w / 2, y + h / 2 + 45 - offset + add + addition + increase, 238, 238, 238, 255, "cb-", 0, "Fuck off I didnt finish yet")
				end

				if getui(fovarrow, true) then
					local r, g, b, a = getui(fovarrowcol)
					triangle(x + w - 20 + getui(size) / 4, y + h / 2 - 50 - offset, x + w - 25 - getui(size) / 4, y + h / 2 - 50 + getui(size) / 2 - offset, x + w - 25 - getui(size) / 4, y + h / 2 - 50 - getui(size) / 2 - offset, r, g, b, a)
				end

				if getui(money, true) then
					text(x + w - 36, y + h / 2 - 131 - offset, 0, 220, 0, 255, "cb-", 0, "$16000")
					additive = 10
				else
					additive = 0
				end

				if getui(flags, true) then
					text(x + w - 41, y + h / 2 - 131 - offset + additive, 238, 238, 238, 255, "cb-", 0, "HK")
					text(x + w - 41, y + h / 2 - 121 - offset + additive, 238, 238, 238, 255, "cb-", 0, "HIT")
				end
		end
	end
end

client.set_event_callback('paint', paint)
