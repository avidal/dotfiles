local function footer()
  local version = vim.version()
  local print_version = "v" .. version.major .. '.' .. version.minor .. '.' .. version.patch
  local datetime = os.date('%Y/%m/%d %H:%M:%S')

  return print_version .. ' ' .. datetime
end

-- Banner
local banner = {
  "                                                    ",
  " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                    ",
}

return {
  "goolord/alpha-nvim",
  dependencies = {"nvim-tree/nvim-web-devicons"},
  config = function(alpha)
    local dashboard = require('alpha.themes.dashboard')
    dashboard.section.header.val = banner
    dashboard.section.buttons.val = {
      dashboard.button('e', '  New file', ':ene <BAR> startinsert<CR>'),
      dashboard.button('f', '  Find file', ':NvimTreeOpen<CR>'),
      dashboard.button('s', '  Settings', ':e $MYVIMRC<CR>'),
      dashboard.button('u', '  Update plugins', ':Lazy sync<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    dashboard.section.footer.val = footer()
    require("alpha").setup(dashboard.config)
  end
}
