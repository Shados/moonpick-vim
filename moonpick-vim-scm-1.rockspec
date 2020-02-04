package = "moonpick-vim"
version = "scm-1"
source = {
  url = "git://github.com/Shados/moonpick-vim",
  branch = "master",
}
description = {
  summary = "ALE-based vim integration for moonpick",
  homepage = "https://github.com/Shados/moonpick-vim",
  license = "MIT",
}
dependencies = {
  "lua == 5.1",
  "moonpick >= 0.8",
}
build_dependencies = {
  "moonscript >= 0.5.0",
}
build = {
  type = "make",

  install_variables = {
    LUA_SHARE_DIR="$(LUADIR)",
    PREFIX="$(PREFIX)",
  },

  -- copy_directories = {
  --   "test",
  -- },
}
rockspec_format = "3.0"
