extends Control

# initialize all variables
@onready var volumeSlider : HSlider = $volumeSlider
@onready var masterVolumeSlider : HSlider = $masterVolumeSlider
@onready var musicVolumeSlider : HSlider = $musicVolumeSlider
@onready var backButton : Button = $backButton

const VOLUME_SETTINGS_PATH := "user://audio_settings.json"

signal return_to_previous_screen # emit to remove from view

func _ready() -> void:
    
    # load all settings from file
    load_from_file()
    
    # connect each slider to its handler
    volumeSlider.connect("value_changed", on_volume_slider_value_changed)
    masterVolumeSlider.connect("value_changed", on_master_volume_slider_value_changed)
    musicVolumeSlider.connect("value_changed", on_music_slider_value_changed)

    # connect the back button 
    backButton.connect("pressed", on_back_button_pressed)

# when the back button is pressed
func on_back_button_pressed() -> void: emit_signal("return_to_previous_screen")

# called when the volume slider is changed
func on_volume_slider_value_changed(_value: float) -> void: save_to_file(get_data_dict())

# called when the music slider is changed
func on_music_slider_value_changed(_value: float) -> void: save_to_file(get_data_dict())

# called when the master volume slider is changed
func on_master_volume_slider_value_changed(_value: float) -> void: save_to_file(get_data_dict())

# load the volume settings from the file
func load_from_file() -> void:

    # first check if file exists at all; go away if not
    if !FileAccess.file_exists(VOLUME_SETTINGS_PATH): return

    var file := FileAccess.open(VOLUME_SETTINGS_PATH, FileAccess.READ)

    var parsed_json : Dictionary = JSON.parse_string(file.get_as_text())

    file.close()

    volumeSlider.value = parsed_json["volumeSlider"]
    musicVolumeSlider.value = parsed_json["musicVolumeSlider"]
    masterVolumeSlider.value = parsed_json["master_volume"]

# poll all sliders for their current value
func get_data_dict() -> Dictionary:
    return {
        "master_volume": masterVolumeSlider.value,
        "musicVolumeSlider": musicVolumeSlider.value,
        "volumeSlider": volumeSlider.value
    }

# save settings to file
func save_to_file(data: Dictionary) -> void:
    var file := FileAccess.open(VOLUME_SETTINGS_PATH, FileAccess.WRITE)

    var json = JSON.stringify(data)

    file.store_string(json)

    file.close()

