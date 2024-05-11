# Allmytoes.yazi

Generate and preview freedesktop-compatible thumbnails for images on [Yazi](https://github.com/sxyazi/yazi) with the power of [AllMyToes](https://gitlab.com/allmytoes/allmytoes).

## Installation

```sh
# Linux only
git clone https://github.com/Sonico98/allmytoes.yazi.git ~/.config/yazi/plugins/allmytoes.yazi

```

## Usage

For the time being, it's recommended to follow [these steps](https://github.com/Sonico98/allmytoes.yazi/issues/1#issuecomment-2052600806) instead.
<details>
<summary>Old instructions, not working for now</summary>
Add this to your `yazi.toml`:

```toml
[[plugin.prepend_previewers]]
mime = "image/*"
exec = "allmytoes"

[[plugin.prepend_preloaders]]
mime = "image/*"
exec = "allmytoes"
```
</details>

Make sure you have AllMyToes [installed](https://gitlab.com/allmytoes/allmytoes#installation) and in your PATH.

## Why would I want this instead of the default image previewer?

### Compatibility 

Because the thumbnails follow the freedesktop spec, they can be generated from any other application that follows the spec, like graphical file managers. This means you'll be able to re-use preexisting thumbnails between yazi and other programs.

### Fast

Once generated, yazi will display the largest thumbnail directly the next time you use it. It works just like how the default previewer caches images, but in a multi-application compatible way, and persistent across reboots by default.
In my limited, not benchmarked tests, I could notice faster image previews in directories containing multiple large images using allmytoes than with the default previewer.

