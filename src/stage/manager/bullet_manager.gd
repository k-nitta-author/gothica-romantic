extends BaseManager

@onready var children := get_children()

# instantiate bullet pools for different types of bullet
@onready var player_bullet_pool : BulletPool = BulletPool.new()
@onready var enemy_bullet_pool : BulletPool = BulletPool.new()

func add_bullet(bullet: BaseBullet, pos: Vector2) -> void:
	var b : BaseBullet = bullet.bind_dependencies(stage).spawn_at(pos)
	add_child(b)
	children.append(b)

func clear_all() -> void:
	for b: BaseBullet in get_children():
		b.queue_free()

func bind_dependencies(s: Stage):	
	super(s)

	for c in children:
		c.bind_dependencies(stage)

func _physics_process(delta: float) -> void:
	for c in children: c.update(delta) # call update on each bullet 
