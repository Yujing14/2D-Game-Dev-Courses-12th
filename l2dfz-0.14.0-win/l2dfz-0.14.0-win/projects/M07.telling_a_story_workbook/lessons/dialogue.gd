extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton

var dialogue_items: Array[String] = [
	"Hello there!",
	"The sky is quite blue huh?",
	"I really like sunny days!",
	"Goodbye! See you next time!"
]
## Holds the index of the currently displayed text
var current_item_index := 0

func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)

func show_text() -> void:
	rich_text_label.text = dialogue_items[current_item_index]

func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else:
		show_text()
