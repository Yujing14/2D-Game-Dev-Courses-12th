# NB: we saw inheritance in M8 with resources
class_name Weapon_01 extends Node2D

@export var bullet_scene: PackedScene = preload("bullets/fireball.tscn")
@export var audio_stream_player: AudioStreamPlayer2D = null

## Maximum random angle applied to the shot bullets. Controls the gun's precision.
@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var random_angle := PI / 12.0
## Maximum range a bullet can travel before it disappears.
@export_range(100.0, 2000.0, 1.0) var max_range := 2000.0
## The speed of the shot bullets
@export_range(100.0, 3000.0, 1.0) var max_bullet_speed := 1500.0


func _ready() -> void:
	assert(
		bullet_scene != null,
		'Bullet Scene is not provided for weapon "' + str(get_path()) + '"'
	)
	assert(
		audio_stream_player != null,
		'Audio stream player property is not set for weapon "' + str(get_path()) + '"'
	)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()


## Makes the weapon shoot once. Override this function in scripts that inherit
## from this to create new weapons.
func shoot() -> void:
	var bullet: Node = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)

	bullet.global_transform = global_transform
	bullet.max_range = max_range
	bullet.speed = max_bullet_speed
	bullet.rotation += randf_range(-random_angle / 2.0, random_angle / 2.0)

	audio_stream_player.play()
