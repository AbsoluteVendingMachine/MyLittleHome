extends CSGMesh3D


var sine_counter : float


func _process(delta):
	sine_counter += delta / 24
	mesh.material.uv1_offset = Vector3(sin(sine_counter) * 3, 1, cos(sine_counter))
	
