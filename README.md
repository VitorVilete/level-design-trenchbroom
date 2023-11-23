![](https://raw.githubusercontent.com/Shfty/qodot-extras/master/graphics/qodot_logo_small.png)

Quake *.map* file support for Godot 4.x. **For the original Godot 3.x plugin, see [Qodot-Plugin](https://github.com/QodotPlugin/qodot-plugin/).**

# Before you enable Qodot

1. [Use Godot Engine .NET / mono build](https://godotengine.org/download/). **You can still use GDScript with .NET build.**
![godot_dl](https://github.com/QodotPlugin/Qodot/assets/47726614/7a831e4b-dc85-43d5-bb70-e4369d7650da)
2. [Download 7.0 .NET SDK](https://dotnet.microsoft.com/en-us/download) and run the 7.0 SDK installer.
![dotnet_dl](https://github.com/QodotPlugin/Qodot/assets/47726614/18d82487-c66b-47d8-83fc-bc7322720d85)
3. In your Godot Project, go to Project > Tools > C# > Create C# Solution.
![csharpsol](https://github.com/QodotPlugin/Qodot/assets/47726614/6f6f71f7-0db0-4ae9-9acb-81827706675b)
4. Build your C# scripts by pressing <kbd>Alt</kbd> + <kbd>B</kbd>, or click the square *Build* button in the top-right corner.
![image](https://github.com/QodotPlugin/Qodot/assets/47726614/af88e7a0-a6da-43dd-bc8f-50b6877a799a)
5. Go to Project > Project Settings > Plugins, then enable Qodot.

If plugin errors appear when you enable the plugin, restart the engine first. If any plugin errors persist after a restart, please [make an issue](https://github.com/QodotPlugin/Qodot/issues/new).

To bring back the "Full Build" toolbar, press <kbd>Alt</kbd> + <kbd>B</kbd> and re-select your QodotMap node.

# About this version

Latest Tested Engine Version: **4.1.1.stable.mono**

This is a port of Qodot to Godot 4.x. It requires the .NET build of Godot to import maps correctly. Games can still be exported with the standard editor/export templates.

Unlike [Qodot-plugin](https://github.com/QodotPlugin/qodot-plugin/), this [Qodot](https://github.com/QodotPlugin/Qodot/) repository is currently the official version of the plugin and where active development continues. You can also find the plugin on Godot's Asset Library.

## Documentation

We have official [Qodot Documentation](https://qodotplugin.github.io/). The docs are undergoing maintenance, so feel free to ask questions in [Issues](https://github.com/QodotPlugin/Qodot/issues) or the [Official Discord](https://discord.gg/c72WBuG).

## Overview

Qodot extends the Godot editor to import Quake *.map* files, and provides a data-driven framework for converting the entities and brushes contained therein into a custom node hierarchy.

![](https://raw.githubusercontent.com/wiki/Shfty/qodot-plugin/images/2-usage/in-editor.gif)

## Features

- Natively import `.map` files into Godot and convert them into a usable scene tree
- Supports
  - Brush geometry
  - Textures and customized UVs
  - Convex and concave collision volumes
  - Gameplay entities
  - FGD (Forge Game Data) export for custom game definitions
- Configurable scene population
  - Leverages the map format's classname and key/value property systems
  - Spawn and configure custom Godot scenes and scripts based on entities defined in the map editor
  - Define the visual and collision properties of brush entities on a per-classname basis
- TrenchBroom Integration
  - Simple, intuitive map editor with a strong feature set
  - TrenchBroom game configurations can be exported for tighter workflow integration
  - Nested TrenchBroom groups can be used to build a tree hierarchy from the format's standard flat structure

## Showcase

[![](https://raw.githubusercontent.com/Shfty/qodot-extras/master/showcase/sunkper-props-thumbnail.jpg)](https://raw.githubusercontent.com/Shfty/qodot-extras/master/showcase/sunkper-props.jpg)

Assorted props by [@SunkPer](https://twitter.com/SunkPer)

[![](https://raw.githubusercontent.com/Shfty/qodot-extras/master/showcase/sunkper-summer-island.gif)](https://cdn.app.com/attachments/651209074930876416/659427504309796876/Project_Summer_Island_WIP_25.mp4)

Summer Island by [@SunkPer](https://twitter.com/SunkPer)

## Thesis

Qodot was created to solve a long-standing problem with modern game engines: The lack of simple, accessible level editing functionality for users without 3D modeling expertise.

Unity, Unreal and Godot are all capable of CSG to some extent or other with varying degrees of usability, but lack fine-grained direct manipulation of geometry, as well as per-face texture and UV manipulation. It's positioned more as a prototyping tool to be used ahead of a proper art pass than a viable methodology.

Conversely, dedicated 3D modeling packages like Maya or Blender are very powerful and can iterate fast in experienced hands, but have an intimidating skill floor for users with a programming-focused background that just want to build levels for their game.

Enter the traditional level editor: Simple tools built for games like Doom, Quake and Duke Nukem 3D that operate in the design language of a video game and are created for use by designers, artists and programmers alike. Thanks to years of community support, classic Quake is still alive, kicking, and producing high-quality content and mapping software alike. This continued popularity combined with its simplicity means the Quake *.map* format presents a novel solution.

## Extra Content

[The Qodot extra content repository](https://github.com/Shfty/qodot-extras) contains a set of additional resources, such as map editor plugins, logo graphics, showcase content and screenshots.

## Qodot Elsewhere

[Discord - Qodot](https://discord.gg/c72WBuG)

[Reddit - Qodot](https://www.reddit.com/r/godot/comments/e41ldk/qodot_quake_map_file_support_for_godot/)

[Godot Asset Library - Qodot 3.x](https://godotengine.org/asset-library/asset/446)

## Credits

[Josh "Shifty" Palmer](https://twitter.com/ShiftyAxel) - Original Qodot plugin

[Hannah "EMBYR" Crawford](https://embyr.sh/) - Godot 4.x & C# port & maintainance

[Emberlynn Bland](https://github.com/deertears/) - Starting the docs & community support & maintenance

[Kristian Duske](https://twitter.com/kristianduske) - For creating TrenchBroom and inspiring the creation of Qodot

Arkii - For example code and handy documentation of the Valve 220 format

[TheRektafire](https://github.com/TheRektafire) - For a variety of useful tidbits on the .map format

[Calinou](https://github.com/Calinou) - For making Qodot work on case-sensitive systems

[SunkPer](https://twitter.com/SunkPer) - For showcase screenshots

[lordee](https://github.com/lordee), [DistractedMOSFET](https://github.com/distractedmosfet) and winadam- For laying the groundwork of the FGD export and entity scripting systems.

[fossegutten](https://github.com/fossegutten) - For a typed GDScript pass

[Corruptinator](https://github.com/Corruptinator) - For the idea of using TrenchBroom groups as a scene tree.

[grenappels](https://github.com/grenappels) - For implementing smoothed brush normal edge splitting

[FreePBR.com](https://freepbr.com) - For royalty-free PBR example textures
