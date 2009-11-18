function ui.bargraph(args)
  ui.container{
    attr = {
      class = "bargraph",
    },
    content = function()
      for i, bar in ipairs(args.bars) do
        local value = bar.value * args.width / args.max_value / 2 
        ui.container{
          attr = {
            style = "width: " .. tostring(value) .. "px; background-color: " .. bar.color .. ";",
            title = tostring(bar.value)
          },
          content = function() slot.put("&nbsp;") end
        }
      end
    end
  }
end
