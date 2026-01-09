-- Example macro
--/run if not TF_UP then CastSpellByName("Tiger's Fury") end
--/cast Claw

TF_UP = false

local TF_SPELL_ID = 9846

local TF_TIMER_ID = nil
local PLAYER_GUID = nil

local f = CreateFrame("Frame")

function TFTimer_Callback(timerID)
    if TF_UP then
            TF_UP = false
            UnitXP("timer", "disarm", timerID)
            TF_TIMER_ID = nil
    end
end

local function StartTFTimer()
    TF_UP = true

    if TF_TIMER_ID then
        UnitXP("timer", "disarm", TF_TIMER_ID)
    end

    TF_TIMER_ID = UnitXP("timer", "arm", 17500, 0, "TFTimer_Callback")
end

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UNIT_CASTEVENT")
f:RegisterEvent("PLAYER_LOGOUT")
f:RegisterEvent("PLAYER_DEAD")

f:SetScript("OnEvent", function()
    if event == "PLAYER_ENTERING_WORLD" then
        local exists, guid = UnitExists("player")
        if exists then PLAYER_GUID = guid end

        TF_UP = false
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ffff[TF Tracker]|r loaded")
        this:UnregisterEvent("PLAYER_ENTERING_WORLD")
        return
    elseif event == "UNIT_CASTEVENT" and arg1 == PLAYER_GUID then
        if arg4 ~= TF_SPELL_ID then return end
        StartTFTimer()
        return
	elseif event == "PLAYER_DEAD" then
        if TF_TIMER_ID then
            UnitXP("timer", "disarm", TF_TIMER_ID)
            TF_TIMER_ID = nil
        end
        TF_UP = false
        return
	elseif event == "PLAYER_LOGOUT" then
        if TF_TIMER_ID then
            UnitXP("timer", "disarm", TF_TIMER_ID)
            TF_TIMER_ID = nil
        end
        TF_UP = false
        return
	end
end)
