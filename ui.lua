--// Load Wabi-Sabi UI library
loadstring(game:HttpGet("https://scripts.wabisabi.mom/wabi-sabi-ui-lib.lua"))()

--// Create the main window
local Library = WabiSabi
local Window = Library:CreateWindow({
    Title = "My Menu",
    SubTitle = "v1.0",
    Size = Vector2.new(580, 460),
    Resize = true,
})

--// Tabs
local MainTab = Window:AddTab({ Title = "Main", Icon = "house" })
local AutofarmTab = Window:AddTab({ Title = "Autofarm", Icon = "robot" })

--// Export all UI controls
local UI = {
    Toggles = {},
    Sliders = {},
    -- add more as needed (Dropdowns, Buttons, etc.)
}

--// Main Tab Controls
UI.Toggles.auto_save = MainTab:AddToggle({
    Id = "auto_save",
    Title = "Auto save",
    Default = true,
    Callback = function(value)
        print("auto save", value)
    end
})

UI.Sliders.volume = MainTab:AddSlider({
    Id = "volume",
    Title = "Volume",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("volume", value)
    end
})

--// Autofarm Tab Controls
UI.Toggles.autofarm = AutofarmTab:AddToggle({
    Id = "autofarm_toggle",
    Title = "Autofarm (Teleport + Fire Remote)",
    Default = false,
    Callback = function(value)
        -- The actual logic will be handled in main.lua
        -- We will override the callback later.
    end
})

--// Notify that the UI is ready
Library:Notify({
    Title = "Loaded",
    Content = "Menu ready.",
    Duration = 4
})

-- Return the UI table for external use
return UI
