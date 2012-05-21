local initiator = param.get("initiator", "table")
local initiative = param.get("initiative", "table")

if initiator and initiator.accepted and not initiative.issue.half_frozen and not initiative.issue.closed and not initiative.revoked then
  ui.link{
    attr = { style = "float: right;" },
    content = function()
      ui.image{ static = "icons/16/script_add.png" }
      slot.put(_"Edit draft")
    end,
    module = "draft",
    view = "new",
    params = { initiative_id = initiative.id }
  }
end
execute.view{ module = "draft", view = "_show", params = { draft = initiative.current_draft } }
