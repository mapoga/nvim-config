local Path = require "plenary.path"

local function build_cwd()
    -- Run "rez build -ic" on the current working directory.

    -- Updates the progress message every 10th of a second.
    -- This is to animate the spinner.
    spinner = require("configs.spinner").Spinner:new {
        on_incr = function(opts)
            local spin_str = opts.spinner:frame()
            vim.api.nvim_echo({ { spin_str .. " Building Rez Package " .. spin_str, "Normal" } }, false, {})
        end,
    }

    -- Launch command in the background.
    local cmd = { "rez", "build", "-ic" }
    local errors = ""
    local result = vim.fn.jobstart(cmd, {

        -- Accumulate errors
        on_stderr = function(job_id, data, event)
            table.remove(data) -- Remove the last element since its always empty.
            errors = errors .. "\n" .. table.concat(data, "\n")
        end,

        -- Stop the spinner and print the final message.
        on_exit = function(id, exit_code, event)
            spinner:stop()
            if exit_code == 0 then
                vim.api.nvim_echo({ { " Package Build Complete ", "DiagnosticOk" } }, true, {})
            else
                vim.notify(errors .. "\n" .. " Package Build Failed ", vim.log.levels.ERROR)
            end
        end,
    })

    -- Only start the animation if the command did not throw an error right away.
    if result > 0 then
        spinner:start()
    end
end

local function get_cwd_name(callback)
    -- Returns the package name of the current source directory.
    -- Currently async because i could not find a better way to get clean outputs.
    -- There is room for improvement.

    -- Pipes:
    -- 1. Print the content of pacakge.py
    -- 2. Find the first line starting with: "name ="
    -- 3. Remove the part before the name
    -- 4. Remove the part after the name
    local cmd =
        [[ rez-build --view-pre | grep -m 1 "name\s*=\s*.*" | sed "s/^name\s*=\s*['\"]//" | sed "s/\s*['\"]\s*$//"]]

    local name = nil
    vim.fn.jobstart(cmd, {

        -- Store the package name
        on_stdout = function(job_id, data, event)
            table.remove(data)
            if #data == 1 then
                name = data[1]
            end
        end,

        -- Return value
        on_exit = function(id, exit_code, event)
            callback(name)
        end,
    })
end

local function clear_cwd_build()
    -- Removes the local build of the current source directory.

    vim.notify("Removing build ...", vim.log.levels.INFO)
    get_cwd_name(function(name)
        -- Package name could not be found.
        -- Most likely not in a source directory.
        -- Abort.
        if not name then
            vim.notify(" Could not find source package at: " .. vim.fn.getcwd(), vim.log.levels.ERROR)
            return
        end

        -- Get the local build path.
        vim.notify("Package Name: " .. name, vim.log.levels.INFO)
        local build_path = "~/packages/" .. name
        build_path = Path:new(build_path):expand()
        vim.notify("Build Path: " .. build_path, vim.log.levels.INFO)

        -- Remove the directory if it exists.
        if Path:new(build_path):is_dir() then
            vim.fn.system { "rm", "-rf", build_path }
            vim.api.nvim_echo({ { " Build Removed: " .. build_path, "Normal" } }, true, {})
        else
            vim.notify(" Build already removed: " .. build_path, vim.log.levels.DEBUG)
        end
    end)
end

return { build_cwd = build_cwd, clear_cwd_build = clear_cwd_build }
