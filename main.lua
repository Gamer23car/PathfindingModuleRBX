local Values = {}
local PathfindingService = game:GetService("PathfindingService")

local function Values:ComputePath(p: Vector3)
	Path:ComputeAsync(NRootPart.Position, p)
	if Pathing == false then
		Pathing = true
		PathingPos = p 
	end
	local Waypoints = Path:GetWaypoints()
	local cBlock
	cBlock = Path.Blocked:Connect(function()
		Pathing = false
		cBlock:Disconnect()
		ComputePath(p)
	end)
	if Waypoints then
		PathingPos = p
		for i, v in ipairs(Waypoints) do
			if Pathing == true then
				if CancelPath == true then
					Pathing = false
					CancelPath = false
					break
				end
				if v.Action == Enum.PathWaypointAction.Walk then
					NHumanoid:MoveTo(v.Position)
					while (NRootPart.Position-v.Position).Magnitude > 4 do
						task.wait()
						NHumanoid:MoveTo(v.Position)
						if (NRootPart.Position-v.Position).Magnitude < 4 then
							break
						end
					end											
					continue
				else
					NHumanoid.Jump = true
				end
			end
		end
		Pathing = false
	end
end
