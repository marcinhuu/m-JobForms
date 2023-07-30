if Config.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
end

RegisterServerEvent('m-JobForms:Server:ApplyPoliceForm')
AddEventHandler('m-JobForms:Server:ApplyPoliceForm', function(name, age, number, aboutyou, weapons, emergencyjob)
    JobFormsWebhook (
        "**Player Name:** " .. name ..
        "\n" ..
        "\n" ..
        "**Player Age:** " .. age ..
        "\n" ..
        "\n" ..
        "**Player Number:** " .. number..
        "\n" ..
        "\n" ..
        "**About Yourself:** " .. aboutyou ..
        "\n" ..
        "\n" ..
        "**Have you ever worked with weapons?** " .. weapons..
        "\n" ..
        "\n" ..
        "**Have you ever worked an emergency job?** " .. emergencyjob 
        )
end)

RegisterServerEvent('m-JobForms:Server:ApplyAmbulanceForm')
AddEventHandler('m-JobForms:Server:ApplyAmbulanceForm', function(name, age, number, aboutyou, weapons, emergencyjob)
    JobFormsWebhook (
        "**Player Name:** " .. name ..
        "\n" ..
        "\n" ..
        "**Player Age:** " .. age ..
        "\n" ..
        "\n" ..
        "**Player Number:** " .. number..
        "\n" ..
        "\n" ..
        "**About Yourself:** " .. aboutyou ..
        "\n" ..
        "\n" ..
        "**Have you ever worked with weapons?** " .. weapons..
        "\n" ..
        "\n" ..
        "**Have you ever worked an emergency job?** " .. emergencyjob 
        )
end)

function JobFormsWebhook(message)
    local embed = {}
    embed = {
        {
            ["color"] = 65280, -- GREEN = 65280 --- RED = 16711680
            ["title"] = "m-JobForms | Logs",
            ["description"] = "" .. message ..  "",
            ["footer"] = {
                ["icon_url"] = "https://media.discordapp.net/attachments/1049749773185470537/1135266178688876595/avatar.png",
                ["text"] = 'm-JobForms | Logs | Created By marcinhu',
            },
        }
    }
    PerformHttpRequest(Config.Webhook, 
    function(err, text, headers) end, 'POST', json.encode({username = 'm-JobForms - Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end

