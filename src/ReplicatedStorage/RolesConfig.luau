--[[
	CONFIGURACION CENTRAL DE ROLES - Tono Peruano
	Edita solo este archivo para gestionar todos los rangos del juego.
	Los cambios se aplican automaticamente en: nametags, chat, comandos VIP y Adonis.
--]]

local Config = {}

Config.VIP_GAMEPASS_ID = 1092300393

-- Acceso a comandos VIP sin necesitar gamepass
Config.VipAdmins = {
	"AngeloGarciia",
	"nxndoxt",
}

-- Acceso a efectos de camara (/gire, /fiesta)
Config.EffectAdmins = {
	"AngeloGarciia",
	"nxndoxt",
}

-- Jugadores con estrella en el nametag
Config.StarUsers = {
	"AngeloGarciia",
	"nxndoxt",
	"keithprincs",
	"Mavet7zxt",
	"Fercho_ZP",
	"dlFers",
	"FabianRs1",
	"shyshybuu_u",
	"VALLEIDS",
	"marcosyuik12",
}

--[[
	RANGOS - ordenados por prioridad (primero = mas alto)

	Cada rango tiene:
	  users        = lista de usernames
	  nametag      = { text, color }   -- color puede ser "rainbow"
	  chat         = { tag, color }    -- nil = no aparece en el chat
	  adonisLevel  = "Creators" | "HeadAdmins" | "Admins" | "Moderators" | nil
--]]
Config.Ranks = {

	-- ==================== STAFF PRINCIPAL ====================

	{
		id = "creator",
		users = { "AngeloGarciia", "nxndoxt" },
		nametag = { text = "CREADOR", color = Color3.fromRGB(255, 255, 0) },
		chat    = { tag  = "CREADOR", color = Color3.fromRGB(255, 217, 1) },
		adonisLevel = "Creators",
	},
	{
		id = "headadmin",
		users = { "keithprincs", "Mavet7zxt", "Fercho_ZP" },
		nametag = { text = "HEAD-ADMIN", color = Color3.fromRGB(255, 200, 4) },
		chat    = { tag  = "HEAD-ADMIN", color = Color3.fromRGB(255, 200, 4) },
		adonisLevel = "HeadAdmins",
	},
	{
		id = "admin",
		users = {
			"TILINPECAUS4", "mrclauss22", "ignxts", "isma_ccc77",
			"SrMyster27", "Amigo_deloajen0", "R0Danny", "xXyohandi",
			"ISASI0220", "Fueg2oh", "Sebasxcxs",
		},
		nametag = { text = "ADMINISTRADOR", color = Color3.fromRGB(179, 0, 0) },
		chat    = { tag  = "ADMIN",         color = Color3.fromRGB(200, 0, 0) },
		adonisLevel = "Admins",
	},
	{
		id = "mod",
		users = {
			"anonymous12220", "Solrc12", "WilliamVR29", "000_iiReyner",
			"DiegoHotPlay", "Jeankskx", "Nightwing_196", "jhoanmaykc",
			"zRenzolucho", "elfortnite12345", "alalaud22", "xChecooo420",
			"checfito2802", "fulltuboamiga", "Rengifo2006M", "DracoPrr",
			"Dadvijay", "kat02L20", "Shiion25", "duraznoHOD",
		},
		nametag = { text = "MODERADOR", color = Color3.fromRGB(38, 255, 0) },
		chat    = { tag  = "MOD",       color = Color3.fromRGB(38, 255, 0) },
		adonisLevel = "Moderators",
	},
	{
		id = "dj",
		users = { "Dj_Sicotic" },
		nametag = { text = "DJ", color = "rainbow" },
		chat    = { tag  = "DJ", color = Color3.fromRGB(255, 100, 255) },
	},

	-- ==================== ROLES ESPECIALES ====================

	{
		id = "influencer",
		users = { "kringtapia", "dlFers", "Ahlekxxz", "chetumari", "WincitoMix", "PANARABIT1248", "stefanosktr", "FabianRs1" },
		nametag = { text = "INFLUENCER", color = Color3.fromRGB(0, 213, 255) },
		chat    = { tag  = "INFLUENCER", color = Color3.fromRGB(0, 213, 255) },
	},
	{
		id = "ga",
		users = { "essechinito" },
		nametag = { text = "OquendoGrone", color = Color3.fromRGB(255, 48, 48) },
	},
	{
		id = "dibujito",
		users = { "pincheratata", "Blane_0100", "Maxckac32", "Carlos_2004pro", "YoshinoT402", "Macr0xzzz", "xXyohandi", "The_dangerr", "vegeta_francow", "carlos_2004pro", "CHRISPAPU1", "FrodoxKing" },
		nametag = { text = "DIBUJITO", color = Color3.fromRGB(255, 0, 123) },
	},
	{
		id = "bandido",
		users = { "ANGEL_JISUS1", "galletadeagua20", "SH3L4O", "Jeankskx", "mijailll_01", "GalletaDeAgua20", "distemper6", "frankym1234", "Noone1237473", "chamoy_siuu", "TarzanPingon", "alalaud22", "its_loaded20", "Kantar0o", "Zack_06104", "llCamotitoUwull", "EsleiterXrX" },
		nametag = { text = "BANDIDO", color = Color3.fromRGB(230, 0, 4) },
	},
	{
		id = "conejita",
		users = { "enotrass", "J0d3_rclaroqsi", "Gia_14537", "Estrellalisbeth4", "kitty_FFw", "rose_luanaUwU", "Stefy_cr", "heidiblanco_ff3", "militux08", "tumama_itk1", "dahyun_ap", "arleth420xd", "shecid017", "mafelamanca", "SioXiio", "Raingirl2407", "kimiti_1", "BB_Lunita31", "Conejiitaaah" },
		nametag = { text = "CONEJITA", color = Color3.fromRGB(255, 179, 202) },
	},
	{
		id = "mono",
		users = { "gxrardo04", "Adrianzazano", "jack_goku55", "PowerFullFo" },
		nametag = { text = "MONO-MAFIA", color = Color3.fromRGB(184, 85, 35) },
	},
	{
		id = "fiel",
		users = { "alguierandom123", "r3zaka" },
		nametag = { text = "FIEL", color = Color3.fromRGB(254, 21, 21) },
	},
	{
		id = "gatita",
		users = { "shyshybuu_u" },
		nametag = { text = "GATITA", color = Color3.fromRGB(255, 179, 202) },
	},
	{
		id = "catador",
		users = { "Guilleproo12345678" },
		nametag = { text = "Catador De Mayores", color = Color3.fromRGB(255, 0, 0) },
	},
	{
		id = "sau",
		users = { "brehmelu3" },
		nametag = { text = "Mister Pisado", color = Color3.fromRGB(255, 0, 242) },
	},
	{
		id = "gatito",
		users = { "JackFox188" },
		nametag = { text = "CAT", color = Color3.fromRGB(162, 0, 255) },
	},
	{
		id = "bandida",
		users = { "stayyyyys5", "Noem_CHV2" },
		nametag = { text = "BANDIDA", color = Color3.fromRGB(255, 0, 4) },
	},
	{
		id = "lider",
		users = { "vVI_EZ" },
		nametag = { text = "LIDER_CLAN_DZN", color = Color3.fromRGB(255, 0, 4) },
	},
	{
		id = "seguridad",
		users = { "tigranpa" },
		nametag = { text = "SEGURIDAD", color = Color3.fromRGB(0, 0, 255) },
	},
	{
		id = "duena",
		users = { "rubialvarez2108" },
		nametag = { text = "Duena MR.Pisado", color = Color3.fromRGB(255, 0, 234) },
	},
	{
		id = "boss",
		users = { "DuraznoHOD" },
		nametag = { text = "BOSS", color = Color3.fromRGB(255, 140, 0) },
	},
}

-- ==================== FUNCIONES HELPER ====================

function Config:GetRank(playerName)
	for _, rank in ipairs(self.Ranks) do
		for _, user in ipairs(rank.users) do
			if user == playerName then return rank end
		end
	end
	return nil
end

function Config:IsVipAdmin(playerName)
	for _, name in ipairs(self.VipAdmins) do
		if name == playerName then return true end
	end
	return false
end

function Config:HasEffectAccess(playerName)
	for _, name in ipairs(self.EffectAdmins) do
		if name == playerName then return true end
	end
	return false
end

function Config:IsStarUser(playerName)
	for _, name in ipairs(self.StarUsers) do
		if name == playerName then return true end
	end
	return false
end

-- Devuelve todos los usuarios de un adonisLevel especifico
function Config:GetAdonisUsers(level)
	local users = {}
	for _, rank in ipairs(self.Ranks) do
		if rank.adonisLevel == level then
			for _, user in ipairs(rank.users) do
				table.insert(users, user)
			end
		end
	end
	return users
end

return Config
