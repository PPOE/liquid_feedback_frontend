local initiative = param.get("initiative", "table")

if not initiative then
  initiative = Initiative:new_selector():add_where{ "id = ?", param.get_id()}:single_object_mode():exec()
end

slot.select("actions", function()
  ui.link{
    content = function()
      ui.image{ static = "icons/16/script.png" }
      slot.put(_"Show alternative initiatives")
    end,
    module = "issue",
    view = "show",
    id = initiative.issue.id
  }
end)

execute.view{
  module = "issue",
  view = "_show_head",
  params = { issue = initiative.issue }
}

--slot.put_into("html_head", '<link rel="alternate" type="application/rss+xml" title="RSS" href="../show/' .. tostring(initiative.id) .. '.rss" />')


slot.select("actions", function()
  if not initiative.issue.fully_frozen and not initiative.issue.closed then
    ui.link{
      image  = { static = "icons/16/script_add.png" },
      attr   = { class = "action" },
      text   = _"Create alternative initiative",
      module = "initiative",
      view   = "new",
      params = { issue_id = initiative.issue.id }
    }
  end
end)

slot.put_into("sub_title", encode.html(_"Initiative: '#{name}'":gsub("#{name}", initiative.shortened_name) ))

execute.view{
  module = "initiative",
  view = "show_partial",
  params = {
    initiative = initiative,
    expanded = true
  }
}