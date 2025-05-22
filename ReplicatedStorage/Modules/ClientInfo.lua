-- @ScriptType: ModuleScript
local ClientInfo = {
	["Playing"] = {},
	
	["Dead"] = {},
	
	
	
}

function ClientInfo.HasPlayed(plr: Player)
	if table.find(ClientInfo.Playing, plr.Name) or table.find(ClientInfo.Dead, plr.Name) then
		return true
	else
		return nil
	end
end

function ClientInfo.IsAlive(plr: Player)
	if table.find(ClientInfo.Playing, plr.Name) then
		return true
	else
		return nil
	end
end

function ClientInfo.IsDead(plr: Player)
	if table.find(ClientInfo.Dead, plr.Name) then
		return true
	else
		return nil
	end
end

function ClientInfo.Birth(plr: Player)
	if table.find(ClientInfo.Dead, plr.Name) then
		table.remove(ClientInfo.Dead, table.find(ClientInfo.Dead, plr.Name))
	end
	
	table.insert(ClientInfo.Playing, plr.Name)
	--print(ClientInfo.Playing, ClientInfo.Dead)
end

function ClientInfo.Kill(plr: Player)
	if table.find(ClientInfo.Playing, plr.Name) then
		table.remove(ClientInfo.Playing, table.find(ClientInfo.Playing, plr.Name))
	end
	
	table.insert(ClientInfo.Dead, plr.Name)
end

function ClientInfo:Reset()
	ClientInfo.Playing = {}
	ClientInfo.Dead = {}
end

function ClientInfo:KillAll()
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		ClientInfo.Kill(v)
	end
end

function ClientInfo:Replicate()
	local value_folder = game:GetService("ReplicatedStorage"):WaitForChild("Values")
	local playing = value_folder:WaitForChild("Playing")
	local dead = value_folder:WaitForChild("Dead")
	local template = value_folder:WaitForChild("template")
	
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
			
			new_val.AncestryChanged:Connect(function()
				if new_val.Parent ~= nil then
					new_val.Parent = playing
				end
			end)
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
			
			new_val.AncestryChanged:Connect(function()
				if new_val.Parent ~= nil then
					new_val.Parent = dead
				end
			end)
		end
	end
end

return ClientInfo
