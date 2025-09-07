extends XROrigin3D

@onready var _grow_pointer: XRToolsFunctionPointer = $LeftHand/GrowPointer
@onready var _shrink_pointer: XRToolsFunctionPointer = $RightHand/ShrinkPointer


func _on_left_hand_button_pressed(button: String) -> void:
	if button == "trigger_click":
		_grow_pointer.enabled = true


func _on_left_hand_button_released(button: String) -> void:
	if button == "trigger_click":
		_grow_pointer.enabled = false


func _on_right_hand_button_pressed(button: String) -> void:
	if button == "trigger_click":
		_shrink_pointer.enabled = true


func _on_right_hand_button_released(button: String) -> void:
	if button == "trigger_click":
		_shrink_pointer.enabled = false
