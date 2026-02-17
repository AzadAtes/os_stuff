-- Application Shortcuts
hs.hotkey.bind({"shift","alt","ctrl"}, '1', function() hs.application.launchOrFocus("Microsoft Outlook") end)
hs.hotkey.bind({"shift","alt","ctrl"}, '2', function() hs.application.launchOrFocus("Microsoft Teams") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'q', function() hs.application.launchOrFocus("Terminal") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'w', function() hs.application.launchOrFocus("Firefox") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'e', function() hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 's', function() hs.application.launchOrFocus("Sublime Text") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'd', function() hs.application.launchOrFocus("IntelliJ IDEA") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'y', function() hs.application.launchOrFocus("Orbstack") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'x', function() hs.application.launchOrFocus("Insomnia") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'c', function() hs.application.launchOrFocus("Finder") end)

hs.hotkey.bind({"shift", "cmd"}, 'q', function() hs.application.frontmostApplication():kill() end)

-- Close window or quit application Shortcut
hs.hotkey.bind({"cmd"}, "q", function()

    local frontmostApp = hs.application.frontmostApplication()
    local focusedWindow = hs.window.focusedWindow()

    if frontmostApp
        and #frontmostApp:allWindows() <= 1
        and frontmostApp:name() ~= "Finder"
        and frontmostApp:name() ~= "OrbStack"
        and frontmostApp:name() ~= "Microsoft Teams"
        and frontmostApp:name() ~= "Microsoft Outlook"
    then
        frontmostApp:kill()
    elseif focusedWindow then
        focusedWindow:close()
    end
end)

-- Reload Config Shortcut
hs.hotkey.bind({"shift","alt","ctrl"}, "return", function()
    hs.reload()
end)

-- Notify on successful reload
hs.alert.show("config loaded")
