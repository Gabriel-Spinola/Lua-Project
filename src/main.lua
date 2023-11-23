local filesReader = require "filesReader"
local lexer = require "lexer"

local fileName = 'examples/grammar.sl'
local lines = filesReader:LinesFrom(fileName)

local code = table.concat(lines)

print "# Start Compiler:\n\n"

local tokens = lexer.tokenize(code)

for _, token in ipairs(tokens) do
  print(token.type .. " : " .. token.value)
end