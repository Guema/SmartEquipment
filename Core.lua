smartEquipment = LibStub("AceAddon-3.0"):NewAddon("SmartEquipment", "AceConsole-3.0", "AceEvent-3.0")

local function options()
    local tb_options = {
        name = "SmartEquipment settings",
        handler = smartEquipment,
        type = "group",
        args = {},
    }
    for k1, v1 in tb_options.handler.GetAvailableSpecializations() do
        tb_options.args[tostring(k1)] = {
            name = v1,
            type = "select",
            values = {},
            style = "dropdown",
            get = "GetChoice",
            set = "SetChoice",
        }
        for k2, v2 in tb_options.handler.GetAvailableEquipments() do
            tb_options.args[tostring(k1)].values[k2] = v2
        end
    end
    return tb_options
end

local defaultDB = {
    profile = {
        gearConfigList = {},
    },
}

function smartEquipment:OnInitialize()
    self.datatest = {nil}
    self.db = LibStub("AceDB-3.0"):New("SmartEquipmentDB", defaultDB)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("SmartEquipmentOptions", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("SmartEquipmentOptions", "SmartEquipment")
    self:RegisterChatCommand("ags", "DebugCommand")
end

function smartEquipment:OnEnable()
    self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", "OnSpecChange")
end

function smartEquipment:OnDisable()
end

function smartEquipment:OnSpecChange(EventType, UnitID)
    if(UnitID == "player") then
        local specID, specName = GetSpecializationInfo(GetSpecialization())
        self:SwapGear(tostring(specID))
        UIErrorsFrame:AddMessage("Spec changed for " .. specName ..", Swap gear for %gearset_name%", 1.0, 1.0, 1.0, 5.0)
    end
end

function smartEquipment:GetChoice(info)
    return self.db.profile.gearConfigList[info[1]]
end

function smartEquipment:SetChoice(info, choiceID)
    --self.datatest[1] = choiceID
    self.db.profile.gearConfigList[info[1]] = choiceID
end

function smartEquipment.GetAvailableEquipments()
    local i = 0
    local nbElements = GetNumEquipmentSets()
    return function()
        i = i + 1
        local eqName = GetEquipmentSetInfo(i)
        if i <= nbElements then return i, eqName end
    end
end

function smartEquipment.GetAvailableSpecializations()
    local i = 0
    local nbElements = GetNumSpecializations()
    return function()
        i = i + 1
        local specID, specName = GetSpecializationInfo(i)
        if i <= nbElements then return specID, specName end
    end
end

function smartEquipment:SlashCommand(input)
    InterfaceOptionsFrame_OpenToCategory("AutoGearSwap")
    InterfaceOptionsFrame_OpenToCategory("AutoGearSwap")
end

function smartEquipment:DebugCommand(input)
    for i, k in self.GetAvailableEquipments() do
        self:Print(i, k)
    end
end

function smartEquipment:SwapGear(SpecID)
    if (self.db.profile.gearConfigList[SpecID]) then
        local setName = GetEquipmentSetInfo(self.db.profile.gearConfigList[SpecID])
        UseEquipmentSet(setName)
    end
end