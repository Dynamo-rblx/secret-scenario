-- @ScriptType: Script
-- < VARIABLES > --
-- SERVICES
local REP_STORE = game:GetService("ReplicatedStorage")
local SERV_STORE = game:GetService("ServerStorage")
local PLAYERS = game:GetService("Players")
local utility = require(script:WaitForChild("Utility"))
local method_module = require(script:WaitForChild("MethodHandler"))
local monster_module = require(script:WaitForChild("MonsterHandler"))
local ClientInfo = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ClientInfo"))

-- FOLDERS
local events = REP_STORE:WaitForChild("Events")
local modules = REP_STORE:WaitForChild("Modules")
local models = SERV_STORE:WaitForChild("Models")
local maps = models:WaitForChild("Maps")
local monster_models = models:WaitForChild("Monsters")

-- ROUND MANAGING VARIABLES
local ROUND_start = events:WaitForChild("StartRound")
local ROUND_stop = events:WaitForChild("StopRound")

local INTERMISSION_start = events:WaitForChild("StartIntermission")
local INTERMISSION_stop = events:WaitForChild("StopIntermission")

local VOTING_start = events:WaitForChild("StartVoting")
local VOTING_stop = events:WaitForChild("StopVoting")

local allowed_winners: number
local monster_folder = workspace:WaitForChild("Monsters")

local game_map: Model

-- WAIT TIME VARIABLES
local intermission_waitTime = 10
local voting_waitTime = 15
local round_waitTime: number

-- VOTING VARIABLES
local vote_module = require(modules:WaitForChild("VoteCount"))
local options = vote_module.Elements
local topics = vote_module.Topics
local rand = Random.new()
local CLIENT_VOTER = events:WaitForChild("ClientVoter")
local responded = {}


-- < FUNCTIONS > --
-- COROUTINE FUNCTION
local routine = coroutine.create(
	function()
		while task.wait() do
			ClientInfo:Replicate()
		end
	end
)

-- GET FUNCTIONS
local function getVoteTopics() -- Returns the iterations of 2 different elements
	local choose1 = rand:NextInteger(1, 5)
	local choose2 = rand:NextInteger(1, 5)

	repeat choose2 = rand:NextInteger(1, 5) until choose1 ~= choose2
	
	return choose1 :: number, choose2 :: number
end

