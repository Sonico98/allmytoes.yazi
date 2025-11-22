local options = ya.sync(
	function(state)
		return {
			sizes = state.sizes or { "n", "l", "x", "xx" },
		}
	end
)

local M = {}

function M:peek(job)
	local cache = ya.file_cache(job)
	if not cache then
		return
	end

	local ok, err = self:preload(job)
	if not ok or err then
		return ya.preview_widget(job, err)
	end

	local t = io.open(tostring(cache), "r")
	if t == nil then return 0 end
	local thumb = Url(t:read())
	t:close()

	local _, err = ya.image_show(thumb, job.area)
	ya.preview_widget(job, err)
end

function M:seek() end -- TODO? Iterate through all different sized previews

function M:setup(args)
	self.sizes = args and args.sizes
end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end

	-- Helper function to check if a value exists in a list
	local function has_value(tbl, val)
		for _, v in ipairs(tbl) do
			if v == val then return true end
		end
		return false
	end

	local opt_sizes = options().sizes

	-- Determine which thumbnail size should be used in the preview
	local all_sizes = { "n", "l", "x", "xx" }
	local biggest_size = nil
	for _, size in ipairs(all_sizes) do
		if has_value(opt_sizes, size) then biggest_size = size end
	end

	local thumb_to_display = nil
	for _, size in ipairs(opt_sizes or all_sizes) do
		local output = Command("allmytoes")
			:arg({ "-s" .. size, tostring(job.file.url) })
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:output()

		if output.status.success then
			if size == biggest_size then
				thumb_to_display = string.gsub(tostring(output.stdout), "\n", "")
			end
		else
			ya.err(
				"Could not obtain " .. size .. " thumbnail for " .. tostring(job.file.url)
				.. ". allmytoes output: " .. tostring(output.stderr)
			)
		end
	end

	if thumb_to_display ~= nil then
		return fs.write(cache, thumb_to_display) and true or false
	else
		return false
	end
end

return M
