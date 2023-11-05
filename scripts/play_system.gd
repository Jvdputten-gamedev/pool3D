extends Node3D

@export var _cue_ball: RigidBody3D


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		var impulse_vector = Vector3(1, 0, 0)
		_cue_ball.apply_central_impulse(impulse_vector)