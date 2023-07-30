if Config.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
end

local showingHelpText = false

CreateThread(function()
    while true do
        Wait(1)
        local inZone = false
        local showMarker = false
        local playerCoords = GetEntityCoords(PlayerPedId())
        local closestDistance = -1
        local closestLocation = nil
        
        for k, v in pairs(Config.Locations) do
            local locationCoords = v.Location
            local zoneDist = #(playerCoords - locationCoords)

            if zoneDist < 15 then
                showMarker = true
                DrawMarker(2, locationCoords.x, locationCoords.y, locationCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 28, 140, 214, 222, false, false, false, true, false, false, false)

                if zoneDist < 1.5 then
                    inZone = true
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent('m-JobForms:Client:OpenForm', v.Form)
                    end
                end
            end
        end
        
        if not inZone and shown then
            shown = false
            if Config.Framework == "qb" then
                exports['qb-core']:HideText()
            elseif Config.Framework == "esx" then
                lib.hideTextUI()
            end
        elseif inZone and not shown then
            shown = true
            if Config.Framework == "qb" then
                exports['qb-core']:DrawText('[E] - Form', 'right')
            elseif Config.Framework == "esx" then
                lib.showTextUI('[E] - Form')
            end
        end

        if not showMarker then Wait(500) end

    end
end)


