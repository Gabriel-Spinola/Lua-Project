local filesReader = require "filesReader"
local lexer = require "lexer"
local parser = require "parser"

local fileName = 'examples/grammar.th'
local lines = filesReader:LinesFrom(fileName)

local code = table.concat(lines)

print "# Start Compiler:\n\n"

local tokens = lexer:tokenize(code)
parser.parse(tokens)

-- for _, token in ipairs(tokens) do
  -- print(token.type .. " : " .. token.value)
-- end

