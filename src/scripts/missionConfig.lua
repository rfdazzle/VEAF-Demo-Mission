-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mission configuration file for the VEAF framework
-- see https://github.com/VEAF/VEAF-Mission-Creation-Tools
--
-- This configuration is tailored for a demonstration mission
-- see https://github.com/VEAF/VEAF-Demo-Mission
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veaf.config.MISSION_NAME = "VEAF-Demo-Mission"
veaf.config.MISSION_EXPORT_PATH = nil -- use default folder

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize QRA
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafQraManager then
    veaf.loggers.get(veaf.Id):info("init - QRA")
    VeafQRA:new()
    :setName("QRA-Maykop")
    :setCoalition(coalition.side.RED)
    :addEnnemyCoalition(coalition.side.BLUE)

    :setTriggerZone("QRA-Maykop")
    --:setZoneCenterFromCoordinates("U37TEK8200048000") -- Maykop
    --:setZoneRadius(40000) -- 22 nm
    :setRespawnRadius(10000)
    :setRespawnDefaultOffset(0, -45000) ---set the default respawn offset (in meters, relative to the zone center)
    --:setRandomGroupsToDeployByEnemyQuantity(1, { "-cap Mig21-Fox1, hdg 180, dist 50", "[0, 0]-cap Mig21-Fox2, hdg 180, dist 30", "[0, 0]-sa15, multiplier 2-4"  }, 1) -- 1 and more
    :setRandomGroupsToDeployByEnemyQuantity(1, { "[0, 0]-cap Mig21-Fox2, hdg 180, dist 30"  }, 1) -- 1 and more
    :setRandomGroupsToDeployByEnemyQuantity(3, { "-cap Mig21-Fox1, size 2, hdg 180, dist 50", "-cap Mig23S-Fox1, size 2, hdg 180, dist 50", "-cap Mig25-Fox1, size 2, hdg 180, dist 50" }, 1) -- 3 and more
    :setRandomGroupsToDeployByEnemyQuantity(5, { "-cap Su27-Fox1, hdg 180, dist 50", "-cap Su33-Fox1, hdg 180, dist 50", "-cap Mig29A-Fox1, hdg 180, dist 50" }, 3) -- 5 and more
    --:setGroupsToDeployByEnemyQuantity(1, { "[0, -45000]-cap Mig21-Fox1, hdg 180, dist 50" }) -- 1 and more
    --:setRandomGroupsToDeployByEnemyQuantity(1, { "QRA-Maykop-1", "QRA-Maykop-2", "QRA-Maykop-3" }, 1) -- 1 and more
    --:setRandomGroupsToDeployByEnemyQuantity(3, { "QRA-Maykop-1", "QRA-Maykop-2", "QRA-Maykop-3" }, 2, 1) -- 3 and more
    --:setRandomGroupsToDeployByEnemyQuantity(5, { "QRA-Maykop-1", "QRA-Maykop-2", "QRA-Maykop-3" }, 3, 1) -- 5 and more
    --:setGroupsToDeployByEnemyQuantity(1, { "QRA-Maykop-1" }) -- 1 and more
    --:setGroupsToDeployByEnemyQuantity(3, { "QRA-Maykop-1", "QRA-Maykop-2" }) -- 3 and more
    --:setGroupsToDeployByEnemyQuantity(5, { "QRA-Maykop-1", "QRA-Maykop-2", "QRA-Maykop-3" }) -- 5 and more
    :setReactOnHelicopters() -- reacts when helicopters enter the zone
    :setDelayBeforeRearming(15) -- 15 seconds before the QRA is rearmed
    :setNoNeedToLeaveZoneBeforeRearming() -- the enemy does not have to leave the zone before the QRA is rearmed
    --:setMaximumAltitudeInFeet(12500) -- hard ceiling is 12500 feet
    --:setMinimumAltitudeInFeet(11500) -- hard floor is 11500 feet
    :setDrawZone(true)
    :start()

