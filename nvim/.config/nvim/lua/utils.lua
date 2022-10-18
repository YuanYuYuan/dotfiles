M = {}

local parse_mode = function(mode_str)
  local tbl = {}
  for mode in string.gmatch(mode_str, '([^,]+)') do
    table.insert(tbl, mode)
  end
  return tbl
end

M.bind_mappings = function (mappings)
  for key, map in pairs(mappings) do
    if type(map) == 'table' then
      for mode, mode_map in pairs(map) do
        vim.keymap.set(parse_mode(mode), key, mode_map)
      end
    else
      vim.keymap.set('n', key, map)
    end
  end
end

M.bind_mapping_collection = function(collection)
  for _, mappings in pairs(collection) do
    M.bind_mappings(mappings)
  end
end

M.table_map = function(tbl, fcn)
  for k, v in pairs(tbl) do
    tbl[k] = fcn(v)
  end
  return tbl
end


M.Table = function(t)
  return setmetatable(t or {}, { __index = table })
end

function table.map(tbl, fcn)
  for key, val in pairs(tbl) do
    tbl[key] = fcn(val)
  end
  return tbl
end


-- https://github.com/nvim-telescope/telescope.nvim/issues/1923#issuecomment-1123136065
M.get_visual_selection = function()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, '\n', '')
  if #text > 0 then
    return text
  else
    return ''
  end
end

return M


