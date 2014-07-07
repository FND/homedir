hydra.alert("Hydra config loaded", 1.5)
menu.show(function()
	local updatetitles = {
		[true] = "Install Update",
		[false] = "Check for Update"
	}
	local updatefns = {
		[true] = updates.install,
		[false] = updates.check
	}
	local hasupdate = (updates.newversion ~= nil)
	return {
		{ title = "Reload Config", fn = hydra.reload },
		{ title = "REPL", fn = repl.open },
		{ title = "-" },
		{ title = "About", fn = hydra.showabout },
		{ title = updatetitles[hasupdate], fn = updatefns[hasupdate] },
		{ title = "Quit", fn = os.exit },
	}
end)

-- move to lower right
hotkey.new({ "cmd", "ctrl", "alt" }, "right", function()
	local win = window.focusedwindow()
	local frame = win:frame()
	local screen = win:screen():frame()
	frame.x = screen.w - frame.w
	frame.y = screen.h - frame.h
	win:setframe(frame)
end):enable()

-- maximize
hotkey.new({ "cmd", "ctrl", "alt" }, "up", function()
	local win = window.focusedwindow()
	local frame = win:frame()
	local screen = win:screen():frame()
	frame.x = 0
	frame.y = 0
	frame.w = screen.w
	frame.h = screen.h
	win:setframe(frame)
end):enable()

-- move up
hotkey.new({ "cmd", "ctrl", "shift" }, "up", function()
	local win = window.focusedwindow()
	local frame = win:frame()
	frame.y = frame.y - 1
	win:setframe(frame)
end):enable()

-- move down
hotkey.new({ "cmd", "ctrl", "shift" }, "down", function()
	local win = window.focusedwindow()
	local frame = win:frame()
	frame.y = frame.y + 1
	win:setframe(frame)
end):enable()

-- move left
hotkey.new({ "cmd", "ctrl", "shift" }, "left", function()
	local win = window.focusedwindow()
	local frame = win:frame()
	frame.x = frame.x - 1
	win:setframe(frame)
end):enable()

-- move right
hotkey.new({ "cmd", "ctrl", "shift" }, "right", function()
	local win = window.focusedwindow()
	local frame = win:frame()
	frame.x = frame.x + 1
	win:setframe(frame)
end):enable()
