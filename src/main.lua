local FilesReader = require "filesReader"

local fileName = 'examples/grammar.sl'
local lines = FilesReader:LinesFrom(fileName)

print "Start:\n\n"

for key, value in pairs(lines) do
  print('line[' .. key .. ']', value)
end