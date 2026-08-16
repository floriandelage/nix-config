{
    inputs,
    pkgs,
    lib,
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
                    {
                        event = ["VimEnter"];
                        desc = "Disable kitty padding when entering";
                        callback = lib.generators.mkLuaInline ''
                            function()
                                vim.defer_fn(function()
                                    vim.cmd("silent !kitty @ set-spacing margin=0")
                                end, 100)
                            end
                        '';
                    }
                    {
                        event = ["VimLeave"];
                        desc = "Re-enable kitty padding when leaving";
                        callback = lib.generators.mkLuaInline ''
                            function()
                                vim.defer_fn(function()
                                    vim.cmd("silent !kitty @ set-spacing margin=12")
                                end, 100)
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
                            terminal.keymap.preset = "terminal";
                        };
                    };
                };

                clipboard = {
                    enable = true;
                    registers = "unnamedplus";
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
                        action = "<cmd>Pick files<CR>";
                        desc = "Find files";
                    }
                    {
                        mode = "n";
                        key = "<leader>fg";
                        action = "<cmd>Pick grep_live<CR>";
                        desc = "Live grep";
                    }
                    {
                        mode = "n";
                        key = "<leader>fb";
                        action = "<cmd>Pick buffers<CR>";
                        desc = "Find buffers";
                    }
                    {
                        mode = "n";
                        key = "<leader>fh";
                        action = "<cmd>Pick help<CR>";
                        desc = "Find help";
                    }
                ];

                languages = {
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

                    icons = {
                        enable = true;
                    };

                    notify = {
                        enable = true;
                    };

                    pairs = {
                        enable = true;
                    };

                    pick = {
                        enable = true;
                        setupOpts = {
                            window.config = lib.generators.mkLuaInline ''
                                function()
                                  local width = math.min(
                                    math.floor(vim.o.columns * 0.7),
                                    100
                                  )

                                  local height = math.min(
                                    math.floor(vim.o.lines * 0.6),
                                    25
                                  )

                                  return {
                                    anchor = "NW",
                                    border = "rounded",

                                    width = width,
                                    height = height,

                                    row = math.floor((vim.o.lines - height) / 2),
                                    col = math.floor((vim.o.columns - width) / 2),
                                  }
                                end
                            '';
                        };
                    };

                    statusline.enable = true;

                    surround = {
                        enable = true;
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

                terminal = {
                    toggleterm = {
                        enable = true;
                        mappings.open = "<C-t>";
                        setupOpts.direction = "float";
                    };
                };

                theme = {
                    enable = true;
                    name = "gruvbox";
                    style = "dark";
                };

                treesitter.enable = true;

                undoFile.enable = true;

                utility = {
                    oil-nvim = {
                        enable = true;
                    };
                };
            };
        };
    };
}
