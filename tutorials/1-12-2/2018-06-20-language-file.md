---
layout: post
title: Language File
date: 2018-06-20
---

Currently, our item and block display their names as "item.tutorialmod.first_item.name" and "tile.tutorialmod.first_block.name". Obviously, we want them to display as something more like "First Item" or "First Block". This is done through the use of language files. Each language in the Minecraft language menu corresponds to different file, which translates the code-like names into something more human-readable. These files go in the `assets/tutorialmod/lang` folder. Create a file there named `en_us.lang`.
```
# Items
item.tutorialmod.first_item.name=First Item

# Blocks
tile.tutorialmod.first_block.name=First Block
```
Each line in this file corresponds to a block, item, or anything else that we need to name later on (like creative tabs).

We also need to add a file named `pack.mcmeta` in `src/main/resources`.
```JSON
{
	"pack": {
		"pack_format": 3,
		"description": "Resources for cubicoder's tutorial mod.",
		 "_comment": "A pack_format of 3 should be used starting with Minecraft 1.11. All resources, including language files, should be lowercase (eg: en_us.lang). A pack_format of 2 will load your mod resources with LegacyV2Adapter, which requires language files to have uppercase letters (eg: en_US.lang)."
	}
}
```
This tells Minecraft to use the new resource pack format for our resources.

That’s all for language files!
![lang0](/img/6lang/lang0.png)
