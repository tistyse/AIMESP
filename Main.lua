--chams
local Enabled = false;
local TeamCheck = false;
local TeamColors = false;
local HideFriendly = false;
local HideEnemy = false;
local Storage = game:GetService("CoreGui");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Neutral = Color3.fromRGB(255, 255, 255);
local Friendly = Color3.fromRGB(47, 211, 61);
local Enemy = Color3.fromRGB(211, 47, 47);
--esp
local Esp = false
local Names = false
local ColoEs = Color3.fromRGB(255, 255, 255)
local ColoNa = Color3.fromRGB(255, 255, 255)

--aimbot
local dwCamera = workspace.CurrentCamera
local dwRunService = game:GetService("RunService")
local dwUIS = game:GetService("UserInputService")
local dwEntities = game:GetService("Players")
local dwLocalPlayer = dwEntities.LocalPlayer
local dwMouse = dwLocalPlayer:GetMouse()
local safe = setmetatable({}, {
	__index = function(_, k)
		return game:GetService(k)
	end
})
local PlayerTable = {}

for i,v in pairs(game:GetService("Players"):GetPlayers()) do 
	if v ~= dwLocalPlayer then
		table.insert(PlayerTable,v.Name)
	end
end
local cam = safe.Workspace.CurrentCamera -- Current Camera
local lp = safe.Players.LocalPlayer -- Local Player
local lpc = safe.Players.LocalPlayer.Character -- Local Player Character
local function inlos(p, ...) -- In line of site?
	return #cam:GetPartsObscuringTarget({p}, {cam, lp.Character, ...}) == 0
end


local settings = {
	Aimbot = false,
	Aiming = false,
	Aimbot_AimPart = "Head",
	Aimbot_TeamCheck = false,
	Aimbot_Draw_FOV = true,
	Aimbot_FOV_Radius = 200,
	Aimbot_FOV_Color = Color3.fromRGB(255,255,255),
	Aimbot_visiblecheck = false,
	Aimbot_Key = Enum.KeyCode.LeftShift,
	Aimbot_Onscreen = true
}


local fovcircle = Drawing.new("Circle")
fovcircle.Visible = settings.Aimbot_Draw_FOV
fovcircle.Radius = settings.Aimbot_FOV_Radius
fovcircle.Color = settings.Aimbot_FOV_Color
fovcircle.Thickness = 1
fovcircle.Filled = false
fovcircle.Transparency = 0

fovcircle.Position = Vector2.new(dwCamera.ViewportSize.X / 2, dwCamera.ViewportSize.Y / 2)



dwRunService.RenderStepped:Connect(function()

	local dist = math.huge
	local closest_char = nil
	if settings.Aimbot then
		if settings.Aiming then

			for i,v in next, dwEntities:GetChildren() do 

				if v ~= dwLocalPlayer and
					v.Character and
					v.Character:FindFirstChild("HumanoidRootPart") and
					v.Character:FindFirstChild("Humanoid") and
					v.Character:FindFirstChild("Humanoid").Health > 0 then

					if settings.Aimbot_TeamCheck == true and
						v.Team ~= dwLocalPlayer.Team or
						settings.Aimbot_TeamCheck == false then

						local char = v.Character
						local char_part_pos, is_onscreen = dwCamera:WorldToViewportPoint(char[settings.Aimbot_AimPart].Position)

						if is_onscreen and settings.Aimbot_Onscreen or settings.Aimbot_Onscreen == false then

							local mag = (Vector2.new(dwMouse.X, dwMouse.Y) - Vector2.new(char_part_pos.X, char_part_pos.Y)).Magnitude

							if mag < dist and mag < settings.Aimbot_FOV_Radius then

								dist = mag
								closest_char = char

							end
						end
					end
				end
			end

			if closest_char ~= nil and
				closest_char:FindFirstChild("HumanoidRootPart") and
				closest_char:FindFirstChild("Humanoid") and
				closest_char:FindFirstChild("Humanoid").Health > 0 then
				if inlos(closest_char:FindFirstChild("HumanoidRootPart").Position, closest_char) and settings.Aimbot_visiblecheck then
					dwCamera.CFrame = CFrame.new(dwCamera.CFrame.Position, closest_char[settings.Aimbot_AimPart].Position)
				elseif not settings.Aimbot_visiblecheck then
					dwCamera.CFrame = CFrame.new(dwCamera.CFrame.Position, closest_char[settings.Aimbot_AimPart].Position)
				end
			end
		end
	elseif not settings.Aimbot then
	end
end)


