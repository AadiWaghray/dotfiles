require'otter'.activate({'python', 'C'}, true, true)

--Wishlsit: 
--Create links to file
---wrap text in delimiters(x)
---write selection+.md
---go to file in delimiters
--Journal 
---create command: Create entry in journal file with date
---persistent todo/ top keep section
---dump section to isolate from feelings to isolate from calendar
--Preview files: I want to be able to compose notes in an obsidian manner
--Images(?)
--Figure out a nicer way to naviagtes notes. I don't like the atomicity of Obsidian, but I want reusability

--Create links to file
--The start and end positions of visual selections are stored in < and > marks . You can retrive the locations from those marks with nvim_buf_get_mark in the lua function.

--assumes called from normal mode
local function create_link()
	--assert(vim.fn.mode() == "v", "link creation ftplugin: mode is not visual");
	vim.api.nvim_input("viw")

	local start_mark = vim.api.nvim_buf_get_mark(0, "<")
	local end_mark = vim.api.nvim_buf_get_mark(0, ">")
	if start_mark[1] == 0 and start_mark[2] == 0 then 
		error("link creation ftplugin: visual selection failure")
	end
	if end_mark[1] == 0 and end_mark[2] == 0 then 
		error("link creation ftplugin: visual selection failure")
	end

	local file_name = vim.api.nvim_buf_get_text(0, 
		start_mark[1] - 1,
		start_mark[2] + 1,
		end_mark[1] - 1,
		end_mark[2] + 1)

	print("start")

	vim.api.nvim_buf_set_text(0,
		start_mark[1] - 1,
		start_mark[2],
		start_mark[1] - 1,
		start_mark[2],
		{"("});
	vim.api.nvim_buf_set_text(0,
		end_mark[1] - 1,
		end_mark[2] + 2,
		end_mark[1] - 1,
		end_mark[2] + 2,
		{")"});	
	vim.api.nvim_buf_set_text(0,
		end_mark[1] - 1,
		end_mark[2] + 3,
		end_mark[1] - 1,
		end_mark[2] + 3,
		{"["});	
	vim.api.nvim_buf_set_text(0,
		end_mark[1] - 1,
		end_mark[2] + 4,
		end_mark[1] - 1,
		end_mark[2] + 4,
		{file_name});	
	vim.api.nvim_buf_set_text(0,
		end_mark[1] - 1,
		end_mark[2] + 5,
		end_mark[1] - 1,
		end_mark[2] + 5,
		{"]"});	
end

create_link()

vim.keymap.set({"v"}, "<C-p>", function() create_link() end, {silent = true})
