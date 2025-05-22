-- @ScriptType: ModuleScript
local votes = {
	["Monsters"] = {
		["Tracker"] = 0, -- Classic pathfinding horror monster
		["The Fog"] = 0, -- Players must win before running out of oxygen (fog gets thicker and makes things harder to see as game progresses)
		["Traitor"] = 0, -- Players must win, but beware of the traitor(s) among them who win only by killing everyone else
		["Apocalypse"] = 0, -- Zombies rise from the ground and hunt players and all players get pistols
		["Mimic"] = 0, -- There are 2 monsters that look like other players
		["None"] = 0
	},

	["Methods"] = {
		["Last One Standing"] = 0, -- The last players alive wins
		["All for One"] = 0, -- Everyone except first winner wins
		["Killer"] = 0, -- Noboy wins unless half of the starting number of players loses
		["Team Player"] = 0, -- You must win in pairs
		["Mission Impossible"] = 0 -- If one player loses, everyone loses
	},

	["Winners"] = {
		["1"] = 0,
		["2"] = 0,
		["3"] = 0,
		["4"] = 0,
		["5"] = 0,
		["6"] = 0,
		["7"] = 0,
		["8"] = 0,

	},

	["Maps"] = {
		["Basement"] = 0,
		["Backrooms"] = 0,
		["Gridlock"] = 0,

	},

	["Lengths"] = {
		["1 Minute"] = 0,
		["5 Minutes"] = 0,
		["10 Minutes"] = 0
	},


}

votes.Elements = {
	["Monsters"] = {
		"Tracker",
		"The Fog",
		"Traitor",
		"Apocalypse",
		"Mimic",
		"None"
		
	},

	["Methods"] = {
		"Last One Standing",
		"All for One",
		"Team Player",
		"Killer",
		"Mission Impossible"
		
	},

	["Winners"] = {
		"1", "2", "3", "4", "5", "6", "7", "8"

	},

	["Maps"] = {
		"Basement",
		"Backrooms",
		"Gridlock"

	},

	["Lengths"] = {
		"1 Minute",
		"5 Minutes",
		"10 Minutes"
	},


}

votes.Topics = {"Monsters", "Methods", "Winners", "Maps", "Lengths"}

votes.TimeLeft = 0

votes.RoundSettings = {
	"1", "2", "3", "4", "5"	--placeholders
}

function votes.getRoundSettings()
	return votes.RoundSettings[1], votes.RoundSettings[2], votes.RoundSettings[3], votes.RoundSettings[4], votes.RoundSettings[5]
end

function votes.SetTimeLeft(timeLeft: number)
	votes.TimeLeft = timeLeft
end

function votes.setRoundSettings(monster, method, winners, map, length)
	votes.RoundSettings[1] = monster
	votes.RoundSettings[2] = method
	votes.RoundSettings[3] = winners
	votes.RoundSettings[4] = map
	votes.RoundSettings[5] = length
	
	return votes.RoundSettings or true
end

function votes.getWinners(element: string)
	local mostVotes = ""
	local amount = 0
	local totalvotes = 0
	--local secondVotes = ""
	--local secondAmount = 0
	local tie = true
	--print(element)
	--print(votes[element])
	--print(#votes[element])
	for i,v in pairs(votes[element]) do
		totalvotes += v
		
		if v > amount then
			mostVotes, amount = i, v
			tie = false
			--print("CLEAR WINNER!")
		
		elseif v == amount and totalvotes > 0 then
			tie = true
			--print("A TIE!")
		--elseif v > secondAmount then
		--	secondVotes, secondAmount = i, v
		end
	end

	if tie then return votes.Elements[element][Random.new():NextInteger(1, #votes.Elements[element])] end
	return mostVotes

end

function votes.Add(element: string, decision:string, amount: number)
	votes[element][decision] += amount
	--print(element, " element")
	--print(decision,  " decision")
	--print(amount, " amount")
	return votes[element][decision] or true
end

function votes.Subtract(element, amount: number)
	if not(amount) then amount = 1 end
	element -= amount
end

function votes.Reset()
	for i,v in pairs(votes.Monsters) do
		i = 0
	end

	for i,v in pairs(votes.Methods) do
		i = 0
	end

	for i,v in pairs(votes.Winners) do
		i = 0
	end

	for i,v in pairs(votes.Maps) do
		i = 0
	end

	for i,v in pairs(votes.Lengths) do
		i = 0
	end
end

return votes
