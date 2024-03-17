local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local Webhook_URL = "https://discord.com/api/webhooks/1218952689656795167/SJbwUyrhhj0TWBlMWCdIWRAI3OlNGdSeS7BwzMBv7CyyNO8iU38ydeVZ6x2gQUKldpqe"

local function getPlayerAvatar(userId)
    return "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(userId) .. "&width=420&height=420&format=png"
end

local function sendNotification()
    local playerName = game.Players.LocalPlayer.Name
    local playerDisplayName = game.Players.LocalPlayer.DisplayName
    local playerUserId = game.Players.LocalPlayer.UserId
    local placeId = game.PlaceId
    local placeName = "Unknown"

    -- Get the place name from the place ID
    local success, placeInfo = pcall(function()
        return MarketplaceService:GetProductInfo(placeId)
    end)

    if success and placeInfo then
        placeName = placeInfo.Name
    end

    local avatarUrl = getPlayerAvatar(playerUserId)

    local data = {
        ["embeds"] = {
            {
                ["title"] = "Script Executed:",
                ["description"] = "Universal Shakars Hub Has Been Executed.",
                ["type"] = "rich",
                ["color"] = tonumber("000000"), -- Black
                ["thumbnail"] = {
                    ["url"] = avatarUrl,
                },
                ["fields"] = {
                    {
                        ["name"] = "Player UserName:",
                        ["value"] = playerName,
                        ["inline"] = true,
                    },
                    {
                        ["name"] = "Player DisplayName:",
                        ["value"] = playerDisplayName,
                        ["inline"] = true,
                    },
                    {
                        ["name"] = "User ID:",
                        ["value"] = playerUserId,
                        ["inline"] = true,
                    },
                    {
                        ["name"] = "Map Name:",
                        ["value"] = placeName,
                        ["inline"] = true,
                    },
                    {
                        ["name"] = "Player Avatar:",
                        ["value"] = "[" .. playerName .. "'s Avatar](" .. avatarUrl .. ")",
                        ["inline"] = true,
                    },
                },
                ["footer"] = {
                    ["text"] = "Script executed from Universal Shakar's Hub",
                },
            },
        },
    }

    local PlayerData = HttpService:JSONEncode(data)

    local Request = http_request or request or HttpPost or syn.request
    Request({Url = Webhook_URL, Body = PlayerData, Method = "POST", Headers = {["Content-Type"] = "application/json"}})
end

sendNotification()
