set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"The ultimate vim statusline utility
Plugin 'Lokaltog/vim-powerline'
"Beautiful dual light/dark, selective contrast, GUI/256/16 colorscheme
Plugin  'altercation/vim-colors-solarized'
"Improved C++ STL syntax highlighting
Plugin 'STL-improved'
"A plugin for visually displaying indent levels in Vim
Plugin 'Indent-Guides'
"Alternate Files quickly (.c --> .h etc)
Plugin 'a.vim'
"Visual mark, similar to UltraEdit's bookmark
"快捷键 mm 创建/删除书签，mn 正向遍历书签，mp 逆向遍历
Plugin 'Visual-Mark'
"A plugin that allows for easy commenting of code for many filetypes.
"<leader>cc，注释当前选中文本
"<leader>cu，取消选中文本块的注释
Plugin 'The-NERD-Commenter'
"The ultimate snippet solution for Vim.模板补全插件，依赖vim-snippets插件
Plugin 'SirVer/ultisnips' 
Plugin 'honza/vim-snippets'

Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'

Plugin 'scrooloose/nerdtree'

"Elegant buffer explorer - takes very little screen space
Plugin 'fholgado/minibufexpl.vim'
"Grep search tools integration with Vim
Plugin 'grep.vim'

"Quickly locate files, buffers, mrus, ... in large project
Plugin 'Yggdroot/LeaderF'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'

" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
"为特定文件类型载入相关缩进文件
filetype indent on
"
"==================================
"    Vim基本配置
"===================================

"关闭vi的一致性模式 避免以前版本的一些Bug和局限
set nocompatible
"配置backspace键工作方式
set backspace=indent,eol,start

"显示行号
set number
"设置在编辑过程中右下角显示光标的行列信息
set ruler

"在状态栏显示正在输入的命令
set showcmd

"set font size
set guifont=monospace:h8

"设置历史记录条数
set history=1000

"禁止生成临时文件
set nobackup

"设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
set showmatch

"开启语法高亮功能
syntax enable
syntax on

"指定配色方案为256色
set t_Co=256

"terminal下面的背景问题
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

"设置颜色方案使用color solarized
"set background=light
if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

"设置C/C++方式自动对齐
set autoindent
set cindent


"设置搜索时忽略大小写
set ignorecase

"set highlight search
set hlsearch

:hi Search term=bold ctermbg=24 guibg=#13354A


"设置Tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
"设置按退格键时可以一次删除4个空格
set smarttab
"将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set expandtab

"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

set vb t_vb=                 " 关闭提示音
set noerrorbells
set novisualbell
set writebackup              " 设置无备份文件

"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn

"带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头

autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "  > File Name: ".expand("%")) 
        call append(line(".")+1, "  > Author:Haoson ") 
        call append(line(".")+2, "  > Created Time: ".strftime("%c")) 
        call append(line(".")+3, " ************************************************************************/") 
        call append(line(".")+4, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+5, "#include<iostream>")
        call append(line(".")+6, "using namespace std;")
        call append(line(".")+7, "")
    endif
    if &filetype == 'c'
        call append(line(".")+5, "#include<stdio.h>")
        call append(line(".")+6, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+5, "#ifndef ".toupper(expand("%:r"))."_H_")
        call append(line(".")+6, "#define ".toupper(expand("%:r"))."_H_")
        call append(line(".")+7, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+5,"public class ".expand("%:r"))
        call append(line(".")+6,"")
    endif
    "新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G

"定义快捷键的前缀,Set mapleader
let mapleader = ","
let g:mapleader = ","

" 设置快捷键将选中文本块复制至系统剪贴板
""vmap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
""nmap <Leader>p "+p
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j
" 定义快捷键在结对符之间跳转，助记pair
nmap <Leader>pa %

" 开启实时搜索功能
set incsearch
" 高亮显示当前行/列
set cursorline
set cursorcolumn

" 总是显示状态栏
set laststatus=2
" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'

