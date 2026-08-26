class_name Game
extends Node2D

const GRID_SIZE = 16 # potentially subject to change
const GRAVITY = 1 # determine best value later on

@onready var hudLayer = $HudLayer
@onready var music: AudioStreamPlayer = $Music
@onready var stage: Stage = self.get_node_or_null("Stage")

@export var next_level_scene: PackedScene
@onready var start_screen := $StartScreen

# saveable data
var stage_number: int
var area : String 
var gun_state: String
var player_hp: int

func _ready() -> void:
	start_screen.connect("start_level", on_start_level )

func on_start_level(from_beginning: bool) -> void:

	start_screen.queue_free()

	stage = load_stage(next_level_scene)
	stage.bind_to_game(self)
	add_child(stage)
	hudLayer.visible = true
	hudLayer.bind_to_player(stage.player)


# polls the current game state to supply data to the save file
func poll_game_state() -> Dictionary:
	return {
		"current_stage_number": stage_number,
		"current_area": area,
		"current_gun_state": gun_state,
		"current_player_hp": player_hp
	}

func on_player_exited(next_level_scene: PackedScene):
	var next_level := next_level_scene.instantiate()
	
	var old_stage := stage
	old_stage.queue_free()

	stage = next_level
	add_child(stage)
	stage.bind_to_game(self)

func start_stage():
	
	var s = load_stage(next_level_scene)
	add_child(s)

func load_stage(nextLevel: PackedScene) -> Stage: return nextLevel.instantiate()

func unload_stage() -> void:
	stage.call_deferred("queue_free")
	stage = null


func _unhandled_input(event: InputEvent) -> void:

	if event.is_action("fullScreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
