extends XROrigin3D

@onready var _grow_pointer: XRToolsFunctionPointer = $RightHand/GrowPointer
@onready var _shrink_pointer: XRToolsFunctionPointer = $LeftHand/ShrinkPointer


func _on_left_hand_button_pressed(button: String) -> void:
	if button == "trigger_click":
		_shrink_pointer.enabled = true


func _on_left_hand_button_released(button: String) -> void:
	if button == "trigger_click":
		_shrink_pointer.enabled = false


func _on_right_hand_button_pressed(button: String) -> void:
	if button == "trigger_click":
		_grow_pointer.enabled = true
	elif button == "ax_button":
		# Find the XRToolsSceneBase ancestor of the current node
		var scene_base : XRToolsSceneBase = XRTools.find_xr_ancestor(self, "*", "XRToolsSceneBase")
		if not scene_base:
			return

		# Request loading the next scene
		scene_base.load_scene("res://scenes/tutorial.tscn")



func _on_right_hand_button_released(button: String) -> void:
	if button == "trigger_click":
		_grow_pointer.enabled = false
