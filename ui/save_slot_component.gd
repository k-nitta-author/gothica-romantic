class_name SaveSlotComponent
extends Panel

@onready var dateLabel : Label = $dateLabel
@onready var playTimeLabel : Label = $playTimeLabel
@onready var placeLabel : Label = $placeLabel

var idx : int

signal on_clicked

func _ready() -> void:
	connect("gui_input", on_gui_input)


func setup(newIdx: int, save_data: SaveDataRef) -> void:
	idx = newIdx 
	dateLabel.text = save_data.dateString
	playTimeLabel.text = save_data.playTimeString
	placeLabel.text = save_data.placeString