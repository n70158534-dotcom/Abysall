--// Services
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

--// Library Load (Compkiller)
local Compkiller = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))();

--// Notifications & Config
local Notifier = Compkiller.newNotify();
local ConfigManager = Compkiller:ConfigManager({
	Directory = "HorryMod-Doors",
	Config = "Doors-Configs"
});

--// Настройки звуков
local soundSettings = {
	Enabled = true,
	Volume = 0.7,
	Id = "rbxassetid://4590657391" 
}

local function playClickSound()
	if not soundSettings.Enabled then return end
	task.spawn(function()
		pcall(function()
			local s = Instance.new("Sound")
			s.SoundId = soundSettings.Id
			s.Volume = soundSettings.Volume
			s.Parent = Workspace
			s:Play()
			s.Ended:Connect(function()
				s:Destroy()
			end)
			task.delay(1, function()
				if s and s.Parent then
					s:Destroy()
				end
			end)
		end)
	end)
end

playClickSound()

--// Loader
Compkiller:Loader(nil, 2.0).yield();

--// 🪟 Кастомное предупреждение по центру (Beta Test Notice)
task.spawn(function()
	pcall(function()
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "HorryMod_BetaNotice"
		screenGui.ResetOnSpawn = false
		screenGui.Parent = CoreGui

		local mainFrame = Instance.new("Frame")
		mainFrame.Size = UDim2.new(0, 360, 0, 180)
		mainFrame.Position = UDim2.new(0.5, -180, 0.5, -90)
		mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		mainFrame.BorderSizePixel = 0
		mainFrame.Parent = screenGui

		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 10)
		uiCorner.Parent = mainFrame

		local uiStroke = Instance.new("UIStroke")
		uiStroke.Color = Color3.fromRGB(0, 170, 255)
		uiStroke.Thickness = 2
		uiStroke.Parent = mainFrame

		local titleLabel = Instance.new("TextLabel")
		titleLabel.Size = UDim2.new(1, 0, 0, 45)
		titleLabel.BackgroundTransparency = 1
		titleLabel.Text = "ВНИМАНИЕ (BETA)"
		titleLabel.TextColor3 = Color3.fromRGB(255, 220, 0)
		titleLabel.TextSize = 18
		titleLabel.Font = Enum.Font.GothamBold
		titleLabel.Parent = mainFrame

		local descLabel = Instance.new("TextLabel")
		descLabel.Size = UDim2.new(1, -30, 0, 75)
		descLabel.Position = UDim2.new(0, 15, 0, 45)
		descLabel.BackgroundTransparency = 1
		descLabel.Text = "Это бета тест скрипта, могут быть лаги и т.д. В дальнейшем будем делать скрипт все более и более лучше!"
		descLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
		descLabel.TextSize = 14
		descLabel.Font = Enum.Font.Gotham
		descLabel.TextWrapped = true
		descLabel.Parent = mainFrame

		local okButton = Instance.new("TextButton")
		okButton.Size = UDim2.new(0, 120, 0, 35)
		okButton.Position = UDim2.new(0.5, -60, 1, -45)
		okButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
		okButton.Text = "ПОНЯТНО"
		okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		okButton.TextSize = 14
		okButton.Font = Enum.Font.GothamBold
		okButton.Parent = mainFrame

		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 6)
		btnCorner.Parent = okButton

		okButton.MouseButton1Click:Connect(function()
			playClickSound()
			screenGui:Destroy()
		end)
	end)
end)

--// 🚀 Уведомление для ошибки трейсеров
local function showCustomCornerWarning(text)
	task.spawn(function()
		pcall(function()
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "HorryMod_CornerWarning"
			screenGui.ResetOnSpawn = false
			screenGui.Parent = CoreGui

			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(0, 280, 0, 50)
			frame.Position = UDim2.new(1, -300, 1, 20)
			frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			frame.BorderSizePixel = 0
			frame.BackgroundTransparency = 0.2
			frame.Parent = screenGui

			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 8)
			corner.Parent = frame

			local stroke = Instance.new("UIStroke")
			stroke.Color = Color3.fromRGB(255, 80, 80)
			stroke.Thickness = 1.5
			stroke.Parent = frame

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundTransparency = 1
			label.Text = text
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.TextSize = 12
			label.Font = Enum.Font.GothamBold
			label.TextWrapped = true
			label.Parent = frame

			local tweenIn = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(1, -300, 1, -70)
			})
			tweenIn:Play()
			tweenIn.Completed:Wait()

			task.wait(2)

			local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position = UDim2.new(1, -300, 1, -140),
				BackgroundTransparency = 1
			})
			local textTween = TweenService:Create(label, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				TextTransparency = 1
			})
			local strokeTween = TweenService:Create(stroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Transparency = 1
			})

			tweenOut:Play()
			textTween:Play()
			strokeTween:Play()

			tweenOut.Completed:Wait()
			screenGui:Destroy()
		end)
	end)
