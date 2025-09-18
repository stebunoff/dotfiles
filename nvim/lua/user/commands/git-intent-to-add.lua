-- Check git tracking for file
local function is_tracked(path)
  vim.fn.system({ "git", "ls-files", "--error-unmatch", path })
  return vim.v.shell_error == 0
end

-- intent-to-add (git add -N) for current or picked file
local function intent_to_add(path)
  path = path or vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Нет открытого файла", vim.log.levels.WARN)
    return
  end

  local tracked_before = is_tracked(path)
  vim.fn.system({ "git", "add", "-N", path })
  local rc = vim.v.shell_error

  pcall(function() require("neogit").refresh() end)

  if rc == 0 then
    local tracked_after = is_tracked(path)
    if not tracked_before and tracked_after then
      vim.notify("File added to the index (intent-to-add): " .. path, vim.log.levels.INFO)
    else
      -- Already tracked or no changes
      vim.notify("File already tracked: " .. path, vim.log.levels.INFO)
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
