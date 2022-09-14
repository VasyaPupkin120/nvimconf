local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Системный буфер обмена shift - Y
-- Похоже моя версия nvim скомпилрована без поддержки буфера +
map('v', 'S-Y', '"+y', {})
-- Типа 'Нажимает' на ESC при быстром нажатии JJ, чтобы не тянутся
-- Переносит действие кнопки J на сочетание JL - чтобы строки не слипались
map('i', 'JJ', '<Esc>', {noremap = true})
map('i', 'ОО', '<Esc>', {noremap = true})
map('n', 'J', '<Esc>', {noremap = true})
map('n', 'JL', 'J', {noremap = true})
-- центровка при вводе новой строки
map('n', 'o', 'zzo', default_opts)
map('n', 'O', 'zzO', default_opts)
-- Заменяет j на gj и обратно + центровка
map('n', 'j', 'gj', default_opts)
map('n', 'k', 'gk', default_opts)
map('n', 'gj', 'jzz', default_opts)
map('n', 'gk', 'kzz', default_opts)
map('v', 'gj', 'jzz', default_opts)
map('v', 'gk', 'kzz', default_opts)
-- Стрелочки откл. Использовать hjkl
map('', '<up>', ':echoe "Use k"<CR>', {noremap = true, silent = false})
map('', '<down>', ':echoe "Use j"<CR>', {noremap = true, silent = false})
map('', '<left>', ':echoe "Use h"<CR>', {noremap = true, silent = false})
map('', '<right>', ':echoe "Use l"<CR>', {noremap = true, silent = false})
-- Навигация по окнам, для удобства работы с деревом имен и вообще с окнами
map('n', '<C-h>', '<C-w>h',  default_opts)
map('n', '<C-l>', '<C-w>l',  default_opts)
map('n', '<C-j>', '<C-w>j',  default_opts)
map('n', '<C-k>', '<C-w>k',  default_opts)
-- Автоформат + сохранение по CTRL-s , как в нормальном, так и в insert режиме
map('n', '<C-s>', ':Autoformat<CR>:w<CR>',  default_opts)
map('i', '<C-s>', '<Esc>:Autoformat<CR>:w<CR>', default_opts)
-- Переключение вкладок с помощью TAB или shift-tab (akinsho/bufferline.nvim)
-- Закрытие вкладки по gw
-- map('n', '<Tab>', ':BufferLineCycleNext<CR>', default_opts)
-- map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', default_opts)
map('n', '<Tab>', ':bn<CR>', default_opts)
map('n', '<S-Tab>', ':bp<CR>', default_opts)
map('n', 'gw', ':bd<CR>', default_opts)
-- Пролистнуть на одну экранную страницу вниз / вверх
-- + центровка посередине следующей страницы
-- map('n', '<Space>', '<PageDown>zz', default_opts)
-- map('n', '<C-Space>', '<PageUp>zz', default_opts)
-- map('v', '<S-h>', '<PageUp>Hkzz', default_opts)
-- map('v', '<S-l>', '<PageDown>Ljzz', default_opts)
map('n', '<S-h>', '<PageUp>zz', default_opts)
map('n', '<S-l>', '<PageDown>zz', default_opts)
map('v', '<S-h>', '<PageUp>zz', default_opts)
map('v', '<S-l>', '<PageDown>zz', default_opts)
-- Переход в самый низ файла с центровкой
map('n', '<S-g>', 'Gzz', default_opts)
-- " Переводчик рус -> eng
map('v', 't', '<Plug>(VTranslate)', {})
-- По <<Space> очищаем последний поиск с подсветкой
map('n', '<<Space>', ':nohl<CR>', default_opts)
-- Набор сочетаний клавиш для go_to_definiton, скопированы из файла Голобурдина
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', default_opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', default_opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', default_opts)
-- map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', default_opts)
map('n', '<C-u>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', default_opts)
map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', default_opts)
map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', default_opts)
map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders))<CR>', default_opts)
map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', default_opts)
map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', default_opts)
map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_opts)
map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', default_opts)
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', default_opts)
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', default_opts)
map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', default_opts)
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', default_opts)
-- this is good!
-----------------------------------------------------------
-- Поиск слов через telescope, дерево файлов, список буферов
-----------------------------------------------------------
-- <# Поиск слова под курсором по всему проекту (отсчитывая вниз от рабочей директории)
map('n', '<#', [[<cmd>lua require('telescope.builtin').grep_string()<cr><Esc>:set relativenumber<CR>]], default_opts)
map('n', '<№', [[<cmd>lua require('telescope.builtin').grep_string()<cr><Esc>:set relativenumber<CR>]], default_opts)
-- </ Поиск слова по всему проекту в модальном окошке
map('n', '<s', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], default_opts)
map('n', '<ы', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], default_opts)
-- <f - files дерево файлов, непоянтно почему нужно дополнительно указывать русскую а
map('n', '<f', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>:set number<CR>:set relativenumber<CR>', default_opts)
map('n', '<а', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>:set number<CR>:set relativenumber<CR>', default_opts)
-- список буферов и список файлов проекта,
-- после открытия popup-окна в нем теперь командный режим
-- за счет списка команд - комнды плагина и команды <Esc>
map('n', '<C-a>', [[<cmd>lua require('telescope.builtin').find_files()<CR>, <Esc>]], default_opts)
map('n', '<C-p>', [[<cmd>lua require('telescope.builtin').buffers()<CR>, <Esc]], default_opts)
-- <n - names Показ дерева классов и функций, плагин majutsushi/tagbar
map('n', '<n', ':TagbarToggle<CR>', default_opts)
map('n', '<т', ':TagbarToggle<CR>', default_opts)
-----------------------------------------------------------
-- Фн. клавиши по F1 .. F12
-----------------------------------------------------------
-- <<F1> удалить пустые строки
-- map('n', '<<F1>', ':g/^$/d<CR>', default_opts)
-- <F2> для временной вставки из буфера, чтобы отключить авто идент
vim.o.pastetoggle='<F2>'
-- <F3> перечитать конфигурацию nvim Может не работать, если echo $TERM  xterm-256color
map('n', '<F3>', ':so ~/.config/nvim/init.lua<CR>:so ~/.config/nvim/lua/plugins.lua<CR>:so ~/.config/nvim/lua/settings.lua<CR>:so ~/.config/nvim/lua/keymaps.lua<CR>', { noremap = true })
-- <<F3> Открыть всю nvim конфигурацию для редактирования
map('n', '<<F3>', ':e ~/.config/nvim/init.lua<CR>:e ~/.config/nvim/lua/plugins.lua<CR>:e ~/.config/nvim/lua/settings.lua<CR>:e ~/.config/nvim/lua/keymaps.lua<CR>:e ~/.config/nvim/trash/conspect.txt<CR>', { noremap = true })
-- <F5> разные вариации нумераций строк, можно переключаться
map('n', '<F5>', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>', default_opts)
-- <F12> Проверка орфографии  для русского и английского языка
map('n', '<F12>', ':set spell!<CR>', default_opts)
map('i', '<F12>', '<C-O>:set spell!<CR>', default_opts)
