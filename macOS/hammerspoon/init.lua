-- Application Shortcuts
hs.hotkey.bind({'alt'}, '1', function() hs.application.launchOrFocus("Finder") end)
hs.hotkey.bind({'alt'}, '2', function() hs.application.launchOrFocus("Firefox") end)
hs.hotkey.bind({'alt'}, '3', function() hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind({'alt'}, '4', function() hs.application.launchOrFocus("Insomnia") end)
hs.hotkey.bind({'alt'}, 'q', function() hs.application.launchOrFocus("Terminal") end)
hs.hotkey.bind({'alt'}, 'w', function() hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind({'alt'}, 'e', function() hs.application.launchOrFocus("IntelliJ IDEA") end)

hs.hotkey.bind({'alt'}, 't', function() hs.application.launchOrFocus("Microsoft Teams") end)
hs.hotkey.bind({'alt'}, 'z', function() hs.application.launchOrFocus("Slack") end)
hs.hotkey.bind({'alt'}, 'o', function() hs.application.launchOrFocus("Microsoft Outlook") end)
hs.hotkey.bind({'alt'}, 'p', function() hs.application.launchOrFocus("Passwords") end)

-- Close window or quit application Shortcut
hs.hotkey.bind({"cmd"}, "q", function()

    local focusedApp = hs.application.frontmostApplication()
    local focusedWindow = hs.window.focusedWindow()

    if focusedApp and #focusedApp:allWindows() <= 1 and focusedApp:name() ~= "Finder"  then
        focusedApp:kill()
    elseif focusedWindow then
        focusedWindow:close()
    end
end)

-- Reload Config Shortcut
hs.hotkey.bind({"alt"}, "r", function()
    hs.reload()
end)

-- Notify on successful reload
hs.alert.show("config loaded")

