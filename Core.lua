
autoGC = LibStub("AceAddon-3.0"):NewAddon("AutoGearChanger", "AceConsole-3.0", "AceEvent-3.0")

function autoGC:OnInitialize()
    -- Called when the addon is loaded
    self:Print("Saucisse !")
end

function autoGC:OnEnable()
    -- Called when the addon in enabled
    self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
end

function autoGC:OnDisable()
    -- Called when the addon is disabled
end

function autoGC:PLAYER_SPECIALIZATION_CHANGED()
    self:Print("Spec changed for %spec_name%. Gear was automatically changed for %gear_set_name%")
end