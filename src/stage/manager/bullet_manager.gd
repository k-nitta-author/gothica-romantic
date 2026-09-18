extends BaseManager

@onready var children := get_children()

func add_bullet(bullet: BaseBullet, pos: Vector2) -> void:
	var b : BaseBullet = bullet.bind_dependencies(stage).spawn_at(pos)
	add_child(b)
	children.append(b)
	
func bind_dependencies(s: Stage):	
	super(s)

	for c in children:
		c.bind_dependencies(stage)

func _physics_process(delta: float) -> void:
	for c in children: c.update(delta) # call update on each bullet 
