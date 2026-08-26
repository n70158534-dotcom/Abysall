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

--// Library Load (Compkiller + Наша библиотека ESP из репозитория)
local Compkiller = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))();
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/n70158534-dotcom/Abysall/main/esp.lua"))();

--// Настройка параметров ESP
ESP:SetShowDistance(true)
ESP:SetTextSize(15)

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

--// 🪟 Предупреждение (Beta Test Notice)
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
		descLabel.Text = "Это бета тест скрипта с интеграцией нашей кастомной ESP библиотеки!"
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
	Content = "Добро пожаловать! Нажми LeftAlt.",
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
	Content = "• Используется кастомная ESP библиотека из репозитория.\n• Вкладка «DOORS Функции» управляет подсветкой."
})

local ESPSection = DoorsTab:DrawSection({ Name = "Подсветка и Обводка (ESP)", Position = 'left' });
local LightSection = DoorsTab:DrawSection({ Name = "Освещение", Position = 'right' });

local modStates = {
	DoorsESP = false,
	MonstersESP = false,
	PlayersESP = false,
	
	TextColor = Color3.fromRGB(255, 255, 255),
	OutlineColor = Color3.fromRGB(0, 255, 100),
	
	NoClip = false,
	SpeedBoost = false,
	SpeedValue = 21,
	FullBright = false
}

