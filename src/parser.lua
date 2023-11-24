-- Write Tree
local lexer = require 'lexer'

local parser = {}

--- @alias ASTNode table<string, unknown>
local ASTNode = {
  --- @type { type: string, value: integer | nil }
  int = { type = lexer.TokenType.Keyword, value = nil };

  --- @type { type: string, value: string | nil }
  string = { type = lexer.TokenType.Keyword, value = nil };

  --- @type { type: string, value: number | nil }
  decimal = { type = lexer.TokenType.Keyword, value = nil };

  --- @type { type: string, value: true | false | nil }
  bool = { type = lexer.TokenType.Keyword, value = nil };

  --- @type { type: string, value: ASTNode | nil }
  mut = { type = lexer.TokenType.Keyword, right = nil };
}

--- @param tokens table<integer, { type: string, value: string }> 
function parser.parse(tokens)
  local tree = {}
  local index = 1

  while index <= #tokens do


    -- Goes to next character
    local next = function()
      index = index + 1
    end

    print(tokens[index].value)
    next()
  end
end

return parser