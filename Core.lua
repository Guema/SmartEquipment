autoGS = LibStub("AceAddon-3.0"):NewAddon("AutoGearSwap", "AceConsole-3.0", "AceEvent-3.0")

local options = {
    name = "AutoGearSwap",
    handler = autoGS,
    type = 'group',
    args = {
        msg = {
            type = "input",
            name = "Message",
            desc = "The message to be displayed when you get home.",
            usage = "<Your message>",
            get = "GetMessage",
            set = "SetMessage",
        },
    },
}

autoGS.message = "Default Message"

function autoGS:OnInitialize()
    -- Called when the addon is loaded
    LibStub("AceConfig-3.0"):RegisterOptionsTable("AutoGearSwap", options, {"autogearswap", "autogs", "ags"})
    self:RegisterChatCommand("setext", "ChatCommand")
end

function autoGS:OnEnable()
    -- Called when the addon in enabled
    self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
end

function autoGS:OnDisable()
    -- Called when the addon is disabled
end

function autoGS:PLAYER_SPECIALIZATION_CHANGED()
    self:Print(self.message)
end


function autoGS:GetMessage(info)
    return self.message
end

function autoGS:SetMessage(info, newValue)
    self.message = newValue
end

function autoGS:ChatCommand(input)
    if not input or input:trim() == "" then
        -- InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        -- LibStub("AceConfigCmd-3.0"):HandleCommand("wh", "WelcomeHome", input)
    end
end