local function getRandomElements() -- Returns a table of the 5 randomly selected elements
	local chosen:{string} = {}
	
	chosen[1] = options.Monsters[rand:NextInteger(1, #options.Monsters)] -- MONSTER
	chosen[2] = options.Methods[rand:NextInteger(1, #options.Methods)] -- METHOD
	chosen[3] = options.Winners[rand:NextInteger(1, #options.Winners)] -- # WINNER
	chosen[4] = options.Maps[rand:NextInteger(1, #options.Maps)] -- MAP
	chosen[5] = options.Lengths[rand:NextInteger(1, #options.Lengths)] -- LENGTH
	
	return chosen
end






-- END FUNCTIONS
local function endIntermission()
	utility.setPlayTabText("Intermission Period Has Ended")
	task.wait(2)	
	INTERMISSION_stop:FireAllClients()
	
	return
end

local function endRound()
	monster_module:Terminate()
	utility.setPlayTabText("Round Has Ended")
	task.wait(2)
	
	for i, v in pairs(PLAYERS:GetPlayers()) do
		v.Character:MoveTo(workspace.SpawnLocation.Position)
	end
	
	ROUND_stop:FireAllClients()
	ClientInfo:Reset()

	return
end

local function endVoting(c1, c2, winner1, winner2)
	utility.packPlayTabChoices()
	utility.setPlayTabText("Voting Has Ended")
	task.wait(2)
	VOTING_stop:FireAllClients()
	utility.displayResults(topics[c1], topics[c2], winner1, winner2)
	task.wait(4)
	utility.packResults()
	responded = {}
	vote_module.Reset()

	
	return
end




--[[
TODO:
	[DONE] Fix voting (it doesn't count your vote b/c there was a tie btwn 0 & 0)	Just don't do anything for ties
	Finish match system
	Work on monsters
	Work on win methods
	Work on spectator system and mid-round joins
	Work on game-item placement and game mechanics
	Add leaderboard (rewards)
	Add donation button to credits window
	Refine UI
	Change chat system ui (font, etc.)
	Add lore
]]

-- RUN FUNCTIONS
local function runVoting()
	local baseChoices = getRandomElements()
	local c1, c2 = getVoteTopics()
	--print(c1, c2) ==================== 0 1
	--print(options[c1], options[c2]) ========== nil nil
	VOTING_start:FireAllClients(topics[c1], topics[c2])
	utility.displayPlayTabChoices(topics[c1], topics[c2])
	
	local ticker = CLIENT_VOTER.Event:Connect(function(plr: Player, element: string, decision: string)
		if not(table.find(responded, plr)) then
			table.insert(responded, plr)
			vote_module.Add(element, decision, 1) -- EX. vote_module.Add(vote_module.Monsters.Tracker)
			
		end
		
	end)
	
	for i=voting_waitTime, 0, -1 do
		utility.setPlayTabText("Voting ("..i..")")
		task.wait(1)
		
		if #responded == #PLAYERS:GetPlayers() then
			break
		end
	end
	
	
	--print(c1, c2)
	--print(topics)
	--print(topics[c1], topics[c2])
	local winner1, winner2 = vote_module.getWinners(topics[c1]), vote_module.getWinners(topics[c2])
	--local index1, index2 = table.find(vote_module.Elements, c1), table.find(vote_module.Elements, c2)
	
	baseChoices[c1] = winner1
	baseChoices[c2] = winner2
	
	
	vote_module.setRoundSettings(baseChoices[1], baseChoices[2], baseChoices[3], baseChoices[4], baseChoices[5])
	
	ticker:Disconnect()
	endVoting(c1, c2, winner1, winner2)
	return
end

local function initializeRound()
	local monster, method, winners, map, length = vote_module.getRoundSettings()
	
	if length == "1 Minute" then
		round_waitTime = 1 * 60
		
	elseif length == "5 Minutes" then
		round_waitTime = 5 * 60
		
	elseif length == "10 Minutes" then
		round_waitTime = 10 * 60
		
	end
	
	local map_model = maps:WaitForChild(map)
	game_map = map_model:Clone()
	
	game_map.Parent = workspace:WaitForChild("Map")
	
	for i, v in pairs(PLAYERS:GetPlayers()) do
		ClientInfo.Birth(v)
		
		local spawns = game_map.player_spawnpoints:GetChildren()
		
		local chosen_spawn = spawns[rand:NextInteger(1, #spawns)]
		v.Character:MoveTo(chosen_spawn.Position)
		
		task.wait()
	end
	
	monster_module.Create(game_map)
	
	
end


local function runRound()
	--local monster, method, winners, map, length = vote_module.getRoundSettings()
	initializeRound()
	--if winners	== "1" then
	--	utility.setPlayTabText(monster.." | "..method.." | "..winners.." Winner | "..map.." | "..length)
	--else
	--	utility.setPlayTabText(monster.." | "..method.." | "..winners.." Winners | "..map.." | "..length)
	--end
	
	task.wait(2)
	
	vote_module.SetTimeLeft(round_waitTime)
	
	for i=round_waitTime, 0, -1 do
		utility.setPlayTabText("Playing ("..i..")")
		task.wait(1)
		vote_module.SetTimeLeft(i)
	end
	
	endRound()
	return
end


local function runIntermission()
	INTERMISSION_start:FireAllClients()
	
	for i=intermission_waitTime, 0, -1 do
		utility.setPlayTabText("Intermission ("..i..")")
		task.wait(1)
	end
	
	endIntermission()
	return
end





-- < CODE > --
-- PRE JOIN
coroutine.resume(routine)

-- INITIALIZATION
PLAYERS.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		local PointLight = Instance.new("PointLight")
		PointLight.Shadows = false
		PointLight.Brightness = .1
		PointLight.Range = 5
		PointLight.Parent = char:WaitForChild("HumanoidRootPart")

		
		
		char:FindFirstChildOfClass("Humanoid").Died:Connect(function()
			ClientInfo.Kill(plr)
		end)
	end)
end)

PLAYERS.PlayerRemoving:Connect(function(plr)
	ClientInfo.Kill(plr)
end)

-- GAME MECHANICS
while task.wait() do
	runIntermission()
	
	runVoting()
	
	runRound()
end