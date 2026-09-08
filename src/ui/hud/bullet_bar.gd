extends Control

# an array of all the bullet icons
@onready var bulletBar: Array[Sprite2D] = [$BulletIcon, $BulletIcon2, $BulletIcon3, $BulletIcon4, $BulletIcon5, $BulletIcon6]

# update the bullet bar display
func update_bullet_bar(_old_value: int, bulletsCurrent: int):

	var bulletBarIdx := bulletsCurrent - 1

	bulletBar[bulletBarIdx].visible = true

	for i in range(6):

		bulletBar[i].visible = i < bulletsCurrent