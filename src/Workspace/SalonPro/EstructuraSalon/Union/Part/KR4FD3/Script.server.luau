print("Animated slideshow started.")

local TweenService = game:GetService("TweenService")

--// id-s images

local imgList = {
	96189890284296,
	80734893858644,
	87233017207553,
}

local img = script.Parent:FindFirstChild("ImageLabel")
local watermark = script.Parent:FindFirstChild("Watermark")

if not watermark then
	watermark = Instance.new("TextLabel")
	watermark.Name = "Watermark"
	watermark.Parent = script.Parent
	watermark.AnchorPoint = Vector2.new(0.5, 0.5)
	watermark.Position = UDim2.new(0.5, 0, 1, -20)
	watermark.Size = UDim2.new(0, 300, 0, 50)
	watermark.Text = "owner"
	watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
	watermark.TextSize = 24
	watermark.BackgroundTransparency = 1
end

img.AnchorPoint = Vector2.new(0.5, 0.5)
img.Position = UDim2.new(0.5, 0, 0.5, 0)
img.Size = UDim2.new(1, 0, 1, 0)

local shrinkInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local growInfo = TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local moveTweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local moveTween = TweenService:Create(watermark, moveTweenInfo, {
	Position = UDim2.new(0.5, 100, 1, -20)
})
moveTween:Play()

local function transitionImage(id)
	local shrink = TweenService:Create(img, shrinkInfo, { Size = UDim2.new(0, 0, 0, 0) })
	shrink:Play()
	shrink.Completed:Wait()
	img.Image = "rbxassetid://" .. tostring(id)
	img.Size = UDim2.new(0, 0, 0, 0)
	local grow = TweenService:Create(img, growInfo, { Size = UDim2.new(1, 0, 1, 0) })
	grow:Play()
	grow.Completed:Wait()
end

local function startSlideshow()
	for _, id in ipairs(imgList) do
		transitionImage(id)
		task.wait(3)
	end
end

while true do
	startSlideshow()
end