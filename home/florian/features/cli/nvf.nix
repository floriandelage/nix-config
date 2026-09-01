{
    inputs,
    pkgs,
    lib,
    config,
    ...
}: {
    imports = [
        inputs.nvf.homeManagerModules.default
    ];

    programs.nvf = {
        enable = true;
        settings = {
            vim = {
                extraPackages = with pkgs; [
                    luaPackages.tree-sitter-cli
                    ripgrep
                ];

                vendoredKeymaps.enable = false;

                extraPlugins = {
                    vim-tmux-navigator = {
                        package = pkgs.vimPlugins.vim-tmux-navigator;
                    };
                };

                luaConfigRC = {
                    notes-keymaps = ''
                        local notes_dir = vim.fn.expand("~/Notes")

                        local function daily_template()
                          local date = os.date("%d-%m-%Y")
                          return string.format([[---
                        date: %s
                        tags: ["daily"]
                        ---

                        # Tasks
                        - [ ]

                        # Notes

                        ]], date)
                        end


                        local function inbox_template(title)
                          local date = os.date("%d-%m-%Y")
                          return string.format([[---
                        date: %s
                        title: %s
                        tags: []
                        ---

                        ]], date, title)
                        end

                        local function open_today_note()
                          vim.cmd("cd " .. notes_dir)

                          local journal_dir = notes_dir .. "/journal"
                          vim.fn.mkdir(journal_dir, "p")

                          local filepath = journal_dir .. "/" .. os.date("%d-%m-%Y") .. ".md"

                          if vim.fn.filereadable(filepath) == 0 then
                            local file = io.open(filepath, "w")
                            if file then
                              file:write(daily_template())
                              file:close()
                            end
                          end

                          vim.cmd("edit " .. filepath)
                        end

                        local function new_inbox_note()
                          vim.cmd("cd " .. notes_dir)

                          local inbox_dir = notes_dir .. "/inbox"
                          vim.fn.mkdir(inbox_dir, "p")

                          vim.ui.input({ prompt = "New note: " }, function(title)
                            if not title or title == "" then return end

                            local slug = title:gsub("%s+", "-"):lower()
                            local filepath = inbox_dir .. "/" .. slug .. ".md"

                            if vim.fn.filereadable(filepath) == 1 then
                              vim.cmd("edit " .. filepath)
                              return
                            end

                            local file = io.open(filepath, "w")
                            if not file then
                              vim.notify("Failed to create file: " .. filepath, vim.log.levels.ERROR)
                              return
                            end
                            file:write(inbox_template(title))
                            file:close()

                            vim.cmd("edit " .. filepath)
                            vim.cmd("normal! G")
                          end)
                        end

                        local function find_note()
                          vim.cmd("cd " .. notes_dir)
                          require("telescope.builtin").find_files({
                            prompt_title = "Notes",
                            cwd = notes_dir,
                            hidden = false,
                          })
                        end

                        vim.api.nvim_create_user_command("TodayNote", open_today_note, {})
                        vim.api.nvim_create_user_command("InboxNote", new_inbox_note, {})
                        vim.api.nvim_create_user_command("FindNote", find_note, {})

                        vim.keymap.set("n", "<leader>nt", open_today_note, { desc = "Open today's daily note" })
                        vim.keymap.set("n", "<leader>ni", new_inbox_note, { desc = "New inbox note" })
                        vim.keymap.set("n", "<leader>nf", find_note, { desc = "Find note" })
                    '';
                };

                autocmds = [
                    {
                        event = ["TextYankPost"];
                        desc = "Highlight yanked text";
                        callback = lib.generators.mkLuaInline ''
                            function()
                              vim.hl.on_yank()
                            end
                        '';
                    }
                ];

                autocomplete = {
                    blink-cmp = {
                        enable = true;
                        friendly-snippets.enable = true;
                        setupOpts = {
                            completion.documentation.auto_show = false;
                            signature.enabled = true;

                            keymap.preset = "default";
                            cmdline.keymap.preset = "cmdline";
                        };
                    };
                };

                clipboard = {
                    enable = true;
                    registers = "unnamedplus";
                };
                dashboard = {
                    alpha = {
                        enable = true;
                        theme = null;

                        layout = [
                            {
                                type = "padding";
                                val = 2;
                            }
                            {
                                type = "text";
                                val = [
                                    "                                   "
                                    "                                   "
                                    "                                   "
                                    "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
                                    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
                                    "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
                                    "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
                                    "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
                                    "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
                                    "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
                                    " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
                                    " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
                                    "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
                                    "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "
                                    "                                   "
                                ];
                                opts = {
                                    position = "center";
                                    hl = "Type";
                                };
                            }
                            {
                                type = "padding";
                                val = 2;
                            }
                            {
                                type = "group";
                                val = [
                                    {
                                        type = "button";
                                        val = "  New file                       e";
                                        opts = {
                                            shortcut = "e";
                                            position = "center";
                                            keymap = ["n" "e" "<cmd>ene<CR>" {}];
                                            hl_shortcut = "Keyword";
                                        };
                                    }
                                    {
                                        type = "button";
                                        val = "  Find file                      f";
                                        opts = {
                                            shortcut = "f";
                                            position = "center";
                                            keymap = ["n" "f" "<cmd>Telescope find_files<CR>" {}];
                                            hl_shortcut = "Keyword";
                                        };
                                    }
                                    {
                                        type = "button";
                                        val = "  Recent files                   r";
                                        opts = {
                                            shortcut = "r";
                                            position = "center";
                                            keymap = ["n" "r" "<cmd>Telescope oldfiles<CR>" {}];
                                            hl_shortcut = "Keyword";
                                        };
                                    }
                                    {
                                        type = "button";
                                        val = "  Find note                      n";
                                        opts = {
                                            shortcut = "n";
                                            position = "center";
                                            keymap = ["n" "n" "<cmd>FindNote<CR>" {}];
                                            hl_shortcut = "Keyword";
                                        };
                                    }
                                    {
                                        type = "button";
                                        val = "  Today's note                   t";
                                        opts = {
                                            shortcut = "t";
                                            position = "center";
                                            keymap = ["n" "t" "<cmd>TodayNote<CR>" {}];
                                            hl_shortcut = "Keyword";
                                        };
                                    }
                                    {
                                        type = "button";
                                        val = "  New inbox note                 i";
                                        opts = {
                                            shortcut = "i";
                                            position = "center";
                                            keymap = ["n" "i" "<cmd>InboxNote<CR>" {}];
                                            hl_shortcut = "Keyword";
                                        };
                                    }
                                    {
                                        type = "button";
                                        val = "  Quit                           q";
                                        opts = {
                                            shortcut = "q";
                                            position = "center";
                                            keymap = ["n" "q" "<cmd>qa<CR>" {}];
                                            hl_shortcut = "Keyword";
                                        };
                                    }
                                ];
                                opts = {
                                    spacing = 1;
                                    position = "center";
                                };
                            }
                        ];

                        opts = {
                            margin = 5;
                            position = "center";
                        };
                    };
                };

                diagnostics = {
                    enable = true;
                    config = {
                        virtual_text = true;
                    };
                };

                formatter = {
                    conform-nvim = {
                        enable = true;

                        setupOpts.formatters.alejandra = {
                            cwd = lib.generators.mkLuaInline ''
                                require("conform.util").root_file({ "alejandra.toml" })
                            '';
                        };
                    };
                };

                keymaps = [
                    {
                        mode = "n";
                        key = "<Esc>";
                        action = ":nohlsearch<CR>";
                        desc = "Clear search highlights";
                    }

                    {
                        mode = "n";
                        key = "n";
                        action = "nzzzv";
                        desc = "Next search result (centered)";
                    }
                    {
                        mode = "n";
                        key = "N";
                        action = "Nzzzv";
                        desc = "Previous search result (centered)";
                    }
                    {
                        mode = "n";
                        key = "<C-d>";
                        action = "<C-d>zz";
                        desc = "Half page down (centered)";
                    }
                    {
                        mode = "n";
                        key = "<C-u>";
                        action = "<C-u>zz";
                        desc = "Half page up (centered)";
                    }

                    {
                        mode = "n";
                        key = "<A-j>";
                        action = ":m .+1<CR>==";
                        desc = "Move line down";
                    }
                    {
                        mode = "n";
                        key = "<A-k>";
                        action = ":m .-2<CR>==";
                        desc = "Move line up";
                    }
                    {
                        mode = "v";
                        key = "<A-j>";
                        action = ":m '>+1<CR>gv=gv";
                        desc = "Move selection down";
                    }
                    {
                        mode = "v";
                        key = "<A-k>";
                        action = ":m '<-2<CR>gv=gv";
                        desc = "Move selection up";
                    }

                    {
                        mode = "v";
                        key = "<";
                        action = "<gv";
                        desc = "Indent left and reselect";
                    }
                    {
                        mode = "v";
                        key = ">";
                        action = ">gv";
                        desc = "Indent right and reselect";
                    }

                    {
                        mode = "n";
                        key = "J";
                        action = "mzJ`z";
                        desc = "Join lines and keep cursor position";
                    }

                    {
                        mode = "n";
                        key = "gd";
                        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
                        desc = "Go to definition";
                    }
                    {
                        mode = "n";
                        key = "gD";
                        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
                        desc = "Go to declaration";
                    }
                    {
                        mode = "n";
                        key = "gi";
                        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
                        desc = "Go to implementation";
                    }
                    {
                        mode = "n";
                        key = "gr";
                        action = "<cmd>lua vim.lsp.buf.references()<CR>";
                        desc = "References";
                    }

                    {
                        mode = "n";
                        key = "K";
                        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
                        desc = "Hover documentation";
                    }

                    {
                        mode = ["n" "v"];
                        key = "<leader>la";
                        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
                        desc = "Code action";
                    }
                    {
                        mode = "n";
                        key = "<leader>lr";
                        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
                        desc = "Rename";
                    }

                    {
                        mode = "n";
                        key = "[d";
                        action = "<cmd>lua vim.diagnostic.jump({ count = -1 })<CR>";
                        desc = "Previous diagnostic";
                    }
                    {
                        mode = "n";
                        key = "]d";
                        action = "<cmd>lua vim.diagnostic.jump({ count = 1 })<CR>";
                        desc = "Next diagnostic";
                    }
                    {
                        mode = "n";
                        key = "<leader>ld";
                        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
                        desc = "Line diagnostic";
                    }
                    {
                        mode = "n";
                        key = "<leader>ff";
                        action = "<cmd>Telescope find_files<CR>";
                        desc = "Find files";
                    }
                    {
                        mode = "n";
                        key = "<leader>fg";
                        action = "<cmd>Telescope live_grep<CR>";
                        desc = "Live grep";
                    }
                    {
                        mode = "n";
                        key = "<leader>fb";
                        action = "<cmd>Telescope buffers<CR>";
                        desc = "Find buffers";
                    }
                    {
                        mode = "n";
                        key = "<leader>fh";
                        action = "<cmd>Telescope help_tags<CR>";
                        desc = "Find help";
                    }

                    {
                        key = "<C-h>";
                        mode = "n";
                        action = "<cmd>TmuxNavigateLeft<CR>";
                        desc = "Move to left window/pane";
                    }
                    {
                        key = "<C-j>";
                        mode = "n";
                        action = "<cmd>TmuxNavigateDown<CR>";
                        desc = "Move to bottom window/pane";
                    }
                    {
                        key = "<C-k>";
                        mode = "n";
                        action = "<cmd>TmuxNavigateUp<CR>";
                        desc = "Move to top window/pane";
                    }
                    {
                        key = "<C-l>";
                        mode = "n";
                        action = "<cmd>TmuxNavigateRight<CR>";
                        desc = "Move to right window/pane";
                    }
                ];

                languages = {
                    clang = {
                        enable = true;

                        format = {
                            enable = true;
                            type = ["clang-format"];
                        };

                        lsp = {
                            enable = true;
                            servers = ["clangd"];
                        };

                        treesitter = {
                            enable = true;
                        };
                    };

                    markdown = {
                        enable = true;

                        lsp = {
                            enable = true;
                            servers = ["markdown-oxide"];
                        };

                        treesitter = {
                            enable = true;
                        };

                        extensions = {
                            render-markdown-nvim = {
                                enable = true;
                            };
                        };
                    };

                    nix = {
                        enable = true;

                        format = {
                            enable = true;
                            type = ["alejandra"];
                        };

                        lsp = {
                            enable = true;
                            servers = ["nixd"];
                        };

                        treesitter = {
                            enable = true;
                        };
                    };
                };

                lsp = {
                    enable = true;
                    formatOnSave = true;
                    inlayHints.enable = true;
                };

                mini = {
                    ai = {
                        enable = true;
                    };

                    diff = {
                        enable = true;
                        setupOpts = {
                            view = {
                                style = "sign";
                                signs = {
                                    add = "┃";
                                    change = "┃";
                                    delete = "┃";
                                };
                            };
                        };
                    };

                    pairs = {
                        enable = true;
                    };

                    surround = {
                        enable = true;
                    };
                };

                notify = {
                    nvim-notify = {
                        enable = true;
                        setupOpts = {
                            stages = "static";
                        };
                    };
                };

                opts = {
                    number = true;
                    relativenumber = true;
                    cursorline = true;
                    wrap = false;
                    scrolloff = 10;
                    sidescrolloff = 10;

                    tabstop = 4;
                    shiftwidth = 4;
                    softtabstop = 4;
                    expandtab = true;
                    smartindent = true;
                    autoindent = true;

                    ignorecase = true;
                    smartcase = true;
                    hlsearch = true;
                    incsearch = true;

                    signcolumn = "yes";
                    colorcolumn = "80";
                    showmatch = false;
                    cmdheight = 1;
                    showmode = false;
                    fillchars = {eob = " ";};
                    conceallevel = 2;
                    foldenable = false;

                    backup = false;
                    writebackup = false;
                    swapfile = false;
                    autoread = true;
                    autowrite = false;

                    hidden = true;
                    errorbells = false;
                    backspace = "indent,eol,start";
                    autochdir = false;
                    selection = "inclusive";
                    mouse = "a";
                    modifiable = true;

                    splitbelow = true;
                    splitright = true;
                };

                statusline = {
                    lualine = {
                        enable = true;
                    };
                };

                telescope = {
                    enable = true;
                    extensions = [
                        {
                            name = "fzf";
                            packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
                            setup = {fzf = {fuzzy = true;};};
                        }
                    ];
                    setupOpts = {
                        defaults = {
                            color_devicons = true;
                        };
                    };
                };

                theme = {
                    enable = true;
                    name = "gruvbox";
                    style = "dark";
                };

                treesitter.enable = true;

                ui = {
                    noice = {
                        enable = true;
                        setupOpts = {
                            cmdline = {
                                enabled = true;
                                view = "cmdline_popup";
                            };

                            views = {
                                cmdline_popup = {
                                    position = {
                                        row = "40%";
                                        col = "50%";
                                    };
                                    size = {
                                        width = 60;
                                        height = "auto";
                                    };
                                    border.style = "rounded";
                                };
                            };
                        };
                    };
                };

                undoFile.enable = true;

                utility = {
                    oil-nvim = {
                        enable = true;
                    };
                };

                visuals = {
                    nvim-web-devicons = {
                        enable = true;
                    };
                };
            };
        };
    };

    xdg.configFile."moxide/settings.toml".text = ''
        dailynote = "%d-%m-%Y"
        daily_notes_folder = "${config.home.homeDirectory}/Notes/journal"
        new_file_folder_path = "${config.home.homeDirectory}/Notes/inbox"
    '';

    home.persistence."/persist".directories = [
        ".local/state/nvf"
        "Notes"
    ];
}
