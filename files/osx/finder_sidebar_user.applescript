on run argv
	tell application "Finder"
		if window 1 exists then
			-- skip
		else
			open first item of argv as POSIX file
			delay 0.5
		end if
		activate
		tell application "System Events" to set frontmost of process "Finder" to true
		set target of front window to (POSIX file (first item of argv)) as alias
	end tell

	delay 0.25

	repeat with aPath in argv
		log "Adding " & aPath & " to Finder sidebar"
		set path1 to (aPath as POSIX file)

		delay 0.25
		tell application "Finder" to set target of front window to path1

		delay 0.25
		tell application "System Events" to tell process "Finder" to click menu item "Add to Sidebar" of menu 1 of menu bar item "File" of menu bar 1
	end repeat

	log "Done."
end run