game:GetService('RunService').Stepped:connect(function()
	if aimbotting then
		--MouseTests()
	end
end)


local plr = safe.Players.LocalPlayer
local mouse = plr:GetMouse()


local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cueshut/saves/main/criminality%20paste%20ui%20library'))()

-- // Window \\ --
local window = library.new('Kramos Menu', 'Kramos')

-- // Tabs \\ --
local tab = window.new_tab('rbxassetid://4483345998')

-- // Sections \\ --
local section = tab.new_section('Aimbot')
local section1 = tab.new_section('Visual')
local section2 = tab.new_section('Misc')

-- // Sector \\ --
local sector = section.new_sector('AIMBOT OP', 'Left')
local sector1 = section1.new_sector('ESP WRD API', 'Left')
local sector3 = section1.new_sector('ESP KRAMOS', 'Right')
local sector2 = section2.new_sector('MISC', 'Left')

-- // Elements \\ -- (Type, Name, State, Callback)


local toggle = sector.element('Toggle', 'Aimbot', false, function(v)
	settings.Aimbot = v.Toggle

end)
local toggle2 = sector.element('Toggle', 'TeamCheck', false, function(v)
	settings.Aimbot_TeamCheck = v.Toggle

end)
local toggle3 = sector.element('Toggle', 'VisibleCheck', false, function(v)
	settings.Aimbot_visiblecheck = v.Toggle

end)
local toggle4 = sector.element('Toggle', 'OnScreen', false, function(v)
	settings.Aimbot_Onscreen = v.Toggle

end)
local toggle5 = sector.element('Toggle', 'DrawnFov', false, function(v)
	if v.Toggle == true then
		fovcircle.Transparency = 1
		print(1) 
	elseif v.Toggle == false then
		fovcircle.Transparency = 0
		print(0) 
	end
end)
local slider = sector.element('Slider', 'Fov Radious', {default = {min = 50, max = 1500, default = 200}}, function(v)
	settings.Aimbot_FOV_Radius = v.Slider
	fovcircle.Radius = v.Slider
end)
local dropdown = sector.element('Dropdown', 'Aimbot Key', {options = {'-','LeftShift', 'LeftAlt', 'X'}}, function(v)
	if v.Dropdown == "LeftShift" then
		settings.Aimbot_Key = Enum.KeyCode.LeftShift
	elseif v.Dropdown == "LeftAlt" then
		settings.Aimbot_Key = Enum.KeyCode.LeftAlt
	elseif v.Dropdown == "X" then
		settings.Aimbot_Key = Enum.KeyCode.X
	end

end)


dwUIS.InputBegan:Connect(function(inputObject,gameProcessed)
	if inputObject.KeyCode == settings.Aimbot_Key then
		settings.Aiming = true

	end
end)

dwUIS.InputEnded:Connect(function(inputObject,gameProcessed)
	if inputObject.KeyCode == settings.Aimbot_Key then
		settings.Aiming = false

	end
end)

local dropdown2 = sector.element('Dropdown', 'Aimbot Part', {options = {'-','Head', 'Torso', 'HumanoidRootPart'}}, function(v)
	settings.Aimbot_AimPart = v.Dropdown
	print(settings.Aimbot_AimPart)
end)




