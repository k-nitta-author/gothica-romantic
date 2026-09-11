class_name Game
extends Node2D

const GRID_SIZE = 16 # potentially subject to change
const GRAVITY = 1 # determine best value later on

# intialize child variables
@onready var hudLayer = $HudLayer
@onready var music: AudioStreamPlayer = $Music
@onready var stage: Stage = self.get_node_or_null("Stage")
@onready var saveManager : SaveManager = $SaveManager
@onready var effectLayer : EffectsLayer = $EffectsLayer

@export var next_level_scene: PackedScene
@onready var start_screen : Control = $HudLayer.get_start_screen()

# the current_save_index
var current_save_idx := 1

# saveable data
var stage_number: int
var area : String 
var gun_state: String
var player_hp: int

func _ready() -> void:
	start_screen.connect("start_level", on_start_level)
	hudLayer.bind_game(self)

# sets the current save file that the game is considering
func set_current_save(idx: int) -> void: 

	current_save_idx = idx

	var current_save_data = saveManager.save_file_data[current_save_idx]	
	var new_level : PackedScene = load(current_save_data.placeString)

	update_next_level(new_level)

func save() -> void: saveManager.create_save_file(current_save_idx, save_handler) # create save file and update as needed

# save file handler callback function 
func save_handler(f: FileAccess):
	f.store_string(
		JSON.stringify(
			saveManager.poll_game_state(stage)
			)	
		)

func update_next_level(next: PackedScene) -> void: next_level_scene = next

# starts the game
func start_game() -> void:
	start_screen.hide()
	# set up stage
	stage = load_stage(next_level_scene)
	stage.bind_to_game(self)
		
	add_child(stage)

	# update and link to hud_layer
	hudLayer.visible = true

	hudLayer.currentState = hudLayer.STATE.TRANSITION
	await effectLayer.transition_finished
	hudLayer.currentState = hudLayer.STATE.RESUMED
	
	hudLayer.bind_to_player(stage.player)
	hudLayer.bind_boss(stage.get_boss())

	save()

# start the stage
func start_stage() -> void: add_child(load_stage(next_level_scene))

func load_stage(nextLevel: PackedScene) -> Stage: return nextLevel.instantiate()

# unloads the currently running stage
func unload_stage() -> void:
	stage.call_deferred("queue_free")
	stage = null
	hudLayer.currentState = hudLayer.STATE.START_SCREEN

# called whenever the start level signal
func on_start_level(from_beginning: bool) -> void:

	if from_beginning: start_screen.show_save_game_modal()

	else:
		
		effectLayer.play_transition(EffectsLayer.TRANS.WIPE_UP)
		await effectLayer.transition_finished
		
		start_game()
		save()

# called whenever the loaded stage ends
func on_stage_end(new_next_level_scene: PackedScene) -> void:

	if new_next_level_scene == null: return  

	var next_level := new_next_level_scene.instantiate()
	var old_stage := stage

	old_stage.queue_free()

	stage = next_level
	call_deferred("add_child", stage)
	stage.bind_to_game(self)

# the unhandled input
func _unhandled_input(event: InputEvent) -> void:

	# called whenever the fullscreen button is pressed
	# toggles the fullscreen setting to true
	if event.is_action("fullScreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
