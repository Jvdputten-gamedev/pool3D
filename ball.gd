extends RigidBody3D
class_name Ball


const BALL_RADIUS: float = 0.027
const BALL_DIAMETER: float = BALL_RADIUS * 2

@export var _texture: Texture2D

var _ball_num: int = 0
var ball_type: Enums.BallType

func _ready():
	_apply_new_material()

func _integrate_forces(_state):
	self.linear_velocity.y = min(Ball.BALL_DIAMETER, self.linear_velocity.y)

func setup_ball(ball_num: int, ball_x: float, ball_z: float):
	self._ball_num = ball_num

	if ball_num == 8:
		self.ball_type = Enums.BallType.EIGHT_BALL
	elif ball_num == 0:
		self.ball_type = Enums.BallType.CUE_BALL
	elif ball_num < 8:
		self.ball_type = Enums.BallType.SOLIDS
	else:
		self.ball_type = Enums.BallType.STRIPES


	self.position.x = ball_x
	self.position.z = ball_z

	_texture = load("res://assets/textures/" + str(ball_num) + ".jpg")

	_apply_new_material()

func _apply_new_material():
	var new_material = StandardMaterial3D.new()
	new_material.albedo_texture = _texture
	$BallMesh.material_override = new_material


