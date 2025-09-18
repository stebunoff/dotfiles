-- Check git tracking for file
local function is_tracked(path)
  vim.fn.system({ "git", "ls-files", "--error-unmatch", path })
  return vim.v.shell_error == 0
end

local function refresh_gitsigns_for_current_buffer()
  local ok, gs = pcall(require, 'gitsigns')
  if not ok then return end

  -- Wait for index refresh
  vim.defer_fn(function()
    pcall(function() gs.attach() end)
    pcall(vim.cmd, 'Gitsigns refresh')
  end, 20)
end

-- intent-to-add (git add -N) for current or picked file
local function intent_to_add(path)
  path = path or vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Нет открытого файла", vim.log.levels.WARN)
    return
  end

  if is_tracked(path) then
    vim.notify("File already tracked: " .. path, vim.log.levels.INFO)
    return
  end

  vim.fn.system({ "git", "add", "-N", path })
  local rc = vim.v.shell_error

  refresh_gitsigns_for_current_buffer()
  pcall(function() require("neogit").refresh() end)

  if rc == 0 then
    if is_tracked(path) then
      vim.notify("File added to the index (intent-to-add): " .. path, vim.log.levels.INFO)
    end
  else
    vim.notify("git add -N failed: " .. path, vim.log.levels.ERROR)
  end
end

-- Command :GitIntentToAdd [path]
vim.api.nvim_create_user_command("GitIntentToAdd", function(opts)
  intent_to_add(opts.args ~= "" and opts.args or nil)
end, { nargs = "?" })

-- Keymap: intent-to-add current file
vim.keymap.set("n", "<leader>ga", function() intent_to_add() end)
