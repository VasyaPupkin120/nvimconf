local cmd = vim.cmd             -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local g = vim.g                 -- global variables
local opt = vim.opt             -- global/buffer/windows-scoped options
-- Направление перевода с русского на английский
g.translate_source = 'ru'
g.translate_target = 'en'
-- Компактный вид у тагбара и Отк. сортировка по имени у тагбара
g.tagbar_compact = 1
g.tagbar_sort = 0

-- Конфиг ale + eslint
g.ale_fixers = { javascript= { 'eslint' } }
g.ale_sign_error = '❌'
g.ale_sign_warning = '⚠️'
g.ale_fix_on_save = 1
-- Запуск линтера, только при сохранении
g.ale_lint_on_text_changed = 'never'
g.ale_lint_on_insert_leave = 0

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------
opt.colorcolumn = '80'              -- Разделитель на 80 символов
opt.cursorline = true               -- Подсветка строки с курсором
opt.spelllang= { 'en_us', 'ru' }    -- Словари рус eng
-- opt.number = true                   -- Включаем нумерацию строк
opt.relativenumber = true           -- Вкл. относительную нумерацию строк
-- opt.so = 900                          -- Курсор всегда в центре экрана
opt.so = 0                          -- курсор вплотную к верху и низу
opt.undofile = true                 -- Возможность отката назад
opt.swapfile = false                -- задолбал гребаный своп-файл каждый раз
opt.splitright = true               -- vertical split вправо
opt.splitbelow = true               -- horizontal split вниз
opt.mouse = 'a'                     -- поддержка мыши
opt.linebreak = true                -- перенос по словам
-----------------------------------------------------------
-- Цветовая схема
-----------------------------------------------------------
opt.termguicolors = true      --  24-bit RGB colors
--cmd'colorscheme onedark'
cmd'colorscheme gruvbox'
-----------------------------------------------------------
-- Табы и отступы
-----------------------------------------------------------
cmd([[
filetype indent plugin on
syntax enable
]])
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines
-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
-- 2 spaces for selected filetypes
-- cmd [[
-- autocmd FileType xml,html,xhtml,css,scss,javascript,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
-- ]]
-- С этой строкой отлично форматирует html файл, который содержит jinja2
cmd[[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]]
-----------------------------------------------------------
-- Полезные фишки
-----------------------------------------------------------
-- Запоминает где nvim последний раз редактировал файл
cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]
-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup end
]], false)

-----------------------------------------------------------
-- Установки для плагинов
-----------------------------------------------------------


-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--cmp_nvim_lsp.update_capabilities is deprecated, use cmp_nvim_lsp.default_capabilities instead.
vim.o.completeopt = 'menuone,noselect'
-- luasnip setup
local luasnip = require 'luasnip' -- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    -- включил автокомплит по умолчанию
  completion = {
        autocomplete = false
  },
    -- конец настроек автокомплита по умолчанию
  snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- новый вариант маппинга клавиатуры, из файла Голобурдина
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  -- Конец маппинга из файла Голобурдина
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        --{ name = 'buffer', opts = {
        { name = 'buffer', option = {
            get_bufnrs = function()
                return vim.api.nvim_list_bufs()
            end
        },
    },
},
}


-- Запуск красивой строки состояния при начале работы
cmd [[lua require('lualine').setup()]]
-- запуск плагина для массового комментирования
cmd [[lua require('Comment').setup()]]
-- запуск красивых вкладок для всех буферов вверху,
-- теперь по Tab - переключение между вкладками
cmd [[lua require("bufferline").setup()]]
-- чтобы работал проводник файлов по F6
cmd [[lua require("nvim-tree").setup()]]
-- запуск плагинов установки и настройки lsp-серверов
cmd [[lua require("mason").setup()]]
cmd [[lua require("mason-lspconfig").setup()]]

-- FIXME
-- запуски lsp-серверов, вручную, криво, избавиться
require("lspconfig").lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim',}
            }
        }
    }
}
require("lspconfig").pyright.setup {}
-- require("lspconfig").tailwindcss.setup {}
require("lspconfig").eslint.setup {}

-- Это настройки для DreamMaker - узкоприменимого ЯП, в основном для игры SpaceStation13
-- настройки для lsp-сервера этого языка dm-langserver
-- local lsp_flags = {
--   -- This is the default in Nvim 0.7+
--   debounce_text_changes = 150,
-- }
-- -- запуск dm-langserver
-- require('lspconfig')['dm_langserver'].setup{
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }
-- -- автоопределение типа .dm
-- vim.cmd [[ autocmd BufNewFile,BufRead *.dm,*.dme set filetype=dm ]]
-- -- отключение замены табов на пробелы для dm-файлов
-- vim.cmd [[autocmd FileType dm setlocal noexpandtab]]
-- -- включение подсветки dreammaker для файлов *.dm, *.dme. Нужен установленный плагин vim-dreammaker
-- vim.cmd [[ autocmd BufNewFile,BufRead *.dm,*.dme source ~/.local/share/nvim/site/pack/packer/start/vim-dreammaker/syntax/dreammaker.vim ]]
