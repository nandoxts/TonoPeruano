local weld = Instance.new("Weld")
weld.Part0 = script.Parent
weld.C0 = script.Parent.CFrame:inverse()
weld.Part1 = script.Parent.Parent.SignPart
weld.C1 = script.Parent.Parent.SignPart.CFrame:inverse()
weld.Parent = script.Parent
script.Parent.Anchored = false
script.Parent.Parent.SignPart.Anchored = false

