extends Node3D

@export var _cue_ball: RigidBody3D
@export var _aim_container: Node3D
@export var _cue_stick: Node3D
@export var _stick_animation_player: AnimationPlayer

@export var _stick_min_z: float = 0.75
@export var _stick_max_z: float = 1.25
@export var _stick_z_sens: float = 0.01
@export var _shot_power_min: float = 0.1
@export var _shot_power_max: float = 5.0


var _shot_percent: float = 0
var _play_state: Enums.PlayState = Enums.PlayState.AIMING

func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_cue_ball.position = BilliardTable.HEAD_SPOT

func _process(_delta):
	
	_handle_shot_input()
	_aim_container.position = _cue_ball.position

	
func _input(event):
	var mouse_motion = event as InputEventMouseMotion
	if mouse_motion:
		_aim_container.rotation_degrees.y += mouse_motion.relative.x
		
		_shot_percent += mouse_motion.relative.y * _stick_z_sens
		_shot_percent = clamp (_shot_percent, 0, 1)
		_cue_stick.position.z = lerp(_stick_min_z, _stick_max_z, _shot_percent)

		# _cue_stick.position.z += mouse_motion.relative.y * _stick_z_sens
		# _cue_stick.position.z = clamp(_cue_stick.position.z, _stick_min_z, _stick_max_z)


func _handle_shot_input():
	if (Input.is_action_just_pressed("shoot") and 
			_play_state == Enums.PlayState.AIMING):
		_stick_animation_player.play("shoot_stick")
		
		
func _strike_ball():
	var _shot_power = lerp(_shot_power_min, _shot_power_max, _shot_percent)
	var stick_direction = -_aim_container.basis.z

	_cue_ball.apply_central_impulse(stick_direction * _shot_power)

	_cue_stick.visible = false

	_play_state = Enums.PlayState.BALLS_IN_PLAY
	GameEvents.cue_ball_hit.emit()