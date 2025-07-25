local ruin_set = require("ruins/realistic") -- an array of ruins

local function add(name, parent)
  local ruins = remote.call("AbandonedRuins", "get_ruin_set", parent)

  if not ruins then
    log(string.format("WARNING: Parent ruin '%s' not found!", parent))
    return
  end

  for size, set in pairs(ruin_set) do
    for name, rest in pairs(set) do
      for _, ruin in ipairs(rest) do
        table.insert(ruins[size], ruin)
      end
    end
  end

  remote.call("AbandonedRuins", "add_ruin_sets", name, ruins)
end

local function make_ruin_set()
  add("realistic", "base")

  if script.active_mods["AbandonedRuins-Krastorio2"] then
    add("realistic-krastorio", "krastorio2")
  end
end

script.on_init(make_ruin_set)
script.on_configuration_changed(make_ruin_set)
