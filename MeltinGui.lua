local module = {
	Version = "1.0"
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ANIMATIONS_SPEED = 0.5
local ANIMATIONS_SPEED_SHORT = ANIMATIONS_SPEED/2
local DEFAULT_FONT = Enum.Font.Roboto
local DEFAULT_TEXT_SIZE = 16

local DEFAULT_COLORS = {
	TOPBAR = Color3.new(0.180392, 0.203922, 0.231373),
	BACKGROUND_LIGHT = Color3.new(0.184314, 0.203922, 0.231373),
	BACKGROUND = Color3.new(0.137255, 0.152941, 0.172549),
	BORDER = Color3.new(0.215686, 0.227451, 0.243137),
	BORDER_SPECIAL = Color3.new(0, 0.75, 0.75),

	FOREGROUND_LIGHT = Color3.new(0.298039, 0.309804, 0.321569),
	FOREGROUND = Color3.new(0.219608, 0.235294, 0.25098),
	TEXT = Color3.new(1, 1, 1)
}

local DefaultTweenInfo = TweenInfo.new(ANIMATIONS_SPEED)
local function CreateAnimation(object, propertyTable, tweenInfo)
	return TweenService:Create(
		object,
		tweenInfo or DefaultTweenInfo,
		propertyTable
	)
end

local Templates = {}

do
	local contentPane = Instance.new("ScrollingFrame")
	contentPane.Size = UDim2.new(0.6, 0, 1, 0)
	contentPane.Position = UDim2.new(0.4, 0, 0, 0)
	contentPane.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND_LIGHT
	contentPane.BorderColor3 = DEFAULT_COLORS.BORDER
	contentPane.BorderSizePixel = 1
	contentPane.CanvasSize = UDim2.new()
	contentPane.ScrollBarImageColor3 = Color3.new(1, 1, 1)
	contentPane.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	local pad = Instance.new("UIPadding", contentPane)
	pad.PaddingTop = UDim.new(0, 3)
	pad.PaddingRight = UDim.new(0, 3)
	pad.PaddingBottom = UDim.new(0, 3)

	Templates.ContentPane = contentPane
end

do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 30)
	button.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND
	button.BorderColor3 = DEFAULT_COLORS.BORDER
	button.BorderSizePixel = 1
	button.BorderMode = Enum.BorderMode.Inset
	button.TextColor3 = DEFAULT_COLORS.TEXT
	button.Font = DEFAULT_FONT
	button.TextSize = DEFAULT_TEXT_SIZE
	button.TextTruncate = Enum.TextTruncate.AtEnd
	Templates.Button = button
end

do
	local label = Instance.new("TextLabel")
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, 0, 0, 30)
	label.Font = DEFAULT_FONT
	label.TextSize = DEFAULT_TEXT_SIZE
	label.Name = "Label"
	label.TextTruncate = Enum.TextTruncate.AtEnd
	Templates.Label = label
end

do
	local textBox = Instance.new("TextBox")
	textBox.TextColor3 = Color3.new(1, 1, 1)
	textBox.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND
	textBox.BorderColor3 = DEFAULT_COLORS.BORDER
	textBox.BackgroundTransparency = 0
	textBox.Size = UDim2.new(1, 0, 0, 30)
	textBox.Font = DEFAULT_FONT
	textBox.TextSize = DEFAULT_TEXT_SIZE
	textBox.Name = "TextBox"
	textBox.Text = ""
	Templates.TextBox = textBox
end

do
	local checkBox = Instance.new("Frame")
	checkBox.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND
	checkBox.BorderColor3 = DEFAULT_COLORS.BORDER
	checkBox.Size = UDim2.new(1, 0, 0, 30)
	checkBox.Name = "CheckBox"

	local squareButton = Templates.Button:Clone()
	squareButton.Size = UDim2.new(0, 20, 0, 20)
	squareButton.Name = "CheckButton"
	squareButton.Text = ""
	squareButton.AutoButtonColor = false
	squareButton.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND
	squareButton.BorderColor3 = Color3.new(1, 1, 1)
	squareButton.BorderSizePixel = 2
	squareButton.Position = UDim2.new(0, 5, 0, 5)
	squareButton.Parent = checkBox

	local squareFrame = Instance.new("Frame", squareButton)
	squareFrame.Name = "CheckedFrame"
	squareFrame.BackgroundColor3 = Color3.new(1, 1, 1)
	squareFrame.Position = UDim2.fromOffset(3, 3)
	squareFrame.Size = UDim2.fromOffset(10, 10)
	squareFrame.BackgroundTransparency = 1
	squareFrame.BorderSizePixel = 0
	squareFrame.Visible = false
	squareFrame.Parent = squareButton

	local label = Templates.Label:Clone()
	label.Size = UDim2.new(1, -30, 1, 0)
	label.Position = UDim2.new(0, 30, 0, 0)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = checkBox

	Templates.Checkbox = checkBox
end

