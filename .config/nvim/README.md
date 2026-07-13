# Neovim

LazyVim-based Neovim setup for C# development with Roslyn.

## Stack

- [LazyVim](https://www.lazyvim.org/) as the Neovim distribution
- [roslyn.nvim](https://github.com/seblyng/roslyn.nvim) for C# LSP integration
- `roslyn-language-server` installed as a global .NET tool
- [CSharpier](https://csharpier.com/) for C# formatting
- `netcoredbg` for .NET debugging
- `neotest` + `neotest-vstest` for test integration
- Treesitter parsers for `c_sharp` and `fsharp`

## Layout

```text
.config/nvim/
├── init.lua
├── lazy-lock.json
└── lua/
    ├── config/
    │   ├── autocmds.lua
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   └── options.lua
    └── plugins/
        └── csharp.lua
```

## C# / Roslyn notes

This config intentionally uses **Roslyn**, not OmniSharp.

Do **not** enable LazyVim's official `lang.dotnet` extra unless you explicitly
want OmniSharp; that extra configures OmniSharp.

Roslyn config lives in:

```text
.config/nvim/lua/plugins/csharp.lua
```

## First-time setup

Install the Roslyn language server:

```bash
dotnet tool install -g roslyn-language-server --prerelease --source https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/index.json
```

Then install/update Neovim plugins and Mason-managed tools:

```bash
nvim --headless "+Lazy! sync" "+sleep 10" +qa
```

The config asks Mason to install:

- `csharpier`
- `netcoredbg`

## Updating

Update the Roslyn language server:

```bash
dotnet tool update -g roslyn-language-server --prerelease --source https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/index.json
```

Update Neovim plugins:

```bash
nvim --headless "+Lazy! sync" "+sleep 10" +qa
```

Commit any resulting `lazy-lock.json` changes if you want to pin the updated
plugin versions.

## Verification

Basic startup check:

```bash
nvim --headless +qa
```

Confirm Roslyn attaches:

1. Open a `.cs` file inside a `.sln`/`.csproj` project.
2. Run `:LspInfo`.
3. Confirm the attached client is `roslyn`.

CLI checks:

```bash
command -v roslyn-language-server
roslyn-language-server --version
csharpier --version
~/.local/share/nvim/mason/bin/netcoredbg --version
```

## Key defaults

- Clipboard: `unnamedplus`
- Absolute + relative line numbers enabled
- LazyVim default keymaps remain active

## Debugging

DAP uses `netcoredbg`. The default launch config asks for the path to the built
`.dll`.

Typical flow:

```bash
dotnet build
```

Then in Neovim, start DAP and enter the path to the output assembly under
`bin/<Configuration>/<TargetFramework>/`.
