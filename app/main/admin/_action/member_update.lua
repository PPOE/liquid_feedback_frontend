local id = param.get_id()

local member = Member:by_id(id) or Member:new()

param.update(member, "identification", "notify_email", "admin")

if param.get("invite_member", atom.boolean) then
  member:send_invitation()
end

local err = member:try_save()

if err then
  slot.put_into("error", (_("Error while updating member, database reported:<br /><br /> (#{errormessage})"):gsub("#{errormessage}", tostring(err.message))))
  return false
end

if not id and config.single_unit_id then
  local privilege = Privilege:new()
  privilege.member_id = member.id
  privilege.unit_id = config.single_unit_id
  privilege.voting_right = true
end

if id then
  slot.put_into("notice", _"Member successfully updated")
else
  slot.put_into("notice", _"Member successfully registered")
end