--section/r1
local toggleA = sector1.element('Toggle', 'ESP BOX', false, function(v)
	_G.WRDESPBoxes = v.Toggle
end)
local toggleB = sector1.element('Toggle', 'ESP NAME', false, function(v)
	_G.WRDESPNames = v.Toggle
end)
local toggleC = sector1.element('Toggle', 'ESP LINE', false, function(v)
	_G.WRDESPTracers = v.Toggle
end)
local toggleD = sector1.element('Toggle', 'CHAMS', false, function(v)
	Enabled = v.Toggle
end)
local toggleE = sector1.element('Toggle', 'CHAMS TEM COLORS', false, function(v)
	TeamCheck = v.Toggle
end)
local toggleF = sector1.element('Toggle', 'HIDE FRIENDLY', false, function(v)
	HideFriendly = v.Toggle
end)
local toggleAS = sector3.element('Toggle', 'ESP BOX KRMS', false, function(v)
	Esp = v.Toggle
end)toggleAS:add_color({Color = Color3.fromRGB(255, 255, 255)}, nil, function(v)
	print(v.Color)
	ColoEs = v.Color
end)
local toggleBS = sector3.element('Toggle', 'ESP NAME KRMS', false, function(v)
	Names = v.Toggle
end)toggleBS:add_color({Color = Color3.fromRGB(255, 255, 255)}, nil, function(v)
	print(v.Color)
	ColoNa = v.Color
end)
--Sector2
local tpspeeddd = 1

local button = sector2.element('Button', 'FLY PRESS (T)', nil, function()
	repeat wait() 
	until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
	local mouse = game.Players.LocalPlayer:GetMouse() 
	repeat wait() until mouse
	local plr = game.Players.LocalPlayer 
	local torso = plr.Character.Head 
	local flying = false
	local deb = true 
	local ctrl = {f = 0, b = 0, l = 0, r = 0} 
	local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
	local maxspeed = 100 
	local speed = 0 

	function Fly() 
		local bg = Instance.new("BodyGyro", torso) 
		bg.P = 9e4 
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
		bg.cframe = torso.CFrame 
		local bv = Instance.new("BodyVelocity", torso) 
		bv.velocity = Vector3.new(0,0.1,0) 
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 

		repeat wait() 
			plr.Character.Humanoid.PlatformStand = true 
			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
				speed = speed+.5+(speed/maxspeed) 

				if speed > maxspeed then 

					speed = maxspeed 

				end 


			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 

				speed = speed-1 
				if speed < 0 then 
					speed = 0 

				end 

			end 

			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 

				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 

			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
			else 
				bv.velocity = Vector3.new(0,0.1,0) 
			end 

			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
		until not flying 

		ctrl = {f = 0, b = 0, l = 0, r = 0} 
		lastctrl = {f = 0, b = 0, l = 0, r = 0} 
		speed = 0 
		bg:Destroy() 
		bv:Destroy() 
		plr.Character.Humanoid.PlatformStand = false 

	end 


	mouse.KeyDown:connect(function(key) 

		if key:lower() == "t" then 
			if flying then flying = false 
			else 

				flying = true 
				Fly() 
			end 

		elseif key:lower() == "w" then 

			ctrl.f = 1 

		elseif key:lower() == "s" then 

			ctrl.b = -1 

		elseif key:lower() == "a" then 

			ctrl.l = -1 

		elseif key:lower() == "d" then 

			ctrl.r = 1 

		end 
	end) 


	mouse.KeyUp:connect(function(key) 

		if key:lower() == "w" then 

			ctrl.f = 0 

		elseif key:lower() == "s" then 

			ctrl.b = 0 

		elseif key:lower() == "a" then 

			ctrl.l = 0 

		elseif key:lower() == "d" then 

			ctrl.r = 0 

		end 
	end)
	Fly()
end)
local button1 = sector2.element('Button', 'INF JUMP', nil, function()
	game:GetService("UserInputService").JumpRequest:connect(function()
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end)
end)
local dropdownA = sector2.element('Dropdown', 'TP', {options = PlayerTable}, function(v)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[v.Dropdown].Character.HumanoidRootPart.CFrame * CFrame.new(0,0,1)
end)
local tpspeeddd = 1

