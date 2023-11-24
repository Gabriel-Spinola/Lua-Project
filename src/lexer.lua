local lexer = {}

-- Define token types
lexer.TokenType = {
  Identifier = "Identifier",
  Number = "Number",
  Operator = "Operator",
  Keyword = "Keyword",
  Comment = "Comment",
  SpecialOperator = "SpecialOperator",
  Space = "Space",
  Type = "Type",
}

local types = {
  ["int"] = true,
  ["string"] = true,
  ["decimal"] = true,
  ["bool"] = true,
}

local keywords = {
  ["if"] = true,
  ["else"] = true,
  ["def"] = true,
  ["for"] = true,
  ["mut"] = true,
}

local specialOperators = {
  "->", ":=", "=>", "++", "--"
}

local operators = "[%+%-%*/%=]"

--- @param code string
--- @param index integer
---
--- @return boolean, integer
local function containsSpecialOperator(code, index)
  for _, operator in ipairs(specialOperators) do
    local opLength = #operator

    -- Check if the remaining code is long enough to contain the operator
    if index + opLength - 1 <= #code then
      local substring = code:sub(index, index + opLength - 1)

      -- If the substring matches the operator, return true
      if substring == operator then
        return true, opLength
      end
    end
  end

  return false, 0
end

--- @param identifier string
--- check if the indetifier fits into a Keyword type or a Type. If not return as Identifier
local function getIdentifierType(identifier)
  return
      keywords[identifier] and lexer.TokenType.Keyword or
      types[identifier] and lexer.TokenType.Type or lexer.TokenType.Identifier
end

--- @param code string
--- 
--- @return table<integer, { type: string, value: string }> 
function lexer:tokenize(code)
  local tokens = {}
  local index = 1

  while index <= #code do
    local char = code:sub(index, index)

    -- Goes to next character
    local next = function()
      index = index + 1
    end

    -- skip spaces
    if char:match("%s") then
      next()

      -- match alphanumeric chars & underscores
    elseif char:match("[%a_]") then
      local identifier = char

      next()

      -- Continue matching
      while index <= #code and code:sub(index, index):match("[%w_]") do
        identifier = identifier .. code:sub(index, index)

        next()
      end

      table.insert(tokens, { type = getIdentifierType(identifier), value = identifier })
      -- Match number
    elseif char:match("%d") then
      local number = char
      next()

      while index <= #code and code:sub(index, index):match("[%d_]") do
        number = number .. code:sub(index, index)

        next()
      end

      table.insert(tokens, { type = self.TokenType.Number, value = number })
      -- check for operators
    elseif char:match(operators) then
      -- Check for special operators
      local isSpecialOperator, opLength = containsSpecialOperator(code, index)

      if isSpecialOperator then
        table.insert(tokens, { type = self.TokenType.SpecialOperator, value = code:sub(index, index + opLength - 1) })

        index = index + opLength
      else
        table.insert(tokens, { type = self.TokenType.Operator, value = char })

        next()
      end
    else
      next()
    end
  end

  return tokens
end

return lexer