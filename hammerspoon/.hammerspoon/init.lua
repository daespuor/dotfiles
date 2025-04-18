-- Reload config automatically on changes
function reloadConfig(files)
  hs.reload()
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon config loaded")

-- Modifier groups
local hyper = {"cmd", "alt", "ctrl", "shift"}
local hyperApp = {"cmd", "alt"}
local fullApp = {"cmd", "alt", "ctrl"}

-- Close the focused application
hs.hotkey.bind(hyper, "Q", function()
  local app = hs.application.frontmostApplication()
  if app then app:kill() end
end)

-- Focus window in direction
hs.hotkey.bind(hyper, "H", function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(hyper, "L", function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(hyper, "K", function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(hyper, "J", function() hs.window.focusedWindow():focusWindowSouth() end)

-- Move window to another screen (simulate "swap")
hs.hotkey.bind(hyper, "Y", function()
  local win = hs.window.focusedWindow()
  if win then win:moveOneScreenWest() end
end)

hs.hotkey.bind(hyper, "[", function()
  local win = hs.window.focusedWindow()
  if win then win:moveOneScreenEast() end
end)

-- Set grid size (you can tweak this)
hs.grid.setGrid('6x4')  -- 6 columns, 4 rows
hs.grid.setMargins('5x5') -- space between windows
hs.window.animationDuration = 0 -- instant movement

-- Show the grid
hs.hotkey.bind({"cmd", "alt"}, "G", function()
  hs.grid.show()
end)

-- Toggle fullscreen (non-native and native fullscreen)
hs.hotkey.bind(hyper, "F", function()
  local win = hs.window.focusedWindow()
  if win then win:setFullScreen(not win:isFullScreen()) end
end)


hs.hotkey.bind({"ctrl", "shift"}, "F", function()
  local win = hs.window.focusedWindow()
  if win then win:toggleFullScreen() end
end)


-- Application launchers
local apps = {
  T = "Terminal",
  V = "Visual Studio Code",
  B = "Brave Browser",
  C = "Google Chrome",
  F = "Finder",
  L = "Slack",
  R = "Microsoft Teams",
  N = "Notes",
  A = "Android Studio",
  X = "Xcode",
  I = "IntelliJ Idea",
  Z = "zoom.us"
}

for key, app in pairs(apps) do
  hs.hotkey.bind(hyperApp, key, function() hs.application.launchOrFocus(app) end)
  hs.hotkey.bind(fullApp, key, function() hs.application.launchOrFocus(app) end)
end
