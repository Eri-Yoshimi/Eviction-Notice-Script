--[[

	███████╗██████╗ ██╗██║███████╗                                  
	██╔════╝██╔══██╗██║██║██╔════╝                                  
	█████╗  ██████╔╝██║╚═╝███████╗                                  
	██╔══╝  ██╔══██╗██║   ╚════██║                                  
	███████╗██║  ██║██║   ███████║                                  
	╚══════╝╚═╝  ╚═╝╚═╝   ╚══════╝                                  
	                                                             
	███╗   ███╗ ██████╗ ██████╗ ██╗   ██╗██╗      █████╗ ██████╗ 
	████╗ ████║██╔═══██╗██╔══██╗██║   ██║██║     ██╔══██╗██╔══██╗
	██╔████╔██║██║   ██║██║  ██║██║   ██║██║     ███████║██████╔╝
	██║╚██╔╝██║██║   ██║██║  ██║██║   ██║██║     ██╔══██║██╔══██╗
	██║ ╚═╝ ██║╚██████╔╝██████╔╝╚██████╔╝███████╗██║  ██║██║  ██║
	╚═╝     ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
	                                                             
	 ██████╗ ██╗   ██╗██╗                                        
	██╔════╝ ██║   ██║██║                                        
	██║  ███╗██║   ██║██║                                        
	██║   ██║██║   ██║██║                                        
	╚██████╔╝╚██████╔╝██║                                        
	 ╚═════╝  ╚═════╝ ╚═╝                                        

	Thank you for using Eri's Modular Gui!
	
	Scroll down to the next title to start scripting your script!

]]--

-- GUI Creation copied from Infinite Yield, this makes it so it can appear on top of everything, even the roblox menu. --
function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

newGUI = nil
if game:GetService("RunService"):IsStudio() then
	newGUI = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
	newGUI.Name = randomString()
else
	COREGUI = cloneref(game:GetService("CoreGui"))
	if get_hidden_gui or gethui then
		local hiddenUI = get_hidden_gui or gethui
		local Main = Instance.new("ScreenGui")
		Main.Name = randomString()
		Main.Parent = hiddenUI()
		newGUI = Main
	elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
		local Main = Instance.new("ScreenGui")
		Main.Name = randomString()
		syn.protect_gui(Main)
		Main.Parent = COREGUI
		newGUI = Main
	elseif COREGUI:FindFirstChild('RobloxGui') then
		newGUI = COREGUI.RobloxGui
	else
		local Main = Instance.new("ScreenGui")
		Main.Name = randomString()
		Main.Parent = COREGUI
		newGUI = Main
	end
end
newGUI.ResetOnSpawn = false
newGUI.IgnoreGuiInset = true

-- Custom Event Code ------------------------------------------
local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({ _connections = {} }, Signal)
end

function Signal:Connect(callback)
	table.insert(self._connections, callback)
	return {
		Disconnect = function()
			for i, conn in ipairs(self._connections) do
				if conn == callback then
					table.remove(self._connections, i)
					break
				end
			end
		end
	}
end

function Signal:Fire(...)
	for _, callback in ipairs(self._connections) do
		callback(...)
	end
end
---------------------------------------------------------------

local modularInfo = {
	primaryColor = Color3.fromRGB(170, 85, 255),
	secondaryColor = Color3.fromRGB(170, 85, 127),
	backgroundColor = Color3.fromRGB(0, 0, 0),
	textColor = Color3.fromRGB(255, 255, 255),
	font = Enum.Font.Roboto,
	name = "Eviction Notice Script by Eri",
	barY = 30,
	maxPages = 3,
}

local newMainFrame = Instance.new("Frame", newGUI)
newMainFrame.Size =  UDim2.new(0, 500, 0, 300)
newMainFrame.Position = UDim2.new(1, 0, 1, 0)
newMainFrame.AnchorPoint = Vector2.new(1, 1)
newMainFrame.BackgroundColor3 = modularInfo.backgroundColor
newMainFrame.BackgroundTransparency = 0

