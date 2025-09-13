-- Usage: osascript toggle_hide_app.applescript <app_name> [<app_path>]
-- If <app_path> is not provided, the script assumes the app is in /Applications/<app_name>.app
-- Example: osascript toggle_hide_app.applescript "Google Chrome"
-- Example: osascript toggle_hide_app.applescript "Google Chrome" "/Applications/Google Chrome.app"



-- If the app is closed, open it.
-- Else if the app is frontmost, hide it.
-- If the app is not frontmost, bring it to the front.

on run argv
	set app_name to item 1 of argv
	if (count of argv) < 2 then
		set app_path to "/Applications/" & app_name & ".app"
	else
		set app_path to item 2 of argv
	end if

	tell application "System Events" to set is_running to (count every process whose name is app_name) > 0

	-- tell application "System Events" to set app_processes to windows of application process app_name

	if not is_running then
		log "App " & app_name & " is not running."
		-- App is not running, so open it.
		tell application app_name to activate

		set theTimeout to 20
		repeat until is_running or theTimeout ≤ 0
			delay 0.1
			set theTimeout to theTimeout - 1
			tell application "System Events" to set is_running to (count every process whose name is app_name) > 0
		end repeat
		if not is_running then
			log "App " & app_name & " did not start in time."
			return
		end if
	end if

	tell application "System Events" to set is_window_open to (count windows of application process app_name) > 0
	if not is_window_open then
		log "App " & app_name & " has no open windows."
		-- App has no open windows, so just bring it to the front.
		do shell script "open " & quoted form of app_path

		set theTimeout to 20
		repeat until is_window_open or theTimeout ≤ 0
			delay 0.1
			set theTimeout to theTimeout - 1
			tell application "System Events" to set is_window_open to (count windows of application process app_name) > 0
		end repeat
		if not is_window_open then
			log "App " & app_name & " did not open a window in time."
			return
		end if
		return
	end if

	tell application "System Events" to set app_processes to every process whose name is app_name
	set app_process to item 1 of app_processes

	if frontmost of app_process then
		log "App " & app_name & " is frontmost."
		tell application "System Events" to set visible of application process app_name to false
	else
		log "App " & app_name & " is running but not frontmost."
		-- App is not frontmost, so bring it to the front.
		set frontmost of app_process to true
		activate application app_name
	end if

end run
