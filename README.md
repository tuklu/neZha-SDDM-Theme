# neZha — SDDM Theme

A layered, minimal lockscreen aesthetic for SDDM with real-time clock, WiFi signal, battery, and keyboard layout indicators, designed to pair with the [neZha-Hyprlock-Theme Theme](https://github.com/tuklu/neZha-Hyprlock-Theme).

---

## Preview

![neZha SDDM theme](assets/screenshot.png)

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/tuklu/neZha /usr/share/sddm/themes/neZha
cd /usr/share/sddm/themes/neZha
```

### 2. Download the assets

The background and overlay images are too large for git — download them from the [latest GitHub Release](https://github.com/tuklu/neZha/releases/latest):

```bash
# Download and extract into the assets/ folder
wget https://github.com/tuklu/neZha/releases/latest/download/assets.tar.xz
tar -xJf assets.tar.xz -C assets/
rm assets.tar.xz
```

After this, `assets/` should contain:

```
assets/
  background.jpg
  foreground.png
  middleOverlay.png
```

### 3. Get the fonts

#### SF Pro Display Bold *(not bundled — Apple proprietary)*

This theme is designed for **SF Pro Display Bold**. To use it:

1. Download from the [Apple Developer page](https://developer.apple.com/fonts/) (free, requires Apple account)
2. Place `SF-Pro-Display-Bold.otf` into the `fonts/` directory

If SF Pro is absent, the theme falls back to the system `sans-serif` font.

### 4. Enable the theme

```bash
# /etc/sddm.conf  or  /etc/sddm.conf.d/theme.conf
[Theme]
Current=neZha
```

---

## Configuration

Edit `theme.conf` to swap assets or change the text color:

```ini
[General]
background=assets/background.jpg
middleOverlay=assets/middleOverlay.png
foreground=assets/foreground.png
text_color=#b3ffffff
```

### Resolution and scaling

The theme uses a `1600x1000` design canvas, but it now reads SDDM's actual `Screen.width` and `Screen.height` at runtime and scales the clock, foreground, login form, and status bar proportionally.

If the theme appears too large after an SDDM, Qt, or Arch update, check what the greeter reports:

```bash
sddm-greeter --test-mode --theme /path/to/neZha
# look for: Adding view for "..." QRect(0,0 WxH)
```

On HiDPI displays, SDDM may report logical pixels rather than physical pixels. The QML should adapt automatically, so you should not need to edit `Main.qml` for each monitor.

If the installed greeter still looks zoomed while test mode looks correct, check for SDDM-level scaling overrides in `/etc/sddm.conf`, `/etc/sddm.conf.d/*.conf`, or `/usr/share/sddm/scripts/Xsetup`, such as `QT_SCALE_FACTOR`, `QT_SCREEN_SCALE_FACTORS`, or `QT_AUTO_SCREEN_SCALE_FACTOR`.

---

## Publishing a new release (maintainer notes)

When you update the assets, re-pack and attach them to the GitHub Release:

```bash
cd /path/to/neZha
tar -cJf assets.tar.xz -C assets background.jpg foreground.png middleOverlay.png
# then attach assets.tar.xz to the GitHub release
```

---

## HiDPI & Qt environment

SDDM needs one env var set for the WiFi/battery status to work (Qt 6 deprecated file reads via XMLHttpRequest):

```bash
sudo mkdir -p /etc/sddm.conf.d
echo -e "[Environment]\nQML_XHR_ALLOW_FILE_READ=1" | sudo tee /etc/sddm.conf.d/env.conf
```

Without this, status bar icons will still show but may stop working in a future Qt update.

---

## License

MIT — see [LICENSE](LICENSE)

> The bundled images are part of the theme's visual design. If you redistribute this theme, replace them with your own assets or ensure you have the rights to share them.
