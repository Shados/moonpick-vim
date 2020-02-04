import config_for from require "moonpick.config"
import lint from require "moonpick"

local convert_issue

main = (config_search_path) ->
  config_file = config_for config_search_path
  config = if config_file
    { lint_config: config_file }
  else
    nil

  source = io.stdin\read "*a"
  issues = lint source, config
  formatted_issues = [convert_issue issue for issue in *issues]
  for line in *formatted_issues
    print line

convert_issue = (issue) ->
  "#{issue.line}:#{issue.pos}:#{issue.msg}"


{ :main }
