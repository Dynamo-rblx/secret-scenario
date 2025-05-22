-- @ScriptType: ModuleScript
local storage = game:GetService("ServerStorage"):WaitForChild("Models"):WaitForChild("Monsters")
local vote_module = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("VoteCount"))

local Monster = {}

function Monster.Create(map_model: Model)
	local monster, method, winners, map, length = vote_module.getRoundSettings()
	
	if monster == "Tracker" then
		local tracker_monster
		
		return true
	elseif monster == "The Fog" then
		
		return true
	elseif monster == "Traitor" then
		
		return true
	elseif monster == "Apocalypse" then
		local zombie = storage:WaitForChild("Zombie")
		local zombieSpawns = map_model:WaitForChild("apocalypse_spawnpoints")
		
		while vote_module.TimeLeft > 0 do
			for i, v in pairs(zombieSpawns:GetChildren()) do
				local clone = zombie:Clone()
				clone.CFrame = v.CFrame
				clone.Parent = workspace:WaitForChild("Monsters")
			end
			
			for i=0, 30, 1 do
				task.wait(1)
				if vote_module.TimeLeft <= 0 then break end
			end
		end
		
		return true
	elseif monster == "Mimic" then
		
		return true
	elseif monster == "None" then
		
		return true
	end
	
	return
end

function Monster:Terminate()
	local monster, method, winners, map, length = vote_module.getRoundSettings()

	if monster == "Tracker" then
		

		return true
	elseif monster == "The Fog" then


		return true
	elseif monster == "Traitor" then


		return true
	elseif monster == "Apocalypse" then
		

		return true
	elseif monster == "Mimic" then


		return true
	elseif monster == "None" then


		return true
	end

	return
end

return Monster
