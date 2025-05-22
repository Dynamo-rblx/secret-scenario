-- @ScriptType: LocalScript
game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)

local ClientInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ClientInfo"))

while task.wait() do
	if ClientInfo.IsAlive(game.Players.LocalPlayer) then
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	else
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	end
end