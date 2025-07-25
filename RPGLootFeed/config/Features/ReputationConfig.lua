---@type string, table
local addonName, ns = ...

---@class G_RLF
local G_RLF = ns

local ReputationConfig = {}

---@class RLF_DBGlobal
G_RLF.defaults.global = G_RLF.defaults.global or {}

---@class RLF_ConfigReputation
G_RLF.defaults.global.rep = {
	enabled = true,
	defaultRepColor = { 0.5, 0.5, 1 },
	secondaryTextAlpha = 0.7,
	enableRepLevel = true,
	repLevelColor = { 0.5, 0.5, 1, 1 },
	repLevelTextWrapChar = G_RLF.WrapCharEnum.ANGLE,
	enableIcon = true,
}

G_RLF.options.args.features.args.repConfig = {
	type = "group",
	handler = ReputationConfig,
	name = G_RLF.L["Reputation Config"],
	order = G_RLF.mainFeatureOrder.Reputation,
	args = {
		enableRep = {
			type = "toggle",
			name = G_RLF.L["Enable Reputation in Feed"],
			desc = G_RLF.L["EnableRepDesc"],
			width = "double",
			get = function()
				return G_RLF.db.global.rep.enabled
			end,
			set = function(_, value)
				G_RLF.db.global.rep.enabled = value
				if value then
					G_RLF.RLF:EnableModule(G_RLF.FeatureModule.Reputation)
				else
					G_RLF.RLF:DisableModule(G_RLF.FeatureModule.Reputation)
				end
			end,
			order = 1,
		},
		repOptions = {
			type = "group",
			inline = true,
			name = G_RLF.L["Reputation Options"],
			disabled = function()
				return not G_RLF.db.global.rep.enabled
			end,
			order = 1.1,
			args = {
				showIcon = {
					type = "toggle",
					name = G_RLF.L["Show Reputation Icon"],
					desc = G_RLF.L["ShowRepIconDesc"],
					width = "double",
					disabled = function()
						return G_RLF.db.global.misc.hideAllIcons
					end,
					get = function()
						return G_RLF.db.global.rep.enableIcon
					end,
					set = function(_, value)
						G_RLF.db.global.rep.enableIcon = value
					end,
					order = 0.5,
				},
				defaultRepColor = {
					type = "color",
					hasAlpha = true,
					name = G_RLF.L["Default Rep Text Color"],
					desc = G_RLF.L["RepColorDesc"],
					get = function()
						return unpack(G_RLF.db.global.rep.defaultRepColor)
					end,
					set = function(_, r, g, b)
						G_RLF.db.global.rep.defaultRepColor = { r, g, b }
					end,
					order = 1,
				},
				secondaryTextAlpha = {
					type = "range",
					name = G_RLF.L["Secondary Text Alpha"],
					desc = G_RLF.L["SecondaryTextAlphaDesc"],
					min = 0,
					max = 1,
					step = 0.1,
					get = function()
						return G_RLF.db.global.rep.secondaryTextAlpha
					end,
					set = function(_, value)
						G_RLF.db.global.rep.secondaryTextAlpha = value
					end,
					order = 2,
				},
				repLevelOptions = {
					type = "group",
					inline = true,
					name = G_RLF.L["Reputation Level Options"],
					order = 3,
					args = {
						enableRepLevel = {
							type = "toggle",
							name = G_RLF.L["Enable Reputation Level"],
							desc = G_RLF.L["EnableRepLevelDesc"],
							width = "double",
							get = function()
								return G_RLF.db.global.rep.enableRepLevel
							end,
							set = function(_, value)
								G_RLF.db.global.rep.enableRepLevel = value
							end,
							order = 1,
						},
						repLevelColor = {
							type = "color",
							name = G_RLF.L["Reputation Level Color"],
							desc = G_RLF.L["RepLevelColorDesc"],
							disabled = function()
								return not G_RLF.db.global.rep.enableRepLevel
							end,
							width = "double",
							hasAlpha = true,
							get = function()
								return unpack(G_RLF.db.global.rep.repLevelColor)
							end,
							set = function(_, r, g, b, a)
								G_RLF.db.global.rep.repLevelColor = { r, g, b, a }
							end,
							order = 2,
						},
						repLevelWrapChar = {
							type = "select",
							name = G_RLF.L["Reputation Level Wrap Character"],
							desc = G_RLF.L["RepLevelWrapCharDesc"],
							disabled = function()
								return not G_RLF.db.global.rep.enableRepLevel
							end,
							values = G_RLF.WrapCharOptions,
							get = function()
								return G_RLF.db.global.rep.repLevelTextWrapChar
							end,
							set = function(_, value)
								G_RLF.db.global.rep.repLevelTextWrapChar = value
							end,
							order = 3,
						},
					},
				},
			},
		},
	},
}
