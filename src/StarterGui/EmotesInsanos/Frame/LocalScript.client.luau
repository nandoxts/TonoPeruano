local searchbar = script.Parent.Search
local items = script.Parent.ScrollingFrame
local ui = Instance.new("UIListLayout")

function updateresult()	
	local search = string.lower(searchbar.Text)
	for i, v in pairs(items:GetChildren()) do
		if v:IsA("Frame") then
			if search ~= "" then
				local item = string.lower(v.Name)
				if string.find(item, search) then
					v.Visible = true
				else
					ui.Parent = items
					v.Visible = false
				end
			else
				ui.Parent = nil
				v.Visible = true
			end				
		end		
	end	
end

searchbar.Changed:Connect(updateresult)