local autopilot = {}

local plr = game.Players.LocalPlayer

local vim = game:GetService("VirtualInputManager")

local active = false
local mode = 1
-- 1: player, aim using WASD + character and camera CFrame to point at waypoint
-- 3: vehicle, aim using WASD only

local currentTarget = Vector3.new()
local currentPath, currentStep = {}, 1
local minDistToWaypoint = 5
local targetPart = nil
local keycodes = {
	w = "0x77",
	a = "0x61",
	s = "0x73",
	d = "0x64"
}

function autopilot:SetMode(mode)
	mode = math.min(1, math.max(3, mode or 1))
end

function autopilot:Stop()
	active = false
	currentStep = 1
	for k,v in pairs(keycodes) do
		vim:SendKeyEvent(false, v, 0, game)
	end
end

function autopilot:Pause()
	active = false
	for k,v in pairs(keycodes) do
		vim:SendKeyEvent(true, v, 0, game)
	end
end

function autopilot:Resume()
	active = true
end

function autopilot:Start()
	currentStep = 1
	active = true
end

function autopilot:SetCourse(pos)
	currentPath = pos ~= nil and {pos} or {}
end

function autopilot:FindPath(from, to)
	
end

function autopilot:ApplyPath(coordinates)
	currentPath = coordinates or {}
end

function autopilot:SetMinDistanceToWaypoint(dist)
	minDistToWaypoint = dist or 5
end

function autopilot:SetTargetPart(part)
	targetPart = part
end

local focusPart, nextWaypoint = nil, nil
local direction, distance
local running = true
task.spawn(function()
	while running do
		if active then
			nextWaypoint = currentPath[currentStep]
			focusPart = targetPart or plr.Character:FindFirstChild("HumanoidRootPart")
			if not nextWaypoint or not focusPart then
				autopilot:Stop()
				return
			end
			distance = (nextWaypoint - focusPart.Position).Magnitude
			if distance < minDistToWaypoint then
				currentStep += 1
				return
			end
			if mode == 1 then
				focusPart.CFrame = CFrame.new(focusPart.Position, Vector3.new(nextWaypoint.X, focusPart.Position.Y, nextWaypoint.Z))
				
				game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, nextWaypoint)
				
				vim:SendKeyEvent(true, Enum.KeyCode.W, 0, game)
			end
		end
		vim:WaitForInputEventsProcessed()
	end
end)

function autopilot:Reset()
	autopilot:Stop()
	running = false
end

return autopilot