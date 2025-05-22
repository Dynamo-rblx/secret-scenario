-- @ScriptType: LocalScript
local ts = game:GetService("TweenService")
local info = TweenInfo.new(.6, Enum.EasingStyle.Back, Enum.EasingDirection.In)

local Values = game:GetService("ReplicatedStorage"):WaitForChild("Values")
local playing = Values:WaitForChild("Playing")
local dead = Values:WaitForChild("Dead")

local goal = script.Parent:WaitForChild("Goal")

local playBTN = script.Parent:WaitForChild("PlayBTN")
local helpBTN = script.Parent:WaitForChild("HelpBTN")
local creditsBTN = script.Parent:WaitForChild("CreditsBTN")
local backBTN = script.Parent:WaitForChild("BackBTN")

local playDIS = script.Parent:WaitForChild("PlayFrame")
local helpDIS = script.Parent:WaitForChild("HelpFrame")
local creditsDIS = script.Parent:WaitForChild("CreditsFrame")

local cameras = workspace:WaitForChild("MenuCameras")


local debounce = false

local cam = workspace.CurrentCamera

repeat
	cam.CameraType = Enum.CameraType.Scriptable
until cam.CameraType == Enum.CameraType.Scriptable

goal.Value = cameras:WaitForChild("Title").CFrame
cam.CFrame = goal.Value

goal.Changed:Connect(function(val)
	local t = ts:Create(cam, info, {["CFrame"]=val})
	t:Play()
end)


local function toggleTitle(show: boolean, page:string)
	if show then
		playDIS:TweenSize(UDim2.fromScale(0,0), info.EasingDirection, info.EasingStyle, info.Time, true)
		helpDIS:TweenSize(UDim2.fromScale(0,0), info.EasingDirection, info.EasingStyle, info.Time, true)
		creditsDIS:TweenSize(UDim2.fromScale(0,0), info.EasingDirection, info.EasingStyle, info.Time, true)
		task.wait(info.Time)
		playDIS.Visible = false
		helpDIS.Visible = false
		creditsDIS.Visible = false

		playBTN:TweenPosition(UDim2.fromScale(.5,.7), info.EasingDirection, info.EasingStyle, info.Time, true)
		helpBTN:TweenPosition(UDim2.fromScale(.5,.786), info.EasingDirection, info.EasingStyle, info.Time, true)
		creditsBTN:TweenPosition(UDim2.fromScale(.5,.922), info.EasingDirection, info.EasingStyle, info.Time, true)
		backBTN:TweenPosition(UDim2.fromScale(-.45,.922), info.EasingDirection, info.EasingStyle, info.Time, true)
	else
		playBTN:TweenPosition(UDim2.fromScale(-.45,.7), info.EasingDirection, info.EasingStyle, info.Time, true)
		helpBTN:TweenPosition(UDim2.fromScale(1.45,.786), info.EasingDirection, info.EasingStyle, info.Time, true)
		creditsBTN:TweenPosition(UDim2.fromScale(-.45,.922), info.EasingDirection, info.EasingStyle, info.Time, true)
		backBTN:TweenPosition(UDim2.fromScale(.5,.922), info.EasingDirection, info.EasingStyle, info.Time, true)

		if page == "play" then
			playDIS.Visible = true
			playDIS:TweenSize(UDim2.fromScale(0.8, 0.725), info.EasingDirection, info.EasingStyle, info.Time, true)

		elseif page == "help" then
			helpDIS.Visible = true
			helpDIS:TweenSize(UDim2.fromScale(0.8, 0.725), info.EasingDirection, info.EasingStyle, info.Time, true)

		elseif page == "credits" then
			creditsDIS.Visible = true
			creditsDIS:TweenSize(UDim2.fromScale(0.8, 0.725), info.EasingDirection, info.EasingStyle, info.Time, true)

		end
	end

	return true
end


playBTN.MouseButton1Click:Connect(function()
	if debounce == false then
		debounce = true
		local complete = toggleTitle(false, "play")

		goal.Value = cameras.Round.CFrame
		repeat task.wait() until complete

		task.wait(0.001)
		debounce = false
	end

end)

