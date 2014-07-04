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

hotkey.new({ "cmd", "ctrl", "alt" }, "right", function()
	local win = window.focusedwindow()
	local frame = win:frame()
	local screen = win:screen():frame()
	frame.x = screen.w - frame.w
	frame.y = screen.h - frame.h
	win:setframe(frame)
end):enable()
