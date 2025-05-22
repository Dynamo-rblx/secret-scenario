-- @ScriptType: LocalScript
--[[

	youtube.com/c/TwinPlayz_YT
	
	Put into StarterPlayerScripts

--]]

local ProximityPromptService = game:GetService("ProximityPromptService")
local Players = game:GetService("Players")

ProximityPromptService.PromptShown:Connect(function(proximityPrompt)
	local highlightAdornee = proximityPrompt:FindFirstAncestorWhichIsA("PVInstance")

	local newHighlight = Instance.new("Highlight")
	newHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
	newHighlight.FillColor = Color3.fromRGB(230, 230, 230)
	newHighlight.FillTransparency = 0.75
	newHighlight.Adornee = highlightAdornee
	newHighlight.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	proximityPrompt.PromptHidden:Once(function()
		newHighlight:Destroy()
	end)
end)