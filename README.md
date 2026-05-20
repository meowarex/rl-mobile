# Radiant Lyrics Mobile

A Manager app for Android that patches TIDAL to bring the Radiant Lyrics experience to mobile.

## What it does

- Blurred album art background in the player
- Progress pill overlay in lyrics mode - restored from old UI
- Hides the ugly cover art when in lyrics mode
- Syllable Level lyrics (SoonTM)


### Disclaimer

This project is not affiliated with TIDAL in any way. Use at your own risk.
- I can't guarantee using this project won't result in any platform enforcement **(Bans)**

## Installation

### Batteries <3
- Android 10.0+ & >340 DPI
- Paid TIDAL Account

### Steps
1. Download the latest `rl-manager.apk` from [Releases](../../releases/latest)
2. Install it (allow unknown sources if prompted)
3. Open the Manager & follow the instructions in the app
4. Install the patched TIDAL APK when prompted
5. You might need to disable Play Protect (might not be required so just ignore if you don't see a warning prompt)

## Building from Source

```bash
git clone https://github.com/meowarex/rl-mobile
cd rl-mobile/Manager
./gradlew :app:assembleDebug
```

## How Patching Works

The Manager downloads the TIDAL APK, disassembles it with baksmali, applies each `.patch` file in `patches/` as a unified diff against the matching smali class, reassembles, and repacks the APK.

Each patch file targets a specific class via its `--- a/` header — the filename itself is just for readability.

## Contributing Patches

### Adding a new patch

1. Disassemble TIDAL with apktool:
   ```bash
   apktool d tidal.apk -o tidal-src
   ```

2. Copy the target smali file and edit it:
   ```bash
   cp tidal-src/smali_classesX/com/tidal/.../Target.smali Target.smali.orig
   # make your changes to Target.smali
   ```

3. Generate the patch:
   ```bash
   diff -u Target.smali.orig Target.smali \
     --label a/com/tidal/.../Target.smali \
     --label b/com/tidal/.../Target.smali \
     > patches/my-feature.patch
   ```

4. Test it applies cleanly:
   ```bash
   cp Target.smali.orig Target.smali
   patch -p1 < patches/my-feature.patch
   ```

### Rules for patches
- The `--- a/` header must be the full smali class path relative to the dex root (e.g. `com/tidal/android/feature/...`)
- Patches apply sequentially in filename order — if your patch touches a file another patch already modifies, make sure the context lines still match after the prior patch
- No new helper classes — the patcher only edits existing APK classes
- Keep patches focused: one feature per file
- Comment EACH patch line on the end with a simple 1-5 word description of what it does/or is for
- Make sure the patch file name is descriptive of what it does

### Submitting
Fork the repo, add your patch to `patches/`, and open a PR describing what it changes and why.
- Patch PR should be prefixed with `[patch]` in the title

## Credits

Inrixia — TidaLuna framework
