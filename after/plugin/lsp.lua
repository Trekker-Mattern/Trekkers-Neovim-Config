local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace"

vim.lsp.config("jdtls", {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/jdtls.cmd",
    "-data",
    workspace_dir,
  },
  root_markers = { "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" },
  settings = {
    java = {},
  },
})

vim.lsp.enable("jdtls")
vim.lsp.config("sqllens", {
  cmd = {
    [[C:\Program Files\nodejs\node.exe]],
    [[C:\Users\Trekker\AppData\Local\Programs\sql-language-server\node_modules\sqllens-language-server\bin\cli.js]],
    "--stdio",
  },
  cmd_env = {
    SQLLENS_USER_CONFIG = [[C:\Users\Trekker\AppData\Local\Programs\sql-language-server\.sqllens.json]],
  },
  filetypes = { "sql" },
  root_dir = function(_, on_dir)
    on_dir(vim.fn.getcwd())
  end,
})
vim.lsp.enable("sqllens")