end

--// Creating Window
local Window = Compkiller.new({
	Name = "HorryMod | DOORS Ultimate",
	Keybind = "LeftAlt",
	Logo = "",
	Scale = Compkiller.Scale.Window,
	TextSize = 15,
});

Notifier.new({
	Title = "HorryMod Запущен",
	Content = "Добро пожаловать в чит-хаб DOORS! Нажми LeftAlt.",
	Duration = 5,
});

--// Watermark
local Watermark = Window:Watermark();
Watermark:AddText({ Icon = "user", Text = "HorryMod User" });
local Time = Watermark:AddText({ Icon = "timer", Text = "TIME" });
task.spawn(function()
	while true do task.wait(1)
		Time:SetText(Compkiller:GetTimeNow());
	end
end)
Watermark:AddText({ Icon = "server", Text = Compkiller.Version });

--// --- ВКЛАДКИ ---
local HomeTab = Window:DrawTab({ Name = "Главная", Icon = "home", EnableScrolling = true });
local DoorsTab = Window:DrawTab({ Name = "DOORS Функции", Icon = "eye", EnableScrolling = true });
local ExtraTab = Window:DrawTab({ Name = "Т.д", Icon = "list", EnableScrolling = true });

Window:DrawCategory({ Name = "Системные вкладки" });

local SettingTab = Window:DrawTab({ Icon = "settings", Name = "Настройки", Type = "Single", EnableScrolling = true });
local ThemeTab = Window:DrawTab({ Icon = "paintbrush", Name = "Темы", Type = "Single" });

--// --- СЕКЦИИ И КОНТЕНТ ---

local HomeSection = HomeTab:DrawSection({ Name = "Добро пожаловать в HorryMod", Position = 'left' });
HomeSection:AddParagraph({
	Title = "Инструкция по использованию",
	Content = "• Вкладка «DOORS Функции»:\n  Исправлены наслаивания текста и фильтр лифтов.\n\n• Вкладка «Т.д»:\n  Трейсеры, No-Clip и ускорение."
})

local ESPSection = DoorsTab:DrawSection({ Name = "Подсветка и Обводка (ESP)", Position = 'left' });
local LightSection = DoorsTab:DrawSection({ Name = "Освещение", Position = 'right' });

local modStates = {
	DoorsESP = false,
	MonstersESP = false,
	PlayersESP = false,
	
	TextColor = Color3.fromRGB(255, 255, 255),
	OutlineColor = Color3.fromRGB(0, 255, 100),
	TracerColor = Color3.fromRGB(0, 170, 255),
	
	Tracers1 = false,
	Tracers2 = false,
	
	NoClip = false,
	SpeedBoost = false,
	SpeedValue = 21,
	FullBright = false
}
local Library = {
	Font = Enum.Font.RobotoCondensed,
	Rainbow = false,
	Tracers = false,
	Unloaded = false,
	ShowDistance = false,
	MatchColors = true,
	Arrows = false,
	TextTransparency = 0,
	TracerOrigin = "Bottom",
	FillTransparency = 0.75,
	OutlineTransparency = 0,
	TextOutlineTransparency = 0,
	FadeTime = 0,
	RenderLimit = 240,
	TracerSize = 0.5,
	ArrowRadius = 200,
	TextSize = 20,
	DistanceSizeRatio = 1,
	OutlineColor = Color3.fromRGB(255, 255, 255),
	RainbowColor = Color3.fromRGB(255, 255, 255),

	ElementsEnabled = {},
	TransparencyEnabled = {},
	Highlights = {},
	Labels = {},
	Frames = {},
	Lines = {},
	ArrowsTable = {},
	ColorTable = {},
	TextTable = {},
	ConnectionsTable = {},
	Objects = {},
	TotalObjects = {},
}

