extends Control

@onready var numberLabel = $"small label"

# call when setting the potions amount from the player
func update_potion_icons(_old_value: int, potionsCurrent: int):
    numberLabel.text = "x" + str(potionsCurrent)