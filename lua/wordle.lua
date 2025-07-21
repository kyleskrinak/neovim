vim.api.nvim_create_user_command('WordleAll', function()
  local line = vim.fn.getline('.')
  local parts = vim.split(line, '|')
  if #parts ~= 2 then
    print('Format must be: required|excluded')
    return
  end

  local required = parts[1]
  local excluded_raw = parts[2]

  -- Build lookaheads
  local lookaheads = {}
  for c in required:gmatch('.') do
    table.insert(lookaheads, string.format("(?=.*%s)", c))
  end

  local regex_prefix = table.concat(lookaheads)
  local regex_body = '^' .. string.rep(string.format("[^%s]", excluded_raw), 5)
  local regex = regex_prefix .. regex_body

  -- Build reduced frequency set
  local freq = "eariotnslcdhm"
  local excluded = {}
  for c in excluded_raw:gmatch('.') do
    excluded[c] = true
  end

  local reduced_chars = {}
  for c in freq:gmatch('.') do
    if not excluded[c] then
      table.insert(reduced_chars, c)
    end
  end

  -- Replace the current line with the regex, append reduced chars
  vim.fn.setline('.', regex)
  vim.fn.append(vim.fn.line('.'), table.concat(reduced_chars))
end, {})