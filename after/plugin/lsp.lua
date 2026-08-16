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