local Atp = false
local toggle101 = sector2.element('Toggle', 'AT/TP', false, function(p)
	Atp = p.Toggle
	while task.wait(1) do
		for i,v in next, dwEntities:GetChildren() do 
			if v.Team ~= dwLocalPlayer.Team or v.Team == nil then
				if v ~= game.Players.LocalPlayer or v == nil then
					if v.Character:FindFirstChild("Humanoid").Health > 0 then
						if Atp == true then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
							wait(tpspeeddd)
						else
							return
						end
					end
				end
			end
		end
	end
end)
local sliderATP = sector2.element('Slider', 'AT/TP TIME', {default = {min = 0, max = 5, default = 1}}, function(v)
	tpspeeddd = v.Slider
end)

local toggleCU = sector2.element('Toggle', 'FLOOD TEXT', false, function(v)
	if v.Toggle == true then
		while task.wait(0) do
			if v.Toggle == true then
				if game.PlaceId == 286090429 then
					--arsenal
					local A_1 = "K̶R̶A̶M̶O̶S̶ ̶M̶E̶N̶U̶ ̶/̶ ̶W̶E̶A̶R̶E̶D̶E̶V̶S̶"
					local A_2 = "All"
					local A_3 = false
					local A_5 = false
					local A_6 = true
					local Event = game:GetService("ReplicatedStorage").Events.PlayerChatted
					Event:FireServer(A_1, A_2, A_3, A_5, A_6)
				else 
					-- General

					local A_1 = "K̶R̶A̶M̶O̶S̶ ̶M̶E̶N̶U̶ ̶/̶ ̶W̶E̶A̶R̶E̶D̶E̶V̶S̶"
					local A_2 = "All"
					local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
					Event:FireServer(A_1, A_2)
				end
			end
		end
	elseif v.Toggle == false then
	end
end)
_G.Filled = true
_G.Visible = false


local function CreateHighlight(plr)
	repeat wait() until plr.Character ~= nil;
	local e = Instance.new("Highlight", Storage);
	e.OutlineColor = Color3.fromRGB(0, 0, 0);
	e.OutlineTransparency = 0.6;
	e.Adornee = plr.Character

	local bb = RunService.RenderStepped:Connect(function()
		e.Enabled = Enabled;

		if TeamCheck then
			if plr.Team == Players.LocalPlayer.Team then
				if HideFriendly then e.Enabled = false end
				e.FillColor = Friendly
			else
				if HideEnemy then e.Enabled = false end
				e.FillColor = Enemy;
			end

			if TeamColors then
				e.FillColor = plr.Team.TeamColor.Color;
			end
		else
			e.FillColor = Neutral;
		end
	end)

	plr.CharacterRemoving:Connect(function()
		e:Destroy()
		bb:Disconnect()
	end)
end

for i, v in ipairs(Players:GetChildren()) do
	if v.Character then
		CreateHighlight(v);
	end
	v.CharacterAdded:Connect(function()
		CreateHighlight(v);
	end)
end

Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		CreateHighlight(plr);
	end)
end)
--ESP


--Kramos Here
local Player = game:GetService("Players").LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = Player:GetMouse()
local ps = game:GetService("Players")
local rs = game:GetService("RunService")


