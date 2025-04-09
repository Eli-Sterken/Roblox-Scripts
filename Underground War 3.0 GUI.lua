-- Underground War 3.0 GUI by Eli Sterken
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
local win = lib.CreateLib("Underground War 3.0 GUI", themes['Serpent'])
local infoTab = win:NewTab("Info")
local weaponsTab = win:NewTab("Weapons")
local mapTab = win:NewTab("Map")
local teleportsTab = win:NewTab("Teleports")
local playerTab = win:NewTab("Player")
local otherTab = win:NewTab("Other")
local settingsTab = win:NewTab("Settings")
local info = infoTab:NewSection("Script Information")
local weapons = weaponsTab:NewSection("Weapons Options")
local map = mapTab:NewSection("Map Settings")
local teleports = teleportsTab:NewSection("Avalible Teleports")
local player = playerTab:NewSection("Player Options")
local other = otherTab:NewSection("Other Things")
local settings = settingsTab:NewSection("Script Settings")
local loopCaptureTeam = ""
local loopCapture = false

-- Local functions

local function Notify(text) -- Sends a notifacation
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "The Underground War 3.0 GUI", Text = text})   
end

local function ReturnState(state) -- Returns a user friendly interpritation of a bool
    if state then
        return "on"
    else 
        return "off"
    end
end

local function Teleport(position) -- Teleports a player to a Vector3 position
    game.Players.LocalPlayer.Character:MoveTo(position)
end

-- Load info section

info:NewLabel("Underground War 3.0 GUI by Eli Sterken")
info:NewLabel("Please use on an alt account due to ban risk")
info:NewLabel("Please report any bugs to eli.sterken@outlook.com")
info:NewLabel("Have fun!")

-- Load weapons section

weapons:NewButton("Get Rocket Launcher", "Gives you the rocket launcher", function()
    game.Players.LocalPlayer:SetAttribute("DONE", true)
    game.Players.LocalPlayer.PlayerGui.MainGui.MainInventoryFrame.InventoryHolder.RocketLauncher.ToolName:Destroy()
    Notify("You can now use the rocket launcher!")
end)

weapons:NewButton("Upgrade Gun", "Upgrades your gun to max level", function()
    game.Players.LocalPlayer.UpgradeValues.SniperReloadingSpeed.Value = 5000
    Notify("Gun successfully set to max level!")
end)

weapons:NewButton("Upgrade Sword", "Upgrades your sword to max level", function()
    game.Players.LocalPlayer.UpgradeValues.SwordDamage.Value = 5000
    Notify("Sword successfully set to max level!")
end)

weapons:NewButton("Upgrade Shovel", "Upgrades your shovel to max level", function()
    game.Players.LocalPlayer.UpgradeValues.ShovelSpeed.Value = 5000
    Notify("Shovel successfully set to max level!")
end)

-- Load map section

map:NewButton("Remove Dirt", "Removes all dirt from underground", function()
    game.Workspace.dirts:Destroy() 
    Notify("Successfully removed dirt")
end)

map:NewButton("Remove Wall", "Removes the wall seperating the teams", function()
    for index,value in pairs(game.Workspace:GetChildren()) do
        if value:FindFirstChild('IGNORE') then
            value:Destroy()
        end
    end
    Notify("Successfully removed wall!")
end)

map:NewToggle("Toggle Towers", "Toggles on or off the towers.", function(state)
    for index,value in pairs(game.Workspace:GetChildren()) do
        if value.Name == 'tower' then 
            for index,value in pairs(value:GetChildren()) do
                if state then
                    value.CanCollide = true
                    value.Transparency = 0
                else
                    value.CanCollide = false 
                    value.Transparency = 1
                end
            end
        end
    end
    Notify("Successfully toggled towers to " .. ReturnState(state) .. "!")
end)

map:NewButton("Remove Sword Adds", "Removes the adds for swords near spawns", function()
    game.Workspace.GlowingStands:Destroy()
    game.Workspace.Stands:Destroy()
    Notify("Successfully removes sword adds!")
end)

