-- Sources:
--  - vimjoyer vid:
--    - https://www.youtube.com/watch?v=FmHhonPjvvA
--    - code: https://github.com/vimjoyer/nvim-luasnip-video
-- TODO:
-- - [ ] use the lua loader instead of declaring all snippets via add_snippets
--    - https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
-- - [ ]

local ls = require("luasnip")
local snippet = ls.snippet
local t_node = ls.text_node
-- adds navigable jump points in the snippet
-- use TAB and S-TAB to navigate between jump points
local i_node = ls.insert_node
local extras = require("luasnip.extras")
-- basically multi-curors
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local c_node = ls.choice_node
-- lua function (i.e. lua api); see :h luasnip-functionnode
local f_node = ls.function_node
-- conditionally expand
local d_node = ls.dynamic_node
local s_node = ls.snippet_node

-- ls.add_snippets(
-- -- NOTE: use `set filetype` to get filetype
--   "lua",
--   {
--     snippet(
--     -- snippet name
--       "hello-{ $1 }",
--       -- table of code nodes
--       {
--         t_node('print("Hello, '),
--         i_node(1), -- first jump point
--         t_node('world'),
--         i_node(2), -- second jump point
--         t_node('!!!")'),
--       }
--     ),
--     snippet(
--       "function",
--       {
--         t_node("function "),
--         i_node(1),
--         t_node("("),
--         i_node(2),
--         t_node(")"),
--         t_node("\\n\\t"),
--         i_node(3),
--         t_node("\\nend"),
--       }
--     ),
--   }
-- )

-- for lazyvim to not complain about imports
return {}