local RainbowState = {
	HueSetup = 0,
	Hue = 0,
	Step = 0,
	Color = Color3.new(),
}

local CloneReference = cloneref or function(O) return O end
local Players = CloneReference(game:GetService("Players"))
local CoreGui = getgenv and CloneReference(game:GetService("CoreGui")) or Players.LocalPlayer.PlayerGui
local Workspace = CloneReference(workspace)
local RunService = CloneReference(game:GetService("RunService"))
local TweenService = CloneReference(game:GetService("TweenService"))
local UserInputService = CloneReference(game:GetService("UserInputService"))
local LocalPlayer = Players.LocalPlayer

local function GetHiddenUI()
	if gethui then return gethui() end
	local Folder = Instance.new("Folder", CoreGui)
	Folder.Name = ("%032x"):format(math.random(0, 2^31))
	return Folder
end

function Library:GenerateRandomString()
	local Chars = {}
	local Pool = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local PoolLen = #Pool
	for I = 1, 24 do
		local Idx = math.random(1, PoolLen)
		Chars[I] = Pool:sub(Idx, Idx)
	end
	return table.concat(Chars)
end

local HiddenUI = GetHiddenUI()
local Camera = Workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Name = Library:GenerateRandomString()
ScreenGui.Parent = HiddenUI

local HighlightsFolder = Instance.new("Folder")
HighlightsFolder.Name = Library:GenerateRandomString()
HighlightsFolder.Parent = ScreenGui

local BillboardsFolder = Instance.new("Folder")
BillboardsFolder.Name = Library:GenerateRandomString()
BillboardsFolder.Parent = ScreenGui

local TracersFrame = Instance.new("Frame")
TracersFrame.Size = UDim2.new(1, 0, 1, 0)
TracersFrame.BackgroundTransparency = 1
TracersFrame.Visible = false
TracersFrame.Name = Library:GenerateRandomString()
TracersFrame.Parent = ScreenGui

local ArrowsFrame = Instance.new("Frame")
ArrowsFrame.Size = UDim2.new(1, 0, 1, 0)
ArrowsFrame.BackgroundTransparency = 1
ArrowsFrame.Visible = false
ArrowsFrame.Name = Library:GenerateRandomString()
ArrowsFrame.Parent = ScreenGui

local ArrowTemplate = Instance.new("ImageLabel")
ArrowTemplate.Image = "rbxassetid://16368985219"
ArrowTemplate.Size = UDim2.new(0, 50, 0, 50)
ArrowTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
ArrowTemplate.BackgroundTransparency = 1
ArrowTemplate.ImageTransparency = 1
local ArrowConstraint = Instance.new("UIAspectRatioConstraint")
ArrowConstraint.AspectRatio = 1
ArrowConstraint.Name = Library:GenerateRandomString()
ArrowConstraint.Parent = ArrowTemplate

local function MakeTween(Instance_, Props)
	local Info = TweenInfo.new(Library.FadeTime, Enum.EasingStyle.Quad)
	return TweenService:Create(Instance_, Info, Props)
end

local function PlayTween(Instance_, Props)
	MakeTween(Instance_, Props):Play()
end

local function DestroyObjectData(Object)
	local Highlight = Library.Highlights[Object]
	if Highlight then
		Highlight:Destroy()
		Library.Highlights[Object] = nil
	end

	local Frame = Library.Frames[Object]
	if Frame then
		Frame:Destroy()
		Library.Frames[Object] = nil
	end

	local LineData = Library.Lines[Object]
	if LineData then
		if LineData[1] then LineData[1]:Destroy() end
		Library.Lines[Object] = nil
	end

	local Arrow = Library.ArrowsTable[Object]
	if Arrow then
		Arrow:Destroy()
		Library.ArrowsTable[Object] = nil
	end

	local Conns = Library.ConnectionsTable[Object]
	if Conns then
		for _, Conn in ipairs(Conns) do
			Conn:Disconnect()
		end
		Library.ConnectionsTable[Object] = nil
	end

	Library.Labels[Object] = nil
	Library.ColorTable[Object] = nil
	Library.TextTable[Object] = nil
	Library.ElementsEnabled[Object] = nil
	Library.TransparencyEnabled[Object] = nil
	Library.Objects[Object] = nil

	for Idx = #Library.TotalObjects, 1, -1 do
		if Library.TotalObjects[Idx] == Object then
			table.remove(Library.TotalObjects, Idx)
			break
		end
	end