map:NewToggle("Toggle Leaderboards", "Toggles on or off the leaderboards", function(state)
    for index,value in pairs(game.Workspace:GetChildren()) do
        if value.Name == 'Leaderboard' then
            if state then
                value.MainPart.CanCollide = true
                value.MainPart.Transparency = 0
                value.MeshPart.CanCollide = true 
                value.MeshPart.Transparency = 0
                value.MainPart.SurfaceGui.Enabled = true
            else 
                value.MainPart.CanCollide = false
                value.MainPart.Transparency = 1
                value.MeshPart.CanCollide = false 
                value.MeshPart.Transparency = 1
                value.MainPart.SurfaceGui.Enabled = false
            end
        end
    end
    Notify("Successfully toggled leaderboards to " .. ReturnState(state) .. "!")
end)

map:NewToggle("Toggle Tress", "Toggles on or off the trees", function(state)
    for index,value in pairs(game.Workspace:GetChildren()) do
        if value:FindFirstChild('Meshes/Trees_LOWPOLY_Plane') then
            if state then
                value['Meshes/Trees_LOWPOLY_Plane'].CanCollide = true 
                value['Meshes/Trees_LOWPOLY_Plane'].Transparency = 0
                value['Meshes/Trees_LOWPOLY_Plane']['Meshes/Trees_LOWPOLY_Icosphere.002'].CanCollide = true
                value['Meshes/Trees_LOWPOLY_Plane']['Meshes/Trees_LOWPOLY_Icosphere.002'].Transparency = 0
            else 
                value['Meshes/Trees_LOWPOLY_Plane'].CanCollide = false 
                value['Meshes/Trees_LOWPOLY_Plane'].Transparency = 1
                value['Meshes/Trees_LOWPOLY_Plane']['Meshes/Trees_LOWPOLY_Icosphere.002'].CanCollide = false 
                value['Meshes/Trees_LOWPOLY_Plane']['Meshes/Trees_LOWPOLY_Icosphere.002'].Transparency = 1
            end 
        end
    end
    Notify("Successfully toggled trees to " .. ReturnState(state) .. "!")
end)

-- Load teleports section

teleports:NewButton("Red Spawn", "Teleports you to a red team spawn.", function()
    for index,value in pairs(game.Workspace:GetChildren()) do 
        if value.Name == 'SpawnLocation' and value.BrickColor == BrickColor.new('Bright red') then 
            Teleport(value.Position)
        end
    end
    Notify("Successfully teleported to a red team spawn")
end)

teleports:NewButton("Blue Spawn", "Teleports you to a blue team spawn.", function()
    for index,value in pairs(game.Workspace:GetChildren()) do 
        if value.Name == 'SpawnLocation' and value.BrickColor == BrickColor.new('Bright blue') then 
            Teleport(value.Position)
        end
    end
    Notify("Successfully teleported to a blue team spawn")
end)

teleports:NewButton("Red Tower", "Teleports you to a red team tower.", function()
    for index,value in pairs(game.Workspace:GetChildren()) do 
        if value.Name == 'tower' and value['Smooth Block Model'].BrickColor == BrickColor.new('Bright red') then
            Teleport(value['Smooth Block Model'].Position)
        end
    end
    Notify("Successfully teleported to a red team tower!")
end)

teleports:NewButton("Blue Tower", "Teleports you to a blue team tower.", function()
    for index,value in pairs(game.Workspace:GetChildren()) do 
        if value.Name == 'tower' and value['Smooth Block Model'].BrickColor == BrickColor.new('Electric blue') then
            Teleport(value['Smooth Block Model'].Position)
        end
    end
    Notify("Successfully teleported to a blue team tower!")
end)

teleports:NewButton("Underground", "Teleports you underground.", function()
    Teleport(game.Workspace.Base.Position)
    Notify("Successfully teleported underground!")
end)

teleports:NewButton("Red Flag", "Teleports you to the red team flag.", function()
    Teleport(game.Workspace.RedFlagStand.Stand.Position)
    Notify("Successfully teleported to read teams flag!")
end)

teleports:NewButton("Blue Flag", "Teleports you to the blue team flag.", function()
    Teleport(game.Workspace.BlueFlagStand.Stand.Position)
    Notify("Successfully teleported to blue teams flag!")
end)

teleports:NewButton("Steel Red Flag", "Makes you steel the red teams flag.", function()
    local currentPos = game.Players.LocalPlayer.Character.Humanoid.RootPart.Position
    Teleport(game.Workspace.RedFlagStand.Stand.Position)
    task.wait(0.1)
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    task.wait(1)
    Teleport(currentPos)
    Notify("Successfully stole red teams flag!")
end)

