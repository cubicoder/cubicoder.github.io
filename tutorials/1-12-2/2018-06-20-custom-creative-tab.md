---
layout: post
title: Custom Creative Tab
date: 2018-06-20
---

We can add our own creative tab for our mod’s items and blocks to go in. Start by making a new class in `cubicoder.tutorial` called `TutorialModTab`.
```java
package cubicoder.tutorialmod;

import cubicoder.tutorialmod.init.ModItems;
import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.ItemStack;
import net.minecraftforge.fml.relauncher.Side;
import net.minecraftforge.fml.relauncher.SideOnly;

public class TutorialModTab extends CreativeTabs {

	public TutorialModTab() {
		super(TutorialMod.MODID);
	}
	
	@SideOnly(Side.CLIENT)
	@Override
	public ItemStack createIcon() {
		return new ItemStack(ModItems.FIRST_ITEM);
	}
	
}
```
In the constructor, we set the translation key for the tab. I've chosen to just put my mod id as the translation key, which works great if your mod only has one creative tab. If it has more, you'd want to give each of these a unique name, prepended by the mod id.

In `createIcon()`, we set the item to be used for the icon of our tab. You can also use a block for this, using `Item.getItemFromBlock()`.

Add a localization for your tab in the `en_us.lang` file:
```
# Creative Tabs
itemGroup.tutorialmod=Tutorial Mod
```
Add an instance of your tab to the `TutorialMod` class.
```java
public static final CreativeTabs TUTORIAL_TAB = new TutorialModTab();
```
Finally, change your `setCreativeTab()` method calls in your `RegistrationHandler` to reference your creative tab. For example:
```java
RegistryUtil.setItemName(new Item(), "first_item").setCreativeTab(TutorialMod.TUTORIAL_TAB)
```
That’s all you have to do to have your own creative tab!
![tab0](/img/7tab/tab0.png)
