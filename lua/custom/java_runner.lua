local M = {}

-- Function to open a floating window with output
local function open_floating_output_window(output)
  local buf = vim.api.nvim_create_buf(false, true)  -- Create a new scratch buffer

  -- Define window options (size, position, border)
  local opts = {
    relative = 'editor',
    width = 120,
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
end

-- Function to compile and run Java, showing output in floating window
M.compile_and_run_java_with_floating_output = function()
  -- Get the current file's absolute path and filename
  local file_dir = vim.fn.expand('%:p:h')  -- Directory of the current file
  local filename = vim.fn.expand('%:t')   -- Filename (including extension)
  local classname = vim.fn.expand('%:t:r')  -- Classname (filename without extension)

  -- Get the absolute path to the file
  local file_path = vim.fn.expand('%:p')

  -- Ensure we're in the correct directory
  vim.fn.chdir(file_dir)

  -- Check if the file exists
  if vim.fn.filereadable(file_path) == 0 then
    open_floating_output_window("Error: File does not exist: " .. file_path)
    return
  end

  -- Absolute path to the Java source file for `javac`
  local abs_file_path = vim.fn.expand('%:p')

  -- Compile the Java file using absolute path (ensuring .java extension for javac)
  local compile_cmd = string.format("javac --release 21 --enable-preview '%s'", abs_file_path)

  -- Run compile command using vim.fn.system (captures output)
  local compile_output = vim.fn.system(compile_cmd)

  -- If there are any compilation errors, show them in the popup
  if vim.fn.empty(compile_output) == 0 then
    -- There was an error during compilation, show error output in the popup
    open_floating_output_window("Compilation failed:\n" .. compile_output)
    return
  end

  -- Now run the Java program (with the .java extension)
 local run_cmd = string.format("java --source 21 --enable-preview '%s.java'", classname)

  -- Run the Java program and capture its output (stdout and stderr)
  local run_output = vim.fn.system(run_cmd)

  -- If the run command produced output, display it in the popup window
  if vim.fn.empty(run_output) == 0 then
    open_floating_output_window(run_output)
  else
    -- If no output from running the program, show a message indicating success
    open_floating_output_window("Program executed successfully, but no output was returned.")
  end
end

return M
