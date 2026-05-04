--These are all donations that can be done. You must set this up with your own products to make money of it.
--To make a product you have to make a Developer Product in your game's settings page.
--You can make as many as you want, Once you made one, copy it's ID and past it in the 'ProductId' variable in this script. 
--Change the 'ProductPrice' to what the Developer Product Costs.


local module = {}	
module.Products = {
	
	{
		ProductPrice = 5, --The price from the Developer Product.
		ProductId = 3243324537 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 10, --The price from the Developer Product.
		ProductId = 3243324538 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 50, --The price from the Developer Product.
		ProductId = 3243324540 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 100, --The price from the Developer Product.
		ProductId = 3243324539 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 200, --The price from the Developer Product.
		ProductId = 3250256100 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 300, --The price from the Developer Product.
		ProductId = 3250256102 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 500, --The price from the Developer Product.
		ProductId = 3243326301 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 600, --The price from the Developer Product.
		ProductId = 3250263538 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 700, --The price from the Developer Product.
		ProductId = 3250263536 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 800, --The price from the Developer Product.
		ProductId = 3250263522 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 900, --The price from the Developer Product.
		ProductId = 3250263521 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 1000, --The price from the Developer Product.
		ProductId = 3243326517 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 2000, --The price from the Developer Product.
		ProductId = 3259537903 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 3000, --The price from the Developer Product.
		ProductId = 3259537902 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 4000, --The price from the Developer Product.
		ProductId = 3259537900 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 5000, --The price from the Developer Product.
		ProductId = 3259537898 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 6000, --The price from the Developer Product.
		ProductId = 3259537901 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 7000, --The price from the Developer Product.
		ProductId = 3259537895 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 8000, --The price from the Developer Product.
		ProductId = 3259537899 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 9000, --The price from the Developer Product.
		ProductId = 3259537897 -- The ID from the Developer Product.	
	},
	{
		ProductPrice = 10000, --The price from the Developer Product.
		ProductId = 3259537893 -- The ID from the Developer Product.	
	}
	
}

--module.AbortCustomPurchases = true --READ Below for what this does. 


return module

--[[
	to make more products just copy and past like this:
	
module.Products = {
	{
		ProductPrice = 0, --The price from the Developer Product.
		ProductId = 0 -- The ID from the Developer Product.	
	},
	
	{
		ProductPrice = 0, --The price from the Developer Product.
		ProductId = 0 -- The ID from the Developer Product.	
	},
	
	
	{
		ProductPrice = 0, --The price from the Developer Product.
		ProductId = 0 -- The ID from the Developer Product.	
	},	
}

For the more advanced scripters, READ THIS!
if you're already using the function ProcessReceipt then you must add custom code for this board to work,
as only one of these functions may be used in a game.

to disable the ProcessReceipt function from this board, unquote this above the 'return module' line:
module.AbortCustomPurchases = true

you can update the boards datastore with this line:
game:GetService("DataStoreService"):GetOrderedDataStore("TopDonators"):IncrementAsync(PlayerId, ProductPrice)
-PlayerId, the id from the player who bought the pruduct.
-ProductPrice, the developer products price (In Rs!)
--]]