
OGUI_Menu_Callbacks := {}

class OGUI_Menu
{
	__New(name)
	{
		global OGUI_Menu_Callbacks
		
		this.name := name
		
		if (OGUI_Menu_Callbacks.HasKey(this.name)){
			MsgBox, % "ERROR: Menu '" . this.name . "' already exists."
			ExitApp
		}
		
		OGUI_Menu_Callbacks[this.name] := {}
	}
	
	__Delete()
	{
		Menu, % this.name, Delete
		OGUI_Menu_Callbacks.Remove(this.name)
	}
	
	add_menu(menu)
	{
		Menu, % this.name, Add, % menu.name, % ":" . menu.name
	}
	
	add_item(item, handler)
	{
		global OGUI_Menu_Callbacks
		
		OGUI_Menu_Callbacks[this.name, item] := handler
		
		Menu, % this.name, Add, % item, OGUI_Menu_Handler
		
		return
		OGUI_Menu_Handler:
			OGUI_Menu_Callbacks[A_ThisMenu, A_ThisMenuItem].()
		return
	}
	
	remove_item(item)
	{
		global OGUI_Menu_Callbacks
		
		Menu, % this.name, Delete, % item
		OGUI_Menu_Callbacks[this.name].Remove(item)
	}
	
	set_item_icon(item, file, icon_number = 1)
	{
		Menu, % this.name, Icon, % item, % file, % icon_number
	}
	
	add_separator()
	{
		Menu, % this.name, Add
	}
	
	show()
	{
		Menu, % this.name, Show
	}
}
