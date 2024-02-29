local M = {}

function M:peek()
	local cache = ya.file_cache(self)
	if not cache then
		return
	end

	if not self:preload() then
		return
	end

	local t = io.open(tostring(cache), "r")
	if t == nil then return 0 end
	local thumb = Url(t:read())
	t:close()

	ya.image_show(thumb, self.area)
	ya.preview_widgets(self, {})
end

function M:seek() end

function M:preload()
	local cache = ya.file_cache(self)
	if not cache or fs.cha(cache) then
		return 1
	end

	local output = Command("allmytoes")
		:args({ "-sxx", tostring(self.file.url) })
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not output.status:success() then
		ya.err(
			"Could not obtain thumbnail for " .. tostring(self.file.url)
			.. ". allmytoes output: " .. tostring(output.stderr)
		)
		return 0
	end

	local thumb = string.gsub(tostring(output.stdout), "\n", "")
	return fs.write(cache, thumb) and 1 or 2
end

return M