do
	local slider = Instance.new("Frame")
	slider.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND
	slider.BorderColor3 = DEFAULT_COLORS.BORDER
	slider.Size = UDim2.new(1, 0, 0, 50)
	slider.Name = "Slider"

	Templates.Label:Clone().Parent = slider

	local sliderBackground = Instance.new("Frame", slider)
	sliderBackground.Name = "SliderBackground"
	sliderBackground.BackgroundColor3 = DEFAULT_COLORS.FOREGROUND
	sliderBackground.BorderColor3 = DEFAULT_COLORS.BORDER
	sliderBackground.BorderSizePixel = 0
	sliderBackground.Size = UDim2.new(1, -10, 0, 10)
	sliderBackground.Position = UDim2.new(0, 5, 1, -15)
	sliderBackground.Active = true

	local sliderForeground = Instance.new("Frame", sliderBackground)
	sliderForeground.Name = "SliderForeground"
	sliderForeground.Size = UDim2.fromScale(0, 1)
	sliderForeground.Position = UDim2.new()
	sliderForeground.BorderSizePixel = 0
	sliderForeground.BackgroundColor3 = Color3.new(1, 1, 1)
	sliderForeground.Active = true

	local sliderGrab = Instance.new("TextButton", sliderForeground)
	sliderGrab.BorderSizePixel = 0
	sliderGrab.BackgroundColor3 = Color3.new(1, 1, 1)
	sliderGrab.Text = ""
	sliderGrab.Name = "SliderGrab"
	sliderGrab.Size = UDim2.fromOffset(12, 12)
	sliderGrab.Position = UDim2.new(1, -6, 0.5, -6)

	Templates.Slider = slider
end

do
	local dropdown = Instance.new("Frame")
	dropdown.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND
	dropdown.BorderColor3 = DEFAULT_COLORS.BORDER
	dropdown.Size = UDim2.new(1, 0, 0, 60)
	dropdown.Name = "Dropdown"

	local dropdownLabel = Templates.Label:Clone()
	dropdownLabel.Parent = dropdown
	dropdownLabel.Size = UDim2.new(1, 0, 0, 25)

	local dropdownChoice = Templates.Button:Clone()
	dropdownChoice.Name = "DropdownChoice"
	dropdownChoice.Size = UDim2.new(1, -10, 0, 30)
	dropdownChoice.Position = UDim2.fromOffset(5, 25)
	dropdownChoice.Parent = dropdown

	local dropdownList = Instance.new("ScrollingFrame", dropdown)
	dropdownList.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND_LIGHT
	dropdownList.BorderColor3 = DEFAULT_COLORS.BORDER
	dropdownList.CanvasSize = UDim2.new()
	dropdownList.Size = UDim2.new(1, -10, 0, 0)
	dropdownList.Position = UDim2.fromOffset(5, 60)
	dropdownList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	dropdownList.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	dropdownList.ZIndex = 10
	dropdownList.Name = "DropdownList"

	Templates.Dropdown = dropdown
end

