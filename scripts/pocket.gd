extends Area3D
class_name Pocket



func _on_body_entered(body:Node3D):
    if body is Ball:
        GameEvents.ball_potted.emit(body, self)        
