extends XRToolsInteractableBody

## Rate at which vines grow and shrink
const _GROWTH_RATE := 2.0

## Minimum height a vine can be at
@export var _min_vine_size := 1.0
## Maximum height a vine can be at
@export var _max_vine_size := 10.0

## Shape of the vine's collider
var _vine_col: BoxShape3D
## Mesh of the vine
var _vine_mesh: CapsuleMesh
## Current rate at which the vine is growing
var _current_growth_rate := 0.0

@onready var _collider: CollisionShape3D = $CollisionShape3D
@onready var _mesh: MeshInstance3D = $MeshInstance3D


func  _ready() -> void:
	if _collider.shape is BoxShape3D:
		_vine_col = _collider.shape
	else:
		printerr("Cannot set collider shape! " + str(_collider.shape))
	
	if _mesh.mesh is CapsuleMesh:
		_vine_mesh = _mesh.mesh
	else:
		printerr("Cannot set vine mesh! " + str(_mesh.mesh))


func _process(delta: float) -> void:
	_vine_col.size.y = clamp(
			_vine_col.size.y + (_current_growth_rate * delta),
			_min_vine_size,
			_max_vine_size
	)
	_vine_mesh.height = clamp(
			_vine_mesh.height + (_current_growth_rate * delta),
			_min_vine_size,
			_max_vine_size
	)
	
	_collider.position.y = clamp(
			_collider.position.y + (_current_growth_rate / 2 * delta),
			_min_vine_size / 2,
			_max_vine_size / 2
	)
	_mesh.position.y = clamp(
			_mesh.position.y + (_current_growth_rate / 2 * delta),
			_min_vine_size / 2,
			_max_vine_size / 2
	)


func _on_pointer_event(event: Variant) -> void:
	if event is XRToolsPointerEvent:
		if (
				event.pointer.name == "GrowPointer" 
				and event.event_type == XRToolsPointerEvent.Type.ENTERED
		):
			# If being pointed at by the Grow Pointer
			_current_growth_rate = _GROWTH_RATE
		elif (
				event.pointer.name == "ShrinkPointer" 
				and event.event_type == XRToolsPointerEvent.Type.ENTERED
		):
			# If being pointed at by the Shrink Pointer
			_current_growth_rate = -_GROWTH_RATE
		elif event.event_type == XRToolsPointerEvent.Type.EXITED:
			# If no longer being pointed at
			_current_growth_rate = 0
