local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("lua", {
	s("snip", fmt([[s("{}", "{}")]], {
	    i(1, "trigger"),
		i(2, "expansion")
	})),
	s("fsnip", fmt([[
	s("{}", fmt([[
		{}
	\]\], {{
		{}
	}})),
	]],{
		i(1, "trigger"), 
		i(2, "expansion"),
		i(3, "nodes"),
	})),
	s("lsnip", fmt([[
	ls.add_snippets("{}", {{
		{}
	}})
	]], {
		i(1, "expansion"),
		i(2, "expansion")
	})), 
	--HTML snip in progress
	s({trig="<%a*>", regTrig=true}, fmt([[
	<{}>
		{}
	<{}>
	]], {
		f(function(_, snip)
			return snip.captures[0]
		end, 2),
		i(1, "body"),
		rep(2),
	}))
})

ls.add_snippets("html", {
	s("html", fmt([[
	<!DOCTYPE html>
		<html lang="en">
		<head>
			<title></title>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<link href="css/style.css" rel="stylesheet">
		</head>
	</html>
	]], {})),
	s("<", fmt([[
	<{}>
		{}
	</{}>
	]], {
		i(1, "tag"),
		i(2, "body"),
		rep(1),
	})),
})
