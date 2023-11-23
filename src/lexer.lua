local lexer = {}

-- Define token types
local TokenType = {
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
  ["float"] = true,
  ["char"] = true,
}

local keywords = {
  ["if"] = true,
  ["else"] = true,
  ["function"] = true,
  ["def"] = true,
  ["mut"] = true,
}

local specialOperators = {
  "->", ":=", "=>",
}

--- @param code string
--- @param index integer
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
      keywords[identifier] and TokenType.Keyword or
      types[identifier] and TokenType.Type or TokenType.Identifier
end

--- @param code string
function lexer.tokenize(code)
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
    elseif char:match("%d") then
      local number = char
      next()

      while index <= #code and code:sub(index, index):match("[%d_]") do
        number = number .. code:sub(index, index)

        next()
      end

      table.insert(tokens, { type = TokenType.Number, value = number })
    elseif char:match("[%+%-%*/%=]") then
      -- Check for special operators
      local isSpecialOperator, opLength = containsSpecialOperator(code, index)

      if isSpecialOperator then
        table.insert(tokens, { type = TokenType.SpecialOperator, value = code:sub(index, index + opLength - 1) })

        index = index + opLength
      else
        table.insert(tokens, { type = TokenType.Operator, value = char })

        next()
      end
    else
      next()
    end
  end

  return tokens
end

return lexer
