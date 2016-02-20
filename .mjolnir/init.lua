local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"

-- toggle fullscreen
hotkey.bind({"cmd", "alt", "ctrl"}, "f", function()
	local win = window.focusedwindow()
	win:setfullscreen(not win:isfullscreen())
end)

-- maximize
hotkey.bind({"cmd", "alt", "ctrl"}, "up", function()
	local win = window.focusedwindow()
	local frame = win:frame()
	local screen = win:screen():fullframe()
	frame.x = 0
	frame.y = 0
	frame.w = screen.w
	frame.h = screen.h
	win:setframe(frame)
end)

-- move to lower right
hotkey.bind({"cmd", "alt", "ctrl"}, "right", function()
	local win = window.focusedwindow()
	local frame = win:frame()
	local screen = win:screen():fullframe()
	frame.x = screen.w - frame.w
	frame.y = screen.h - frame.h
	win:setframe(frame)
end)
