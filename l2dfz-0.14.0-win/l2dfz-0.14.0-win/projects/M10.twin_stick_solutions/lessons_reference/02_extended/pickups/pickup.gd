@tool
class_name Pickup extends Area2D

@export var item: Item = null: set = set_item

@onready var _sprite_2d: Sprite2D = %Sprite2D
@onready var _audio_stream_player: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var _animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	assert(
		item != null,
		"The pickup at path " + str(get_path()) + " has no item assigned. " +
		"Please assign an item to the pickup in the inspector."
	)
	set_item(item)

	_animation_player.play("idle")
	body_entered.connect(func (body: Node2D) -> void:
		if body is Player:
			_animation_player.play("destroy")
			set_deferred("monitoring", false)
			item.use(body)
	)


func set_item(value: Item) -> void:
	item = value
	if _sprite_2d != null:
		_sprite_2d.texture = item.texture
	if _audio_stream_player != null:
		_audio_stream_player.stream = item.sound_on_pickup