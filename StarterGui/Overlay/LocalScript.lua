-- @ScriptType: LocalScript
local rng = Random.new()

local framerate = 60
local framerate_enabled = true

local cache = os.clock()

game["Run Service"].RenderStepped:Connect(function()
	if not framerate_enabled or os.clock() - cache > 1 / framerate then
		cache = os.clock()
		
		script.Parent.noise.Position = UDim2.fromScale(rng:NextNumber(-1, 0), rng:NextNumber(-1, 0))
	end
end)