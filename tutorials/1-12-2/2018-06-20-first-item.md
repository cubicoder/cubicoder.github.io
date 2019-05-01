---
layout: post
title: First Item
date: 2018-06-20
---

Now that all of our basic setup is done, we get to move on to the fun stuff: adding content into the game. We’ll start with a very basic item.

Begin by creating two new packages under `com.cubicoder.tutorial`, `item` and `init`. In the `item` package, create a new class called `ItemFirstItem`.
```java
package com.cubicoder.tutorial.item;

import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.Item;

public class ItemFirstItem extends Item {

	public ItemFirstItem() {
		setCreativeTab(CreativeTabs.MISC);
	}

}
```
For now, we will add our item into the miscellaneous creative tab, so we can easily access it.

Next, we create a class named `ModItems` in the `com.cubicoder.tutorial.init` package. This class stores references to all of our items in case we need to access them in the code. By using the `@ObjectHolder` annotation, we can have Forge automatically inject our items into the class by pulling them out of the registry.
```java
package com.cubicoder.tutorial.init;

import com.cubicoder.tutorial.TutorialMod;
import com.cubicoder.tutorial.item.ItemFirstItem;
import net.minecraftforge.fml.common.registry.GameRegistry.ObjectHolder;

@ObjectHolder(TutorialMod.MODID)
public class ModItems {

	public static final ItemFirstItem FIRST_ITEM = null;

}
```
The mod id in the `@ObjectHolder` parameter simply tells Forge to inject matching items from our mod; putting "minecraft" would make it look for items from vanilla Minecraft. If we don’t specify an `@ObjectHolder` annotation above the field declaration, it will take the name of the field, set it to lowercase, and use that as the registry name to be injecting from. So, in this case, we need to make sure the name of the field is `FIRST_ITEM`, since the mod id is automatically added.

Next, we need to actually register our items. Create a new class called `EventSubscriber` in the `com.cubicoder.tutorial` package.
```java
package com.cubicoder.tutorial;

import com.cubicoder.tutorial.TutorialMod;
import com.cubicoder.tutorial.item.ItemFirstItem;
import net.minecraft.item.Item;
import net.minecraftforge.event.RegistryEvent.Register;
import net.minecraftforge.fml.common.Mod.EventBusSubscriber;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;

@EventBusSubscriber(modid = TutorialMod.MODID)
public final class EventSubscriber {

	@SubscribeEvent
	public static void registerItems(Register<Item> event) {
		final Item[] items = {
				new ItemFirstItem().setRegistryName("first_item").setUnlocalisedName(TutorialMod.MODID + "." + "first_item"),
		};

		event.getRegistry().registerAll(items);
	}

}
```
Registration has changed in 1.12.2 from older versions of Minecraft Forge. Instead of calling `GameRegistry.register()`, there is now an event for each kind of registry. We subscribe to the event bus using `@EventBusSubscriber`, then provide a method for each event using `@SubscribeEvent`. In this method, we initialize our item while adding it to the item cache. Then, we use the `event.getRegistry().registerAll()` method to register every item in our item cache. We could run the game now and have a working item, but it would have the ugly default pink-and-black checkboard texture. Instead, we must add a model to the item.

The unlocalized name, like "pickaxeDiamond", is used in language files and will translate into the name that appears onscreen, such as "Diamond Pickaxe" for English. **The unlocalised name and the registry name of an item should always be the same for mods, even though vanilla doesn't do it this way.** We will be covering language files in a later tutorial.

The registry name is the name under which the item is registered into the Forge Registry. This is the name that would appear in a `/give` command, such as `/give @s minecraft:diamond_pickaxe`. For more information on the Forge Registry, read the official documentation on it at [https://mcforge.readthedocs.io/en/latest/concepts/registries/](https://mcforge.readthedocs.io/en/latest/concepts/registries/).

The mod id is added to the unlocalized name to protect against namespace collisions. For example, two different mods might both add a copper ingot and set its unlocalized name to `copper_ingot`. Without adding the mod id, the different items appear to be one. The `setRegistryName()` method adds our mod id automatically, so we don’t have to.

Create a new class called `ClientEventSubscriber` in the `com.cubicoder.tutorial.client` package.
```java
package com.cubicoder.tutorial.client;

import com.cubicoder.tutorial.TutorialMod;
import com.cubicoder.tutorial.init.ModItems;
import net.minecraft.client.renderer.block.model.ModelResourceLocation;
import net.minecraft.item.Item;
import net.minecraftforge.client.event.ModelRegistryEvent;
import net.minecraftforge.client.model.ModelLoader;
import net.minecraftforge.fml.common.Mod.EventBusSubscriber;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import net.minecraftforge.fml.relauncher.Side;

@EventBusSubscriber(modid = TutorialMod.MODID, value = Side.CLIENT)
public final class ClientEventSubscriber {

    @SubscribeEvent
    public static void registerModels(ModelRegistryEvent event) {
        registerModel(ModItems.FIRST_ITEM);
    }

    private static void registerModel(Item item) {
        ModelLoader.setCustomModelResourceLocation(item, 0, new ModelResourceLocation(item.getRegistryName(), "inventory"));
    }

}
```
This subscribes to the `ModelRegistryEvent` and tells the Forge model loader to look for the item model in a certain directory. Note that the `value = Side.CLIENT` parameter in the `@EventBusSubscriber` annotation ensures that this only happens on the client side. In our case, the model directory will be `assets/tutorialmod/models/item`. This folder goes in the `src/main/resources` folder. Also, in the same place, create the `assets/tutorialmod/textures/items` folder. This is where all our item textures will be stored.

Models in Minecraft are done using JSON files. Create an untitled text file in `assets/tutorialmod/models/item` and name it `first_item.json`.
```JSON
{
    "parent": "item/generated",
    "textures": {
        "layer0": "tutorialmod:items/first_item"
    }
}
```
The `parent` line tells what model this model should be based off of. It’s almost like a super class in Java. The `textures` block tells Forge where it should look for the texture.

Your item’s texture, called `first_item.png`, goes in the `assets/tutorialmod/textures/items` folder.

Run the game to see your custom item in the Miscellaneous creative tab!
![item0](/img/4item/item0.png)