teleports:NewButton("Steel Blue Flag", "Makes you steel the blue teams flag.", function()
    local currentPos = game.Players.LocalPlayer.Character.Humanoid.RootPart.Position
    Teleport(game.Workspace.BlueFlagStand.Stand.Position)
    task.wait(0.1)
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    task.wait(1)
    Teleport(currentPos)
    Notify("Successfully stole blue teams flag!")
end)

teleports:NewButton("Capture Red Flag", "Makes you capture the red teams flag.", function()
    local currentPos = game.Players.LocalPlayer.Character.Humanoid.RootPart.Position
    Teleport(game.Workspace.RedFlagStand.Stand.Position)
    task.wait(0.1)
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    task.wait(1)
    Teleport(game.Workspace.BlueFlagStand.Stand.Position)
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    task.wait(1)
    Teleport(currentPos)
    Notify("Successfully captured red teams flag!")
end)

teleports:NewButton("Capture Blue Flag", "Makes you capture the blue teams flag.", function()
    local currentPos = game.Players.LocalPlayer.Character.Humanoid.RootPart.Position
    Teleport(game.Workspace.BlueFlagStand.Stand.Position)
    task.wait(0.1)
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    task.wait(1)
    Teleport(game.Workspace.RedFlagStand.Stand.Position)
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    task.wait(1)
    Teleport(currentPos)
    Notify("Successfully captured blue teams flag!")
end)

teleports:NewToggle("Loop Capture Red", "Repedadly capture red teams flag.", function(state)
    loopCaptureTeam = "Red"
    loopCapture = state 
    Notify("Successfully set loop capture for red team to " .. ReturnState(state) .. "!")
end)

teleports:NewToggle("Loop Capture Blue", "Repedadly capture blue teams flag.", function(state)
    loopCaptureTeam = "Blue"
    loopCapture = state 
    Notify("Successfully set loop capture for blue team to " .. ReturnState(state) .. "!")
end)

teleports:NewButton("Safe Place To Work", "Teleports you to a safe place where you can't get killed.", function()
    for index,value in pairs(game.Workspace:GetChildren()) do 
        if value.Name == 'SpawnLocation' and value.BrickColor == BrickColor.new('Medium stone grey') then 
            Teleport(value.Position)
        end
    end
    Notify("Successfully teleported to safe place!")
end)

-- Load player section

player:NewSlider("Speed", "Sets your players speed.", 1000, 0, function(speed)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed 
end)

player:NewSlider("Jump Power", "Sets your players jump power.", 1000, 0, function(jump)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jump
end)

player:NewButton("Fly", "Tells you how to fly.", function()
    Notify("You now have flight! Press E to toggle.")
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Eli-Sterken/Roblox-Scripts/refs/heads/main/Extras/fly.lua'))()
end)

player:NewButton("Freecam", "Tells you how to activate freecam.", function()
    Notify("You now have freecam! Press Shift+P to toggle.")
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Eli-Sterken/Roblox-Scripts/refs/heads/main/Extras/freecam.lua'))()
end)

player:NewButton("Switch To Red", "Switches you to the red team.", function()
    game.ReplicatedStorage.remotefunctions.Team:InvokeServer('setTeam', 'TeamRed')
    Notify("Successfully switched to red team!")
end)

player:NewButton("Switch To Blue", "Switches you to the blue team.", function()
    game.ReplicatedStorage.remotefunctions.Team:InvokeServer('setTeam', 'TeamBlue')
    Notify("Successfully switched to blue team!")
end)

-- Load other section

other:NewButton("Dex Explorer", "Allows you to see and modify parts of the game", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
    Notify("Successfully loaded Dex Explorer!")
end)

-- Load settings section

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

while true do -- Loop for required tasks
    if loopCapture then 
        local currentPos = game.Players.LocalPlayer.Character.Humanoid.RootPart.Position
        local opTeam = ''

        if loopCaptureTeam == "Red" then
            opTeam = 'Blue'
        else 
            opTeam = 'Red'
        end

        Teleport(game.Workspace[loopCaptureTeam .. 'FlagStand'].Stand.Position)
        task.wait(0.1)
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        task.wait(1)
        Teleport(game.Workspace[opTeam .. "FlagStand"].Stand.Position)
        task.wait(0.1)
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        task.wait(1)
        Teleport(currentPos)
        task.wait(0.1)
    end
    task.wait(0.1)
end
