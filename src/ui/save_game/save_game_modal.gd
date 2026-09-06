extends Panel

@onready var backButton = $backButton
@onready var save_slots : Array = [
	$HBoxContainer/SaveSlotComponent,
	$HBoxContainer/SaveSlotComponent2,
	$HBoxContainer/SaveSlotComponent3,
]

const USER_FILE_DIRECTORY := "user://"
const SAVE_FILE_DIRECTORY := "user://save"

var game: Game

signal return_to_previous_screen

func setup() -> void:
	backButton.connect("pressed", on_back_button_pressed)

	# set each slot visible for each save file
	# none will be visible if there are no save files

	var save_data_array := game.saveManager.load_data_from_save_files()

	for i in save_data_array.size():
		save_slots[i].visible = true
		save_slots[i].setup(i, save_data_array[i])
		save_slots[i].connect("on_clicked", game.set_current_save)
		save_slots[i].connect("on_clicked", on_save_slot_clicked)

func on_save_slot_clicked(idx: int) -> void:
	game.start_game()
	emit_signal("return_to_previous_screen")
	queue_free()

func bind_to_game(g: Game) -> void:
	game = g

# return to the previous screen; meant to be used with the back button
func on_back_button_pressed() -> void: 
	emit_signal("return_to_previous_screen")
	queue_free()