local function Dist(pointA, pointB) -- magnitude errors for some reason : (
	return math.sqrt(math.pow(pointA.X - pointB.X, 2) + math.pow(pointA.Y - pointB.Y, 2))
end

local function GetClosest(points, dest)
	local min = math.huge
	local closest = nil
	for _,v in pairs(points) do
		local dist = Dist(v, dest)
		if dist < min then
			min = dist
			closest = v
		end
	end
	return closest
end

local function DrawESP(plr)
	local Box = Drawing.new("Quad")
	Box.Visible = Esp
	Box.PointA = Vector2.new(0, 0)
	Box.PointB = Vector2.new(0, 0)
	Box.PointC = Vector2.new(0, 0)
	Box.PointD = Vector2.new(0, 0)
	Box.Color = ColoEs
	Box.Thickness = 2
	Box.Transparency = 1

	local function Update()
		local c
		c = game:GetService("RunService").RenderStepped:Connect(function()
			if plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
				local pos, vis = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
				if vis then
					local points = {}
					local c = 0
					for _,v in pairs(plr.Character:GetChildren()) do
						if v:IsA("BasePart") then
							c = c + 1
							local p = Camera:WorldToViewportPoint(v.Position)
							if v.Name == "HumanoidRootPart" then
								p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, 0, -v.Size.Z)).p)
							elseif v.Name == "Head" then
								p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, v.Size.Y/2, v.Size.Z/1.25)).p)
							elseif string.match(v.Name, "Left") then
								p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2, 0, 0)).p)
							elseif string.match(v.Name, "Right") then
								p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2, 0, 0)).p)
							end
							points[c] = p
						end
					end
					local Left = GetClosest(points, Vector2.new(0, pos.Y))
					local Right = GetClosest(points, Vector2.new(Camera.ViewportSize.X, pos.Y))
					local Top = GetClosest(points, Vector2.new(pos.X, 0))
					local Bottom = GetClosest(points, Vector2.new(pos.X, Camera.ViewportSize.Y))

					if Left ~= nil and Right ~= nil and Top ~= nil and Bottom ~= nil then
						Box.PointA = Vector2.new(Right.X, Top.Y)
						Box.PointB = Vector2.new(Left.X, Top.Y)
						Box.PointC = Vector2.new(Left.X, Bottom.Y)
						Box.PointD = Vector2.new(Right.X, Bottom.Y)
						Box.Color = ColoEs	
						Box.Visible = Esp
					else
						Box.Visible = false
					end
				else
					Box.Visible = false
				end
			else
				Box.Visible = false
				if game.Players:FindFirstChild(plr.Name) == nil then
					c:Disconnect()
				end
			end
		end)
	end
	coroutine.wrap(Update)()
end


for _,v in pairs(game:GetService("Players"):GetChildren()) do
	if v.Name ~= Player.Name then
		DrawESP(v)
	end
end

game:GetService("Players").PlayerAdded:Connect(function(v)
	DrawESP(v)
end)

local function esp(p,cr)
	local h = cr:WaitForChild("Humanoid")
	local hrp = cr:WaitForChild("Head")

	local text = Drawing.new("Text")
	text.Visible = Names
	text.Center = true
	text.Outline = true 
	text.Font = 2
	text.Color = ColoNa
	text.Size = 13

	local c1
	local c2
	local c3

	local function dc()
		text.Visible = false
		text:Remove()
		if c1 then
			c1:Disconnect()
			c1 = nil 
		end
		if c2 then
			c2:Disconnect()
			c2 = nil 
		end
		if c3 then
			c3:Disconnect()
			c3 = nil 
		end
	end

	c2 = cr.AncestryChanged:Connect(function(_,parent)
		if not parent then
			dc()
		end
	end)

	c3 = h.HealthChanged:Connect(function(v)
		if (v<=0) or (h:GetState() == Enum.HumanoidStateType.Dead) then
			dc()
		end
	end)

	c1 = rs.RenderStepped:Connect(function()
		local hrp_pos,hrp_onscreen = Camera:WorldToViewportPoint(hrp.Position)
		if hrp_onscreen then
			text.Position = Vector2.new(hrp_pos.X, hrp_pos.Y - 10)
			text.Text = p.Name
			text.Color = ColoNa
			text.Visible = Names
		else
			text.Visible = false
		end
	end)
end

local function p_added(p)
	if p.Character then
		esp(p,p.Character)
	end
	p.CharacterAdded:Connect(function(cr)
		esp(p,cr)
	end)
end

for i,p in next, ps:GetPlayers() do 
	if p ~= Player then
		p_added(p)
	end
end


ps.PlayerAdded:Connect(p_added)
--local sliderSPE = sector2.element('Slider', 'PLAYER SPEED', {default = {min = 1, max = 500, default = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed}}, function(v)
--	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v.Slider
--end)
--local sliderGRA = sector2.element('Slider', 'GRAVITY', {default = {min = 1, max = 200, default = game.Workspace.Gravity}}, function(v)
--	game.Workspace.Gravity = v.Slider
--end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/tistyse/ESP/refs/heads/main/Main.lua", true))()
