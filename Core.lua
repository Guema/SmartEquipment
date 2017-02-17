autoGS = LibStub("AceAddon-3.0"):NewAddon("AutoGearSwap", "AceConsole-3.0", "AceEvent-3.0")

local options = {
    name = "AutoGearSwap settings",
    handler = autoGS,
    type = "group",
    args = {
        Spec1 = {
            type = "select",
            style = "dropdown",
            name = "Default Situation",
            icon = "inv_misc_questionmark",
            desc = "Chose the gear set you want to equip when switching for this spec.",
            values = {
                "none",
                "First set",
                "Second set",
                "Third set",
            },
            get = "GetGear",
            set = "SetGear",
        },
    },
}

local defaults = {
    profile = {
        gearTable = {
            1,
        },
    },
}

function autoGS:OnInitialize()
    -- Called when the addon is loaded
    self.db = LibStub("AceDB-3.0"):New("AutoGearSwapDB", defaults)

    LibStub("AceConfig-3.0"):RegisterOptionsTable("AGS_settings", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AGS_settings", "AutoGearSwap")
    self:RegisterChatCommand("ags", self.SlashCommand)
end

function autoGS:OnEnable()
    -- Called when the addon in enabled
    self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", "OnSpecChange")
end

function autoGS:OnDisable()
    -- Called when the addon is disabled
end

function autoGS:OnSpecChange(EventType, UnitID)
    if(UnitID == "player") then
        local _specID,_specName = GetSpecializationInfo(GetSpecialization())
        UIErrorsFrame:AddMessage("Spec changed for " .. _specName ..". Swapping gear for %gearset_name%", 1.0, 1.0, 1.0, 5.0)
    end
end

function autoGS:GetGear(info)
    return self.db.profile.gearTable[1]
end

function autoGS:SetGear(info, choiceID)

    self.db.profile.gearTable[1] = choiceID
    --[[
    if GetEquipmentSetInfoByName(gearName) then
        self.db.profile.gearTable[1] = gearName
    else
        self.db.profile.gearTable[1] = ""
    end
    --]]
end

function autoGS:SlashCommand(input)
    InterfaceOptionsFrame_OpenToCategory("AutoGearSwap")
    InterfaceOptionsFrame_OpenToCategory("AutoGearSwap")
end

function autoGS:SwapGear(SpecID)
    if(self.db.profile.gearTable[SpecID]) then
        UseEquipmentSet(self.db.profile.gearTable[SpecID])
    end
end