function module.New(title, startPosition)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "\0"
	local frame = Instance.new("Frame", screenGui)
	frame.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND
	frame.BorderSizePixel = 0

	local topBar = Instance.new("Frame", frame)
	topBar.Name = "TopBar"
	topBar.Size = UDim2.new(1, 0, 0, 30)
	topBar.BackgroundColor3 = DEFAULT_COLORS.TOPBAR
	topBar.BorderSizePixel = 0
	topBar.Active = true

	local titleLabel = Instance.new("TextLabel", topBar)
	titleLabel.BackgroundTransparency = 1
	titleLabel.TextColor3 = Color3.new(1, 1, 1)
	titleLabel.Font = DEFAULT_FONT
	titleLabel.TextSize = DEFAULT_TEXT_SIZE+2
	titleLabel.Size = UDim2.new(1, -35, 0, 30)
	titleLabel.Position = UDim2.new()
	titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
	titleLabel.Active = true

	local hideButton = Templates.Button:Clone()
	hideButton.TextSize = DEFAULT_TEXT_SIZE+2
	hideButton.Size = UDim2.new(0, 30, 1, -10)
	hideButton.Position = UDim2.new(1, -35, 0, 5)
	hideButton.Parent = topBar

	local container = Instance.new("Frame", frame)
	container.Name = "Container"
	container.BackgroundTransparency = 1
	container.ClipsDescendants = true
	container.Size = UDim2.new(1, -10, 1, -40)
	container.Position = UDim2.fromOffset(5, 35)

	local categoryPane = Instance.new("ScrollingFrame", container)
	categoryPane.Size = UDim2.new(0.4, -5, 1, 0)
	categoryPane.BackgroundTransparency = 1
	categoryPane.BorderSizePixel = 0
	categoryPane.CanvasSize = UDim2.new()
	categoryPane.ScrollBarImageColor3 = Color3.new(1, 1, 1)

	local categorySelectorPlate = Instance.new("Frame", categoryPane)
	categorySelectorPlate.Size = Templates.Button.Size
	categorySelectorPlate.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND_LIGHT
	categorySelectorPlate.BorderColor3 = DEFAULT_COLORS.BORDER
	categorySelectorPlate.BorderSizePixel = 1
	categorySelectorPlate.Visible = false

	local MinimumSize = UDim2.fromOffset(170, topBar.AbsoluteSize.Y)
	local DefaultSize = UDim2.fromOffset(450,  310)
	local isDragging = false
	local dragOffset = UDim2.new()
	
	local Categories = {}
	local SelectedCategory = 0
	local HoverIndex = 0
	
	local __defaultPosY = nil
	pcall(function()
		if game.CoreGui:FindFirstChild("PlayerList") then
			__defaultPosY = game.CoreGui.PlayerList.PlayerListMaster.AbsolutePosition.Y +
				game.CoreGui.PlayerList.PlayerListMaster.AbsoluteSize.Y + 50
		end
	end)

	local properties = {
		Title = title or "New Frame",
		Draggable = true,
		Visible = true,
		Hidden = false,
		Size = DefaultSize,
		Position = startPosition or UDim2.new(1, -DefaultSize.X.Offset - 25, __defaultPosY and 0 or 0.6, __defaultPosY or -(DefaultSize.Y.Offset/2)),
		OnDestroy = nil,
		ScreenGui = screenGui
	}
	
	local function IsInheritedVisible(object, topMostParent)
		if not object.Visible then return false end
		if object == topMostParent then return object.Visible end
		local parent = object.Parent
		while parent and parent.Visible and parent ~= topMostParent do
			parent = parent.Parent
		end
		return parent.Visible
	end

	local function Update(ignoreUIUpdate)
		titleLabel.Text = properties.Title
		frame.Visible = properties.Visible

		container.Visible = not properties.Hidden
		hideButton.Text = properties.Hidden and "+" or "-"
		if properties.Hidden then
			--CreateAnimation(frame, {
			--	Size = MinimumSize,
			--	Position = properties.Position + UDim2.fromOffset(properties.Size.X.Offset - MinimumSize.X.Offset, 0)
			--}):Play()
			frame.Size = MinimumSize
			frame.Position = properties.Position + UDim2.fromOffset(properties.Size.X.Offset - MinimumSize.X.Offset, 0)
		else
			do -- Category Pane
				if not Categories then
					--warn("Calling MeltinGui form dead thread.")
					if properties then
						pcall(function() properties:Shutdown() end)
					end
					if screenGui then
						screenGui:Destroy()
					end
					return
				end
				if SelectedCategory > #Categories then
					SelectedCategory = #Categories
				end
				categorySelectorPlate.Visible = SelectedCategory > 0
				local Category_PosY = 0
				for k,v in ipairs(Categories) do
					v._CategoryButton.Visible = v.Visible
					if v.Visible then
						v._ContentPane.Visible = k == SelectedCategory
						CreateAnimation(v._CategoryButton, {
							Position = UDim2.fromOffset(0, Category_PosY)
						}):Play()
						if (HoverIndex > 0 and k == HoverIndex) or (HoverIndex == 0 and k == SelectedCategory) then
							CreateAnimation(categorySelectorPlate,
								{
								Position = UDim2.fromOffset(0, Category_PosY)
								},
								TweenInfo.new(ANIMATIONS_SPEED_SHORT)
							):Play()
						end
						Category_PosY += Templates.Button.AbsoluteSize.Y + 5
						
						local Content_PosY = 0
						local Content_PosX = 0
						local Current_Line = {}
						for x, content in ipairs(v.Content) do
							content._GuiObject.Visible = content.Visible
							if content.Visible and content._GuiObject:FindFirstChild("DisableOverlay") then
								content._GuiObject.DisableOverlay.Visible = not content.Enabled
								for k,v in pairs(content._GuiObject:GetDescendants()) do
									if v:IsA("TextButton") then
										v.AutoButtonColor = content.Enabled
									end
								end
								if content.Type == "Label" then
									content._GuiObject.Text = content.Text or ""
									content._GuiObject.TextXAlignment = content.Align or Enum.TextXAlignment.Center
								elseif content.Type == "Button" then
									content._GuiObject.Text = content.Text or ""
									content._GuiObject.AutoButtonColor = content.Enabled
								elseif content.Type == "Checkbox" then
									content._GuiObject.Label.Text = content.Text or ""
								elseif content.Type == "Slider" then
									CreateAnimation(
										content._GuiObject.SliderBackground.SliderForeground,
										{
											Size = UDim2.new(
												0, content._GuiObject.SliderBackground.AbsoluteSize.X * ((content.Value - content.Minimum) / (content.Maximum - content.Minimum)), 1, 0
											)
										},
										TweenInfo.new(ANIMATIONS_SPEED_SHORT)
									):Play()
									if not content.CustomText then
										content._GuiObject.Label.Text = (content.Text or "") .. " (" .. tostring(content.Value) .. " / " .. tostring(content.Maximum) .. ")"
									else
										content._GuiObject.Label.Text = (content.Text or "")
									end
								elseif content.Type == "Dropdown" then
									content._GuiObject.Label.Text = content.Text or ""
									if content.SelectedOption then
										content._GuiObject.DropdownChoice.Text = content.SelectedOption.CustomDropdownDisplayName or tostring(content.SelectedOption)
									else
										content._GuiObject.DropdownChoice.Text = "None"
									end
								end
								local Max_Y = content._GuiObject.AbsoluteSize.Y
								for k, child in pairs(content._GuiObject:GetDescendants()) do
									if child:IsA("GuiBase2d") and IsInheritedVisible(child, content._GuiObject) and not child.Parent:IsA("ScrollingFrame") then
										if child.AbsoluteSize.Y + child.Position.Y.Offset > Max_Y then
											Max_Y = child.AbsoluteSize.Y + child.Position.Y.Offset
										end
									end
								end
								content._GuiObject.Position = UDim2.fromOffset(Content_PosX, Content_PosY)
								
								if #Current_Line > 0 or content.Inline then
									table.insert(Current_Line, content)
									if not content.Inline or x == #v.Content then
										local xLen = 1 / #Current_Line
										local xPos = 0
										for k,v in pairs(Current_Line) do
											v._GuiObject.Size = UDim2.new(xLen, 0, 0, 30)
											v._GuiObject.Position = UDim2.fromOffset(xPos, Content_PosY)
											xPos += v._GuiObject.AbsoluteSize.X
										end
										Current_Line = {}
										Content_PosY = content._GuiObject.Position.Y.Offset + Max_Y + 5
									end
								else
									Content_PosY = content._GuiObject.Position.Y.Offset + Max_Y + 5
								end
								
								Content_PosX = 0
							end
						end
						if categoryPane.CanvasSize.Y.Offset ~= Category_PosY then
							local pos = categoryPane.CanvasPosition
							categoryPane.CanvasSize = UDim2.fromOffset(0, Category_PosY)
							categoryPane.CanvasPosition = pos
						end
						if v._ContentPane.CanvasSize.Y.Offset ~= Content_PosY then
							v._ContentPane.CanvasSize = UDim2.fromOffset(0, Content_PosY)
						end
					else
						if k == SelectedCategory then
							if k >= 1 and k < #Categories then
								SelectedCategory += 1
							else
								SelectedCategory = 0
								Update()
								return
							end
						end
					end
				end
			end
			
			if not ignoreUIUpdate then
				--[[
				local onAnim = CreateAnimation(frame, {
					Size = properties.Size + UDim2.fromOffset(10, 10),
					Position = properties.Position
				})
				onAnim.Completed:Connect(function(playbackState)
					if playbackState == Enum.PlaybackState.Completed then
						Update(true)
					end
				end)
				onAnim:Play()
				]]
				frame.Size = properties.Size + UDim2.fromOffset(10, 10)
				frame.Position = properties.Position
			end
		end
	end
	
	categoryPane.MouseLeave:Connect(function()
		HoverIndex = 0
		Update()
	end)

	hideButton.MouseButton1Click:Connect(function()
		properties.Hidden = not properties.Hidden
		Update()
	end)

	local inputBegan = nil
	local inputChanged = nil
	local inputEnded = nil

	local InputActions = {
		Began = {},
		Changed = {},
		Ended = {}
	}

	local function AddInputBegan(action)
		table.insert(InputActions.Began, action)
	end

	local function RemoveInputBegan(action)
		for k,v in pairs(InputActions.Began) do
			if v and v == action then
				table.remove(InputActions.Began, k)
				return true
			end
		end
		return false
	end

	local function AddInputChanged(action)
		table.insert(InputActions.Changed, action)
	end

	local function RemoveInputChanged(action)
		for k,v in pairs(InputActions.Changed) do
			if v and v == action then
				table.remove(InputActions.Changed, k)
				return true
			end
		end
		return false
	end

	local function AddInputEnded(action)
		table.insert(InputActions.Ended, action)
	end

	local function RemoveInputEnded(action)
		for k,v in pairs(InputActions.Ended) do
			if v and v == action then
				table.remove(InputActions.Ended, k)
				return true
			end
		end
		return false
	end

	inputBegan = UserInputService.InputBegan:Connect(function(input)
		local errored = {}
		for k,v in pairs(InputActions.Changed) do
			local f, err = pcall(v, input)
			if not f then
				warn(err)
				table.insert(errored, v)
			end
		end
		if #errored > 0 then
			for x, err in pairs(errored) do
				for k,v in pairs(InputActions.Changed) do
					if v == err then
						table.remove(InputActions.Changed, k)
						break
					end
				end
			end
		end
	end)

	inputChanged = UserInputService.InputChanged:Connect(function(input)
		local errored = {}
		for k,v in pairs(InputActions.Changed) do
			local f, err = pcall(v, input)
			if not f then
				warn(err)
				table.insert(errored, v)
			end
		end
		if #errored > 0 then
			for x, err in pairs(errored) do
				for k,v in pairs(InputActions.Changed) do
					if v == err then
						table.remove(InputActions.Changed, k)
						break
					end
				end
			end
		end
	end)

	inputEnded = UserInputService.InputEnded:Connect(function(input)
		local errored = {}
		for k,v in pairs(InputActions.Ended) do
			local f, err = pcall(v, input)
			if not f then
				warn(err)
				table.insert(errored, v)
			end
		end
		if #errored > 0 then
			for x, err in pairs(errored) do
				for k,v in pairs(InputActions.Ended) do
					if v == err then
						table.remove(InputActions.Ended, k)
						break
					end
				end
			end
		end
	end)
	
	--[[
		type - MessageBox
			params:
				- Title (string?)
				- Message (string!)
				- Buttons (table of: {Text=(string)})
		
		type - GridList
			params:
				- Title (string?)
				- List (list of gui objects)
					table of {
						Text=(string),
						Image=(string?)
					}
				- Multichoice (bool = false)
			functions:
				- popup.UpdateList(newList)
		
		for all types:
			params:
				- UserChoice (callback: table of selected indexes)
	]]
	function properties:CreatePopup(popupType, params)
		if not params then return end
		
		local result = {}
		local popup = Instance.new("Frame", screenGui)
		popup.Name = "Popup"
		popup.BackgroundColor3 = DEFAULT_COLORS.BACKGROUND
		popup.BorderSizePixel = 0
		result.Popup = popup
		
		if popupType == "MessageBox" then
			popup.Size = UDim2.fromOffset(350, 200)
			popup.Position = UDim2.new(0.5, -175, 0.5, -100)
			
			local title = titleLabel:Clone()
			title.Parent = popup
			title.Text = params.Title or "Message"
			
			local closeButton = hideButton:Clone()
			closeButton.Parent = popup
			closeButton.Text = "x"
			closeButton.TextYAlignment = Enum.TextYAlignment.Center
			closeButton.Size = UDim2.new(0, 30, 0, 20)
			closeButton.MouseButton1Click:Connect(function()
				if params.UserChoice then
					local f, err = pcall(params.UserChoice)
					if not f then
						warn(err)
					end
				end
				popup:Destroy()
				result = nil
				Update()
			end)
			
			local message = title:Clone()
			message.Position = UDim2.new(0, 5, 0, title.Size.Y.Offset + 5)
			message.Size = UDim2.new(1, -10, 1, -title.Size.Y.Offset - 45)
			message.Text = params.Message
			message.TextWrap = true
			message.Parent = popup
			
			if not params.Buttons or #params.Buttons == 0 then
				params.Buttons = {[1] = {Text="Ok"}}
			end
			
			local btnContainer = Instance.new("Frame", popup)
			btnContainer.Position = UDim2.new(0, 0, 1, -35)
			btnContainer.Size = UDim2.new(1, 0, 0, 30)
			btnContainer.BackgroundTransparency = 1
			do
				local layout = Instance.new("UIListLayout", btnContainer)
				layout.FillDirection = Enum.FillDirection.Horizontal
				layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				layout.Padding = UDim.new(0, 5)
			end
			local btn = Templates.Button:Clone()
			btn.Size = UDim2.new(1 / #params.Buttons, -10, 1, 0)
			for index, btnProps in ipairs(params.Buttons) do
				local optBtn = btn:Clone()
				optBtn.Parent = btnContainer
				optBtn.Text = btnProps.Text
				optBtn.MouseButton1Click:Connect(function()
					if params.UserChoice then
						local f, err = pcall(params.UserChoice, {index})
						if not f then
							warn(err)
						end
					end
					popup:Destroy()
					result = nil
					Update()
				end)
			end
		elseif popupType == "GridList" then
			local test, err = pcall(function()
			popup.Size = UDim2.fromOffset(600, 400)
			popup.Position = UDim2.new(0.5, -300, 0.5, -200)
			
			local title = titleLabel:Clone()
			title.Parent = popup
			title.Text = params.Title or "Message"
			
			local closeButton = hideButton:Clone()
			closeButton.Parent = popup
			closeButton.Text = "x"
			closeButton.TextYAlignment = Enum.TextYAlignment.Center
			closeButton.Size = UDim2.new(0, 30, 0, 20)
			closeButton.MouseButton1Click:Connect(function()
				if params.UserChoice then
					local f, err = pcall(params.UserChoice)
					if not f then
						warn(err)
					end
				end
				popup:Destroy()
				result = nil
				Update()
			end)
			
			local container = Instance.new("ScrollingFrame", popup)
			container.Position = UDim2.fromOffset(0, 30)
			container.Size = UDim2.new(1, 0, 1, params.Multichoice and -70 or -30)
			container.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
			container.BackgroundTransparency = 1
			container.AutomaticCanvasSize = Enum.AutomaticSize.Y
			container.CanvasSize = UDim2.new()
			container.Name = "MainContainer"
			local layout = Instance.new("UIGridLayout", container)
			layout.Parent = container
			layout.Name = "Layout"
			layout.CellSize = UDim2.new(0.25, -5, 0.3, 5)
			
			local searchBox = Templates.TextBox:Clone()
			searchBox.Parent = popup
			searchBox.Size = UDim2.new(0, 150, 0, 20)
			searchBox.Position = UDim2.fromOffset(5, 5)
			searchBox.PlaceholderText = "Search"
			searchBox.ClearTextOnFocus = false
			
			local function SearchFor(term)
				for k,v in pairs(container:GetChildren()) do
					if v:FindFirstChild("GridObjectLabel") then
						v.Visible = term == "" or v.GridObjectLabel.Text:lower():find(term:lower(), 1, true) ~= nil
					end
				end
			end
			
			searchBox.Changed:Connect(function(property)
				if property == "Text" then
					SearchFor(searchBox.Text)
				end
			end)
			--searchBox:CaptureFocus()
			
			local selectedChoices = {}
			local resultChoices = {}
			
			local confirmBtn
			if params.Multichoice then
				confirmBtn = Templates.Button:Clone()
				confirmBtn.Parent = popup
				confirmBtn.Size = UDim2.new(0, 100, 0, 30)
				confirmBtn.Position = UDim2.new(0.5, -50, 1, -35)
				confirmBtn.Text = "Confirm"
				confirmBtn.Active = false
				confirmBtn.MouseButton1Click:Connect(function()
					if params.UserChoice then
						local f, err = pcall(params.UserChoice, selectedChoices)
						if not f then
							warn(err)
						end
					end
					popup:Destroy()
					result = nil
					Update()
				end)
			end
			
			local gridObject = Templates.Button:Clone()
			gridObject.Text = ""
			do
				gridObject.Size = UDim2.new(1, 0, 1, 0)
				local labelObject = Templates.Label:Clone()
				labelObject.Parent = gridObject
				labelObject.TextScaled = true
				labelObject.Size = UDim2.new(1, 0, 1, 0)
				labelObject.Name = "GridObjectLabel"
				Instance.new("UIListLayout", gridObject).HorizontalAlignment = Enum.HorizontalAlignment.Center
				local pad = Instance.new("UIPadding", gridObject)
				pad.PaddingTop = UDim.new(0, 5)
				pad.PaddingBottom = UDim.new(0, 5)
				local imageObject = Instance.new("ImageLabel", gridObject)
				imageObject.BackgroundTransparency = 1
				imageObject.Visible = false
				imageObject.Name = "GridObjectImage"
				imageObject.Size = UDim2.new(1, 0, 1, -30)
				Instance.new("UIAspectRatioConstraint", imageObject)--.AspectType = Enum.AspectType.ScaleWithParentSize
			end
			
			function result.UpdateList(listParams)
				if popup == nil then warn("UpdateList called on non-existing popup!") return end
				selectedChoices = {}
				for k,v in pairs(container:GetChildren()) do
					if v:IsA("TextButton") then v:Destroy() end
				end
				for _,lpData in ipairs(listParams) do
					local obj = gridObject:Clone()
					obj.Parent = container
					obj.GridObjectLabel.Text = lpData.Text or "Option " .. tostring(lpData.Value)
					obj.GridObjectLabel.TextColor3 = lpData.Color or Templates.Button.TextColor3
					if lpData.Image then
						if type(lpData.Image) == "function" then
							obj.GridObjectImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
							task.spawn(function()
								local f, err = pcall(function()
									obj.GridObjectImage.Image = lpData.Image()
								end)
								if not f then
									warn(err)
								end
							end)
						else
							obj.GridObjectImage.Image = lpData.Image
						end
						if lpData.ImageScaleType then
							obj.GridObjectImage.ScaleType = lpData.ImageScaleType
						end
						obj.GridObjectImage.Visible = true
						obj.GridObjectLabel.Size = UDim2.new(1, 0, 0, 30)
						obj.GridObjectLabel.Position = UDim2.new(0, 0, 1, -30)
					end
					selectedChoices[lpData.Value] = false
					obj.MouseButton1Click:Connect(function()
						if not params.Multichoice then
							if params.UserChoice then
								local f, err = pcall(params.UserChoice, lpData.Value)
								if not f then
									warn(err)
								end
							end
							popup:Destroy()
							result = nil
							Update()
						else
							selectedChoices[lpData.Value] = not selectedChoices[lpData.Value]
							resultChoices = 0
							for k,v in pairs(selectedChoices) do
								if v then
									selectedChoices[lpData.Value] = v
									resultChoices += 1
								else
									selectedChoices[lpData.Value] = nil
								end
							end
							confirmBtn.Active = resultChoices > 0
							obj.BorderColor3 = selectedChoices[lpData.Value] and DEFAULT_COLORS.BORDER_SPECIAL or DEFAULT_COLORS.BORDER
						end
					end)
					--container.CanvasSize = UDim2.new(0, 0, 0, (obj.AbsolutePosition.Y - container.AbsolutePosition.Y) + obj.AbsoluteSize.Y)
				end
				SearchFor(searchBox.Text)
				Update()
			end
			
			result.UpdateList(params.List or {})
			end)
			if not test then
				warn("FAILED AT GRID: " .. tostring(err))
			end
		end
		popup.Parent = screenGui
		
		function result.Cancel()
			popup:Destroy()
			Update()
		end
		
		Update()
		return result
	end

	function properties:AddCategory(categoryName)
		for k,v in ipairs(Categories) do
			if v.Name == categoryName then
				return k
			end
		end
		local id = #Categories+1
		local category = {
			Name = categoryName,
			Content = {},
			Visible = true,
			_CategoryButton = Templates.Button:Clone(),
			_ContentPane = Templates.ContentPane:Clone()
		}
		category._CategoryButton.BackgroundTransparency = 1
		--category._CategoryButton.BorderSizePixel = 0
		category._CategoryButton.Text = categoryName
		category._CategoryButton.Parent = categoryPane

		category._CategoryButton.MouseEnter:Connect(function()
			if category.Visible then
				for k,v in pairs(Categories) do
					if v == category then
						HoverIndex = k
						Update()
						break
					end
				end
			end
		end)

		category._CategoryButton.MouseButton1Click:Connect(function()
			if category.Visible then
				for k,v in pairs(Categories) do
					if v == category then
						SelectedCategory = k or 0
						Update()
						break
					end
				end
			end
		end)

		category._ContentPane.Visible = false
		category._ContentPane.Parent = container
		category._ContentPane.Name = categoryName .. "_Content"

		local function NewContent(content)
			local contentId = #category.Content+1

			function content:Remove()
				content._GuiObject:Destroy()
				for k, v in pairs(category.Content) do
					if v == content then
						table.remove(category.Content, k)
						Update()
						return
					end
				end
			end
			
			function content:Update()
				Update()
			end
			
			function content:SetEnabled(enabled)
				content.Enabled = enabled or false
				Update()
			end
			
			function content:SetVisible(visible)
				content.Visible = visible or false
				Update()
			end

			local guiObject = Templates[content.Type]:Clone()
			if content.Type == "Button" or content.Type == "Label" then
				function content:SetText(text)
					content.Text = text
					content._GuiObject.Text = text
				end
			end
			if content.Type == "Button" then
				guiObject.MouseButton1Click:Connect(function()
					if content.Action then
						local f, err = pcall(content.Action)
						if not f then
							warn(err)
						end
					end
					Update()
				end)
			elseif content.Type == "Checkbox" then
				function content:SetText(text)
					content.Text = text
					if content._GuiObject:FindFirstChild("Label") then
						content._GuiObject.Label.Text = text
					end
				end
				local animOn = CreateAnimation(
					guiObject.CheckButton.CheckedFrame,
					{
						BackgroundTransparency = 0
					},
					TweenInfo.new(ANIMATIONS_SPEED_SHORT)
				)
				local animOff = CreateAnimation(
					guiObject.CheckButton.CheckedFrame,
					{
						BackgroundTransparency = 1
					},
					TweenInfo.new(ANIMATIONS_SPEED_SHORT)
				)
				animOff.Completed:Connect(function(playbackState)
					if playbackState == Enum.PlaybackState.Completed then
						guiObject.CheckButton.CheckedFrame.Visible = false
					end
				end)
				
				function content:SetChecked(newValue)
					content.Checked = newValue
					if content.Checked then
						guiObject.CheckButton.CheckedFrame.Visible = true
						animOn:Play()
					else
						animOff:Play()
					end
					--guiObject.CheckButton.CheckedFrame.Visible = content.Checked
					if content.Action then
						local f, err = pcall(content.Action, content.Checked)
						if not f then
							warn(err)
						end
					end
					Update()
				end

				guiObject.CheckButton.MouseButton1Click:Connect(function()
					content:SetChecked(not content.Checked)
				end)
			elseif content.Type == "Slider" then
				local sliding = false
				
				function content:SetSliderValue(newValue)
					if newValue ~= content.Value then
						content.Value = content.ScrollDelta * math.floor(math.max(content.Minimum, math.min(content.Maximum, newValue))/content.ScrollDelta)
						Update()
						if content.Action then
							local f, err = pcall(content.Action, newValue)
							if not f then
								warn(err)
							end
						end
					end
				end
				
				function content:SetSliderMinMax(newMin, newMax)
					content.Minimum = newMin or content.Minimum
					content.Maximum = newMax or content.Maximum
					content.Value = content.ScrollDelta * math.floor(math.max(content.Minimum, math.min(content.Maximum, content.Value))/content.ScrollDelta)
					Update()
				end
				
				local function UpdateSlider(input)
					if input and (input.UserInputType == Enum.UserInputType.MouseButton1 or
						input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						
						local Xmin, Xmax =
							guiObject.SliderBackground.AbsolutePosition.X,
							guiObject.SliderBackground.AbsolutePosition.X + guiObject.SliderBackground.AbsoluteSize.X

						local posX = math.max(Xmin, math.min(Xmax, input.Position.X))

						local val = (posX - Xmin) / guiObject.SliderBackground.AbsoluteSize.X
						content:SetSliderValue(((content.Maximum - content.Minimum) * val) + content.Minimum)
					end
				end

				local function BeginSliding(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						sliding = true
						guiObject.SliderBackground.SliderForeground.SliderGrab.Size = UDim2.fromOffset(16, 16)
						guiObject.SliderBackground.SliderForeground.SliderGrab.Position = UDim2.new(1, -8, 0.5, -8)
						UpdateSlider(input)
					end
				end
				
				guiObject.SliderBackground.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseWheel then
						content:SetSliderValue(content.Value + (content.ScrollDelta * input.Position.Z))
					end
				end)
				
				guiObject.SliderBackground.SliderForeground.InputBegan:Connect(BeginSliding)
				guiObject.SliderBackground.SliderForeground.SliderGrab.InputBegan:Connect(BeginSliding)

				AddInputChanged(function(input)
					if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						UpdateSlider(input)
					end
				end)

				AddInputEnded(function(input)
					if sliding and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
						sliding = false
						guiObject.SliderBackground.SliderForeground.SliderGrab.Size = UDim2.fromOffset(12, 12)
						guiObject.SliderBackground.SliderForeground.SliderGrab.Position = UDim2.new(1, -6, 0.5, -6)
						UpdateSlider(input)
					end
				end)
			elseif content.Type == "Dropdown" then
				local ListVisible = false
				local animOff = CreateAnimation(
					guiObject.DropdownList,
					{
						Size = UDim2.new(1, -10, 0, 0)
					},
					TweenInfo.new(ANIMATIONS_SPEED_SHORT)
				)
				animOff.Completed:Connect(function(playbackState)
					if playbackState == Enum.PlaybackState.Completed then
						guiObject.DropdownList.Visible = false
						Update()
					end
				end)
				
				function content:SetOptions(options)
					if options then
						content.Options = options
						if content.SelectedIndex > #content.Options then
							content.SelectedIndex = #content.Options
						end
						if content.SelectedOption ~= nil then
							for k, v in ipairs(content.Options) do
								if v == content.SelectedOption then
									content.SelectedIndex = k
									break
								end
							end
						end
						content.SelectedOption = content.Options[content.SelectedIndex]
						Update()
					end
				end
				
				function content:SelectOption(index)
					if index and index > 0 and index < #content.Options then
						content.SelectedIndex = index
						content.SelectedOption = content.Options[content.SelectedIndex]
					end
				end
				
				guiObject.DropdownChoice.Text = content.SelectedIndex > 0 and tostring(content.Options[content.SelectedIndex]) or ""
				guiObject.DropdownChoice.MouseButton1Click:Connect(function()
					local plr = game.Players.LocalPlayer
					ListVisible = not ListVisible
					if ListVisible then
						guiObject.DropdownList:ClearAllChildren()
						guiObject.DropdownChoice.BorderColor3 = DEFAULT_COLORS.BORDER_SPECIAL
						local x = 0
						for k,v in ipairs(content.Options) do
							if v and v ~= content.SelectedOption then
								x += 1
								local btn = Templates.Button:Clone()
								btn.ZIndex = 10
								btn.Size = UDim2.new(1, 0, 0, 30)
								btn.Position = UDim2.fromOffset(0, 30*(x-1))
								--btn.BorderSizePixel = 0
								if type(v) == "userdata" and v:IsA("Player") then
									btn.Text = v.DisplayName ~= v.Name and (v.Name .. " (" .. v.DisplayName .. ")") or v.Name
									if plr and plr.Team and v.Team then
										btn.TextColor3 = plr.Team == v.Team and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
									end
								else
									btn.Text = v.CustomDropdownDisplayName or tostring(v)
									btn.TextColor3 = DEFAULT_COLORS.TEXT
								end
								btn.Parent = guiObject.DropdownList
								btn.MouseButton1Click:Connect(function()
									content.SelectedIndex = k
									content.SelectedOption = v
									if content.Action then
										local f, err = pcall(content.Action, k, v)
										if not f then
											warn(err)
										end
									end
									ListVisible = false
									guiObject.DropdownChoice.BorderColor3 = DEFAULT_COLORS.BORDER
									animOff:Play()
									Update()
								end)
							end
						end
						guiObject.DropdownList.Size = UDim2.new(1, -10, 0, 0)
						guiObject.DropdownList.Visible = true
						local animOn = CreateAnimation(
							guiObject.DropdownList,
							{
								Size = UDim2.new(1, -10, 0, math.min(100, x * 30))
							},
							TweenInfo.new(ANIMATIONS_SPEED_SHORT)
						)
						animOn.Completed:Connect(function(playbackState)
							if playbackState == Enum.PlaybackState.Completed then
								Update()
							end
						end)
						animOn:Play()
					else
						guiObject.DropdownChoice.BorderColor3 = DEFAULT_COLORS.BORDER
						animOff:Play()
					end
					Update()
				end)
			end
			guiObject.Parent = category._ContentPane
			content._GuiObject = guiObject
			content.Visible = true
			content.Inline = false
			content.Enabled = true
			do
				local disableOverlay = Instance.new("TextButton")
				disableOverlay.Text = ""
				disableOverlay.BackgroundTransparency = 0.5
				disableOverlay.BorderSizePixel = 0
				disableOverlay.Size = UDim2.fromScale(1, 1)
				disableOverlay.Active = true
				disableOverlay.AutoButtonColor = false
				disableOverlay.Name = "DisableOverlay"
				disableOverlay.Visible = false
				disableOverlay.Parent = content._GuiObject
			end

			category.Content[contentId] = content
			Update()
			return category.Content[contentId]
		end

		function category:AddLabel(text, align)
			return NewContent({
				Type = "Label",
				Text = text or "New Label",
				Align = align or Enum.TextXAlignment.Center
			})
		end

		function category:AddButton(text, action)
			return NewContent({
				Type = "Button",
				Text = text or "New Button",
				Action = action
			})
		end

		function category:AddCheckbox(text, action)
			return NewContent({
				Type = "Checkbox",
				Checked = false,
				Text = text or "New Checkbox",
				Action = action
			})
		end

		function category:AddSlider(text, value, min, max, action, scrollDelta)
			local contentId = #category.Content+1
			return NewContent({
				Type = "Slider",
				Value = value or 0,
				Minimum = min or 0,
				Maximum = max or 10,
				ScrollDelta = scrollDelta or 1,
				CustomText = false,
				Text = text or "New Slider",
				Action = action
			})
		end

		function category:AddDropdown(text, options, default, action)
			local contentId = #category.Content+1
			return NewContent({
				Type = "Dropdown",
				Options = options or {},
				SelectedIndex = default or 0,
				SelectedOption = (default and options and options[default]) and options[default] or nil,
				Text = text or "New Dropdown",
				Action = action
			})
		end

		function category:Remove()
			for k,v in ipairs(Categories) do
				if v == category then
					table.remove(Categories, k)
					for k,v in pairs(category.Content) do
						v:Remove()
					end
					Update()
					return
				end
			end
		end
		Categories[id] = setmetatable(category, {
			__newindex = function(t, key, value)
				t[key] = value
				Update()
			end,
		})

		if id == 1 then
			SelectedCategory = 1
		end

		Update()

		return Categories[id]
	end

	function properties:Destroy()
		inputBegan:Disconnect()
		inputChanged:Disconnect()
		inputEnded:Disconnect()
		screenGui:Destroy()
		if properties.OnDestroy ~= nil then
			local f, err = pcall(properties.OnDestroy)
			if not f then
				warn(err)
			end
		end
		Categories = nil
	end
	
	function properties:Update()
		Update()
	end

	local mt = setmetatable({}, {
		__index = function(t, key)
			if key then
				if key == "Parent" then
					return screenGui.Parent
				else
					return properties[key]
				end
			end
		end,
		__newindex = function(t, key, value)
			if key then
				if key == "Parent" then
					screenGui.Parent = value
				else
					properties[key] = value
				end
				Update()
			end
		end
	})

	local dragOffset = UDim2.new()

	titleLabel.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if not properties.Hidden then
				dragOffset = frame.AbsolutePosition - Vector2.new(input.Position.X, input.Position.Y)
			else
				dragOffset = frame.AbsolutePosition - Vector2.new(properties.Size.X.Offset - MinimumSize.X.Offset, 0) - Vector2.new(input.Position.X, input.Position.Y)
			end
			isDragging = true
		end
	end)

	AddInputChanged(function(input)
		if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			if mt.Visible then
				mt.Position = UDim2.fromOffset(input.Position.X, input.Position.Y) + UDim2.fromOffset(dragOffset.X, dragOffset.Y)
			else
				isDragging = false
			end
		end
	end)

	AddInputEnded(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
		end
	end)
	
	return mt
end

print("Loaded MeltinGui v" .. module.Version)

return module