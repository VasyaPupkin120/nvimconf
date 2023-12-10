-- Установка менеджера плагинов, а если менеджер не загружен, то и загрузка
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end




-- Собственно, плагины
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer сам себя, не всегда отрабатывает, возможно нужно сначала клонировать.
    -- Добавил в начало этого файла код, который проверяет наличие менеджера 
    -- и автоматически его устанавливает.
    use 'wbthomason/packer.nvim'

    -----------------------------------------------------------
    -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
    -----------------------------------------------------------

    -- Цветовая схема
    --use 'joshdick/onedark.vim'
    use 'morhetz/gruvbox'
    --- Информационная строка внизу
    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = function() require('lualine').setup{} end,
    }
     -- Табы вверху
     use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
     config = function()
         require("bufferline").setup{}
     end, }
---
---
---  -----------------------------------------------------------
---  -- НАВИГАЦИЯ
---  -----------------------------------------------------------
---  -- Файловый менеджер
     use { 'kyazdani42/nvim-tree.lua',
     requires = 'kyazdani42/nvim-web-devicons',
     config = function() require'nvim-tree'.setup{} end, }
---  -- Навигация внутри файла по классам и функциям
     use 'majutsushi/tagbar'
---  -- Замена fzf и ack
     use { 'nvim-telescope/telescope.nvim',
     requires = { {'nvim-lua/plenary.nvim'} },
     config = function() require'telescope'.setup{} end, }
---
---
---  -----------------------------------------------------------
---  -- LSP и автодополнялка
---  -----------------------------------------------------------
---
---
---  -- Highlight, edit, and navigate code using a fast incremental parsing library
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
---  -- Collection of configurations for built-in LSP client
     use {
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim",
         "neovim/nvim-lspconfig",
     }
---  -- Автодополнялка
     use 'hrsh7th/nvim-cmp'
     use 'hrsh7th/cmp-nvim-lsp'
     use 'hrsh7th/cmp-buffer'
     use 'saadparwaiz1/cmp_luasnip'
---  --- Автодополнлялка к файловой системе
---  use 'hrsh7th/cmp-path'
---  -- Snippets plugin
     use 'L3MON4D3/LuaSnip'
---
---
---
--- -----------------------------------------------------------
---  -- PYTHON
---  -----------------------------------------------------------
---  --- Шапка с импортами приводим в порядок
---  use 'fisadev/vim-isort'
---  -- Поддержка темплейтом jinja2
---  use 'mitsuhiko/vim-jinja'
---
---
---  -----------------------------------------------------------
---  -- HTML и CSS
---  -----------------------------------------------------------
---  -- Подсвечивает закрывающий и откры. тэг. Если, где-то что-то не закрыто, то не подсвечивает.
---  use 'idanarye/breeze.vim'
---  -- Закрывает автоматом html и xml тэги. Пишешь <h1> и он автоматом закроется </h1>
     use 'alvan/vim-closetag'
---  -- Подсвечивает #ffffff
     use 'ap/vim-css-color'
---  -----------------------------------------------------------
---  -- РАЗНОЕ
---  -----------------------------------------------------------
---  -- Даже если включена русская раскладка vim команды будут работать
     use 'powerman/vim-plugin-ruscmd'
---  -- 'Автоформатирование' кода для всех языков
---  use 'Chiel92/vim-autoformat'
---  -- ]p - вставить на строку выше, [p - ниже
---  use 'tpope/vim-unimpaired'
---  -- Переводчик рус - англ
     use 'skanehira/translate.vim'
---  --- popup окошки
---  use 'nvim-lua/popup.nvim'
---  -- Обрамляет или снимает обрамление. Выдели слово, нажми S и набери <h1>
---  use 'tpope/vim-surround'
---  -- Считает кол-во совпадений при поиске
---  use 'google/vim-searchindex'
---  -- Может повторять через . vimsurround
---  use 'tpope/vim-repeat'
---  -- Стартовая страница, если просто набрать vim в консоле
     use 'mhinz/vim-startify'
     -- Комментирует по gc все, вне зависимости от языка программирования
     use { 'numToStr/Comment.nvim',
     config = function() require('Comment').setup{} end }
---  -- Обрамляет строку в теги по ctrl- y + ,
---  use 'mattn/emmet-vim'
---  -- Закрывает автоматом скобки
     use 'cohama/lexima.vim'
---  -- Линтер, работает для всех языков почему то не ставится - из-за него лагало при переключении буферов
     -- use 'dense-analysis/ale'

--- -- Плагин подсветки кода для dreammaker
     use 'ccraciun/vim-dreammaker'
--- -- Удаление сразу двух кавычек, скобок 
    use 'tpope/vim-surround'
--- -- Автоввод html-кода
    use 'mattn/emmet-vim'

end)