"Indent_Guide插件配置信息
"随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

"a.vim插件配置信息
" *.cpp 和 *.h 间切换
nmap <Leader>ch :A<CR>
" 子窗口中显示 *.cpp 或 *.h
nmap <Leader>sch :AS<CR>

" UltiSnips插件设置，该插件的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"

"YCM插件配置信息
let g:ycm_global_ycm_extra_conf = '/home/haoson/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-k>'
" YCM 补全菜单配色
" 菜单
" highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
" highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
" let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
" let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库 tags
" set tags+=/data/misc/software/misc./vim/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader><Leader> <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全            
let g:ycm_seed_identifiers_with_syntax=1

map <F3> :YcmDiags <CR>
map <F6> :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 使用 NERDTree 插件查看工程文件。设置快捷键F2打开/关闭插件
nmap <F2> :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

" MiniBufExplorer插件配置信息
" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>
" buffer 切换快捷键
map <Leader>bn :MBEbn<cr>
map <Leader>bp :MBEbp<cr>

" 设置环境保存项
set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
" 保存快捷键
map <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
" 恢复快捷键
map <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>

"一键编译
"wa<CR> 保存所有调整文档内容，:make<CR> 调用 make 命令，后面的 <CR> 消除执行完 make 命令屏幕上“Press ENTER or type command to continue”的输入等待提示，:cw<CR> 显示 quickfix（仅当有编译错误或警告时）"
"先删除老的可执行程序，再编译、链接，发现缺失可执行程序时，再手工执行:make，这样，可查看具体是什么链接错误了(所有工程必须都先叫做main)
nmap <Leader>m :!rm -rf main<CR>:wa<CR>:make<CR><CR>:cw<CR>

""""""""syntastic""""""""""""
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'
"whether to show balloons
let g:syntastic_enable_balloons = 1


" 使用 Grep.vim 插件在工程内全局查找，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>sp :Grep -ir<CR><CR><CR>
" " 使用 Grep.vim 插件在工程内全局查找，设置快捷键。快捷键速记法：search in buffer
nnoremap <Leader>sb :GrepBuffer -ir<CR><CR>

"括号自动补全
:inoremap ( ()<ESC>i
:inoremap { {}<ESC>i
:inoremap [ []<ESC>i
:inoremap ' ''<ESC>i
:inoremap " ""<ESC>i
:inoremap < <><ESC>i
:inoremap << <<<ESC>a


"代码折叠。常用命令：
"1）za  打开/关闭在光标下的折叠
"2）zA  循环地打开/关闭光标下的折叠
"3）zo  打开 (open) 在光标下的折叠
"4）zO  循环打开 (Open) 光标下的折叠
"5）zc  关闭 (close) 在光标下的折叠
"6）zC  循环关闭 (Close) 在光标下的所有折叠
"7）zM  关闭所有折叠
"8）zR  打开所有的折叠
set foldmethod=syntax " 用语法高亮来定义折叠
set foldlevel=100 " 启动vim时不要自动折叠代码
set foldcolumn=2 " 设置折叠栏宽度

set pastetoggle=<F10>
"transfer/read and write one block of text between vim sessions
" Usage:
" " `from' session:
" " ma
" " move to end-of-block
" " <leader>y
" "
" " `to' session:
" " move to where I want block inserted
" " <leader>p
" "
if has("unix")
    nmap <Leader>p  :r $HOME/.vimxfer<CR>
    nmap <Leader>y :'a,.w! $HOME/.vimxfer<CR>
    vmap <Leader>p  c<esc>:r $HOME/.vimxfer<CR>
    vmap <Leader>y :w! $HOME/.vimxfer<CR>
else
    nmap <Leader>p  :r c:/.vimxfer<CR>
    nmap <Leader>y :'a,.w! c:/.vimxfer<CR>
    vmap <Leader>p  c<esc>:r c:/.vimxfer<cr>
    vmap <Leader>y :w! c:/.vimxfer<CR>
endif
