local function build()
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

local function get_package_name(callback)
    -- This is async because i could not find a better way to get clean results.
    -- There is room for improvement.
    -- 1. Print the content of pacakge.py
    -- 2. Find the first line starting with: "name ="
    -- 3. Remove the part before the name
    -- 4. Remove the part after the name
    local name_cmd =
        [[ rez-build --view-pre | grep -m 1 "name\s*=\s*.*" | sed "s/^name\s*=\s*['\"]//" | sed "s/\s*['\"]\s*$//"]]

    local pkg_name = nil
    vim.fn.jobstart(name_cmd, {

        -- Store the package name
        on_stdout = function(job_id, data, event)
            table.remove(data)
            if #data == 1 then
                pkg_name = data[1]
            end
        end,

        -- Return value
        on_exit = function(id, exitcode, event)
            callback(pkg_name)
        end,
    })
end

local function clear_build()
    vim.notify("Removing build ...", vim.log.levels.INFO)

    local pkg_name = nil
    get_package_name(function(name)
        pkg_name = name

        if not pkg_name then
            vim.notify(" Could not get name of package at: " .. vim.fn.getcwd(), vim.log.levels.ERROR)
            return
        end

        vim.notify("Package Name: " .. pkg_name, vim.log.levels.INFO)
        local plen_path = require "plenary.path"
        local build_path = "~/packages/" .. pkg_name
        build_path = plen_path:new(build_path):expand()
        vim.notify("Build Path: " .. build_path, vim.log.levels.INFO)

        if plen_path:new(build_path):is_dir() then
            vim.fn.system { "rm", "-rf", build_path }
            vim.api.nvim_echo({ { " Build Removed: " .. build_path, "Normal" } }, true, {})
        else
            vim.notify(" Build already removed: " .. build_path, vim.log.levels.DEBUG)
        end
    end)
end

return { build = build, clear_build = clear_build }
