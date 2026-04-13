local ok, secrets = pcall(require, "secrets")
if ok then
  vim.env.GEMINI_API_KEY = secrets.GEMINI_API_KEY
end
require("core")
require("lazy_setup")
require("lsp_setup")
