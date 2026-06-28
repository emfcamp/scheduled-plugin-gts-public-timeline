util.init_hosted()

local text_font
local text_size = 70
local toots = {}

gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.json_watch("tootlist.json", function(new_toots)
    log("new toots")
    toots = new_toots
end)

util.file_watch("config.json", function(content)
    local config = json.decode(content)

    text_font = resource.load_font(config.text_font.asset_name)
    text_size = config.text_size
end)

function node.render()
    text_font:write(10, 10, "This is a plugin for scheduled player, don't use it individually.", text_size, 1,1,1,1)
    text_font:write(10, text_size+20, "This view is for debugging only", 30, 1,1,1,1)

    y = text_size + 60

    if #toots then
        for idx, #toots do
            toot = toots[idx]

            text_font:write(1, y, toot.id .. " - " .. toot.display_name .. " - " .. tostring(toot.created_at), text_size, 1,1,1,1)
            y = y + text_size + 10
        end
    end
end
