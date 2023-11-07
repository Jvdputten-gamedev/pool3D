extends Node

@export var _game_state: GameState
var _occurrences_during_shot: Array[Occurrence]

func _ready():
	GameEvents.all_balls_stopped.connect(_on_all_balls_stopped)
	GameEvents.ball_potted.connect(_on_ball_potted)

func _process_rules():

	for occurrence in _occurrences_during_shot:
		
		if occurrence is PocketOccurrence:
			var ball: Ball = occurrence.ball
			if ball.is_object_ball():
				_check_and_set_ball_suit_for_players(ball)
				print("Player_suits: ", _game_state.ball_suit_by_player_id)

	_game_state.current_play_state = Enums.PlayState.AIMING
	_occurrences_during_shot.clear()
	GameEvents.shot_completed.emit()


func _check_and_set_ball_suit_for_players(ball: Ball):
	var cp_id = _game_state.current_player_id
	if _game_state.ball_suit_by_player_id[cp_id] == Enums.BallType.TBD:
		_game_state.ball_suit_by_player_id[cp_id] = ball.ball_type
		var op_id = _get_other_player_id(cp_id)

		var suits_remaining = [Enums.BallType.SOLIDS, Enums.BallType.STRIPES]
		suits_remaining.erase(ball.ball_type)
		
		_game_state.ball_suit_by_player_id[op_id] = suits_remaining[0]

		
func _get_other_player_id(player_id: int) -> int:
	return int(not player_id)
			


func _on_ball_potted(ball: Ball, pocket: Pocket):
	var pocket_occurrence = PocketOccurrence.new()
	pocket_occurrence.ball = ball
	pocket_occurrence.pocket = pocket
	_occurrences_during_shot.append(pocket_occurrence)

func _on_all_balls_stopped():
	if _game_state.current_play_state == Enums.PlayState.BALLS_IN_PLAY:
		_process_rules()


## Occurrence classes
class Occurrence:
	pass


class PocketOccurrence extends Occurrence:
	var ball: Ball
	var pocket: Pocket

