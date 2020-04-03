---
layout: post
title: First Block
date: 2018-06-20
---

Now that we’ve added a basic item, let’s add a basic block. The process for this is very similar to adding an item. The only difference is that we actually have to add a block and an item. This is because a block in Minecraft exists in two places: in the world, as a `Block`, and in the inventory as an `ItemBlock`, which is an item that corresponds to a `Block`. Let’s get started! 

Begin by creating a new class in `cubicoder.tutorialmod.init` named `ModBlocks`. This will be exactly like the `ModItems` class, except for blocks.

```java
package cubicoder.tutorialmod.init;

import cubicoder.tutorialmod.TutorialMod;
import net.minecraft.block.Block;
import net.minecraftforge.fml.common.registry.GameRegistry.ObjectHolder;

@ObjectHolder(TutorialMod.MODID)
public class ModBlocks {

	public static final Block FIRST_BLOCK = null;
	
}
```

Next, we need to register the `Block`, as well as the `ItemBlock` corresponding to that `Block`. We do this in our `EventSubscriber`.

```java
package cubicoder.tutorialmod;

import cubicoder.tutorialmod.init.ModBlocks;
import cubicoder.tutorialmod.util.RegistryUtil;
import net.minecraft.block.Block;
import net.minecraft.block.material.Material;
import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.Item;
import net.minecraft.item.ItemBlock;
import net.minecraftforge.event.RegistryEvent.Register;
import net.minecraftforge.fml.common.Mod.EventBusSubscriber;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;

@EventBusSubscriber(modid = TutorialMod.MODID)
public class RegistrationHandler {

	@SubscribeEvent
	public static void registerItems(Register<Item> event) {
		final Item[] items = {
				RegistryUtil.setItemName(new Item(), "first_item").setCreativeTab(CreativeTabs.MISC),
		};

		final Item[] itemBlocks = {
				new ItemBlock(ModBlocks.FIRST_BLOCK).setRegistryName(ModBlocks.FIRST_BLOCK.getRegistryName())
		};

		event.getRegistry().registerAll(items);
		event.getRegistry().registerAll(itemBlocks);
	}

	@SubscribeEvent
	public static void registerBlocks(Register<Block> event) {
		final Block[] blocks = {
				RegistryUtil.setBlockName(new Block(Material.ROCK), "first_block").setCreativeTab(CreativeTabs.MISC)
		};

		event.getRegistry().registerAll(blocks);
	}

}
```

Here, we add a new method that registers the blocks. We also register an `ItemBlock` for each block in the `registerItems()` method. Make sure to set the registry name of the `ItemBlock` to be the same as the block’s. Also, note that we didn't add the `ItemBlock` to the list in `ModItems`. This is because a reference to the `ItemBlock` of a specific `Block` can be obtained through the method `Item.getItemFromBlock()`.

You might notice that the `Block` constructor takes in a `Material`. Every `Block` contains a `Material`, which defines things like whether the block is flammable, or if can be seen through. Minecraft already defines a number of materials which are good enough for most purposes, but you could make a custom material if you wanted to. Right now, we’ll just stick to the vanilla ones.

Now we need to add the models. In the `ModelRegistrationHandler` class, add a line in `registerModels()` to register your block’s model. Technically, this is actually the model for the `ItemBlock`; we **do not** need to register a model for the `Block` separately. Note also that we use the aforementioned method for retrieving an `ItemBlock` from a `Block`.
```java
registerModel(Item.getItemFromBlock(ModBlocks.FIRST_BLOCK), 0);
```

Now, we need to create the block models. Each block needs three models: a blockstate JSON in the `assets/tutorialmod/blockstates` folder, a block model JSON in the `assets/tutorialmod/models/block` folder, and an item model JSON in the `assets/tutorialmod/models/item` folder.

Blockstate JSON (named `first_block.json`):
```JSON
{
    "forge_marker": 1,
    "defaults": {
        "model": "tutorialmod:first_block"
    },
    "variants": {
        "normal": [{}],
        "inventory": [{}]
    }
}
```
Block model JSON (also named `first_block.json`):
```JSON
{
    "parent": "block/cube_all",
    "textures": {
        "all": "tutorialmod:blocks/first_block"
    }
}
```
Item model JSON (**also** named `first_block.json`):

```JSON
{
    "parent": "tutorialmod:block/first_block"
}
```

Finally, put your block's texture in the `assets/tutorialmod/textures/blocks` folder. Run the game to see your custom block!
![block0](/img/5block/block0.png)