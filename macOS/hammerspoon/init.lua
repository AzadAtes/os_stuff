-- FUNCTIONS ----------------------------------------------------------------------------------

local keepRunningApps = {
    ["Finder"] = true,
    ["OrbStack"] = true,
    ["Microsoft Teams"] = true,
    ["Microsoft Outlook"] = true,
    ["Calendar"] = true,
    ["Mail"] = true,
}

local function closeWinOrQuitApp()
    local frontmostApp = hs.application.frontmostApplication()
    local focusedWindow = hs.window.focusedWindow()

    if frontmostApp
        and #frontmostApp:allWindows() <= 1
        and not keepRunningApps[frontmostApp:name()]
    then
        frontmostApp:kill()
    elseif focusedWindow then
        focusedWindow:close()
    end
end

local function focusCursorWindow(match)
    local app = hs.application.get("Cursor")

    if not app or #app:allWindows() == 0 then
        hs.application.launchOrFocus("Cursor")
        return
    end

    local fallback

    for _, win in ipairs(app:allWindows()) do
        fallback = fallback or win -- focus the first window if no title matches

        if match(win:title() or "") then
            win:focus()
            return
        end
    end

    fallback:focus()
end

local function focusCursor()
    focusCursorWindow(function(title)
        return not title:find("Cursor Agents")
    end)
end

local function focusCursorAgents()
    focusCursorWindow(function(title)
        return title:find("Cursor Agents")
    end)
end


-- BINDINGS -----------------------------------------------------------------------------------

-- Bind Application Shortcuts
hs.hotkey.bind({"shift","alt","ctrl"}, '1', function() hs.application.launchOrFocus("Notion") end)
hs.hotkey.bind({"shift","alt","ctrl"}, '2', function() hs.application.launchOrFocus("Microsoft Teams") end)
hs.hotkey.bind({"shift","alt","ctrl"}, '3', function() hs.application.launchOrFocus("Mail") end)
hs.hotkey.bind({"shift","alt","ctrl"}, '4', function() hs.application.launchOrFocus("Calendar") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'q', function() hs.application.launchOrFocus("Terminal") end)
hs.hotkey.bind({"shift","cmd","ctrl"}, 'w', function() hs.application.launchOrFocus("Firefox") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'e', function() hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 's', function() hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind({"shift","alt","ctrl"}, 'x', function() hs.application.launchOrFocus("Finder") end)

hs.hotkey.bind({"shift","alt","ctrl"}, "d", focusCursor)
hs.hotkey.bind({"shift","alt","ctrl"}, "c", focusCursorAgents)

-- Bind Other Shortcut
hs.hotkey.bind({"cmd"}, "q", closeWinOrQuitApp)
hs.hotkey.bind({"shift", "cmd"}, 'q', function() hs.application.frontmostApplication():kill() end)
hs.hotkey.bind({"shift","alt","ctrl"}, "return", function() hs.reload() end)


-- --------------------------------------------------------------------------------------------

-- Notify on successful reload
hs.alert.show("config loaded")
