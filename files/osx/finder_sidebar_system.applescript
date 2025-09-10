set FINDER_SIDEBAR_ITEMS_ACTIVATE to system attribute "FINDER_SIDEBAR_ITEMS_ACTIVATE"
set FINDER_SIDEBAR_ITEMS_DEACTIVATE to system attribute "FINDER_SIDEBAR_ITEMS_DEACTIVATE"

activate application "Finder"

tell application "System Events"
	tell process "Finder"

		click menu item "Settings…" of menu 1 of menu bar item "Finder" of menu bar 1
		repeat until exists window "Finder Settings"
		end repeat
		set frontmost to true

		click button "Sidebar" of toolbar 1 of window "Finder Settings"

		set theCheckboxes to every checkbox of scroll area 1 of window "Finder Settings"
		repeat with aCheckbox in theCheckboxes
			set checkboxDescription to description of aCheckbox
			set checkboxValue to value of aCheckbox
			set checkboxChecked to checkboxValue > 0

			if checkboxValue > 1 then
				log "Value of checkbox " & checkboxDescription & " is " & checkboxValue & ". Better not touch it."
				-- skip
			else if (checkboxDescription is in FINDER_SIDEBAR_ITEMS_ACTIVATE) and not checkboxChecked then
				log "Checking " & checkboxDescription
				click aCheckbox
			else if (checkboxDescription is in FINDER_SIDEBAR_ITEMS_DEACTIVATE) and checkboxChecked then
				log "Unchecking " & checkboxDescription
				click aCheckbox
			end if
		end repeat

		log "Done."

		click menu item "Close Window" of menu 1 of menu bar item "File" of menu bar 1
	end tell
end tell
