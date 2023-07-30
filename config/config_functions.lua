if Config.Framework == "qb" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports.es_extended:getSharedObject()
end

function Notify(msg, type)
    if Config.Framework == "qb" then
        if type == "primary" then 
            QBCore.Functions.Notify(msg, "primary")
        end
        if type == "success" then
            QBCore.Functions.Notify(msg, "success")
        end
        if type == "error" then
            QBCore.Functions.Notify(msg, "error")
        end
    elseif Config.Framework == "esx" then
        if type == "primary" then
            lib.notify({ title = 'Notification', description = msg, type = 'inform' })
        elseif type == "error" then
            lib.notify({ title = 'Notification', description = msg, type = 'error' })
        elseif type == "success" then
           lib.notify({ title = 'Notification', description = msg, type = 'success' })
        end
    end
end

function Email(form)
    if Config.Phone == "qb-phone" then
        TriggerServerEvent("qb-phone:server:sendNewMail", {
            sender = "Form",
            subject = "Valid Form",
            message = "The form for: "..form.." has been completed and submitted correctly.",
        })
    elseif Config.Phone == "qs-smartphone" then
        TriggerServerEvent("qs-smartphone:server:sendNewMail", {
            sender = "Form",
            subject = "Valid Form",
            message = "The form for: "..form.." has been completed and submitted correctly.",
        })
    elseif Config.Phone == "gksphone" then
        TriggerServerEvent("gksphone:NewMail", {
            sender = "Form",
            image = '/html/static/img/icons/mail.png',
            subject = "Valid Form",
            message = "The form for: "..form.." has been completed and submitted correctly.",
        })
    elseif Config.Phone == "roadphone" then
        TriggerServerEvent("roadphone:receiveMail", {
            sender = "Form",
            image = '/public/html/static/img/icons/app/mail.png',
            subject = "Valid Form",
            message = "The form for: "..form.." has been completed and submitted correctly.",
        })
    elseif Config.Phone == "d-phone" then
        TriggerServerEvent("mail:functions:sendmail:tosource", 1, "Form", "Form", "Valid Form", "The form for: "..form.." has been completed and submitted correctly.", nil)
    elseif Config.Phone == "renewed-phone" then
        TriggerServerEvent("qb-phone:server:sendNewMail", {
            sender = "Form",
            subject = "Valid Form",
            message = "The form for: "..form.." has been completed and submitted correctly.",
            button = {
                buttonEvent = "Renewed-Debt:server:AcceptShit",
                buttonData = 10,
                isServer = false
            }
        })
    elseif Config.Phone == "road-phone" then
        TriggerServerEvent('roadphone:receiveMail', {
            sender = "Form",
            subject = "Valid Form",
            message = "The form for: "..form.." has been completed and submitted correctly.",
            image = '/public/html/static/img/icons/app/mail.png',
            button = {
              buttonEvent = "",
              buttonData = data,
              buttonname = "SetLocation"
            }
         })
    elseif Config.Phone == "notify" then
        Notify("The form for: "..form.." has been completed and submitted correctly.", "success", 5000)
    end
end