end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize AirWaves zones
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafAirWaves then
    veaf.loggers.get(veaf.Id):info("init - AIRWAVES")

    -- example zone 01 (can easily be copy/pasted, nothing to set in the editor except player slots and if desired trigger zones)
    AirWaveZone:new()

    -- technical name (AirWave instance name)
    :setName("Zone 01")

    -- description for the messages
    :setDescription("Zone 01 - FOX1 fighters")
    -- coalitions of the players (only human units from these coalitions will be monitored)
    :addPlayerCoalition(coalition.side.BLUE)

    -- trigger zone name (if set, we'll use a DCS trigger zone)
    --:setTriggerZone("airWave_HARD")

    -- center (point in the center of the circle, when not using a DCS trigger zone) - can be set with coordinates either in LL or MGRS
    :setZoneCenterFromCoordinates("U37TCL5297") -- U=UTM (MGRS); 37T=grid number; CL=square; 52000=latitude; 97000=longitude

    -- radius (size of the circle, when not using a zone) - in meters
    :setZoneRadius(90000) -- 50 nm

    -- draw the zone on screen
    :setDrawZone(true)

    -- default position for respawns (im meters, lat/lon, relative to the zone center)
    :setRespawnDefaultOffset(0, -45000) -- 45km north of the zone's center

    -- radius of the waves groups spawn
    :setRespawnRadius(10000)

    ---add a wave of ennemy planes
    --@param groups any a list of groups or VEAF commands; VEAF commands can be prefixed with [lat, lon], specifying the location of their spawn relative to the center of the zone; default value is set with "setRespawnDefaultOffset"
    --@param number any how many of these groups will actually be spawned (can be multiple times the same group!)
    --@param bias any shifts the random generator to the right of the list
    :addRandomWave( { "[0, 0]-cap Mig25-Fox2-solo, hdg 180, dist 30"  }, 1) -- a single Mig25 with FOX2 missiles spawning near
    :addRandomWave( { "[0, -30000]-cap Mig21-Fox1, size 2, hdg 180, dist 50", "[0, -30000]-cap Mig23S-Fox1, size 2, hdg 180, dist 50", "[0, -30000]-cap Mig25-Fox1, size 2, hdg 180, dist 50" }, 1) -- 1 group from FOX1 fighter pairs spawning at 30km to the north
    :addRandomWave( { "[0, -60000]-cap Su27-Fox1, hdg 180, dist 50", "[0, -60000]-cap Su33-Fox1, hdg 180, dist 50", "[0, -60000]-cap Mig29A-Fox1, hdg 180, dist 50" }, 2) -- 2 groups from modern FOX1 fighter pairs spawning at 60km to the north
    --:addRandomWave({ "airWave_EASY-1-1", "airWave_EASY-1-2"}, 1) -- one group
    --:addRandomWave({ "airWave_EASY-2-1", "airWave_EASY-2-1"}, 2) -- two groups

    -- players in the zone will only be detected above this altitude (in feet)
    :setMaximumAltitudeInFeet(40000) -- hard ceiling

    -- players in the zone will only be detected below this altitude (in feet)
    :setMinimumAltitudeInFeet(1500) -- hard floor

    -- message when the zone is activated
    :setMessageStart("%s est maintenant fonctionnelle")

    -- event when the zone is activated
    --:setOnStart(callbackFunction)

    -- message when a wave is triggered
    :setMessageDeploy("%s déploie la vague numéro %s")

    -- event when a wave is triggered
    --:setOnDeploy(callbackFunction)

    -- message when a wave is destroyed
    :setMessageDestroyed("%s: la vague %s a été détruite")

    -- event when a wave is destroyed
    --:setOnDestroy(callbackFunction)

    -- message when all waves are finished (won)
    :setMessageWon("%s: c'est gagné (plus d'ennemi) !")

    -- event when all waves are finished (won)
    --:setOnWon(callbackFunction)

    -- message when all players are dead (lost)
    :setMessageLost("%s: c'est perdu (joueur mort ou sorti) !")

    -- event when all players are dead (lost)
    --:setOnLost(callbackFunction)

    -- message when the zone is deactivated
    :setMessageStop("%s n'est plus active")

    -- event when the zone is deactivated
    --:setOnStop(callbackFunction)

    -- start the zone
    :start()

    -- example zone 02 (copy/pasted from zone 01, changed only the name and coordinates)
    AirWaveZone:new()
    :setName("Zone 02")
    :setDescription("Zone 02 - FOX1 fighters")
    :addPlayerCoalition(coalition.side.BLUE)
    :setZoneCenterFromCoordinates("U37TEL4792")
    :setZoneRadius(90000) -- 50 nm
    :setDrawZone(true)
    :setRespawnDefaultOffset(0, -45000) -- 45km north of the zone's center
    :setRespawnRadius(10000)
    :addRandomWave( { "[0, 0]-cap Mig21-Fox2-solo, hdg 180, dist 30"  }, 1) -- a single Mig-21 with FOX2 missiles spawning near
    :addRandomWave( { "-cap Mig21-Fox1, size 2, hdg 180, dist 50", "-cap Mig23S-Fox1, size 2, hdg 180, dist 50", "-cap Mig25-Fox1, size 2, hdg 180, dist 50" }, 1) -- 1 group from FOX1 fighter pairs
    :addRandomWave( { "-cap Su27-Fox1, hdg 180, dist 50", "-cap Su33-Fox1, hdg 180, dist 50", "-cap Mig29A-Fox1, hdg 180, dist 50" }, 3) -- 3 groups from modern FOX1 fighter pairs
    :setMessageStart("La zone %s est fonctionnelle")
    :setMessageDeploy("La zone %s déploie la vague numéro %s")
    :setMessageDestroyed("La vague %s a été détruite dans la zone %s")
    :setMessageWon("La zone %s est gagnée (plus d'ennemi)")
    :setMessageStop("La zone %s n'est plus active")
    :start()

    -- example zone 03 (deep copied from zone 01, changed only the name and coordinates)
    mist.utils.deepCopy(veafAirWaves.get("Zone 01"))
    :setName("Zone 03")
    :setDescription("Zone 03 - FOX1 fighters")
    :setZoneCenterFromCoordinates("U37TCH2163")
    :start()

    AirWaveZone:new()
    :setName("zone1")
    :setDescription("zone 1")
    :addPlayerCoalition(coalition.side.BLUE)
    :setTriggerZone("airWave_zone1")
    --:setZoneCenterFromCoordinates("U37TEK8250048000")
    --:setZoneRadius(91440) -- 300,000 feet
    :addRandomWave({ "airWave_zone1_wave1-1", "airWave_zone1_wave1-2"}, 1) -- spawn one of the 2 groups
    :addRandomWave({ "airWave_zone1_wave2-1", "airWave_zone1_wave2-2"}, 2) -- spawn two of the 2 groups (can be multiple times the same group!)
    --:setRespawnRadius(10000) -- 10km respawn radius
    --:setMaximumAltitudeInFeet(12500) -- hard ceiling is 12500 feet
    --:setMinimumAltitudeInFeet(11500) -- hard floor is 11500 feet
    :start()

    veaf.loggers.get(veafAirWaves.Id):debug("Initialized")
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize all the scripts
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafRadio then
    veaf.loggers.get(veaf.Id):info("init - veafRadio")
    veafRadio.initialize(true)
end
if veafSpawn then
    veaf.loggers.get(veaf.Id):info("init - veafSpawn")
    veafSpawn.initialize()
end
if veafGrass then
    veaf.loggers.get(veaf.Id):info("init - veafGrass")
    veafGrass.initialize()
end
if veafCasMission then
    veaf.loggers.get(veaf.Id):info("init - veafCasMission")
    veafCasMission.initialize()
end
if veafTransportMission then
    veaf.loggers.get(veaf.Id):info("init - veafTransportMission")
    veafTransportMission.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- change some default parameters
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veaf.DEFAULT_GROUND_SPEED_KPH = 25

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize SHORTCUTS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafShortcuts then
    veaf.loggers.get(veaf.Id):info("init - veafShortcuts")
    veafShortcuts.initialize()

    -- you can add all the shortcuts you want here. Shortcuts can be any VEAF command, as entered in a map marker.
    -- here are some examples :

    -- veafShortcuts.AddAlias(
    --     VeafAlias:new()
    --         :setName("-sa11")
    --         :setDescription("SA-11 Gadfly (9K37 Buk) battery")
    --         :setVeafCommand("_spawn group, name sa11")
    --         :setBypassSecurity(true)
    -- )
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure ASSETS
-------------------------------------------------------------------------------------------------------------------------------------------------------------

if veafAssets then
    veaf.loggers.get(veaf.Id):info("Loading configuration")
    veafAssets.Assets = {
	    {sort=1, name="Arco", description="Arco (KC-135)", information="Tacan 11Y\nVHF 251 Mhz\nZone OUEST", linked={"Arco-escort1","Arco-escort2"}},
	    {sort=2, name="Petrolsky", description="900 (IL-78M, RED)", information="VHF 267 Mhz", linked="Petrolsky-escort"},
    }

    veaf.loggers.get(veaf.Id):info("init - veafAssets")
    veafAssets.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure MOVE
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafMove then
    veaf.loggers.get(veaf.Id):info("Setting move tanker radio menus")
    -- keeping the veafMove.Tankers table empty will force veafMove.initialize() to browse the units, and find the tankers
    veaf.loggers.get(veaf.Id):info("init - veafMove")
    veafMove.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure COMBAT MISSION
-------------------------------------------------------------------------------------------------------------------------------------------------------------

if veafCombatMission then
    veaf.loggers.get(veaf.Id):info("Loading configuration")

    veafCombatMission.addCapMission("CAP-Maykop-1", "CAP on Maykop", "A Russian CAP patrol has been spotted over Maykop.", true, true)

    veafCombatMission.AddMission(
		VeafCombatMission:new()
		:setName("ELINT-Mission-1")
		:setFriendlyName("Start ELINT gathering")
		:setBriefing([[
West patrol ; ATIS on 282.125, SAM CONTROL on 282.225
A C-130 pair will fly reciprocical headings, trying to pinpoint enemy SAMS.
Don't let them be destroyed by the enemy !]])
		:addElement(
			VeafCombatMissionElement:new()
			:setName("ELINT")
			:setGroups({
				"ELINT-C-130-1",
				"ELINT-C-130-2"
            })
			:setSkill("Good")
		)
		:initialize()
	)

    veaf.loggers.get(veaf.Id):info("init - veafCombatMission")
    veafCombatMission.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure COMBAT ZONE
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafCombatZone then
    veaf.loggers.get(veaf.Id):info("Loading configuration")

    veafCombatZone.EventMessages.CombatZoneComplete = nil
    veafCombatZone.SecondsBetweenWatchdogChecks = 10 -- for testing purpose
    veafCombatZone.RadioMenuName = "Command center"
    veafCombatZone.CombatZoneRadioMenuName = "Secondary missions" -- optional
    veafCombatZone.OperationRadioMenuName = "Primary operations" -- optional

    veafCombatZone.AddZone(
		VeafCombatZone:new()
			:setMissionEditorZoneName("combatZone_CrossKobuleti")
			:setFriendlyName("Cross Kobuleti")
			:setBriefing("This is a simple mission\n" ..
						 "You must destroy the comm antenna\n" ..
						 "The other ennemy units are secondary targets\n")
			:initialize()
	)
	veafCombatZone.AddZone(
		VeafCombatZone:new()
			:setMissionEditorZoneName("combatZone_Batumi")
			:setFriendlyName("Batumi airbase")
			:setBriefing("A BTR patrol and a few manpads are dispersed around the Batumi airbase")
			:initialize()
            :setTraining(true)
    )

    function onGoriEnd(zone)
        trigger.action.outText(string.format("Hook on %s", zone:getFriendlyName()), 10)
    end

    -- Operations
    local gori = VeafCombatZone:new()
        :setMissionEditorZoneName("subCombatZone_gori")
        :setFriendlyName("Mission Gori")
        :setBriefing("Destroy the armored group in the city of Gori")
        :setOnCompletedHook(onGoriEnd)
        :initialize()
        :setTraining(false)
    local otarasheni = VeafCombatZone:new()
        :setMissionEditorZoneName("subCombatZone_otarasheni")
        :setFriendlyName("Mission Otarasheni")
        :setBriefing("Destroy the mortar group in the city of Otarasheni")
        :initialize()
        :setTraining(false)
    local arashenda = VeafCombatZone:new()
        :setMissionEditorZoneName("subCombatZone_arashenda")
        :setFriendlyName("Mission Arashenda")
        :setBriefing("Destroy the AAA group near Arashenda")
        :initialize()
        :setTraining(false)

    veafCombatZone.AddZone(
        VeafCombatOperation:new()
            :setMissionEditorZoneName("goriOperation")
            :setFriendlyName("Operation Gori free")
            :setBriefing("This operation aims to free the city of Gori of any pressure from local forces.\n" ..
            "Complete all tasks to get it done.")
            :addTaskingOrder(gori)
            :addTaskingOrder(otarasheni)
            :addTaskingOrder(arashenda, { gori:getMissionEditorZoneName(), otarasheni:getMissionEditorZoneName() })
            :initialize()
    )

    veaf.loggers.get(veaf.Id):info("init - veafCombatZone")
    veafCombatZone.initialize()


end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure WW2 settings based on loaded theatre
-------------------------------------------------------------------------------------------------------------------------------------------------------------
local theatre = string.lower(env.mission.theatre)
veaf.loggers.get(veaf.Id):info(string.format("theatre is %s", theatre))
veaf.config.ww2 = false
if theatre == "thechannel" then
    veaf.config.ww2 = true
elseif theatre == "normandy" then
    veaf.config.ww2 = true
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure NAMEDPOINTS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafNamedPoints then

    veaf.loggers.get(veaf.Id):info("Loading configuration")

    veaf.loggers.get(veaf.Id):info("init - veafNamedPoints")
    if theatre == "syria" then
        veafNamedPoints.Points = {
            -- Turkish Airports
            {name="INCIRLIK AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("37.001944", "35.425833"), {atc=true, tower="V129.40, U360.10", tacan="21X", runways={{name="05", hdg=50, ils="109.30"}, {name="23", hdg=230, ils="111.70"}}})},
            {name="ADANA SAKIRPASA INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.981944", "35.280278"), {atc=true, tower="V121.10, U251.00", runways={{name="05", hdg=51, ils="108.70"}, {name="23", hdg=231}}})},
            {name="HATAY AIRPORT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.360278", "36.285000"), {atc=true, tower="V128.50, U250.25", runways={{name="04", hdg=40, ils="108.90"}, {name="22", hdg=220, ils="108.15"}}})},
            {name="GANZIANTEP",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.947057", "37.478579"), {atc=true, tower="V120.10, U250.05", runways={{name="10", hdg=100}, {name="28", hdg=280, ils="109.10"}}})},

            -- Syrian Airports
            {name="MINAKH HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.521944", "37.041111"), {atc=true, tower="V120.60, U250.80", runways={{name="10", hdg=97}, {name="28", hdg=277}}})},
            {name="ALEPPO INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.180556", "37.224167"), {atc=true, tower="V119.10, U250.85", runways={{name="09", hdg=93}, {name="27", hdg=273}}})},
            {name="KUWEIRES AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.186944", "37.583056"), {atc=true, tower="V120.50, U251.10", runways={{name="10", hdg=97}, {name="28", hdg=277}}})},
            {name="JIRAH AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("36.097500", "37.940278"), {atc=true, tower="V118.10, U250.30", runways={{name="10", hdg=96}, {name="28", hdg=276}}})},
            {name="TAFTANAZ HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.972222", "36.783056"), {atc=true, tower="V122.80, U251.45", runways={{name="10", hdg=100}, {name="28", hdg=280}}})},
            {name="ABU AL DUHUR AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.732778", "37.101667"), {atc=true, tower="V122.20, U250.45", runways={{name="09", hdg=89}, {name="27", hdg=269}}})},
            {name="TABQA AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.754444", "38.566667"), {atc=true, tower="V118.50, U251.40", runways={{name="09", hdg=88}, {name="27", hdg=268}}})},
            {name="BASSEL AL ASSAD (KHMEIMIM)", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.400833", "35.948611"), {atc=true, tower="V118.10, U250.55", runways={{name="17R", hdg=174, ils="109.10"}, {name="17L", hdg=174}, {name="35R", hdg=354}, {name="35L", hdg=354}}})},
            {name="HAMA AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("35.118056", "36.711111"), {atc=true, tower="V118.05, U250.20", runways={{name="09", hdg=96}, {name="27", hdg=276}}})},
            {name="AL QUSAYR AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.570833", "36.571944"),  {atc=true, tower="V119.20, U251.55", runways={{name="10", hdg=98}, {name="28", hdg=278}}})},
            {name="PALYMYRA AIRPORT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.557222", "38.316667"), {atc=true, tower="V121.90, U250.90", runways={{name="08", hdg=80}, {name="26", hdg=260}}})},
            {name="AN NASIRIYAH AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.918889", "36.866389"), {atc=true, tower="V122.30, U251.65", runways={{name="04", hdg=41}, {name="22", hdg=221}}})},
            {name="AL DUMAYR AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.609444", "36.748889"), {atc=true, tower="V120.30, U251.95", runways={{name="06", hdg=62}, {name="24", hdg=242}}})},
            {name="MEZZEH AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.477500", "36.223333"), {atc=true, tower="V120.70, U250.75", runways={{name="06", hdg=57}, {name="24", hdg=237}}})},
            {name="MARJ AS SULTAN NTH HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.500278", "36.466944"), {atc=true, tower="V122.70, U250.60", runways={{name="08", hdg=80}, {name="26", hdg=260}}})},
            {name="MARJ AS SULTAN STH HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.486944", "36.475278"), {atc=true, tower="V122.90, U251.90", runways={{name="09", hdg=90}, {name="27", hdg=270}}})},
            {name="QABR AS SITT HELIPT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.458611", "36.357500"), {atc=true, tower="V122.60, U250.95", runways={{name="05", hdg=50}, {name="23", hdg=230}}})},
            {name="DAMASCUS INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.415000", "36.519444"), {atc=true, tower="V118.50, U251.85", runways={{name="05R", hdg=46}, {name="05L", hdg=46}, {name="23R", hdg=226, ils="109.90"}, {name="23L", hdg=226}}})},
            {name="MARJ RUHAYYIL AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.286389", "36.457222"), {atc=true, tower="V120.80, U250.65", runways={{name="06", hdg=59}, {name="24", hdg=239}}})},
            {name="KHALKHALAH AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.077222", "36.558056"), {atc=true, tower="V122.50, U250.35", runways={{name="07", hdg=72}, {name="15", hdg=147}, {name="25", hdg=252}, {name="33", hdg=327}}})},
            {name="SAYQUAL AB",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.679816", "37.218204"), {atc=true, tower="V120.40, U251.30", runways={{name="08", hdg=80}, {name="26", hdg=260}}})},
            {name="SHAYRAT AB",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.494819", "36.903173"), {atc=true, tower="V120.20, U251.35", runways={{name="11", hdg=110}, {name="29", hdg=290}}})},
            {name="TIYAS AB",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.522645", "37.627498"), {atc=true, tower="V120.50, U251.50", runways={{name="09", hdg=90}, {name="27", hdg=270}}})},

            -- Lebanese Airports
            {name="RENE MOUAWAD AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.589444", "36.011389"), {atc=true, tower="V121.00, U251.20", runways={{name="06", hdg=59}, {name="24", hdg=239}}})},
            {name="HAJAR AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("34.283333", "35.680278"),  {atc=true, tower="V121.50, U251.60", runways={{name="02", hdg=25}, {name="20", hdg=205}}})},
            {name="BEIRUT INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.821111", "35.488333"), {atc=true, tower="V118.90, U251.80", runways={{name="03", hdg=30, ils="110.70"}, {name="16", hdg=164, ils="110.10"}, {name="17", hdg=175, ils="109.50"}, {name="21", hdg=210}, {name="34", hdg=344}, {name="35", hdg=355}}})},
            {name="RAYAK AB", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.852222", "35.990278"),  {atc=true, tower="V124.40, U251.15", runways={{name="04", hdg=42}, {name="22", hdg=222}}})},
            {name="NAQOURA HELIPT",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.107877", "35.127728"), {atc=true, tower="V122.00, U251.70"})},

            -- Israeli Airports
            {name="KIRYAT SHMONA AIRPORT", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("33.216667", "35.596667"), {atc=true, tower="V118.40, U250.50", runways={{name="03", hdg=34}, {name="21", hdg=214}}})},
            {name="HAIFA INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.809167", "35.043056"), {atc=true, tower="V127.80, U250.15", runways={{name="16", hdg=158}, {name="34", hdg=338}}})},
            {name="RAMAT DAVID INTL", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.665000", "35.179444"), {atc=true, tower="V118.60, U251.05", runways={{name="09", hdg=85}, {name="11", hdg=107}, {name="15", hdg=143}, {name="27", hdg=265}, {name="29", hdg=287}, {name="33", hdg=323}}})},
            {name="MEGIDDO AIRFIELD", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.597222", "35.228611"), {atc=true, tower="V119.90, U250.70", runways={{name="09", hdg=89}, {name="27", hdg=269}}})},
            {name="EYN SHEMER AIRFIELD", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.440556", "35.007500"), {atc=true, tower="V123.40, U250.00", runways={{name="09", hdg=96}, {name="27", hdg=276}}})},

            -- Jordan Airports
            {name="KING HUSSEIN AIR COLLEGE", point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.356389", "36.259167"), {atc=true, tower="V118.30, U250.40", runways={{name="13", hdg=128}, {name="31", hdg=308}}})},
            {name="H4",point=veafNamedPoints.addDataToPoint(coord.LLtoLO("32.539122", "38.195841"), {atc=true, tower="V122.60, U250.10", runways={{name="10", hdg=100}, {name="28", hdg=280}}})},
        }
        veafNamedPoints.addAllSyriaCities()
    elseif theatre == "caucasus" then
        veafNamedPoints.Points = {
            -- airbases in Georgia
            {name="AIRBASE Batumi",  point={x=-356437,y=0,z=618211, atc=true, tower="V131, U260", tacan="16X BTM", runways={{name="13", hdg=125, ils="110.30"}, {name="31", hdg=305}}}},
            {name="AIRBASE Gudauta", point={x=-196850,y=0,z=516496, atc=true, tower="V130, U259", runways={ {name="15", hdg=150}, {name="33", hdg=330}}}},
            {name="AIRBASE Kobuleti",point={x=-318000,y=0,z=636620, atc=true, tower="V133, U262", tacan="67X KBL", runways={ {name="07", hdg=69, ils="111.50"}}}},
            {name="AIRBASE Kutaisi", point={x=-284860,y=0,z=683839, atc=true, tower="V134, U264", tacan="44X KTS", runways={ {name="08", hdg=74, ils="109.75"}, {name="26", hdg=254}}}},
            {name="AIRBASE Senaki",  point={x=-281903,y=0,z=648379, atc=true, tower="V132, U261", tacan="31X TSK", runways={ {name="09", hdg=94, ils="108.90"}, {name="27", hdg=274}}}},
            {name="AIRBASE Sukhumi", point={x=-221382,y=0,z=565909, atc=true, tower="V129, U258", runways={{name="12", hdg=116}, {name="30", hdg=296}}}},
            {name="AIRBASE Tbilisi", point={x=-314926,y=0,z=895724, atc=true, tower="V138, U267", tacan="25X GTB", runways={{name="13", hdg=127, ils="110.30"},{name="31", hdg=307, ils="108.90"}}}},
            {name="AIRBASE Vaziani", point={x=-319000,y=0,z=903271, atc=true, tower="V140, U269", tacan="22X VAS", runways={ {name="13", hdg=135, ils="108.75"}, {name="31", hdg=315, ils="108.75"}}}},
            -- airbases in Russia
            {name="AIRBASE Anapa - Vityazevo",   point={x=-004448,y=0,z=244022, atc=true, tower="V121, U250" , runways={ {name="22", hdg=220}, {name="04", hdg=40}}}},
            {name="AIRBASE Beslan",              point={x=-148472,y=0,z=842252, atc=true, tower="V141, U270", runways={ {name="10", hdg=93, ils="110.50"}, {name="28", hdg=273}}}},
            {name="AIRBASE Krymsk",              point={x=-007349,y=0,z=293712, atc=true, tower="V124, U253", runways={ {name="04", hdg=39}, {name="22", hdg=219}}}},
            {name="AIRBASE Krasnodar-Pashkovsky",point={x=-008707,y=0,z=388986, atc=true, tower="V128, U257", runways={ {name="23", hdg=227}, {name="05", hdg=47}}}},
            {name="AIRBASE Krasnodar-Center",    point={x=-011653,y=0,z=366766, atc=true, tower="V122, U251", runways={ {name="09", hdg=86}, {name="27", hdg=266}}}},
            {name="AIRBASE Gelendzhik",          point={x=-050996,y=0,z=297849, atc=true, tower="V126, U255", runways={ {hdg=40}, {hdg=220}}}},
            {name="AIRBASE Maykop",              point={x=-027626,y=0,z=457048, atc=true, tower="V125, U254", runways={ {name="04", hdg=40}, {name="22", hdg=220}}}},
            {name="AIRBASE Mineralnye Vody",     point={x=-052090,y=0,z=707418, atc=true, tower="V135, U264", runways={ {name="12", hdg=115, ils="111.70"}, {name="30", hdg=295, ils="109.30"}}}},
            {name="AIRBASE Mozdok",              point={x=-083330,y=0,z=835635, atc=true, tower="V137, U266", runways={ {name="08", hdg=82}, {name="26", hdg=262}}}},
            {name="AIRBASE Nalchik",             point={x=-125500,y=0,z=759543, atc=true, tower="V136, U265", runways={ {name="06", hdg=55}, {name="24", hdg=235, ils="110.50"}}}},
            {name="AIRBASE Novorossiysk",        point={x=-040299,y=0,z=279854, atc=true, tower="V123, U252", runways={ {name="04", hdg=40}, {name="22", hdg=220}}}},
            {name="AIRBASE Sochi",               point={x=-165163,y=0,z=460902, atc=true, tower="V127, U256", runways={ {name="06", hdg=62, ils="111.10"}, {name="24", hdg=242}}}},
        }
        veafNamedPoints.addAllCaucasusCities()
    elseif theatre == "persiangulf" then
        veafNamedPoints.Points = {
        }
        veafNamedPoints.addAllPersianGulfCities()
    elseif theatre == "thechannel" then
        veafNamedPoints.Points = {
        }
        veafNamedPoints.addAllTheChannelCities()
    elseif theatre == "marianaislands" then
        veafNamedPoints.Points = {
            -- airbases in Blue Island
            {name="AIRBASE Andersen AFB",  point={x=-010688,y=0,z=014822, atc=true, tower="V126.2, U250.1", tacan="54X", runways={{name="06", hdg=66}, {name="24", hdg=246}}}},
            {name="AIRBASE Antonio B. Won Pat Intl", point={x=-000068,y=0,z=-000109, atc=true, tower="V118.1, U340.2", runways={ {name="6", hdg=65, ils="110.30"}, {name="24", hdg=245}}}},
            {name="AIRBASE Olf Orote",point={x=-005047,y=0,z=-016913, atc=false}},
            {name="AIRBASE Santa Rita",point={x=-013576,y=0,z=-009925, atc=false}},

            -- airbases in Neutral Island
            {name="AIRBASE Rota Intl", point={x=-075886,y=0,z=048612, atc=true, tower="V123.6, U250", tacan="44X KTS", runways={ {name="09", hdg=92, ils="109.75"}, {name="27", hdg=272}}}},

            -- airbases in Red Island
            {name="AIRBASE Tinian Intl",  point={x=-166865,y=0,z=090027, atc=true, tower="V123.65, U250.05", tacan="31X TSK", runways={ {name="0", hdg=94, ils="108.90"}, {name="27", hdg=274}}}},
            {name="AIRBASE Saipan Intl", point={x=180074,y=0,z=101921, atc=true, tower="V125.7, U256.9", runways={{name="07", hdg=68, ils="109.90"}, {name="25", hdg=248}}}},
        }
        veafNamedPoints.addAllMarianasIslandsCities()
    else
        veaf.loggers.get(veaf.Id):warn(string.format("theatre %s is not yet supported by veafNamedPoints", theatre))
    end
    -- points of interest
    table.insert(veafNamedPoints.Points,
        {name="RANGE Kobuleti",point={x=-328289,y=0,z=631228}}
    )
    veafNamedPoints.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure SECURITY
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafSecurity then
    --let's not set a password
    --veafSecurity.password_L9["SHA1 hash of the password"] = true -- set the L9 password (the lowest possible security)
    veaf.loggers.get(veaf.Id):info("Loading configuration")
    veaf.loggers.get(veaf.Id):info("init - veafSecurity")
    veafSecurity.initialize()

    -- force security in order to test it when dynamic loading is in place (change to TRUE)
    if (false) then
        veaf.SecurityDisabled = false
        veafSecurity.authenticated = false
    end
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure CARRIER OPERATIONS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafCarrierOperations then
    veaf.loggers.get(veaf.Id):info("init - veafCarrierOperations")
    veafCarrierOperations.initialize(true)
    --mist.scheduleFunction(veafCarrierOperations.startCarrierOperations,{{"CSG-74 Stennis", 90}},timer.getTime() + 1)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure CTLD
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if ctld then
    veaf.loggers.get(veaf.Id):info("init - ctld")
    ctld.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize the remote interface
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafRemote then
    veaf.loggers.get(veaf.Id):info("init - veafRemote")
    veafRemote.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize the interpreter
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafInterpreter then
    veaf.loggers.get(veaf.Id):info("init - veafInterpreter")
    veafInterpreter.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize Skynet-IADS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafSkynet then
    veaf.loggers.get(veaf.Id):info("init - veafSkynet")
    veafSkynet.initialize(
        false, --includeRedInRadio=true
        false, --debugRed
        false, --includeBlueInRadio
        false --debugBlue
    )
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize veafSanctuary
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafSanctuary then
    veaf.loggers.get(veaf.Id):info("init - veafSanctuary")
    --veafSanctuary.addZoneFromTriggerZone("Sanctuary_Kutaisi")
    veafSanctuary.addZone(
        VeafSanctuaryZone:new()
        :setName("Kutaisi Sanctuary")
        :setPolygonFromUnits({
            "Sanctuary_Kutaisi_Polygon #001",
            "Sanctuary_Kutaisi_Polygon #002",
            "Sanctuary_Kutaisi_Polygon #003",
            "Sanctuary_Kutaisi_Polygon #004",
            "Sanctuary_Kutaisi_Polygon #005",
            "Sanctuary_Kutaisi_Polygon #006",
            "Sanctuary_Kutaisi_Polygon #007",
            "Sanctuary_Kutaisi_Polygon #008",
            "Sanctuary_Kutaisi_Polygon #009",
            "Sanctuary_Kutaisi_Polygon #010",
            "Sanctuary_Kutaisi_Polygon #011",
            "Sanctuary_Kutaisi_Polygon #012",
            "Sanctuary_Kutaisi_Polygon #013",
            "Sanctuary_Kutaisi_Polygon #014",
            "Sanctuary_Kutaisi_Polygon #015",
            "Sanctuary_Kutaisi_Polygon #016"
        }))
        :setCoalition(coalition.side.BLUE)
        :setDelayWarning(0)    -- immediate warning, as soon as the plane is detected in the zone 
        :setDelaySpawn(-1)     -- after 60 seconds in the zone, start spawning defense systems
        :setDelayInstant(240)   -- no instant death
        :setProtectFromMissiles()
    veafSanctuary.initialize()
end

-- example of automatic activation of a combat zone
--veafCombatZone.ActivateZone("combatZone_CrossKobuleti", false)

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize Hound Elint
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafHoundElint and false then -- don't use Hound Elint
    veaf.loggers.get(veaf.Id):info("init - veafHoundElint")
    veafHoundElint.initialize(
        "ELINT", -- prefix
        { -- red
            admin = false,
            markers = true,
            atis = false,
            controller = false
        },
        { -- blue
            admin = false,
            markers = true,
            atis = {
                freq = 282.125,
                interval = 15,
                speed = 1,
                reportEWR = false
            },
            controller = {
                freq = 282.225,
                voiceEnabled = true
            }
        }
    )
end

-- automatically start the ELINT mission
--[[
veafCombatMission.ActivateMission("ELINT-Mission-1", true)
]]

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Testing veafShortcuts.ExecuteBatchAliasesList
-------------------------------------------------------------------------------------------------------------------------------------------------------------
local delay = nil -- no delay
local coa = 1 -- blue
local silent = false -- shout my name baby
veafShortcuts.ExecuteBatchAliasesList({
        "-shell#U38TLM3120086100",
        "-shell#U38TLM3155087960",
        "-armor#U38TLM3167086723, side red",
        "-armor#U38TLM3085285707, side blue",
    }, delay, coa, silent)

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mission Master stuffn  
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function mySuperCoolFunction(text)
    trigger.action.outText("Yay, my super cool function was run with "..text, 5)
    return text.."-result"
end

function shellsAt(coord)
    veafShortcuts.ExecuteBatchAliasesList({"-shells#"..coord..", radius 250"})
end

-- Mission master group ID is "1"
local mmGroupID = 1
-- if "silent" is true, no message will be displayed when running the runnable
local silent = false
veafSpawn.missionMasterSetMessagingMode(silent, mmGroupID)

veafSpawn.missionMasterAddRunnable("mscf1", mySuperCoolFunction, "test1")
veafSpawn.missionMasterAddRunnable("mscf2", mySuperCoolFunction, "test2")
veafSpawn.missionMasterAddRunnable("shellRed", shellsAt, "U38TLM3167086723")
veafSpawn.missionMasterAddRunnable("shellBlue", shellsAt, "U38TLM3085285707")
veafSpawn.missionMasterAddRunnable("startPA", veafCarrierOperations.startCarrierOperations, {"CSG-74 Stennis", 90})
veafSpawn.missionMasterAddRunnable("stopPA", veafCarrierOperations.stopCarrierOperations, "CSG-74 Stennis")

if veafSecurity then
    veafSecurity.password_MM["a7e627f2edbca7a8feac8b652764c043e9ae18d7"] = true -- this password is `encircle-account-cilium`
    veafSecurity.password_MM["cb02f137c8422720075e53075d062ab6de398af6"] = true -- there can be multiple passwords ; this one is `sudanese-seaweed-yucatan` 
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- mission-specific menus
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if (veafRadio) then
    local MISSION_MASTER_GROUPID = 1
    local LOG_NAME = "DEMO"
    local LOG_LEVEL = "trace"
    local RESPAWN_RADIUS = 500 -- rayon de respawn, en mètres
    ----------------------------------------

    veaf.loggers.new(LOG_NAME, LOG_LEVEL)

    local function _respawnCap(groupName)
        local message = string.format("On va respawner le groupe [%s]", veaf.p(groupName))
        veaf.loggers.get(LOG_NAME):debug(message)
        trigger.action.outTextForGroup(MISSION_MASTER_GROUPID, message, 5)

        local group = Group.getByName(groupName)
        if group == nil then
            local message = string.format("Impossible de trouver le groupe [%s] pour le respawner", veaf.p(groupName))
            veaf.loggers.get(LOG_NAME):error(message)
            trigger.action.outTextForGroup(MISSION_MASTER_GROUPID, message, 5)
        else
            --group:activate()
            local vars = {}
            vars.gpName = groupName
            vars.action = 'respawn'
            vars.radius = RESPAWN_RADIUS
            vars.route = mist.getGroupRoute(groupName, 'task')
            group = mist.teleportToPoint(vars) -- respawn with radius
            local message = string.format("Groupe [%s] réactivé avec succès", veaf.p(groupName))
            if not(group) then
                message = string.format("Impossible de réactiver le groupe [%s]", veaf.p(groupName))
            end
            veaf.loggers.get(LOG_NAME):info(message)
            trigger.action.outTextForGroup(MISSION_MASTER_GROUPID, message, 5)
        end
    end

    local function _changeQra(parameters)
        local name, startOrStop = veaf.safeUnpack(parameters)
        veaf.loggers.get(LOG_NAME):info("_changeQra(%s, %s)", name, startOrStop)
        local qra = veafQraManager.get(name)
        if qra then
            trigger.action.outText(string.format("DEBUG - QRA %s - %s", name, startOrStop), 10)
            if startOrStop:upper() == "START" then
                qra:start(false)
            else
                qra:stop(false)
            end
        end
    end

    local function _destroyGroup(name)
        local names = name
        if type(name) == "string" then
            names = {name}
        end
        for _, name in pairs(names) do
            local _group = Group.getByName(name)
            if _group then
                _group:destroy()
                trigger.action.outText(string.format("Group %s has been destroyed", name), 10)
            end
        end
    end

    local function _airwaves_destroyWave()
        local _zone = veafAirWaves.get("zone1")
        if _zone then
            _zone:destroyCurrentWave()
            trigger.action.outText(string.format("DEBUG - Wave has been forced destroyed"), 10)
        end
    end

    local function _airwaves_stop()
        local _zone = veafAirWaves.get("zone1")
        if _zone then
            _zone:stop()
            trigger.action.outText(string.format("DEBUG - Zone has been stopped"), 10)
        end
    end

    local function _airwaves_start()
        local _zone = veafAirWaves.get("zone1")
        if _zone then
            _zone:start()
            trigger.action.outText(string.format("DEBUG - Zone has been started"), 10)
        end
    end

    local function _spawnFOB()
        local delay = nil -- no delay
        local coa = 1 -- blue
        local silent = true
        veafShortcuts.ExecuteBatchAliasesList({
        "-fob#U37TGG2164791685, side blue, hdg 270, radius 1",
        }, delay, coa, silent)
    end

    local function menu(name, items)
        return {
            "menu", name, items
        }
    end

    local function command(name, aFunction, parameters)
        return {
            "command", name, aFunction, parameters
        }
    end

    local userMenu = {
        menu("Mission menus", {
            menu("Gestion CAP", {
                menu("CAP Est", {
                    menu("Facile", {
                        command("Mig21", _respawnCap, "EST on Demand MIG21"),
                        command("Mig21x3", _respawnCap, "EST on Demand MIG21x3"),
                    }),
                    menu("Moyen", {
                        command("Mig31", _respawnCap, "EST on Demand mig31"),
                        command("Mig31x3", _respawnCap, "EST on Demand mig31x3"),
                    }),
                }),
                menu("CAP Ouest", {
                    menu("Facile", {
                        command("Mig21", _respawnCap, "OUEST on Demand MIG21"),
                        command("Mig21x3", _respawnCap, "OUEST on Demand MIG21x3"),
                    }),
                    menu("Moyen", {
                        command("Mig31", _respawnCap, "OUEST on Demand mig31"),
                        command("Mig31x3", _respawnCap, "OUEST on Demand mig31x3"),
                    }),
                })
            }),
            menu("QRA Maykop", {
                command("Stop", _changeQra, {"QRA-Maykop", "stop"}),
                command("Start", _changeQra, {"QRA-Maykop", "start"}),
            }),
            menu("Airwave tests", {
                command("Start", _airwaves_start, {}),
                command("Stop", _airwaves_stop, {}),
                command("Destroy wave", _airwaves_destroyWave, {}),
            }),
            menu("FOB test", {
                command("Spawn FOB", _spawnFOB),
            })
        })
    }

    --veafRadio.createUserMenu(userMenu, MISSION_MASTER_GROUPID)
    veafRadio.createUserMenu(userMenu)
end

-- Silence ATC on all the airdromes
veaf.silenceAtcOnAllAirbases()

veafCombatZone.GetZone("goriOperation"):activate()

