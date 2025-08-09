vim.api.nvim_create_user_command('WordlePatternAll', function()
  local line = vim.fn.getline('.')
  local parts = vim.split(line, '|')
  if #parts ~= 2 then
    print('Format must be: includeSpec|excluded')
    return
  end

  local include_spec = parts[1]
  local excluded_raw = parts[2]

  local lookaheads = {}
  local fixed = {}
  local must_not_match = {}
  local required_letters = {}

  -- Track excluded letters (preserve order exactly as entered)
  local excluded_set = {}
  local excluded_list = {}
  for c in excluded_raw:gmatch('.') do
    if not excluded_set[c] then
      excluded_set[c] = true
      table.insert(excluded_list, c)
    end
  end

  -- Parse include spec like o3t4*
  for char, pos, star in include_spec:gmatch("([a-zA-Z])(%d?)(%*?)") do
    local has_fixed_pos = (pos ~= "" and star == "*")
    if not has_fixed_pos then
      required_letters[char] = true
    end

    if pos ~= "" then
      local i = tonumber(pos)
      if star == "*" then
        fixed[i] = char
      else
        must_not_match[i] = must_not_match[i] or {}
        table.insert(must_not_match[i], char)
      end
    end
  end

  -- Build lookaheads only for required (not fixed) letters
  for char, _ in pairs(required_letters) do
    table.insert(lookaheads, string.format("(?=.*%s)", char))
  end

  -- Build regex body
  local body = {}
  for i = 1, 5 do
    if fixed[i] then
      body[i] = fixed[i]
    else
      -- Start with excluded letters in the user-entered order
      local seen = {}
      local chars = {}
      for _, c in ipairs(excluded_list) do
        table.insert(chars, c)
        seen[c] = true
      end
      -- Append per-position “not-here” letters (preserve their order)
      if must_not_match[i] then
        for _, c in ipairs(must_not_match[i]) do
          if not seen[c] then
            table.insert(chars, c)
            seen[c] = true
          end
        end
      end
      body[i] = string.format("[^%s]", table.concat(chars))
    end
  end

  local regex = table.concat(lookaheads) .. "^" .. table.concat(body)
  vim.fn.setline('.', regex)

  -- Reduced pool (unchanged): frequency minus excluded
  local freq = "eariotnslcdhm"
  local reduced = {}
  for c in freq:gmatch('.') do
    if not excluded_set[c] then
      table.insert(reduced, c)
    end
  end

  vim.fn.append(vim.fn.line('.'), table.concat(reduced))
end, {})