Require Superwow and UnitXP

Tracker for Tiger's Fury using spell casts instead of buff bar looping

Global variable TF_UP set to true for 17.5s after player casts Tiger's Fury. 
Length can be adjusted on line 30 in ms

uses UnitXP timers that only trigger when the time comes, rather than every frame. And run in a different thread from the game.

--------------------------------------------------
-- Example macro
--------------------------------------------------
--/run if not TF_UP then CastSpellByName("Tiger's Fury") end
--/cast Claw