class_name  Player
extends BaseActor

@export var isRejectingInput: bool

const POTION_HEAL_AMOUNT := 3
const BASIC_DMG_AMT := 1

# the amount of time that the player is invincible when struck
@export var invincibility_time:= 3.6

# important child variables
@onready var swordSprite : Sprite2D = $sword
@onready var gunshotEffect : Sprite2D = $gunshot
@onready var firingPoint : Marker2D = $gunshot/firingPoint

# player's own custom managers
@onready var gunManager : GunManager = $gunManager.Setup(self)
@onready var potionManager: PotionManager = $potionManager.Setup(self)

# bullet related signals
signal on_bullets_current_change(old_value: int, new_value: int)
signal on_bullets_max_change(old_value: int, new_value: int)

# potion related signal
signal on_potions_current_change(old_value: int, new_value: int)

var is_ducking :bool

# the use input method for the player
func use_input(e) -> void: pass

# override the knockback method for the player
func knockback(area: Area2D) -> void:
	var fall_speed_multiplier := 16
	var x = (1 if area.global_position.x < global_position.x else -1) * knockback_impulse
	var y = speed_in_air_vertical * fall_speed_multiplier

	velocity = Vector2(x, y)

	can_flip = false

	selected_state = STATES.DAMAGED

func start_invincibility() -> void:
	hitbox.collision_mask = 0
	collision_mask = COLLIDE_WITH_TILEMAP_MASK

	get_tree().create_timer(invincibility_time).connect("timeout", end_invincibility)

func end_invincibility() -> void:
	collision_mask = BaseActor.COLLIDE_WITH_TILEMAP_MASK
	hitbox.collision_mask = BaseActor.COLLIDE_WITH_ENEMY_MASK
	sprite.is_flashing_transparent = false

func jump_down() -> void:
	collision_mask = COLLIDE_WITH_ONLY_NON_PLATFORMS

# the player's attack
func attack() -> void:
	is_attacking = true
	anim.play("attack")
	swordSprite.start()
	
# override fall
func fall(fall_height: float) -> void:
	if global_position.y >= fall_height + Game.GRID_SIZE / 2: collision_mask = BaseActor.COLLIDE_WITH_TILEMAP_MASK

# overrides the base method
func cease_attack() -> void:
	swordSprite.end()
	is_attacking = false

# overrides the base method
func cease_shoot() -> void:
	is_shooting = false

func has_gotten_up() -> bool: return is_on_floor()

func _unhandled_input(_event: InputEvent) -> void:
	if current_state != null:
		current_state.handle_input()

	# consume potion and reduce based on how how much hp the player has
	if _event.is_action_pressed("drinkPotion") and current_hp < max_hp:
		potionManager.current_potion_count -= 1
		heal(POTION_HEAL_AMOUNT)

# sets the current flip state;
func set_is_flipped(value: bool): super(value)

func load_game(data: Dictionary) -> Player:

	max_hp = data["current_player_hp"]

	return self

func update() -> void:
	super()
	if current_state != null: current_state.handle_input()

func on_hitbox_entered(area: Area2D):
	# only knockback the player when they touch an enemy
	knockback(area)

	current_hp -= BASIC_DMG_AMT
	selected_state = STATES.DAMAGED

# the heal method; simple
func heal(amount: int): current_hp += amount

# overrides the parent's walk method
func walk() -> void:
	velocity.x = Input.get_axis("move_left", "move_right") * speed

# overrides the parent's shoot method
func shoot():
	gunManager.shoot()
