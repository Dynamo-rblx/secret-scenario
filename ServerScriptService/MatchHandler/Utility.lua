-- @ScriptType: ModuleScript
local vote_module = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("VoteCount"))

local utility = {}
local lastFunction = {}

function utility.setPlayTabText(text: string)
	for i, plr in pairs(game.Players:GetPlayers()) do
		local label = plr.PlayerGui:WaitForChild("Menu"):WaitForChild("PlayFrame"):WaitForChild("Status")
		label.Text = text
	end
	return
end

function utility.displayPlayTabChoices(element1: string, element2: string)
	for i, plr in pairs(game.Players:GetPlayers()) do
		local holderFrame = plr.PlayerGui:WaitForChild("Menu"):WaitForChild("PlayFrame"):WaitForChild("HolderFrame")
		
		local choices = {}
		local givenOptions = {}
		local found
		local chosen_element
		
		holderFrame.Parent:WaitForChild("Header").Visible = true
		
		for i=1, 7, 1 do
			if i%2 == 1 then
				found = vote_module.Elements[element1][Random.new():NextInteger(1, #vote_module.Elements[element1])]
				chosen_element = element1
				
				local iterations = 0
				if table.find(givenOptions, found) then
					repeat
						task.wait()
						found = vote_module.Elements[element1][Random.new():NextInteger(1, #vote_module.Elements[element1])]
						chosen_element = element1
						iterations += 1
					until not(table.find(givenOptions, found)) or iterations > 20
				end
				
				table.insert(givenOptions, found)
				
			else
				found = vote_module.Elements[element2][Random.new():NextInteger(1, #vote_module.Elements[element2])]
				chosen_element = element2
				
				local iterations = 0
				if table.find(givenOptions, found) then
					repeat
						task.wait()
						found = vote_module.Elements[element2][Random.new():NextInteger(1, #vote_module.Elements[element2])]
						chosen_element = element2
						iterations += 1
					until not(table.find(givenOptions, found)) or iterations > 20
				end

				table.insert(givenOptions, found)
			end
			
			local cBTN = holderFrame:WaitForChild("ScrollingFrame"):FindFirstChild("choice"..i)
			--print(i)
			--print("element: "..chosen_element)
			--print("found: "..found)
			cBTN.Text = chosen_element..": "..found
			
			--print(holderFrame:WaitForChild("ScrollingFrame"):FindFirstChild("choice"..i))
			
			local btn_data = {
				["Button"] = cBTN,
				["element"] = chosen_element,
				["found"] = found
			}
			
			table.insert(choices, i, btn_data)
			
			lastFunction[i] = choices[i].Button.MouseButton1Click:Connect(function()
				--print(temp0.Name.." picked "..temp1..": "..temp2)
				game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("ClientVoter"):Fire(plr, choices[i].element, choices[i].found)
				
				cBTN.BackgroundColor3 = Color3.fromRGB(57, 255, 64)
				cBTN.TextColor3 = Color3.fromRGB(57, 255, 64)
				cBTN.UIStroke.Color = Color3.fromRGB(57, 255, 64)
			end)
			
			--print(tostring(lastFunction[i]))
			--table.insert(lastFunction, fxn)
		end
		holderFrame.ScrollingFrame.Visible = true
	end
	return
end

function utility.packPlayTabChoices()
	for i, plr in pairs(game.Players:GetPlayers()) do
		local holderFrame = plr.PlayerGui:WaitForChild("Menu"):WaitForChild("PlayFrame"):WaitForChild("HolderFrame")

		holderFrame.Parent:WaitForChild("Header").Visible = false
		holderFrame.ScrollingFrame.Visible = false

		for i, v in pairs(holderFrame.ScrollingFrame:GetChildren()) do
			if lastFunction ~= {} and lastFunction then
				for i, v in pairs(lastFunction) do
					v:Disconnect()
				end
			end
			
			if v:IsA("TextButton") then
				v.Text = ""
				v.BackgroundColor3 = Color3.fromRGB(41,41,41)
				v.TextColor3 = Color3.fromRGB(255, 255, 255)
				v.UIStroke.Color = Color3.fromRGB(41, 41, 41)
			end
		end

	end
	return
end

function utility.displayResults(element1:string, element2: string, winner1: string, winner2: string)
	for i, plr in pairs(game.Players:GetPlayers()) do
		local decisionDisplay = plr.PlayerGui:WaitForChild("Menu"):WaitForChild("PlayFrame"):FindFirstChild("DecisionDisplay")
		decisionDisplay.Parent:WaitForChild("Header2").Visible = true
		decisionDisplay.element1.Text = element1..": "..winner1
		decisionDisplay.element2.Text = element2..": "..winner2
		
		decisionDisplay.Visible = true
	end
end

function utility.packResults()
	for i, plr in pairs(game.Players:GetPlayers()) do
		local decisionDisplay = plr.PlayerGui:WaitForChild("Menu"):WaitForChild("PlayFrame"):FindFirstChild("DecisionDisplay")
		decisionDisplay.Parent:WaitForChild("Header2").Visible = false
		decisionDisplay.Visible = false

	end
end

return utility