RegisterNetEvent('m-JobForms:Client:OpenForm')
AddEventHandler('m-JobForms:Client:OpenForm', function(form)
    local playerPed = PlayerPedId()
    if form == "police" then
        if Config.Menus == "qb" then
            local dialog = exports["qb-input"]:ShowInput({
                header = " Police Form",
                submitText = "Submit Form",
                inputs = {
                    { text = "Your Name",                               name = "name",          type = "text",  isRequired = true,  },
                    { text = "Your Age",                                name = "age",           type = "text",  isRequired = true,  },
                    { text = "Your Number",                             name = "number",        type = "text",  isRequired = true,  },
                    { text = "About You",                               name = "aboutyou",      type = "text",  isRequired = true,  },
                    { text = "Have you ever worked with weapons?",      name = "weapons",       type = "select", options = {  { value = "yes", text = "Yes" }, { value = "no", text = "No" }, } },
                    { text = "Have you ever worked an emergency job?",  name = "emergencyjob",  type = "select", options = {  { value = "yes", text = "Yes" }, { value = "no", text = "No" }, } },
                },
            })

            if dialog then
                if Config.Emotes == "dpemotes" then TriggerEvent('animations:client:EmoteCommandStart', {Config.Animation}) elseif Config.Emotes == "rpemotes" then exports["rpemotes"]:EmoteCommandStart(Config.Animation) else print("Missing or write wrong on: Config.Emotes") end
                QBCore.Functions.Progressbar("writingPoliceForm", "Writing...", Config.Time, false, true, {
                    disableMovement = true, 
                    disableCarMovement = true, 
                    disableMouse = false, 
                    disableCombat = true, 
                }, {}, {}, {}, function()  
                    if Config.SendEmail then
                        Email(form)
                    end
                    if Config.Emotes == "dpemotes" then TriggerEvent('animations:client:EmoteCommandStart', {"c"}) elseif Config.Emotes == "rpemotes" then exports["rpemotes"]:EmoteCommandStart("c") else print("Missing or write wrong on: Config.Emotes") end
                    if Config.SendEmail then Email(form) end
                    TriggerServerEvent('m-JobForms:Server:ApplyPoliceForm', dialog.name, dialog.age, dialog.number, dialog.aboutyou, dialog.weapons, dialog.emergencyjob)
                end)
            end
        elseif Config.Menus == "ox" then
            local input = lib.inputDialog("Police Form", {
                { type = 'input',        label = 'Your Name',            description = 'Write your name here',               required = true, icon = 'hashtag' },
                { type = 'input',        label = 'Your Age',             description = 'Write your age here',                required = true, icon = 'hashtag' },
                { type = 'input',        label = 'Your Number',          description = 'Write your number here',             required = true, icon = 'hashtag' },
                { type = 'input',        label = 'About You',            description = 'Write something about you here',     required = true, icon = 'hashtag' },
                { type = 'input',        label = 'Have you ever worked with weapons?',        description = '( Yes or No )', required = true, icon = 'hashtag' },
                { type = 'input',        label = 'Have you ever worked an emergency job?',    description = '( Yes or No )', required = true, icon = 'hashtag' },
            })
            if input then
                if Config.Emotes == "dpemotes" then TriggerEvent('animations:client:EmoteCommandStart', {Config.Animation}) elseif Config.Emotes == "rpemotes" then exports["rpemotes"]:EmoteCommandStart(Config.Animation) else print("Missing or write wrong on: Config.Emotes") end
                lib.progressCircle({
                    duration = Config.Time,
                    label = "Writing...",
                    useWhileDead = false,
                    position = "bottom",
                    canCancel = true,
                    disable = {
                        car = true,
                    },
                })
                if Config.Emotes == "dpemotes" then TriggerEvent('animations:client:EmoteCommandStart', {"c"}) elseif Config.Emotes == "rpemotes" then exports["rpemotes"]:EmoteCommandStart("c") else print("Missing or write wrong on: Config.Emotes") end
                if Config.SendEmail then Email(form) end
                TriggerServerEvent('m-JobForms:Server:ApplyPoliceForm', input[1], input[2], input[3], input[4], input[5], input[6])
            end
        end
    elseif form == "ambulance" then
        if Config.Menus == "qb" then
            local dialog = exports["qb-input"]:ShowInput({
                header = "Ambulance Form",
                submitText = "Submit Form",
                inputs = {
                    { text = "Your Name",                               name = "name",          type = "text",  isRequired = true,  },
                    { text = "Your Age",                                name = "age",           type = "text",  isRequired = true,  },
                    { text = "Your Number",                             name = "number",        type = "text",  isRequired = true,  },
                    { text = "About You",                               name = "aboutyou",      type = "text",  isRequired = true,  },
                    { text = "Have you ever worked with weapons?",      name = "weapons",       type = "select", options = {  { value = "yes", text = "Yes" }, { value = "no", text = "No" }, } },
                    { text = "Have you ever worked an emergency job?",  name = "emergencyjob",  type = "select", options = {  { value = "yes", text = "Yes" }, { value = "no", text = "No" }, } },
                },
            })

            if dialog then
                if Config.Emotes == "dpemotes" then TriggerEvent('animations:client:EmoteCommandStart', {Config.Animation}) elseif Config.Emotes == "rpemotes" then exports["rpemotes"]:EmoteCommandStart(Config.Animation) else print("Missing or write wrong on: Config.Emotes") end
                QBCore.Functions.Progressbar("writingAmbulanceForm", "Writing...", Config.Time, false, true, {
                    disableMovement = true, 
                    disableCarMovement = true, 
                    disableMouse = false, 
                    disableCombat = true, 
                }, {}, {}, {}, function() 
                    if Config.Emotes == "dpemotes" then TriggerEvent('animations:client:EmoteCommandStart', {"c"}) elseif Config.Emotes == "rpemotes" then exports["rpemotes"]:EmoteCommandStart("c") else print("Missing or write wrong on: Config.Emotes") end
                    if Config.SendEmail then Email(form) end
                    TriggerServerEvent('m-JobForms:Server:ApplyAmbulanceForm', dialog.name, dialog.age, dialog.number, dialog.aboutyou, dialog.weapons, dialog.emergencyjob)
                end)
            end
        elseif Config.Menus == "ox" then
            local input = lib.inputDialog("Ambulance Form", {
                { type = 'input',        label = 'Your Name',            description = 'Write your name here',               required = true, icon = 'hashtag' },
                { type = 'input',        label = 'Your Age',             description = 'Write your age here',                required = true, icon = 'hashtag' },
                { type = 'input',        label = 'Your Number',          description = 'Write your number here',             required = true, icon = 'hashtag' },
                { type = 'input',        label = 'About You',            description = 'Write something about you here',     required = true, icon = 'hashtag' },
                { type = 'input',        label = 'Have you ever worked with weapons?',        description = '( Yes or No )', required = true, icon = 'hashtag' },
                { type = 'input',        label = 'Have you ever worked an emergency job?',    description = '( Yes or No )', required = true, icon = 'hashtag' },
            })
            if input then
                if Config.Emotes == "dpemotes" then TriggerEvent('animations:client:EmoteCommandStart', {Config.Animation}) elseif Config.Emotes == "rpemotes" then exports["rpemotes"]:EmoteCommandStart(Config.Animation) else print("Missing or write wrong on: Config.Emotes") end
                lib.progressCircle({
                    duration = Config.Time,
                    label = "Writing...",
                    useWhileDead = false,
                    position = "bottom",
                    canCancel = true,
                    disable = {
                        car = true,
                    },
                })
                if Config.Emotes == "dpemotes" then TriggerEvent('animations:client:EmoteCommandStart', {"c"}) elseif Config.Emotes == "rpemotes" then exports["rpemotes"]:EmoteCommandStart("c") else print("Missing or write wrong on: Config.Emotes") end
                if Config.SendEmail then Email(form) end
                TriggerServerEvent('m-JobForms:Server:ApplyAmbulanceForm', input[1], input[2], input[3], input[4], input[5], input[6])
            end
        end
    end
end)