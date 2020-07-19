import main from require "moonpick-vim"
if #arg != 1
  os.exit 1
file_path = arg[1]
main(file_path)
