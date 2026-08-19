extends BaseActor

@export var seek_right : bool # if true, the enemy seeks whatever is on the right
@export var can_see_player : bool
@export var is_active : bool

@onready var visionArea : Area2D = $VisionArea

func _ready() -> void:
    hitbox.connect("area_entered", on_hitbox_entered)
    visionArea.connect("area_entered", on_vision_area_entered)
    visionArea.connect("area_exited", on_vision_area_exited)

func on_hitbox_entered(area: Area2D):
    
    if area is BaseBullet or area.owner is Player:
        current_hp -= 1

func on_vision_area_entered(area: Area2D):
    can_see_player = true
    is_active = true
    
func on_vision_area_exited(area: Area2D):
    pass

func update():

    if !is_active: return

    velocity = Vector2(1 if seek_right else -1,0) * speed

    super()
    