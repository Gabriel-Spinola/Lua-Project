local lpeg = require "lpeg"

local lexer = {}

-- Define token types
local TokenType = {
  Identifier = "Identifier",
  Number = "Number",
  Operator = "Operator",
  Keyword = "Keyword",
  Comment = "Comment",
  Space = "Space",
}

--- @param code string
function lexer.tokenize(code)
  local tokens = {}
  local index = 1

  while index <= #code do
    local char = code:sub(index, index)

    -- skip spaces
    if char:match("%s") then
      index = index + 1
    elseif char:match("[%a_]") then -- match alphanumeric chars & underscores
      local indentifier = char

      index = index + 1

      while index <= #code and code:sub(index, index):match("[%w_]") do
        indentifier = indentifier .. code:sub(index, index)

        index = index + 1
      end

      table.insert(tokens, {type = TokenType.Identifier, value = indentifier})
    else
      index = index + 1
    end
  end

  for _, token in ipairs(tokens) do
    print(token.type .. " : " .. token.value)
  end
end

return lexer