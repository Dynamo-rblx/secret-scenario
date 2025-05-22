-- @ScriptType: LocalScript
local btnHOLDER = script.Parent:WaitForChild("Topics")
local display = script.Parent:WaitForChild("Info")

-- SET DEFAULT TO RULES --------------------------
for i, v in pairs(display:GetChildren()) do
	if v == display.RuleText then
		v.Visible = true
	else
		v.Visible = false
	end
end
--------------------------------------------------


-- < CODE > --
btnHOLDER.rulesGUIDE.MouseButton1Click:Connect(function()
	for i, v in pairs(display:GetChildren()) do
		if v == display.RuleText then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end)

btnHOLDER.votingGUIDE.MouseButton1Click:Connect(function()
	for i, v in pairs(display:GetChildren()) do
		if v == display.VotingText then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end)

btnHOLDER.winningGUIDE.MouseButton1Click:Connect(function()
	for i, v in pairs(display:GetChildren()) do
		if v == display.WinningText then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end)

btnHOLDER.scoringGUIDE.MouseButton1Click:Connect(function()
	for i, v in pairs(display:GetChildren()) do
		if v == display.ScoringText then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end)

btnHOLDER.monsterGUIDE.MouseButton1Click:Connect(function()
	for i, v in pairs(display:GetChildren()) do
		if v == display.monsterText then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end)

btnHOLDER.methodGUIDE.MouseButton1Click:Connect(function()
	for i, v in pairs(display:GetChildren()) do
		if v == display.methodText then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end)

btnHOLDER.winnerGUIDE.MouseButton1Click:Connect(function()
	for i, v in pairs(display:GetChildren()) do
		if v == display.winnerText then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end)

btnHOLDER.mapGUIDE.MouseButton1Click:Connect(function()
	for i, v in pairs(display:GetChildren()) do
		if v == display.mapText then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end)

btnHOLDER.lengthGUIDE.MouseButton1Click:Connect(function()
	for i, v in pairs(display:GetChildren()) do
		if v == display.lengthText then
			v.Visible = true
		else
			v.Visible = false
		end
	end
end)