end

function Library:AddESP(Parameters)
	local Object = Parameters.Object
	if Library.ElementsEnabled[Object] == true or Library.Unloaded == true then return end
	if not Object:IsA("BasePart") and not Object:IsA("Model") then return end

	Library.ElementsEnabled[Object] = true
	Library.TransparencyEnabled[Object] = false
	Library.ConnectionsTable[Object] = Library.ConnectionsTable[Object] or {}

	if Library.Highlights[Object] then
		Library.Highlights[Object]:Destroy()
		Library.Highlights[Object] = nil
	end

	local Highlight = Instance.new("Highlight")
	Highlight.FillTransparency = 1
	Highlight.OutlineTransparency = 1
	Highlight.Name = Library:GenerateRandomString()
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.Adornee = Object
	Highlight.Parent = HighlightsFolder
	Library.Highlights[Object] = Highlight

	local TextFrame = Instance.new("Frame")
	TextFrame.Visible = false
	TextFrame.Name = Library:GenerateRandomString()
	TextFrame.Size = UDim2.fromScale(1, 1)
	TextFrame.BackgroundTransparency = 1
	TextFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	TextFrame.Parent = BillboardsFolder

	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = Library:GenerateRandomString()
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = Parameters.Text
	TextLabel.TextTransparency = 1
	TextLabel.TextStrokeTransparency = Library.TextOutlineTransparency
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.Font = Library.Font
	TextLabel.TextSize = Library.TextSize
	TextLabel.RichText = true
	TextLabel.TextColor3 = Parameters.Color
	TextLabel.Parent = TextFrame

	Library.Frames[Object] = TextFrame
	Library.Labels[Object] = TextLabel
	Library.ColorTable[Object] = Parameters.Color
	Library.TextTable[Object] = Parameters.Text
	Library.Objects[Object] = Object
	table.insert(Library.TotalObjects, Object)

	PlayTween(Highlight, { FillTransparency = Library.FillTransparency })
	PlayTween(Highlight, { OutlineTransparency = Library.OutlineTransparency })

	local TextFadeIn = MakeTween(TextLabel, { TextTransparency = Library.TextTransparency })
	TextFadeIn.Completed:Once(function()
		Library.TransparencyEnabled[Object] = true
	end)
	TextFadeIn:Play()
	PlayTween(TextLabel, { TextStrokeTransparency = Library.TextOutlineTransparency })

	task.spawn(function()
		local Last = 0
		local function Render()
			if not Object or not Object:IsDescendantOf(game) then
				Library:RemoveESP(Object)
				return
			end

			local ObjectPos = Object:GetPivot().Position
			local ScreenPoint, OnScreen = Camera:WorldToViewportPoint(ObjectPos)

			local Frame = Library.Frames[Object]
			local Label = Library.Labels[Object]
			local CachedHighlight = Library.Highlights[Object]

			if Frame then
				Frame.Visible = OnScreen
				if OnScreen then
					Frame.Position = UDim2.new(0, ScreenPoint.X, 0, ScreenPoint.Y)
				end
			end

			if not OnScreen then
				if CachedHighlight then
					CachedHighlight:Destroy()
					Library.Highlights[Object] = nil
				end
			elseif Library.ElementsEnabled[Object] == true and not CachedHighlight then
				CachedHighlight = Instance.new("Highlight")
				CachedHighlight.FillTransparency = 1
				CachedHighlight.OutlineTransparency = 1
				CachedHighlight.Name = Library:GenerateRandomString()
				CachedHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				CachedHighlight.Adornee = Object
				CachedHighlight.Parent = HighlightsFolder
				Library.Highlights[Object] = CachedHighlight
			end

			local ActiveColor = Library.Rainbow and RainbowState.Color or Library.ColorTable[Object] or Color3.fromRGB(255, 255, 255)

			if Label then
				Label.TextColor3 = ActiveColor
			end

			if CachedHighlight then
				local Distance = math.floor((Camera.CFrame.Position - ObjectPos).Magnitude)
				local DistanceText = Library.ShowDistance
					and ("\n" .. '<font size="' .. math.round(Library.TextSize * Library.DistanceSizeRatio) .. '">[' .. Distance .. ']</font>')
					or ""
				if Label then
					Label.Text = Library.TextTable[Object] .. DistanceText
				end

				CachedHighlight.Enabled = true
				CachedHighlight.FillColor = ActiveColor
				CachedHighlight.OutlineColor = Library.MatchColors and ActiveColor or Library.OutlineColor

				if Library.TransparencyEnabled[Object] == true then
					CachedHighlight.FillTransparency = Library.FillTransparency
					CachedHighlight.OutlineTransparency = Library.OutlineTransparency
					if Label then
						Label.TextTransparency = Library.TextTransparency
						Label.TextStrokeTransparency = Library.TextOutlineTransparency
					end
				end
			end
		end

		local Connection
		Connection = RunService.Heartbeat:Connect(function(Delta)
			Last = Last + Delta
			if Last >= 1 / Library.RenderLimit then
				Last = 0
				if Library.ElementsEnabled[Object] ~= true then
					Connection:Disconnect()
					return
				end
				Render()
			end
		end)
		table.insert(Library.ConnectionsTable[Object], Connection)
	end)
