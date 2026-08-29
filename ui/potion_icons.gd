extends Control

# initialize array of potion icons
@onready var potionIconsArray : Array[Sprite2D] = [$Potion, $Potion2, $Potion3]

# call when setting the potions amount from the player
func update_potion_icons(_old_value: int, potionsCurrent: int):

	var potionIconsArrayIdx := potionsCurrent - 1

	potionIconsArray[potionIconsArrayIdx].visible = true

	for i in range(6):

		potionIconsArray[i].visible = i < potionsCurrent