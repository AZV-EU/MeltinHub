print("Applying android patches")

local plr = game.Players.LocalPlayer
local Mouse = plr:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

pcall(function()
	RunService:UnbindFromRenderStep("androidcam")
end)
local cam
local delta, lastDelta = Vector2.zero, Vector2.zero
RunService:BindToRenderStep("androidcam", Enum.RenderPriority.Camera.Value - 1, function(deltaTime)
	if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
		cam = game.Workspace.CurrentCamera
		delta = UserInputService:GetMouseDelta()
		print("android patch running, delta=", delta)
		cam.CFrame = cam.CFrame * CFrame.fromOrientation(math.rad(delta.Y),math.rad(delta.X),0)
	end
end)