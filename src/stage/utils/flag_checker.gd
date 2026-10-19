extends BaseStageUtil

@export var check_on_ready: bool
@export var flag: String
@export var value: bool

signal flag_true
signal flag_false

var persistence_service: PersistenceService

func bind_dependencies(g: Game) -> void:

    super(g)
    persistence_service = game.persistence_service

func check_flag(flag_name: String) -> bool:
    var flag_value := persistence_service.retrieve_flag_value(flag_name)
    var signal_name = "flag_true" if value else "flag_false"  

    emit_signal(signal_name)

    return flag_value

func set_flag(flag_name: String) -> bool:
    persistence_service.update_flag_value(flag_name, value)
    return true