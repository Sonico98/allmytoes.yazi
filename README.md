# Allmytoes.yazi

Generate and preview freedesktop-compatible thumbnails for images on [Yazi](https://github.com/sxyazi/yazi) with the power of [AllMyToes](https://gitlab.com/allmytoes/allmytoes).

## Installation

```sh
# Linux only
ya pkg add Sonico98/allmytoes.yazi

```

## Usage

Add the following to your `~/.config/yazi/yazi.toml` configuration file
<details>
<summary>yazi.toml: </summary>

```toml
[plugin]
prepend_previewers = [
	# Allmytoes doesn't handle these by default
	{ mime = "image/svg+xml", run = "magick" },
	{ mime = "image/heic",    run = "magick" },
	{ mime = "image/jxl",     run = "magick" },
	# Handle other image types with allmytoes
	{ mime = "image/*", run = "allmytoes" },
]

prepend_preloaders = [
	# Allmytoes doesn't handle these by default
	{ mime = "image/svg+xml", run = "magick" },
	{ mime = "image/heic",    run = "magick" },
	{ mime = "image/jxl",     run = "magick" },
	# Handle other image types with allmytoes
	{ mime = "image/*", run = "allmytoes" },
]


```
</details>

Make sure you have AllMyToes [installed](https://gitlab.com/allmytoes/allmytoes#installation) and in your PATH.

## Configuration
It's possible to decide which thumbnail sizes should be generated. Add the following to your `~/.config/yazi/init.lua` file:
```
require("allmytoes"):setup {
    -- By default, all sizes are generated. Remove the ones you don't need.
    sizes = {"n", "l", "x", "xx"},
}
```
Generating all sizes guarantees thumbnails will be instantly available for other clients that request freedesktop thumbs. This can, however, affect yazi's performance the first time a thumbnail has to be generated.

## Why would I want this instead of the default image previewer?

### Compatibility 

Because the thumbnails follow the freedesktop spec, they can be generated from any other application that follows the spec, like graphical file managers. This means you'll be able to re-use preexisting thumbnails between yazi and other programs.

### Fast

Once generated, yazi will display the largest thumbnail directly the next time you use it. It works just like how the default previewer caches images, but in a multi-application compatible way, and persistent across reboots by default.
