class_name Bullet extends Area2D

@export var audio_stream_player: AudioStreamPlayer2D = null
@export var speed := 750
@export var damage := 1
## If true, the bullet will damage the player and not the enemies.
@export var targets_player := false: set = set_targets_player

var max_range := 1000.0

var _travelled_distance = 0.0


func _ready() -> void:
	assert(
		audio_stream_player != null,
		"The audio_stream_player property is not set for the bullet at path " + str(get_path()) + ". " +
		"The bullet needs an AudioStreamPlayer2D node to play audio when it hits something. Set it in the Inspector."
	)
	set_targets_player(targets_player)
	body_entered.connect(func (body: Node) -> void:
		hit_body(body)
		_destroy()
	)


func _physics_process(delta: float) -> void:
	var distance := speed * delta
	var motion := transform.x * speed * delta

	position += motion

	_travelled_distance += distance
	if _travelled_distance > max_range:
		_destroy()


func set_targets_player(new_value: bool) -> void:
	targets_player = new_value

	const PLAYER_PHYSICS_LAYER = 1
	const MOB_PHYSICS_LAYER = 3
	set_collision_mask_value(MOB_PHYSICS_LAYER, not targets_player)
	set_collision_mask_value(PLAYER_PHYSICS_LAYER, targets_player)


func hit_body(body: Node) -> void:
	if body is Player or body is Mob:
		body.health -= damage


## Override this function to change the behavior when the bullet hits something
## or reaches its maximum range.
func _destroy():
	set_physics_process(false)
	set_deferred("monitoring", false)
	audio_stream_player.play()