local topBar =  Instance.new("Frame", newMainFrame)
topBar.Size = UDim2.new(1, 0, 0, modularInfo.barY)
topBar.BackgroundColor3 = modularInfo.primaryColor
topBar.BackgroundTransparency = 0
topBar.BorderSizePixel = 0
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.AnchorPoint = Vector2.new(0, 0)
topBar.AutomaticSize = Enum.AutomaticSize.Y
local topBarUIList = Instance.new("UIListLayout", topBar)
topBarUIList.SortOrder = Enum.SortOrder.LayoutOrder

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size = UDim2.new(1, 0, 0, modularInfo.barY)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextColor3 = modularInfo.textColor
titleLabel.BackgroundTransparency = 1
titleLabel.TextScaled = true
titleLabel.Font = modularInfo.font
titleLabel.Text = modularInfo.name
titleLabel.LayoutOrder = 1
local titlePadding = Instance.new("UIPadding", titleLabel)
titlePadding.PaddingLeft =  UDim.new(0, 5)

local closeMenuButton = Instance.new("TextButton", titleLabel)
closeMenuButton.Size =  UDim2.new(0.1, 0, 0.8, 0)
closeMenuButton.TextColor3 = modularInfo.textColor
closeMenuButton.AnchorPoint = Vector2.new(1, 0.5)
closeMenuButton.Position =  UDim2.new(1, -5, 0.5, 0)
closeMenuButton.BorderSizePixel = 0
closeMenuButton.BackgroundColor3 = modularInfo.backgroundColor
closeMenuButton.TextScaled = true
closeMenuButton.Font = modularInfo.font
closeMenuButton.Text = "X"
closeMenuButton.Activated:Connect(function()
	newGUI:Destroy()
end)

local minimizeMenuButton = Instance.new("TextButton", titleLabel)
local maximizeButton = Instance.new("TextButton", newGUI)

minimizeMenuButton.Size =  UDim2.new(0.1, 0, 0.8, 0)
minimizeMenuButton.TextColor3 = modularInfo.textColor
minimizeMenuButton.AnchorPoint = Vector2.new(1, 0.5)
minimizeMenuButton.Position =  UDim2.new(0.9, -10, 0.5, 0)
minimizeMenuButton.BorderSizePixel = 0
minimizeMenuButton.BackgroundColor3 = modularInfo.backgroundColor
minimizeMenuButton.TextScaled = true
minimizeMenuButton.Font = modularInfo.font
minimizeMenuButton.Text = "-"
minimizeMenuButton.Activated:Connect(function()
	newMainFrame.Visible = false
	maximizeButton.Visible = true
end)

maximizeButton.Size = UDim2.new(0, minimizeMenuButton.AbsoluteSize.X, 0, minimizeMenuButton.AbsoluteSize.Y)
maximizeButton.TextColor3 = modularInfo.textColor
maximizeButton.AnchorPoint = Vector2.new(1, 1)
maximizeButton.Position =  UDim2.new(1, 0, 1, 0)
maximizeButton.BorderSizePixel = 0
maximizeButton.BackgroundColor3 = modularInfo.backgroundColor
maximizeButton.TextScaled = true
maximizeButton.Font = modularInfo.font
maximizeButton.Text = "+"
maximizeButton.Visible = false
maximizeButton.Activated:Connect(function()
	newMainFrame.Visible = true
	maximizeButton.Visible = false
end)

local pageSelector = Instance.new("Frame", topBar)
pageSelector.LayoutOrder = 2
pageSelector.Size =  UDim2.new(1, 0, 0, modularInfo.barY)
pageSelector.BackgroundColor3 = modularInfo.secondaryColor

local leftPageButton = Instance.new("TextButton", pageSelector)
leftPageButton.Size = UDim2.new(0.1, 0, 0.8, 0)
leftPageButton.TextColor3 = modularInfo.textColor
leftPageButton.AnchorPoint = Vector2.new(0, 0.5)
leftPageButton.Position =  UDim2.new(0, 5, 0.5, 0)
leftPageButton.BorderSizePixel = 0
leftPageButton.BackgroundColor3 = modularInfo.backgroundColor
leftPageButton.TextScaled = true
leftPageButton.Font = modularInfo.font
leftPageButton.Text = "<"

