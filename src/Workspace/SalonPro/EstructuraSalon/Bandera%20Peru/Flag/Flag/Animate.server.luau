t=.01

while true do
for i=1,32 do
	script.Parent:FindFirstChild(i).Transparency = 0
	wait(t)
	for _,meshpart in pairs (script.Parent:GetChildren()) do
		if meshpart:IsA("MeshPart") then
			meshpart.Transparency = 1
			end
     	end
	end
end