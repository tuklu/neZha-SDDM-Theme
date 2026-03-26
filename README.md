# neZha — SDDM Theme

A layered, minimal lockscreen aesthetic for SDDM with real-time clock, WiFi signal, battery, and keyboard layout indicators.

---

## Preview

> *(Add a screenshot here)*

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

If SF Pro is absent, the theme automatically falls back to **Inter Bold** (bundled).

#### Inter Bold *(bundled fallback)*

Already included — no action needed. Source: https://rsms.me/inter/

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

### Resolution

The root size defaults to `1920x1080`. If your display differs, edit `Main.qml` lines 9–10:

```qml
width: 1920   // px
height: 1080  // px
```

---

## Publishing a new release (maintainer notes)

When you update the assets, re-pack and attach them to the GitHub Release:

```bash
cd /path/to/neZha
tar -cJf assets.tar.xz -C assets background.jpg foreground.png middleOverlay.png
# then attach assets.tar.xz to the GitHub release
```

---

## License

MIT — see [LICENSE](LICENSE)

> The bundled images are part of the theme's visual design. If you redistribute this theme, replace them with your own assets or ensure you have the rights to share them.
