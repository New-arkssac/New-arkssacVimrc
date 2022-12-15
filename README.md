# 这是一位咸鱼的[VIMRC](https://github.com/New-arkssac/New-arkssacVimrc) 

**这是自用的NEOVIM的配置, 有一些功能我自己实现的（maybe have some bug?）** 
**使用这些配置文件的话，默认你已经对vim的操作有一定的了解~ 以下把MYVIMRC统称为此配置** 

--------

![VIM](https://file.fishpi.cn/2022/11/20221122192407-13514960.png) 
> 成品展示


<!-- vim-markdown-toc GFM -->

* [安装前的环境配置](#安装前的环境配置)
* [配置特性](#配置特性)
  * [基础快捷键](#基础快捷键)
  * [窗口快捷键](#窗口快捷键)
  * [实用快捷键](#实用快捷键)
  * [插件](#插件)
    * [插件管理器](#插件管理器)
    * [主题](#主题)
    * [代码补全](#代码补全)
    * [代码高亮](#代码高亮)
    * [代码块](#代码块)
    * [文件树](#文件树)
    * [一个很酷的通知系统](#一个很酷的通知系统)
    * [一个很酷的默认启动屏](#一个很酷的默认启动屏)
    * [一些很酷的图标Icon](#一些很酷的图标icon)
    * [Git](#git)
    * [代码诊断](#代码诊断)
    * [模糊查询](#模糊查询)
    * [异步执行编译项目](#异步执行编译项目)
    * [DEBUG](#debug)
    * [编辑历史](#编辑历史)
    * [缓冲区导航](#缓冲区导航)
    * [翻译](#翻译)
    * [自己写的功能](#自己写的功能)
      * [初始化项目](#初始化项目)
      * [注释](#注释)
      * [粘贴剪切板图片](#粘贴剪切板图片)
      * [Markdown](#markdown)

<!-- vim-markdown-toc -->

## 安装前的环境配置 

如果你想使用这些配置的话你需要安装一些依赖环境呢～  

- [ ]  安装[Python3](https://www.python.org/downloads/)  
- [ ]  安装[Nerd-Font](https://www.nerdfonts.com/)此配置中使用里大量的[Nerd-Font](https://www.nerdfonts.com/)字体`Icon`
  如果你能忍受乱码的话这个选项不是必须的  
- [ ]  安装[Nodejs](https://nodejs.org/en/download/)   

- [ ]  此配置中集成了`Go, C, Python3, Lua` 的编程环境所以你需要使用的话你需要请安装他们  

- [ ]  安装`Curl`上传图床功能是使用的此软件来实现的
- [ ]  如果你是`linux` 用户且使用的是`x11` 标准图形桌面，你得需要额外安装`xclip` 此软件是`Neovim`
      与`x11` 标准图形桌面的剪切板进行交互的，windows则不需要，因为windows有强大的`powershell` 
- [ ]  最后你还得安装一个[Rg](https://github.com/BurntSushi/ripgrep) 功能请行查看
- [ ]  需要安装lazygi来支持快捷键在新的标签页打开lazygit的ui界面


## 配置特性

ok看到这里已经默认你已经完成以上的配置了  

现在可以开始介绍啦～

### 基础快捷键
| 快捷键     | 模式   | 行为                       |
|------------|--------|----------------------------|
| `<Space>`  | NORMAL | \<LEADER\>键替换成了空格   |
| `;`        | NORMAL | `;`被映射成了`:`           |
| `s`        | NORMAL | `nop` 被映射成了空         |
| `sr`       | NORMAL | 重新加载$VIMRC文件         |
| `S`        | NORMAL | 保存当前文件               |
| `Q`        | NORMAL | 关闭当前窗口               |
| `<Alt-r>`  | NORMAL | 重新加载当前文件           |
| `<Alt-s>k` | NORMAL | 无论在哪直接编辑$VIMRC文件 |

### 窗口快捷键
| 快捷键      | 模式   | 行为                  |
|-------------|--------|-----------------------|
| `sl`        | NORMAL | 向右分屏              |
| `sh`        | NORMAL | 向左分屏              |
| `sk`        | NORMAL | 向上分屏              |
| `sj`        | NORMAL | 向下分屏              |
| `st`        | NORMAL | 创建一个新标签页      |
| `su`        | NORMAL | 向左移一个标签页      |
| `si`        | NORMAL | 向右移一个标签页      |
| `<Space>q`  | NORMAL | 关闭所有窗口          |
| `<Space>l`  | NORMAL | 向右移动一个窗口      |
| `<Space>h`  | NORMAL | 向左移动一个窗口      |
| `<Space>k`  | NORMAL | 向上移动一个窗口      |
| `<Space>j`  | NORMAL | 向下移动一个窗口      |
| `<Up>`      | NORMAL | 上方窗口增加5行长度   |
| `<Down>`    | NORMAL | 下方窗口增加5行长度   |
| `<Left>`    | NORMAL | 左方窗口增加5字符宽度 |
| `<Right>`   | NORMAL | 右方窗口增加5字符宽度 |

### 实用快捷键
| 快捷键      | 模式   | 行为                       |
|-------------|--------|----------------------------|
| `<Space>sp` | NORMAL | 开启拼写检查               |
| `<Space>uu` | NORMAL | 开启修改历史               |
| `>`         | VISUAL | 选中的行向右缩进           |
| `<`         | VISUAL | 选中的行向左缩进           |
| `p`         | VISUAL | 粘贴寄存器内容             |
| `<Ctrl-c>`  | VISUAL | 复制选中的字符到系统剪切板 |
| `<Ctrl-p>`  | NORMAL | 粘贴系统剪切板里的字符     |
| `<Ctrl-p>`  | INSERT | 粘贴系统剪切板里的字符     |
| `sg`        | INSERT | 打开lazygit                |
   
### 插件
#### 插件管理器
[packer.nvim](https://github.com/wbthomason/packer.nvim)   
![packer](https://file.fishpi.cn/2022/11/QQ录屏20221122221333-147383d0.gif)  

#### 主题 
* [lualine](https://github.com/nvim-lualine/lualine.nvim)
  lualine十分强大不仅可以设置`statusline` 还可以设置`tabline` 以及`winbar` 不过为仅仅使用了  
  不过这里的配置仅仅设置了`statusline` 和 `tabline`
  想要设置的可以自行官方文档修改[schema.lua](https://github.com/New-arkssac/New-arkssacVimrc/blob/main/lua/lib/scheme.lua)
  ![tabline](https://file.fishpi.cn/2022/11/20221122223924-e9ffee82.png) 
  ![lualine](https://file.fishpi.cn/2022/11/20221122224121-3024ff70.png) 
  在此配置中`statusline mod` 块还会根据系统切换Icon哦 
* [nightfox](https://github.com/EdenEast/nightfox.nvim)
  主题配色
* [nvim-navic](https://github.com/SmiteshP/nvim-navic)
  在`statusline` 里显示代码上下文信息
  ![navic](https://file.fishpi.cn/2022/11/QQ录屏20221122224601-da94be83.gif) 

#### 代码补全
* [cmp全家桶](https://github.com/hrsh7th/nvim-cmp) 
* [NVIM-LSP](https://github.com/neovim/nvim-lspconfig) 
* [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) 

**cmp快捷键** 
| 快捷      | 行为               |
| --        | --                 |
| `<Up>`    | 光标向上移动       |
| `<Down>`  | 光标向下移动       |
| `<Enter>` | 选择光标选中的提示 |
| `<Tabe>`  | 光标向下移动       |

![cmp](https://file.fishpi.cn/2022/11/QQ录屏20221123111112-57f4af7a.gif) 

**LSP快捷键** 
| 快捷       | 行为                                 |
| --         | --                                   |
| `gd`       | 转跳到光标下关键词的定义             |
| `gr`       | 展开当前管标下关键词的引用出         |
| `gk`       | 显示光标下关键词的签名               |
| `<Space>=` | 转跳到下一个错误处                   |
| `<Space>-` | 转跳到上一个错误处                   |
| `sdn`      | 重命名光标下的关键词                 |
| `<Ctrl-l>` | INSERT模式下在函数括号内显示函数签名 |

![gk](https://file.fishpi.cn/2022/11/20221123145629-21490744.png) 
![gk](https://file.fishpi.cn/2022/11/20221123150224-94d06817.png)  
![ctrl-l](https://file.fishpi.cn/2022/11/20221123151507-a749e61a.png)  




#### 代码高亮
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) 
![treesitter](https://user-images.githubusercontent.com/2361214/202753610-e923bf4e-e88f-494b-bb1e-d22a7688446f.png)

#### 代码块
* 代码块引擎 [LuaSnip](https://github.com/L3MON4D3/LuaSnip) 
* 代码块来源 [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) 
  
![snip](https://file.fishpi.cn/2022/11/QQ录屏20221123114125-dd4044e6.gif) 


#### 文件树
[nvim-tree.lua](nvim-tree/nvim-tree.lua) 

| 快捷键 | 行为                   |
|--------|------------------------|
| `u`    | 返回上一层目录         |
| `s`    | 上下分屏打开文件       |
| `v`    | 左右分屏打开文件       |
| `t`    | 新建标签页打开文件     |
| `S`    | 用系统默认程序打开文件 |
| `/`    | 搜索文件               |

![nvim-tree](https://file.fishpi.cn/2022/11/20221123114616-faa628fb.png)

> 更多操作请看插件官方文档

#### 一个很酷的通知系统

[nvim-notify](https://github.com/rcarriga/nvim-notify) 

![notify](https://user-images.githubusercontent.com/24252670/130856848-e8289850-028f-4f49-82f1-5ea1b8912f5e.gif)  

#### 一个很酷的默认启动屏 

[alpha-nvim](https://github.com/New-arkssac/New-arkssacVimrc/blob/main/lua/lib/plugins.lua) 

| 快捷键 | 行为                           |
|--------|--------------------------------|
| `e`    | 编辑一个新的文件               |
| `g`    | 当前目录下初始化一个Golang项目 |
| `c`    | 当前目录下初始化一个Clang项目  |
| `p`    | 当前目录下初始化一个Python项目 |
| `r`    | 查看之前编辑过的文件           |
| `s`    | 编辑$MYVIMRC                   |
| `q`    | 退出                           |

![alpha](https://file.fishpi.cn/2022/11/20221123141032-d50d039b.png) 

#### 一些很酷的图标Icon

[nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) 

#### Git  
  [git](lewis6991/gitsigns.nvim) 

| 快捷键      | 行为                  |
|-------------|-----------------------|
| `<Space>ui` | 提交当前代码块        |
| `<Space>uh` | 撤回当前提交的代码块  |
| `<Space>ua` | 浮窗显示当前行的blame |
| `<Space>tb` | 虚拟字体当前行的blame |
| `<Space>ud` | 显示版本差异          |

![git](https://raw.githubusercontent.com/lewis6991/media/main/gitsigns_blame.gif) 
  
     
  
#### 代码诊断
基于LSP的代码诊断，自动转调到错误处

| 快捷键     | 行为             |
|------------|------------------|
| `<Space>o` | 开启代码诊断窗口 |

[trouble.nvi](https://github.com/folke/trouble.nvim) 
![trouble.nvim](https://file.fishpi.cn/2022/11/20221123122454-df28739a.png) 

#### 模糊查询

[fzf.vim](https://github.com/junegunn/fzf) 

| 快捷键     | 行为                   |
|------------|------------------------|
| `<Space>n` | 查询已开启的缓冲区     |
| `<Space>;` | 查询工作目录下文件内容 |
| `<Space>F` | 查询工作目录下文件     |

![fzf](https://file.fishpi.cn/2022/11/20221123123020-b5ca48cc.png) 

#### 异步执行编译项目

[asynctasks](https://github.com/skywind3000/asynctasks.vim) 

| 快捷键      | 行为                       |
|-------------|----------------------------|
| `so`        | 在当前目录下创建.tasks文件 |
| `<LEADER>i` | 运行当前文件的可执行文件   |
| `<LEADER>b` | 编译当前文件               |
| `<LEADER>n` | 编译当前项目               |

![aysnctask](https://raw.githubusercontent.com/skywind3000/images/master/p/asynctasks/demo-1.png) 

#### DEBUG

从 ~~[vimspector](https://github.com/puremourning/vimspector)~~ 过度到 [nvim-dap](https://github.com/mfussenegger/nvim-dap)  

| 快捷键     | 行为                |
|------------|---------------------|
| `<Ctrl-q>` | 退出DEBUG           |
| `<F3>`     | DEBUG步进一         |
| `<F4>`     | DEBUG步进           |
| `<F5>`     | 开始DEBUG           |
| `<F7>`     | debug到程序最后一步 |
| `<F8>`     | 停止当前DEBUG       |
| `<F9>`     | 打断点              |

![nvim-dap](https://file.fishpi.cn/2022/11/20221130111558-4ddbce0b.png) 


#### 编辑历史

[undotree](https://github.com/mbbill/undotree) 

| 快捷键      | 行为         |
|-------------|--------------|
| `<Space>uu` | 展开编辑历史 |

![undotree](https://file.fishpi.cn/2022/11/20221123131056-c2faacdc.png) 

#### 缓冲区导航

[vista.vim](https://github.com/liuchengxu/vista.vim) 

| 快捷键     | 行为           |
|------------|----------------|
| `<Space>m` | 展开关键词列表 |

![visita](https://file.fishpi.cn/2022/11/20221123131421-37d326f1.png) 

#### 翻译

[translator](https://github.com/voldikss/vim-translator) 

| 快捷键     | 行为             |
|------------|------------------|
| `<Space>t` | 翻译光标下的单词 |

![translator](https://file.fishpi.cn/2022/11/20221123131655-8a2d3549.png) 


#### 自己写的功能

##### 初始化项目
| 快捷键 | 模式   | 行为       |
|--------|--------|------------|
| `s\`   | NORMAL | 初始化项目 |

目前仅支持初始化`go, c, python` 三个项目  
如果想添加其他额外的项目请自行修改[project.lua](https://github.com/New-arkssac/New-arkssacVimrc/blob/main/lua/util/project.lua)  
以及[alpha.lua](https://github.com/New-arkssac/New-arkssacVimrc/blob/main/lua/lib/alpha.lua) 

使用`alpha` 初始化
![alpha](https://file.fishpi.cn/2022/11/42058-86899e52.gif) 

快捷键初始化  
![init](https://file.fishpi.cn/2022/11/42518-83923dd6.gif) 


##### 注释
| 快捷键      | 模式   | 行为         |
|-------------|--------|--------------|
| `<Ctrl-/>`  | NORMAL | 注释当前行   |
| `V<Ctrl-/>` | VISUAL | 注释选中的行 |


仅能使用在`go、c、py、lua、vim`中  
如果想要添加注释自己想要的语言请自行修改[comment.lua](https://github.com/New-arkssac/New-arkssacVimrc/blob/main/lua/util/comment.lua) 文件
![comment](https://file.fishpi.cn/2022/11/34019-06141150.gif) 


##### 粘贴剪切板图片
| 快捷键 | 模式   | 行为                             |
|--------|--------|----------------------------------|
| `sp`   | NORMAL | 粘贴剪切板里的截图               |
| `sP`   | NORMAL | 将剪切板里的图片上传到图床并粘贴 |
| `sy`   | NORMAL | 展开已经粘贴过的图片的剪切板     |
| `,p`   | INSERT | 粘贴剪切板里的截图               |
| `,P`   | INSERT | 将剪切板里的图片上传到图床并粘贴 |
| `,y`   | NORMAL | 展开已经粘贴过的图片的剪切板     |

此功能仅能在`windows、wsl、x11linux` 下使用，x11标准的linux需要安装`xclip`  
上传功能是使用的`curl` 所以还得有`curl` 的依赖  
所有操作均会在当前目录下创建一个`img` 目录，上传和粘贴的图片均会在里面  
目前并不打算支持其他系统，如果要支持其他系统的话请自行修改[clipboard.lua](https://github.com/New-arkssac/New-arkssacVimrc/blob/main/lua/util/clipboard.lua) 

![clipboard](https://file.fishpi.cn/2022/11/140118-c0641011.gif) 

##### Markdown 

| 快捷键 | 模式   | 行为          |
|--------|--------|---------------|
| `,b`   | INSERT | **加粗** 字体 |
| `,m`   | INSERT | ~~划去~~ 字体 |
| `,i`   | INSERT | *斜体* 字体   |
| `,x`   | INSERT | `行内代码块`  |
| `,c`   | INSERT | `多行代码块`  |
| `,h`   | INSERT | - [ ] 清单    |
| `,j`   | INSERT | * [ ] 清单    |
| `,a`   | INSERT | 图片          |
| `,1`   | INSERT | # H1          |
| `,2`   | INSERT | ## H2         |
| `,3`   | INSERT | ### H3        |
| `,4`   | INSERT | #### H4       |
| `,5`   | INSERT | ##### H5      |
| `,l`   | INSERT | 分隔符        |

`,f` 去往下一个占位符`<++>` 

![markdown](https://file.fishpi.cn/2022/11/144582-0bd65444.gif) 
