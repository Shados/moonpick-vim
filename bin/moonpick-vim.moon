import main from require "moonpick-vim"
if #arg != 1
  os.exit 1
config_search_path = arg[1]
main(config_search_path)
