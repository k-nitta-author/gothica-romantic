extends Node2D

@onready var children := get_children()
@onready var player := $Player
@onready var bosses : Array

var can_update := false

# get the current boss
func get_boss() -> Array: return get_bosses()

# get the current player
func get_player() -> Player: return player

func on_actor_died(actor: BaseActor) -> void:
	pass

# spawn actor
func spawn_actor(actorScene: PackedScene) -> void: add_child(actorScene.instantiate())

func bind_dependencies(stage: Stage) -> void:
	for c in get_children():
		c.bind_dependencies(stage)
		c.connect("has_died", stage.propManager.spawn_collectible)
		c.connect("has_died", on_actor_died)
		c.connect("attacked_at_point", stage.effectsManager.spawn_effects)

		if c is BaseEnemy and c.is_boss: bosses.append(c)

func get_bosses() -> Array: return bosses

func _physics_process(_delta: float) -> void:
	
	if !can_update: return

	for c in children:
		c.update()

func _unhandled_input(event: InputEvent) -> void:
	player.use_input(event)
