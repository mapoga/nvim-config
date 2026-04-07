local function rez_build()
    -- Update progress message every tick of the spinner.
    spinner = require("configs.spinner").Spinner:new {
        on_incr = function(opts)
            local spin_str = opts.spinner:frame()
            vim.api.nvim_echo({ { spin_str .. " Building Rez Package " .. spin_str, "Normal" } }, false, {})
        end,
    }

    -- Command
    -- local cmd = { "sleep", "2" }
    local cmd = { "rez", "build", "-ic" }

    -- Launch in Background
    local stack_trace = ""
    vim.fn.jobstart(cmd, {

        -- Accumulate error messages
        on_stderr = function(job_id, data, event)
            table.remove(data)
            stack_trace = stack_trace .. "\n" .. table.concat(data, "\n")
        end,

        -- Stop spinner and print final message.
        on_exit = function(id, exitcode, event)
            spinner:stop()
            if exitcode == 0 then
                vim.api.nvim_echo({ { " Package Build Complete ", "DiagnosticOk" } }, true, {})
            else
                vim.notify(stack_trace .. "\n" .. " Package Build Failed ", vim.log.levels.ERROR)
            end
        end,
    })

    -- Only start if the command did not throw an error right away.
    spinner:start()
end

return { rez_build = rez_build }
