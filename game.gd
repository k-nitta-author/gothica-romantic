class_name Game
extends Node2D

const GRID_SIZE = 16 # potentially subject to change
const GRAVITY = 1 # determine best value later on

@onready var hudLayer = $HudLayer
@onready var music: AudioStreamPlayer = $Music
@onready var stage: Stage = self.get_node_or_null("Stage")
@onready var saveManager : SaveManager = $SaveManager

@export var next_level_scene: PackedScene
@onready var start_screen : Control = $HudLayer.get_start_screen()

# saveable data
var stage_number: int
var area : String 
var gun_state: String
var player_hp: int

func _ready() -> void:
	start_screen.connect("start_level", on_start_level)
	hudLayer.bind_game(self)

func save_to_file(f: FileAccess):
	f.store_string(JSON.stringify(poll_game_state()))

func on_start_level(from_beginning: bool) -> void:

	if from_beginning:
		start_screen.show_save_game_modal()

	else:
		start_screen.hide()
	
		stage = load_stage(next_level_scene)
		stage.bind_to_game(self)
		
		add_child(stage)

		hudLayer.visible = true
		hudLayer.currentState = hudLayer.STATE.RESUMED
		hudLayer.bind_to_player(stage.player)
		hudLayer.bind_boss(stage.get_boss())

		saveManager.create_save_file(save_to_file)

# polls the current game state to supply data to the save file
func poll_game_state() -> Dictionary:
	return {
		"current_stage_number": 1,
		"place": stage.name,
		"current_player_hp": stage.get_player().max_hp,
		"save_date": "",
		"play_time": ""
	}

func on_player_exited(new_next_level_scene: PackedScene):

	if new_next_level_scene == null: return  

	var next_level := new_next_level_scene.instantiate()
	
	var old_stage := stage
	old_stage.queue_free()

	stage = next_level

	call_deferred("add_child", stage)

	stage.bind_to_game(self)

func start_stage():
	var s = load_stage(next_level_scene)
	add_child(s)

func load_stage(nextLevel: PackedScene) -> Stage: return nextLevel.instantiate()

func unload_stage() -> void:
	stage.call_deferred("queue_free")
	stage = null
	hudLayer.currentState = hudLayer.STATE.START_SCREEN

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("fullScreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