local rightPageButton = Instance.new("TextButton", pageSelector)
rightPageButton.Size = UDim2.new(0.1, 0, 0.8, 0)
rightPageButton.TextColor3 = modularInfo.textColor
rightPageButton.AnchorPoint = Vector2.new(1, 0.5)
rightPageButton.Position =  UDim2.new(1, -5, 0.5, 0)
rightPageButton.BorderSizePixel = 0
rightPageButton.BackgroundColor3 = modularInfo.backgroundColor
rightPageButton.TextScaled = true
rightPageButton.Font = modularInfo.font
rightPageButton.Text = ">"

local pageIndicator = Instance.new("TextLabel", pageSelector)
pageIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
pageIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
pageIndicator.BackgroundTransparency = 1
pageIndicator.Size = UDim2.new(0.3, 0, 1, 0)
pageIndicator.TextScaled = true
pageIndicator.TextColor3 = modularInfo.textColor
pageIndicator.Font = modularInfo.font
pageIndicator.Text = "1/1"

local mainContentFrame = Instance.new("Frame", newMainFrame)
mainContentFrame.Size =  UDim2.new(1, 0, 1, -topBar.AbsoluteSize.Y)
mainContentFrame.Position = UDim2.new(0, 0, 1, 0)
mainContentFrame.AnchorPoint = Vector2.new(0, 1)
mainContentFrame.BackgroundTransparency = 1
local mainContentUIList = Instance.new("UIListLayout", mainContentFrame)
mainContentUIList.FillDirection = Enum.FillDirection.Horizontal
mainContentUIList.HorizontalFlex = Enum.UIFlexAlignment.Fill
mainContentUIList.VerticalFlex = Enum.UIFlexAlignment.Fill
mainContentUIList.SortOrder = Enum.SortOrder.LayoutOrder

local createdModules = {}
local currentPage = 1
local modulesPerPage = modularInfo.maxPages

