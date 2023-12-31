
vim.g.REPL_iPython_pane_id = 2
vim.g.REPL_NodeJs_pane_id = 2


vim.api.nvim_create_user_command(
    'REPLSetiPythonPaneId',
    function (opts)
        local pane_id = opts.fargs[1]
        if tonumber(pane_id) < 2 then
            return
        end
        vim.g.REPL_iPython_pane_id = pane_id
    end,
    {nargs = 1}
)
vim.api.nvim_create_user_command(
    'REPLSetNodeJsPaneId',
    function (opts)
        local pane_id = opts.fargs[1]
        if tonumber(pane_id) < 2 then
            return
        end
        vim.g.REPL_NodeJs_pane_id = pane_id
    end,
    {nargs = 1}
)


local send_code = function (pane_id)
    -- local pane_id = vim.g.REPL_iPython_pane_id
    local mode = vim.api.nvim_get_mode().mode
    local v_line = vim.fn.line('v')
    local curs = vim.api.nvim_win_get_cursor(0)
    local c_line = curs[1]
    if mode ~= 'n' and v_line == c_line then
        local s_col, e_col
        local v_col = vim.fn.col('v')
        local c_col = curs[2]
        if v_col < c_col then
            s_col, e_col = v_col-1, c_col+1
        else
            s_col, e_col = c_col, v_col
        end
        local line = vim.api.nvim_buf_get_text(0, v_line-1, s_col, c_line-1, e_col, {})[1]
        vim.cmd('!tmux send-keys -t ' .. pane_id .. ' "' .. line:gsub('"', '\\"') .. '" Enter')
    else
        local indent_min = 100
        local indent_last
        for _, line in ipairs(vim.api.nvim_buf_get_lines(0, v_line - 1, c_line, false)) do
            if line:gsub('^%s+', '') ~= '' then 
                _, indent_last = string.find(line, '^%s*')
                indent_min = math.min(indent_min, indent_last)
                vim.cmd('!tmux send-keys -t ' .. pane_id .. ' "' .. line:gsub('"', '\\"') .. '" Enter')
            end
        end
        if indent_last > indent_min then vim.cmd('!tmux send-keys -t ' .. pane_id .. ' Enter') end
    end
    vim.api.nvim_input('<esc>')
end 

vim.keymap.set(
    { 'v', 'n' }, 
    '<C-i>', 
    function () send_code(vim.g.REPL_iPython_pane_id) end,
    { desc = 'Send code to iPython REPL' }
)

vim.keymap.set(
    { 'v', 'n' }, 
    '<C-o>', 
    function () send_code(vim.g.REPL_NodeJs_pane_id) end,
    { desc = 'Send code to iPython REPL' }
)




