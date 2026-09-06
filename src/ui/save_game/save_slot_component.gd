class_name SaveSlotComponent
extends Panel

@onready var dateLabel : Label = $dateLabel
@onready var playTimeLabel : Label = $playTimeLabel
@onready var placeLabel : Label = $placeLabel

var idx : int

signal on_clicked(save_data: SaveDataRef)

func _ready() -> void:
	connect("gui_input", on_gui_input)

func on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed(): emit_signal("on_clicked", idx)

func setup(newIdx: int, save_data: SaveDataRef) -> void:
	idx = newIdx 
	dateLabel.text = save_data.dateString
	playTimeLabel.text = save_data.playTimeString

	var path := save_data.placeString

	# get just the file name from the path
	placeLabel.text = path.split("/")[-1].split(".")[0]