-- ESP Дверей, Ключей и Шкафов через нашу библиотеку
ESPSection:AddToggle({
	Name = "ESP Дверей, Ключей и Шкафов",
	Flag = "ESP_Doors",
	Default = false,
	Callback = function(State)
		playClickSound()
		modStates.DoorsESP = State
		task.spawn(function()
			while modStates.DoorsESP do
				pcall(function()
					for _, obj in ipairs(Workspace:GetDescendants()) do
						if modStates.DoorsESP and obj.Name == "Door" then
							local parentName = obj.Parent and obj.Parent.Name or ""
							if not parentName:lower():find("elevator") and not parentName:lower():find("lift") then
								local target = obj:IsA("Model") and (obj:FindFirstChild("Door") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
								if target and target:IsA("BasePart") then
									ESP:AddESP({ Object = target, Text = "Дверь", Color = modStates.TextColor })
								end
							end
						end
						if modStates.DoorsESP and (obj.Name == "Key" or obj.Name == "KeyObtain") then
							local target = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
							if target and target:IsA("BasePart") then
								ESP:AddESP({ Object = target, Text = "Ключ", Color = Color3.fromRGB(255, 255, 0) })
							end
						end
						if modStates.DoorsESP and (obj.Name == "Wardrobe" or obj.Name == "Closet") then
							local target = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
							if target and target:IsA("BasePart") then
								ESP:AddESP({ Object = target, Text = "Шкаф", Color = modStates.OutlineColor })
							end
						end
					end
				end)
				task.wait(2)
			end
			-- Очистка при выключении
			pcall(function()
				for _, obj in ipairs(Workspace:GetDescendants()) do
					if obj.Name == "Door" or obj.Name == "Key" or obj.Name == "KeyObtain" or obj.Name == "Wardrobe" or obj.Name == "Closet" then 
						local target = obj:IsA("Model") and (obj:FindFirstChild("Door") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
						if target and target:IsA("BasePart") then ESP:RemoveESP(target) end
					end
				end
			end)
		end)
	end,
});

-- ESP Монстров
ESPSection:AddToggle({
	Name = "ESP Монстров",
	Flag = "ESP_Monsters",
	Default = false,
	Callback = function(State)
		playClickSound()
		modStates.MonstersESP = State
		task.spawn(function()
			while modStates.MonstersESP do
				pcall(function()
					for _, obj in ipairs(Workspace:GetDescendants()) do
						if modStates.MonstersESP and (obj.Name == "RushMoving" or obj.Name == "AmbushMoving" or obj.Name == "Eyes" or obj.Name == "SeekMoving" or obj.Name == "Figure") then
							local target = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
							if target and target:IsA("BasePart") then
								ESP:AddESP({ Object = target, Text = "МОНСТР!", Color = Color3.fromRGB(255, 50, 50) })
							end
						end
					end
				end)
				task.wait(1)
			end
			pcall(function()
				for _, obj in ipairs(Workspace:GetDescendants()) do
					if obj.Name == "RushMoving" or obj.Name == "AmbushMoving" then 
						local target = obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")) or obj
						if target and target:IsA("BasePart") then ESP:RemoveESP(target) end
					end
				end
			end)
		end)
	end,
});

-- ESP Игроков
ESPSection:AddToggle({
	Name = "ESP Игроков",
	Flag = "ESP_Players",
	Default = false,
	Callback = function(State)
		playClickSound()
		modStates.PlayersESP = State
		task.spawn(function()
			while modStates.PlayersESP do
				pcall(function()
					for _, player in ipairs(Players:GetPlayers()) do
						if player ~= LocalPlayer and player.Character then
							local root = player.Character:FindFirstChild("HumanoidRootPart")
							if root and modStates.PlayersESP then
								ESP:AddESP({ Object = root, Text = player.Name, Color = modStates.TextColor })
							end
						end
					end
				end)
				task.wait(2)
			end
			pcall(function()
				for _, player in ipairs(Players:GetPlayers()) do
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						ESP:RemoveESP(player.Character.HumanoidRootPart)
					end
				end
			end)
		end)
	end,
});

LightSection:AddToggle({
	Name = "Взлом Фонарика (Видеть в темноте)",
	Flag = "Full_Bright",
	Default = false,
	Callback = function(State)
		playClickSound()
		modStates.FullBright = State
		task.spawn(function()
			while modStates.FullBright do
				Lighting.Brightness = 2
				Lighting.ClockTime = 14
				Lighting.FogEnd = 100000
				Lighting.GlobalShadows = false
				task.wait(1)
			end
			Lighting.Brightness = 1
			Lighting.GlobalShadows = true
		end)
	end,
});

-- 3. ВКЛАДКА "Т.Д"
local ExtraSection = ExtraTab:DrawSection({ Name = "Модификации", Position = 'left' });

ExtraSection:AddToggle({
	Name = "No-Clip (Сквозь стены)",
	Flag = "No_Clip",
	Default = false,
	Callback = function(State)
		playClickSound()
		modStates.NoClip = State
		local connection
		connection = RunService.Stepped:Connect(function()
			if not modStates.NoClip then
				connection:Disconnect()
				return
			end
			pcall(function()
				local char = LocalPlayer.Character
				if char then
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)
		end)
	end,
});

ExtraSection:AddToggle({
	Name = "Ускорение (Безопасное до 23)",
	Flag = "Speed_Boost",
	Default = false,
	Callback = function(State)
		playClickSound()
		modStates.SpeedBoost = State
		task.spawn(function()
			while modStates.SpeedBoost do
				pcall(function()
					local char = LocalPlayer.Character
					if char then
						local hum = char:FindFirstChildOfClass("Humanoid")
						local hrp = char:FindFirstChild("HumanoidRootPart")
						if hum and hrp and hum.MoveDirection.Magnitude > 0 then
							local currentVel = hrp.AssemblyLinearVelocity
							local targetVel = hum.MoveDirection * math.clamp(modStates.SpeedValue, 16, 23)
							hrp.AssemblyLinearVelocity = Vector3.new(targetVel.X, currentVel.Y, targetVel.Z)
						end
					end
				end)
				RunService.Heartbeat:Wait()
			end
		end)
	end,
});

ExtraSection:AddSlider({
	Name = "Скорость движения",
	Min = 16,
	Max = 23,
	Default = 21,
	Round = 0,
	Flag = "Speed_Slider",
	Callback = function(v)
		playClickSound()
		modStates.SpeedValue = math.clamp(v, 16, 23)
	end
});

local SettingsSec = SettingTab:DrawSection({ Name = "Параметры меню и звуков" });

SettingsSec:AddToggle({
	Name = "Включить звуки кликов",
	Default = true,
	Callback = function(v)
		soundSettings.Enabled = v
		if v then playClickSound() end
	end,
});

ThemeTab:DrawSection({ Name = "Темы Меню" }):AddDropdown({
	Name = "Выбрать тему",
	Default = "Default",
	Values = { "Default", "Dark Green", "Dark Blue", "Purple Rose", "Skeet" },
	Callback = function(v)
		playClickSound()
		Compkiller:SetTheme(v)
	end,
})

local ConfigUI = Window:DrawConfig({
	Name = "Конфиг",
	Icon = "folder
