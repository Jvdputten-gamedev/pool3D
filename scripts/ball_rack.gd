extends Node3D

@export var _ball_tscn: PackedScene


func _ready():
    self.position = BilliardTable.FOOT_SPOT

    _rack_balls()

func _rack_balls():
    var ball_nums := range(1, 16)
    ball_nums.shuffle()

    const DIAMETER = Ball.BALL_DIAMETER
    const RADIUS = Ball.BALL_RADIUS
    var ball_i = 0
    for i in 5:
        for j in i+1:
            var new_ball = _ball_tscn.instantiate() as Ball
            var ball_x: float = i * DIAMETER * 0.9
            var ball_z: float = (i * RADIUS) - (j * DIAMETER)
            new_ball.setup_ball(ball_nums[ball_i], ball_x, ball_z)

            self.add_child(new_ball)
            ball_i += 1
            