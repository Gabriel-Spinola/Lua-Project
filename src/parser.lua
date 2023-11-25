-- Write Tree
local lexer = require 'lexer'

local parser = {}

--- @alias ASTNode table<string, unknown>
local ASTNode = {
  --- @type { type: string, keyword: string, value: integer | nil }
  int = { type = lexer.TokenType.Keyword, keyword="int", value = nil };

  --- @type { type: string, keyword: string, value: string | nil }
  string = { type = lexer.TokenType.Keyword, keyword = "string", value = nil };

  --- @type { type: string, keyword: string, value: number | nil }
  decimal = { type = lexer.TokenType.Keyword, keyword = "decimal", value = nil };

  --- @type { type: string, keyword: string, value: true | false | nil }
  bool = { type = lexer.TokenType.Keyword, keyword = "bool", value = nil };

  --- @type { type: string, keyword: string, value: ASTNode | nil }
  mut = { type = lexer.TokenType.Keyword, keyword = "mut", right = nil };

  --- @type { type: string, operator: "=", left: ASTNode | nil, right: ASTNode | nil }
  assign = { type = lexer.TokenType.Operator, operator = "=", left = nil, right = nil }
}

--- @param tokens table<integer, { type: string, value: string }> 
function parser.parser(tokens)
  local tree = {}
  local index = 1

  local function peek()
    return tokens[index]
  end

  local function next()
    local current = tokens[index]
    index = index + 1

    return current
  end

  local function parseNumber()
    local token = next()

    return table.insert(tree, { type = lexer.TokenType.Number, value = token })
  end

  local function parse()
    local left

    while index <= #tokens do
      if peek().type == lexer.TokenType.Keyword then
        local keyword = peek().value

        if keyword == ASTNode.mut.keyword then
          return parseIntNode()
        end
      end

      next()
    end

    return left
  end

  return parse()
end

return parser