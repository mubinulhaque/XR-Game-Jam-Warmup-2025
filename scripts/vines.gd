extends XRToolsInteractableBody

const _GROWTH_RATE := 0.5

var _capsule_col: BoxShape3D
var _capsule_mesh: CapsuleMesh
var _current_growth_rate := 0.0

@onready var _collider: CollisionShape3D = $CollisionShape3D
@onready var _mesh: MeshInstance3D = $MeshInstance3D

func  _ready() -> void:
	if _collider.shape is BoxShape3D:
		_capsule_col = _collider.shape
	else:
		printerr("Cannot set collider shape! " + str(_collider.shape))
	
	if _mesh.mesh is CapsuleMesh:
		_capsule_mesh = _mesh.mesh
	else:
		printerr("Cannot set vine mesh! " + str(_mesh.mesh))


func _process(delta: float) -> void:
	_capsule_col.size.y += _current_growth_rate * delta
	_capsule_mesh.height += _current_growth_rate * delta
	
	_collider.position.y += _current_growth_rate / 2 * delta
	_mesh.position.y += _current_growth_rate / 2 * delta


func _on_pointer_event(event: Variant) -> void:
	if event is XRToolsPointerEvent:
		if (event.pointer.name == "GrowPointer" 
				and event.event_type == XRToolsPointerEvent.Type.ENTERED):
			print("Vine growing!")
			_current_growth_rate = _GROWTH_RATE
		elif (event.pointer.name == "ShrinkPointer" 
				and event.event_type == XRToolsPointerEvent.Type.ENTERED):
			print("Vine shrinking!")
			_current_growth_rate = -_GROWTH_RATE
		elif event.event_type == XRToolsPointerEvent.Type.EXITED:
			_current_growth_rate = 0
