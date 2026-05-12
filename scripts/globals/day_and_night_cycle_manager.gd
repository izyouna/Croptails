extends Node

const MINUTES_PER_DAY: int = 24 * 60
const MINUTES_PER_HOUR: int = 60
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_DAY

var game_speed: float = 5.0

var init_day: int = 1
var init_hour: int = 12
var init_min: int = 30

var time: float = 0.0
var current_min: int = -1
var current_day: int = 0

signal game_time(time:float)
signal time_tick(day: int, hour: int, min: int)
signal time_tick_day(day:int)

func _ready() -> void:
	set_init_time()

func _process(delta: float) -> void:
	time += delta * game_speed * GAME_MINUTE_DURATION
	game_time.emit(time)
	
	recalculate_time()
	
func set_init_time() -> void:
	var init_total_min = init_day * MINUTES_PER_DAY + (init_hour * MINUTES_PER_HOUR) + init_min
	
	time = init_total_min * GAME_MINUTE_DURATION
	
func recalculate_time() -> void:
	var total_min: int = int(time / GAME_MINUTE_DURATION)
	var day: int = int(total_min / MINUTES_PER_DAY)
	var current_day_min: int = total_min % MINUTES_PER_DAY
	var hour: int = int(current_day_min / MINUTES_PER_HOUR)
	var min: int = int(current_day_min % MINUTES_PER_HOUR)
	
	if current_min != min:
		current_min = min
		time_tick.emit(day, hour, min)
		
	if current_day != day:
		current_day = day
		time_tick.emit(day) 
	
