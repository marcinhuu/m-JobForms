Config = {}

Config.Framework = "qb" -- "qb" or "esx"
Config.Menus = "qb" -- "qb" or "ox" | If you use esx use Config.Menus = "ox"
Config.Emotes = "rpemotes" -- "rpemotes" or "dpemotes"
Config.Animation = "notepad" -- Animation when you are writing the form
Config.Webhooks = {
    police = "",
    ambulance = "",
}
Config.SendEmail = true -- Send email to player?
Config.Phone = "qb-phone" -- qb-phone / qs-smartphone / gksphone / rodaphone / d-phone / renewed-phone / notify - if you dont use any phone
Config.Time = 5000 -- Time of progressbar when you are writing the form

Config.Locations = {
    [1] = {
        Location = vector3(441.26, -981.92, 30.69),
        Form = "police",
    },
    [2] = {
        Location = vector3(312.28, -592.73, 43.28),
        Form = "ambulance",
    },
    -- You can add more zones
    --[3] = {
    --    Location = vector3(312.28, -592.73, 43.28),
    --    Form = "mechanic",
    --},
}