local function updateModuleVisibility()
	local totalPages = math.ceil(#createdModules / modulesPerPage)
	currentPage = math.clamp(currentPage, 1, totalPages)

	for _, module in pairs(createdModules) do
		module.Frame.Visible = false
	end

	local startIndex = (currentPage - 1) * modulesPerPage + 1
	local endIndex = math.min(startIndex + modulesPerPage - 1, #createdModules)

	for i = startIndex, endIndex do
		createdModules[i].Frame.Visible = true
	end

	pageIndicator.Text = tostring(currentPage) .. "/" .. tostring(totalPages)
end

leftPageButton.Activated:Connect(function()
	if currentPage > 1 then
		currentPage = currentPage - 1
		updateModuleVisibility()
	end
end)

rightPageButton.Activated:Connect(function()
	if currentPage < math.ceil(#createdModules / modulesPerPage) then
		currentPage = currentPage + 1
		updateModuleVisibility()
	end
end)

local function createNewModule(title)
	local newModuleFrame = Instance.new("Frame", mainContentFrame)
	newModuleFrame.Name = title
	newModuleFrame.Size = UDim2.new(1, 0, 1, 0)
	newModuleFrame.BackgroundTransparency = 1
	newModuleFrame.AutomaticSize = Enum.AutomaticSize.Y
	newModuleFrame.Visible = false

	local moduleTitle = Instance.new("TextLabel", newModuleFrame)
	moduleTitle.Size = UDim2.new(1, 0, 0, modularInfo.barY)
	moduleTitle.TextColor3 = modularInfo.textColor
	moduleTitle.BackgroundColor3 = modularInfo.primaryColor
	moduleTitle.TextScaled = true
	moduleTitle.Font = modularInfo.font
	moduleTitle.Text = title
	
	local contentBox = Instance.new("Frame", newModuleFrame)
	contentBox.Position = UDim2.new(0, 0, 1, 0)
	contentBox.AnchorPoint = Vector2.new(0, 1)
	contentBox.BackgroundTransparency = 1
	--contentBox.AutomaticCanvasSize = Enum.AutomaticSize.Y
	--contentBox.CanvasSize = UDim2.new(0, 0, 0, 0)
	--contentBox.ScrollBarThickness = 0
	--contentBox.ClipsDescendants = false
	contentBox.Size = UDim2.new(1, 0, 1, -moduleTitle.AbsoluteSize.Y)
	local newContentUIPadding = Instance.new("UIPadding", contentBox)
	local padding = 10
	newContentUIPadding.PaddingTop = UDim.new(0, 0)
	newContentUIPadding.PaddingBottom = UDim.new(0, 0)
	newContentUIPadding.PaddingLeft = UDim.new(0, padding)
	newContentUIPadding.PaddingRight = UDim.new(0, padding)
	local newContentUIList = Instance.new("UIListLayout", contentBox)
	newContentUIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	newContentUIList.VerticalAlignment = Enum.VerticalAlignment.Center
	newContentUIList.Padding = UDim.new(0, padding)
	newContentUIList.SortOrder = Enum.SortOrder.LayoutOrder
	newContentUIList.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly

	local module = {}
	module.Frame = newModuleFrame

	function module:AddText(text)
		local textLabel = Instance.new("TextLabel", contentBox)
		textLabel.Size = UDim2.new(1, 0, 0, modularInfo.barY)
		textLabel.Text = text
		textLabel.TextScaled = true
		textLabel.Font = modularInfo.font
		textLabel.TextColor3 = modularInfo.textColor
		textLabel.BackgroundColor3 = modularInfo.secondaryColor

		return textLabel
	end
	
	function module:AddButton(buttonText)
		local button = Instance.new("TextButton", contentBox)
		button.Size = UDim2.new(1, 0, 0, modularInfo.barY)
		button.Text = buttonText
		button.TextScaled = true
		button.Font = modularInfo.font
		button.TextColor3 = modularInfo.textColor
		button.BackgroundColor3 = modularInfo.secondaryColor

		return button
	end
	
	function module:AddToggle(toggleText)
		local toggleData = { state = false }

		local toggleButton = Instance.new("TextButton", contentBox)
		toggleButton.Size = UDim2.new(1, 0, 0, modularInfo.barY)
		toggleButton.Text = toggleText .. ": OFF"
		toggleButton.TextScaled = true
		toggleButton.Font = modularInfo.font
		toggleButton.TextColor3 = modularInfo.textColor
		toggleButton.BackgroundColor3 = modularInfo.secondaryColor

		toggleButton.MouseButton1Click:Connect(function()
			toggleData.state = not toggleData.state
			toggleButton.Text = toggleText .. (toggleData.state and ": ON" or ": OFF")
		end)

		function toggleData:GetState()
			return self.state
		end

		return toggleButton, toggleData
	end
	
	function module:AddList(listTitle)
		local listContainer = Instance.new("Frame", contentBox)
		listContainer.Size = UDim2.new(1, 0, 0, modularInfo.barY)
		listContainer.AutomaticSize = Enum.AutomaticSize.Y
		listContainer.BackgroundTransparency = 1

		local titleButton = Instance.new("TextButton", listContainer)
		titleButton.Size = UDim2.new(1, 0, 0, modularInfo.barY)
		titleButton.Text = listTitle
		titleButton.TextScaled = true
		titleButton.Font = modularInfo.font
		titleButton.TextColor3 = modularInfo.textColor
		titleButton.BackgroundColor3 = modularInfo.secondaryColor

		local itemListFrame = Instance.new("ScrollingFrame", listContainer)
		itemListFrame.Position = UDim2.new(0, 0, 0, -5)
		itemListFrame.AnchorPoint = Vector2.new(0, 1)
		itemListFrame.Size = UDim2.new(1, 0, 5, 0)
		itemListFrame.BackgroundColor3 = modularInfo.backgroundColor
		itemListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		itemListFrame.ScrollBarThickness = 0
		itemListFrame.Visible = false

		titleButton.Activated:Connect(function()
			itemListFrame.Visible = not itemListFrame.Visible
		end)

		local uiListLayout = Instance.new("UIListLayout", itemListFrame)
		uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout.Padding = UDim.new(0, 5)

		local listObject = {
			Frame = listContainer,
			currentItem = nil,
			Items = {},
			OnItemChanged = Signal.new()
		}

		function listObject:AddListItem(itemText)
			local itemButton = Instance.new("TextButton", itemListFrame)
			itemButton.Size = UDim2.new(1, 0, 0, modularInfo.barY)
			itemButton.Text = itemText
			itemButton.TextScaled = true
			itemButton.Font = modularInfo.font
			itemButton.TextColor3 = modularInfo.textColor
			itemButton.BackgroundColor3 = modularInfo.secondaryColor

			itemButton.Activated:Connect(function()
				listObject.currentItem = itemText
				titleButton.Text = listTitle .. ": " .. itemText
				itemListFrame.Visible = false
				listObject.OnItemChanged:Fire(itemText)
			end)

			table.insert(listObject.Items, itemButton)
			return itemButton
		end
		
		function listObject:RemoveListItem(itemText)
			for i, itemButton in ipairs(listObject.Items) do
				if itemButton.Text == itemText then
					itemButton:Destroy()
					table.remove(listObject.Items, i)
					break
				end
			end
		end

		function listObject:GetCurrentItem()
			return listObject.currentItem
		end

		return listObject
	end

	table.insert(createdModules, module)
	updateModuleVisibility()
	
	return module
end

--[[

	███████╗██████╗ ██╗██║███████╗                                  
	██╔════╝██╔══██╗██║██║██╔════╝                                  
	█████╗  ██████╔╝██║╚═╝███████╗                                  
	██╔══╝  ██╔══██╗██║   ╚════██║                                  
	███████╗██║  ██║██║   ███████║                                  
	╚══════╝╚═╝  ╚═╝╚═╝   ╚══════╝                                  
	                                                             
	███╗   ███╗ ██████╗ ██████╗ ██╗   ██╗██╗      █████╗ ██████╗ 
	████╗ ████║██╔═══██╗██╔══██╗██║   ██║██║     ██╔══██╗██╔══██╗
	██╔████╔██║██║   ██║██║  ██║██║   ██║██║     ███████║██████╔╝
	██║╚██╔╝██║██║   ██║██║  ██║██║   ██║██║     ██╔══██║██╔══██╗
	██║ ╚═╝ ██║╚██████╔╝██████╔╝╚██████╔╝███████╗██║  ██║██║  ██║
	╚═╝     ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
	                                                             
	 ██████╗ ██╗   ██╗██╗                                        
	██╔════╝ ██║   ██║██║                                        
	██║  ███╗██║   ██║██║                                        
	██║   ██║██║   ██║██║                                        
	╚██████╔╝╚██████╔╝██║                                        
	 ╚═════╝  ╚═════╝ ╚═╝                                        

	Thank you for using Eri's Modular Gui!

]]--

--[[
-- Premade Variables
local players = game:GetService("Players")
local plr = players.LocalPlayer
]]--

local players = game:GetService("Players")
local plr = players.LocalPlayer

local function teleportTo(where)
	if where:IsA("BasePart") then
		plr.Character:PivotTo(where.CFrame)
	elseif where:IsA("Model") then
		plr.Character:PivotTo(where:GetBoundingBox())
	elseif where:IsA("CFrame") then
		plr.Character:PivotTo(where)
	end
end

local competitionFolder = workspace:FindFirstChild("Competition")

local generalModule = createNewModule("General")
local freezePlayer, frozenState = generalModule:AddToggle("Freeze Player")
freezePlayer.Activated:Connect(function()
	plr.Character:WaitForChild("HumanoidRootPart").Anchored = frozenState:GetState()
end)
local speedBoost, boostingSpeed = generalModule:AddToggle("Speed boost")
speedBoost.Activated:Connect(function()
	plr.Character:WaitForChild("Humanoid").WalkSpeed = boostingSpeed:GetState() and 50 or 16
end)
local TPtoSafety = generalModule:AddButton("Teleport To Safety")
TPtoSafety.Activated:Connect(function()
	teleportTo(competitionFolder:WaitForChild("Map"):WaitForChild("Bench"))
end)

local powerOutageModule = createNewModule("Power Outage")
local getItemInsta = powerOutageModule:AddButton("Get Item")
getItemInsta.Activated:Connect(function()
	teleportTo(competitionFolder:WaitForChild("Map"):WaitForChild("SpawnedItems"):GetChildren()[2])
end)

local straightShootersModule = createNewModule("Straight Shooters")
local instaWin = straightShootersModule:AddButton("Insta win")
instaWin.Activated:Connect(function()
	for i = 1, 3 do
		for _, p in ipairs(players:GetPlayers()) do
			if p ~= plr and p.Character and p.Character:FindFirstChild("Head") then
				game.ReplicatedStorage.Comps.Health:FireServer(p.Character.Health)
			end
		end
	end
end)

local bakeOffModule = createNewModule("Bake Off")
local recordIngredientsShown = bakeOffModule:AddButton("Record Ingredients")
recordIngredientsShown.Activated:Connect(function()
	for _, i in competitionFolder:WaitForChild("Map"):WaitForChild("Picture"):WaitForChild("SurfaceGui"):GetChildren() do
		i.Changed:Connect(function(property)
			if property == "Visible" and i.Visible == true then
				print(i.Name)
			end
		end)
	end
end)

local memorabiliaModule = createNewModule("Memorabilia")
local recordShapesShown = memorabiliaModule:AddButton("Record Shapes")
recordIngredientsShown.Activated:Connect(function()
	for _, i in competitionFolder:WaitForChild("Map"):WaitForChild("Picture"):GetChildren() do
		i.Changed:Connect(function(property)
			if i.Transparency < 0.99 then
				print(i.Name)
			end
		end)
	end
end)

local tileTrekkerModule = createNewModule("Tile Trekker")
local touchAllTiles = tileTrekkerModule:AddButton("Touch All Tiles")
touchAllTiles.Activated:Connect(function()
	for _,v in ipairs(competitionFolder:WaitForChild("Map"):WaitForChild("Tiles"):GetChildren()) do
		teleportTo(v)
		task.wait()
	end
end)

local flowerGameModule = createNewModule("April Showers")
local loopTPtoCloud, loopTPing = flowerGameModule:AddToggle("Loop TP to cloud")
loopTPtoCloud.Activated:Connect(function()
	task.spawn(function()
		while loopTPing:GetState() do
			if not loopTPing:GetState() then break end
			teleportTo(competitionFolder:WaitForChild("Map"):WaitForChild("Cloud"):WaitForChild("Disc"))
			wait()
		end
	end)
end)

local obbyModule = createNewModule("Cents of Balance")
local teleportToStart = obbyModule:AddButton("Teleport To Start")
teleportToStart.Activated:Connect(function()
	teleportTo(competitionFolder:WaitForChild("Map"):WaitForChild("Touch"))
end)

local buzzInModule = createNewModule("Buzz In")
local recordObjects = buzzInModule:AddButton("Get Most Objects")
recordObjects.Activated:Connect(function()
	local count = {}

	for _,v in competitionFolder:WaitForChild("Map"):WaitForChild("Misc"):GetChildren() do
		if not count[v.Name] then
			count[v.Name] = 0
		end

		count[v.Name] = count[v.Name] + 1
	end
	
	local highest = ""
	local highesti = 0

	for n, count in pairs(count) do
		if count > highesti then
			highesti = count
			highest = n
		end
	end
	
	print(highest)
end)
local removeDoors = buzzInModule:AddButton("Remove Doors")
removeDoors.Activated:Connect(function()
	competitionFolder:WaitForChild("Map"):WaitForChild("Door1"):Destroy()
	competitionFolder:WaitForChild("Map"):WaitForChild("Door2"):Destroy()
end)

local clubbingModule =  createNewModule("Clubbing")
local removeAllWalls = clubbingModule:AddButton("Remove Walls")
removeAllWalls.Activated:Connect(function()
	competitionFolder:WaitForChild("Map"):WaitForChild("Walls"):ClearAllChildren()
end)
