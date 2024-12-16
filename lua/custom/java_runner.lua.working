-- lua/custom/java_runner.lua

local M = {}

-- Function to open a floating window with output
local function open_floating_output_window(output)
  local buf = vim.api.nvim_create_buf(false, true)  -- Create a new scratch buffer

  -- Define window options (size, position, border)
  local opts = {
    relative = 'editor',
    width = 80,
    height = 20,
    col = 10,
    row = 5,
    border = 'single',
  }

  -- Set the lines of the buffer to the output
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, '\n'))

  -- Open the floating window
  local win_id = vim.api.nvim_open_win(buf, true, opts)

  -- Map the 'q' key to close the floating window
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })

  -- You can also map other keys if you want additional behavior (e.g., ESC to close)
  -- vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { noremap = true, silent = true })
end

-- Function to compile and run Java, showing output in floating window
M.compile_and_run_java_with_floating_output = function()
  -- Get the current file's absolute path and filename
  local file_dir = vim.fn.expand('%:p:h')  -- Directory of the current file
  local filename = vim.fn.expand('%:t')   -- Filename (including extension)
  local classname = vim.fn.expand('%:t:r')  -- Classname (filename without extension)

  -- Get the absolute path to the file
  local file_path = vim.fn.expand('%:p')

  -- Debugging: Print the current directory and file path
  print("Current directory: " .. file_dir)
  print("Filename: " .. filename)
  print("Full file path: " .. file_path)

  -- Check if the file exists
  if vim.fn.filereadable(file_path) == 0 then
    open_floating_output_window("Error: File does not exist: " .. file_path)
    return
  end

  -- Ensure we're in the correct directory
  vim.fn.chdir(file_dir)

  -- Debugging: Print current directory to check where we're running the command
  print("Working directory: " .. vim.fn.getcwd())

  -- Absolute path to the Java source file for `javac`
  local abs_file_path = vim.fn.expand('%:p')

  -- Compile the Java file using absolute path (ensuring .java extension for javac)
  local compile_cmd = string.format("javac --release 21 --enable-preview '%s'", abs_file_path)
  print("Running compile command: " .. compile_cmd)  -- Debugging

  -- Run compile command using :! (shell command)
  vim.cmd('! ' .. compile_cmd)

  -- Capture the output and show it in a floating window
  local compile_output = vim.fn.system(compile_cmd)

  -- Debugging: Show compile output (even if empty)
  print("Compile output: " .. compile_output)

  -- Display compilation errors if any
  if vim.fn.empty(compile_output) == 0 then
    open_floating_output_window("Compilation failed:\n" .. compile_output)
    return
  end

  -- Run the Java program (with the .java extension)
  local run_cmd = string.format("java --source 21 --enable-preview '%s.java'", classname)
  print("Running run command: " .. run_cmd)  -- Debugging

  -- Run the Java program using :! (shell command)
  vim.cmd('! ' .. run_cmd)

  -- Capture the run output
  local run_output = vim.fn.system(run_cmd)

  -- Debugging: Show run output
  print("Run output: " .. run_output)

  -- Display the output in a floating window
  open_floating_output_window(run_output)
end

return M
