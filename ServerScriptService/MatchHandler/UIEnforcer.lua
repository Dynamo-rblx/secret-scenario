-- @ScriptType: Script
local ClientInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ClientInfo"))
local value_folder = game:GetService("ReplicatedStorage"):WaitForChild("Values")
local playing = value_folder:WaitForChild("Playing")
local dead = value_folder:WaitForChild("Dead")
local template = value_folder:WaitForChild("template")


function Replicate()
	for i, value: IntValue in pairs(playing:GetChildren()) do
		task.wait()
		if not(table.find(ClientInfo.Playing, value.Name)) then
			value:Destroy()
		end
	end

	for i, plrName in pairs(ClientInfo.Playing) do
		task.wait()
		if not(playing:FindFirstChild(plrName)) then
			local new_val = template:Clone()
			new_val.Name = plrName
			new_val.Value = i
			new_val.Parent = playing
		end
	end

	for i, value: IntValue in pairs(dead:GetChildren()) do
		task.wait()
		if not(table.find(ClientInfo.Playing, value.Name)) then
			value:Destroy()
		end
	end

	for i, plrName in pairs(ClientInfo.Dead) do
		task.wait()
		if not(dead:FindFirstChild(plrName)) then
			local new_val = template:Clone()
			new_val.Name = plrName
			new_val.Value = i
			new_val.Parent = dead
		end
	end
end

while task.wait() do
	Replicate()
end