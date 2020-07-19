import config_for, load_config_from from require "moonpick.config"
import lint from require "moonpick"

local convert_issue

main = (file_path) ->
  config_file = config_for file_path
  config = if config_file
    load_config_from config_file, file_path
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