helpBTN.MouseButton1Click:Connect(function()
	if debounce == false then
		debounce = true
		local complete = toggleTitle(false, "help")
		goal.Value = cameras.Help.CFrame
		repeat task.wait() until complete

		task.wait(0.001)
		debounce = false
	end

end)

creditsBTN.MouseButton1Click:Connect(function()
	if debounce == false then
		debounce = true
		local complete = toggleTitle(false, "credits")
		goal.Value = cameras.Credits.CFrame
		repeat task.wait() until complete

		task.wait(0.001)
		debounce = false
	end

end)

backBTN.MouseButton1Click:Connect(function()
	if debounce == false then
		debounce = true
		local complete = toggleTitle(true)
		goal.Value = cameras.Title.CFrame
		repeat task.wait() until complete

		task.wait(0.001)
		debounce = false
	end

end)

while task.wait(.05) do
	
	if playing:FindFirstChild(game.Players.LocalPlayer.Name) or dead:FindFirstChild(game.Players.LocalPlayer.Name) then
		if playing:FindFirstChild(game.Players.LocalPlayer.Name) then
			--print("Alive")
			backBTN.Visible = false
			backBTN.Active = false
			
			repeat
				cam.CameraType = Enum.CameraType.Custom
			until cam.CameraType == Enum.CameraType.Custom
			script.Parent.Enabled = false
		else
			--print("Dead")
			backBTN.Visible = true
			backBTN.Active = true
			
			repeat
				cam.CameraType = Enum.CameraType.Scriptable
			until cam.CameraType == Enum.CameraType.Scriptable
			script.Parent.Enabled = true
		end
		
		playBTN.Visible = false
		playBTN.Active = false
	else
		--print("Never Born")
		playBTN.Visible = true
		playBTN.Active = true
		
		backBTN.Visible = true
		backBTN.Active = true
		
		repeat
			cam.CameraType = Enum.CameraType.Scriptable
		until cam.CameraType == Enum.CameraType.Scriptable
		script.Parent.Enabled = true
	end
end

--local side_to_side = coroutine.create(function()
--	while task.wait() do
--		if script.Parent.Enabled then
--			for i=1, 200 do
--				cam.CFrame += Vector3.new(0,0,.001)
--				task.wait(.01)
--			end
--			task.wait(.1)
--			for i=1, 400 do
--				cam.CFrame += Vector3.new(0,0,-.001)
--				task.wait(.01)
--			end
--			task.wait(.1)
--		end		
--	end
--end)

--local cam_movement_magnitude = .1
--local mouse = game.Players.LocalPlayer:GetMouse()
--local maxTilt_X = .1
--local maxTilt_Y = .025
--game:GetService("RunService").RenderStepped:Connect(function()
--	cam.CFrame = cam.CFrame * CFrame.Angles(
--		math.rad((((mouse.Y - mouse.ViewSizeY / 2) / mouse.ViewSizeY)) * -maxTilt_Y),
--		math.rad((((mouse.X - mouse.ViewSizeX / 2) / mouse.ViewSizeX)) * -maxTilt_X),
--		0
--	)


--end)

--game:GetService("RunService").PostSimulation:Connect(function()
--	if workspace.MenuLight then
--		workspace.MenuLight.Position = cam.CFrame.Position
--		workspace.MenuLight.CFrame = cam.CFrame*cam.CFrame.Rotation
--	end
--end)

--while task.wait() do

--	if script.Parent.Enabled then

--	--	--if	coroutine.status(side_to_side) == "suspended" then
--	--	--	coroutine.resume(side_to_side)
--	--	--end

--	--	for i=1, 300 do

--	--		cam.CFrame = CFrame.new(Vector3.new(cam.CFrame.Position.X,((i/300)*cam_movement_magnitude) + 7.874,cam.CFrame.Position.Z))
--	--		task.wait(.01)
--	--	end
--	--	task.wait()
--	--	for i=1, 600 do
--	--		cam.CFrame = CFrame.new(Vector3.new(cam.CFrame.Position.X,(.005-(i/300)*cam_movement_magnitude) + 7.874,cam.CFrame.Position.Z))
--	--		task.wait(.01)
--	--	end
--	--	task.wait(.1)
--	----else
--	----	if	coroutine.status(side_to_side) == "running" then
--	----		coroutine.yield(side_to_side)
--	----	end
--	end
--end