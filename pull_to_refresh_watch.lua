-- pull_to_refresh_watch.lua
-- Paste into ~/.hammerspoon/init.lua
-- Grant Hammerspoon Accessibility permission:
--   System Settings -> Privacy & Security -> Accessibility
-- (Screen Recording permission is no longer needed — change detection
--  now reads text via the Accessibility API instead of screenshots.)

----------------------------------------------------------------------
-- EDIT THIS
----------------------------------------------------------------------
local APP_NAME = "Flovi"
local REFRESH_INTERVAL_SECONDS = 3
local SETTLE_WAIT_SECONDS = 1.3 -- time for spinner/animation to finish before snapshotting

-- true  = stop watching automatically the moment a change is detected
-- false = keep refreshing forever, just notify each time something changes
local stopOnChange = true

----------------------------------------------------------------------
-- Refresh via "Touch Alternatives": double-tap Down arrow
----------------------------------------------------------------------
local function pullToRefresh()
    hs.eventtap.keyStroke({}, "down", 0)
    hs.timer.usleep(80000) -- 80ms between taps, tune if it doesn't register
    hs.eventtap.keyStroke({}, "down", 0)
end

----------------------------------------------------------------------
-- Read all visible text from Flovi's window via the Accessibility API
-- instead of screenshotting — immune to rendering/anti-aliasing noise,
-- only changes when actual content changes.
----------------------------------------------------------------------
local ax = require("hs.axuielement")

local function collectText(element, out, depth)
    depth = depth or 0
    if depth > 25 or not element then return end -- safety guard vs deep/cyclic trees

    for _, attr in ipairs({"AXValue", "AXTitle", "AXDescription"}) do
        local ok, val = pcall(function() return element:attributeValue(attr) end)
        if ok and type(val) == "string" and val ~= "" then
            table.insert(out, val)
        end
    end

    local ok, children = pcall(function() return element:attributeValue("AXChildren") end)
    if ok and children then
        for _, child in ipairs(children) do
            collectText(child, out, depth + 1)
        end
    end
end

local function captureWatchRegion()
    local app = hs.application.find(APP_NAME)
    if not app then return nil end
    local win = app:mainWindow()
    if not win then return nil end
    local axWin = ax.windowElement(win)
    if not axWin then return nil end
    local out = {}
    collectText(axWin, out)
    if #out == 0 then return nil end
    return table.concat(out, "|")
end

----------------------------------------------------------------------
-- Watch session state
----------------------------------------------------------------------
local watchTimer = nil
local lastSnapshot = nil

local function stopWatch(reason)
    if watchTimer then
        watchTimer:stop()
        watchTimer = nil
        print("Stopped watching: " .. (reason or ""))
    end
end

local function tick()
    local app = hs.application.find(APP_NAME)
    if not app then
        print("App not running: " .. APP_NAME)
        return
    end
    app:activate()
    hs.timer.doAfter(0.15, function()
        pullToRefresh()
        -- wait for any loading spinner / refresh animation to fully
        -- finish before snapshotting, so we don't compare against a
        -- mid-animation frame
        hs.timer.doAfter(SETTLE_WAIT_SECONDS, function()
            local snap = captureWatchRegion()
            if snap and lastSnapshot and snap ~= lastSnapshot then
                hs.alert.show("Change detected!", 3)
                hs.sound.getByName("Glass"):play()
                hs.notify.new({title="App watcher", informativeText="Something changed — check the app"}):send()
                if stopOnChange then
                    stopWatch("change detected")
                    return
                end
                -- forever mode: treat this new state as the baseline so we
                -- only notify again on the NEXT change, not every tick
            end
            lastSnapshot = snap or lastSnapshot
        end)
    end)
end

local function startWatch()
    if watchTimer then
        hs.alert.show("Already watching")
        return
    end
    lastSnapshot = nil -- baseline gets set after the first refresh settles, not before
    watchTimer = hs.timer.doEvery(REFRESH_INTERVAL_SECONDS, tick)
    local mode = stopOnChange and "stops on change" or "runs forever"
    hs.alert.show("Watching started (every " .. REFRESH_INTERVAL_SECONDS .. "s, " .. mode .. ")")
end

----------------------------------------------------------------------
-- Hotkeys: cmd+alt+R to start, cmd+alt+S to stop manually,
-- cmd+alt+F to toggle "stop on change" vs "run forever" mode
----------------------------------------------------------------------
hs.hotkey.bind({"cmd", "alt"}, "R", startWatch)
hs.hotkey.bind({"cmd", "alt"}, "S", function() stopWatch("manual stop") end)
hs.hotkey.bind({"cmd", "alt"}, "F", function()
    stopOnChange = not stopOnChange
    hs.alert.show(stopOnChange and "Mode: stop on change" or "Mode: run forever (notify only)")
end)
