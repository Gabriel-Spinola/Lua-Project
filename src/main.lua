local filesReader = require "filesReader"
local lexer = require "lexer"

local fileName = 'examples/grammar.sl'
local lines = filesReader:LinesFrom(fileName)

local code = table.concat(lines)

print "# Start Compiler:\n\n"

lexer.tokenize(code)