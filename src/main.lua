local filesReader = require "filesReader"
local lexer = require "lexer"
local parser = require "parser"

local fileName = 'examples/grammar.th'
local lines = filesReader:LinesFrom(fileName)

local code = table.concat(lines)

print "# Start Compiler:\n\n"

local tokens = lexer:tokenize(code)
local syntaxTree = parser.parser(tokens)

print(require('inspect')(syntaxTree))