-- [SCRIPT NAME] GUI by Eli Sterken
-- Please report any bugs to eli.sterken@outlook.com
-- Have fun!

local themes = {
    DarkTheme = {
        SchemeColor = Color3.fromRGB(64, 64, 64),
        Background = Color3.fromRGB(0, 0, 0),
        Header = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(150, 150, 150),
        Background = Color3.fromRGB(255,255,255),
        Header = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.fromRGB(0,0,0),
        ElementColor = Color3.fromRGB(224, 224, 224)
    },
    BloodTheme = {
        SchemeColor = Color3.fromRGB(227, 27, 27),
        Background = Color3.fromRGB(10, 10, 10),
        Header = Color3.fromRGB(5, 5, 5),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    GrapeTheme = {
        SchemeColor = Color3.fromRGB(166, 71, 214),
        Background = Color3.fromRGB(64, 50, 71),
        Header = Color3.fromRGB(36, 28, 41),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(74, 58, 84)
    },
    Ocean = {
        SchemeColor = Color3.fromRGB(86, 76, 251),
        Background = Color3.fromRGB(26, 32, 58),
        Header = Color3.fromRGB(38, 45, 71),
        TextColor = Color3.fromRGB(200, 200, 200),
        ElementColor = Color3.fromRGB(38, 45, 71)
    },
    Midnight = {
        SchemeColor = Color3.fromRGB(26, 189, 158),
        Background = Color3.fromRGB(44, 62, 82),
        Header = Color3.fromRGB(57, 81, 105),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(52, 74, 95)
    },
    Sentinel = {
        SchemeColor = Color3.fromRGB(230, 35, 69),
        Background = Color3.fromRGB(32, 32, 32),
        Header = Color3.fromRGB(24, 24, 24),
        TextColor = Color3.fromRGB(119, 209, 138),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Synapse = {
        SchemeColor = Color3.fromRGB(46, 48, 43),
        Background = Color3.fromRGB(13, 15, 12),
        Header = Color3.fromRGB(36, 38, 35),
        TextColor = Color3.fromRGB(152, 99, 53),
        ElementColor = Color3.fromRGB(24, 24, 24)
    },
    Serpent = {
        SchemeColor = Color3.fromRGB(0, 166, 58),
        Background = Color3.fromRGB(31, 41, 43),
        Header = Color3.fromRGB(22, 29, 31),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(22, 29, 31)
    }
}
local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua'))()
local win = lib.CreateLib("[SCRIPT NAME] GUI", themes.Serpent)
local infoTab = win:NewTab("Info")
local settingsTab = win:NewTab("Settings")
local info = infoTab:NewSection("Script Information")
local settings = settingsTab:NewSection("Script Settings")

-- Load info tab

info:NewLabel("[SCRIPT NAME] GUI by Eli Sterken")
info:NewLabel("Please report any bugs to eli.sterken@outlook.com")
info:NewLabel("Please use on an alt account due to ban risk")
info:NewLabel("If script is not working please close GUI and rerun")
info:NewLabel("Have fun!")

-- Load settings tab

settings:NewKeybind("UI Toggle Key", "The key code to toggle the GUI", Enum.KeyCode.F, function()
    lib:ToggleUI() 
end)

settings:NewDropdown("Theme", "The GUI theme.", {'LightTheme', 'DarkTheme', 'GrapeTheme', 'BloodTheme', 'Ocean', 'Midnight', 'Sentinel', 'Synapse', 'Serpent'}, function(option)
    for name,value in pairs(themes[option]) do 
        lib:ChangeColor(name, value)
    end
end)

for index,value in pairs({'SchemeColor', 'Background', 'Header', 'TextColor', 'ElementColor'}) do 
    settings:NewColorPicker(value, 'Change the GUI ' .. value .. '.', Color3.fromRGB(0, 255, 0), function(color)
        lib:ChangeColor(value, color)
    end)
end