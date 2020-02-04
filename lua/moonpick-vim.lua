local config_for
config_for = require("moonpick.config").config_for
local lint
lint = require("moonpick").lint
local convert_issue
local main
main = function(config_search_path)
  local config_file = config_for(config_search_path)
  local config
  if config_file then
    config = {
      lint_config = config_file
    }
  else
    config = nil
  end
  local source = io.stdin:read("*a")
  local issues = lint(source, config)
  local formatted_issues
  do
    local _accum_0 = { }
    local _len_0 = 1
    for _index_0 = 1, #issues do
      local issue = issues[_index_0]
      _accum_0[_len_0] = convert_issue(issue)
      _len_0 = _len_0 + 1
    end
    formatted_issues = _accum_0
  end
  for _index_0 = 1, #formatted_issues do
    local line = formatted_issues[_index_0]
    print(line)
  end
end
convert_issue = function(issue)
  return tostring(issue.line) .. ":" .. tostring(issue.pos) .. ":" .. tostring(issue.msg)
end
return {
  main = main
}