end

function Library:RemoveESP(Object)
	if Library.Unloaded == true or Library.ElementsEnabled[Object] ~= true then return end
	Library.ElementsEnabled[Object] = false
	Library.TransparencyEnabled[Object] = false

	local Label = Library.Labels[Object]
	if Label then PlayTween(Label, { TextTransparency = 1 }) end

	local Highlight = Library.Highlights[Object]
	if Highlight then
		PlayTween(Highlight, { FillTransparency = 1 })
		PlayTween(Highlight, { OutlineTransparency = 1 })
	end

	task.delay(Library.FadeTime + 0.05, function()
		if Library.ElementsEnabled[Object] == false then
			DestroyObjectData(Object)
		end
	end)
end

function Library:SetFillTransparency(Number) Library.FillTransparency = Number end
function Library:SetOutlineTransparency(Number) Library.OutlineTransparency = Number end
function Library:SetShowDistance(Value) Library.ShowDistance = Value end

local RainbowConnection = RunService.RenderStepped:Connect(function(Delta)
	RainbowState.Step = RainbowState.Step + Delta
	if RainbowState.Step >= (1 / 60) then
		RainbowState.Step = 0
		RainbowState.HueSetup = RainbowState.HueSetup + (1 / 400)
		if RainbowState.HueSetup > 1 then RainbowState.HueSetup = 0 end
		RainbowState.Hue = RainbowState.HueSetup
		RainbowState.Color = Color3.fromHSV(RainbowState.Hue, 0.8, 1)
		Library.RainbowColor = RainbowState.Color
	end
end)

local CameraConnection = Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	Camera = Workspace.CurrentCamera
end)

return Library
--// --- ДОБАВЛЕНИЕ КНОПОК ВО ВКЛАДКУ DOORS ФУНКЦИИ ---

local ESPSection = DoorsTab:DrawSection({ Name = "Подсветка и Обводка (ESP)", Position = 'left' });

ESPSection:AddToggle({
	Name = "Включить ESP (Тест)",
	Default = false,
	Callback = function(Value)
		modStates.DoorsESP = Value
		if Value then
			-- Пример добавления объектов в ESP (например, поиск моделей в Workspace)
			for _, obj in ipairs(Workspace:GetChildren()) do
				if obj:IsA("Model") and obj ~= LocalPlayer.Character then
					Library:AddESP({
						Object = obj,
						Text = obj.Name,
						Color = Color3.fromRGB(0, 255, 100)
					})
				end
			end
			Notifier.new({ Title = "ESP", Content = "Подсветка включена!", Duration = 3 })
		else
			-- Очистка или отключение
			for _, obj in ipairs(Library.TotalObjects) do
				Library:RemoveESP(obj)
			end
			Notifier.new({ Title = "ESP", Content = "Подсветка выключена!", Duration = 3 })
		end
	end
})

ESPSection:AddSlider({
	Name = "Прозрачность заливки",
	Min = 0,
	Max = 1,
	Default = 0.75,
	Decimal = 2,
	Callback = function(Value)
		Library:SetFillTransparency(Value)
	end
})

ESPSection:AddToggle({
	Name = "Показывать дистанцию",
	Default = false,
	Callback = function(Value)
		Library:SetShowDistance(Value)
	end
})
return Library
