# Hytale mod template

A bare Hytale server plugin: Gradle build, hytale-tools (dev server and manifest), hytale-publisher, and a
GitHub Action, with Configly and Patchly bundled. It contains one class, the plugin entry point.

This file and `init.sh` delete themselves when you run `init.sh`.

## Starting a new mod

```bash
cp -r ~/Documents/Hytale/template ~/Documents/Hytale/mymod
cd ~/Documents/Hytale/mymod
./init.sh MyMod "One-line description"
./gradlew build
```

`init.sh` replaces every placeholder:

| Placeholder | Becomes | Where |
| --- | --- | --- |
| `Template` | `MyMod` | main class, mod id, mod name, jar name, GitHub URLs, README title |
| `template` | `mymod` | package `com.riprod.mymod`, artifact id, shaded-lib package |
| `__DESCRIPTION__` | your description | gradle.properties, manifest.json, README |

It also deletes the template's `.git` (history and remote) and any copied `bin/`, `build/` and `.gradle/`,
then creates a fresh git repo on `main` with nothing committed. Add your own remote after.

## After init

- **Publishing:** put the Modtale UUID, Modifold ID and CurseForge ID in `gradle.properties`, then set
  `enabled = true` for each platform in the `hytalePublisher` block in `build.gradle`. Add the matching
  secrets (`MODTALE_KEY`, `CURSE_KEY`, `MODIFOLD_KEY`) to the GitHub repo. Pushing a `v*` tag publishes.
- **Assets:** if the mod ships anything under `src/main/resources/Common` or `Server`, set
  `includes_pack = true` in `gradle.properties`.
- **Bundled libs:** Configly and Patchly are shaded into the jar and relocated to
  `com.riprod.<mod>.shaded.*`. Delete the line in `dependencies` and `hytalePublisher` for any library
  the mod doesn't use.
- **Icon:** replace `src/main/resources/icon-256.png` (a placeholder "T").
- **Version / authors / description:** edit `gradle.properties` only. The build regenerates
  `manifest.json` from it (the manifest `Authors` list comes from `mod_credits`).
- **Empty CurseForge ID:** until `curseforgeID` is set, the built manifest has an empty
  `UpdateChecker.CurseForge` entry. It disappears once the ID is filled in.
