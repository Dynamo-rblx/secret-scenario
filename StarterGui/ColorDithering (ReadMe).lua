-- @ScriptType: LocalScript
----- Thanks for opening the script!!

-- Key details: Reccomended intensity is between 1 and 50. Anything above will result in general grossness
-- Have fun!




local FrustrumDistance = 1


local part = Instance.new("Part")
part.Name = "DITHERING"
part.Parent = workspace

part.Anchored = true
part.CanCollide = false
part.CanQuery = false
part.CanTouch = false

part.Transparency = 1


local sgui = script.DitheringGUI
sgui.Parent = part

sgui.Adornee = part
sgui.Face = Enum.NormalId.Back


local cc = script.ColorCorrection
cc.Parent = game.Lighting



game["Run Service"]:BindToRenderStep("Dithering", Enum.RenderPriority.Last.Value, function(dt)
	
	local intensity = math.clamp(script:GetAttribute("Intensity"), 1, 100)
	
	
	local cam = workspace.CurrentCamera
	
	local v2 = cam.ViewportSize.Unit*10
	
	part.Size = Vector3.new(v2.X, v2.Y, 0.005)
	
	part.CFrame = cam.CFrame*CFrame.new(-Vector3.zAxis*FrustrumDistance)
	
	
	
	sgui.ImageLabel.BackgroundTransparency = 1/intensity
	
	cc.Contrast = intensity
	cc.Saturation = -0.001*intensity
	cc.Brightness = -0.01*intensity
	
end)