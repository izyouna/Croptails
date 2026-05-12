class_name DayNightCycleComponent
extends CanvasModulate

@export var init_day: int = 1:
	set(id):
		init_day = id
		DayAndNightCycleManager.init_day = id
		DayAndNightCycleManager.set_init_time()

@export var init_hour: int = 12:
	set(ih):
		init_hour = ih
		DayAndNightCycleManager.init_hour = ih
		DayAndNightCycleManager.set_init_time()
		
@export var init_min: int = 30:
	set(im):
		init_min = im
		DayAndNightCycleManager.init_min = im
		DayAndNightCycleManager.set_init_time()

@export var day_night_gradient_texture: GradientTexture1D

func _ready() -> void:
	DayAndNightCycleManager.init_day = init_day
	DayAndNightCycleManager.init_hour = init_hour
	DayAndNightCycleManager.init_min = init_min
	DayAndNightCycleManager.set_init_time()
	
	DayAndNightCycleManager.game_time.connect(on_game_time)
	
func  on_game_time(time: float) -> void:
	var sample_value = 0.5 * (sin(time - PI * 0.5) + 1.0)
	color = day_night_gradient_texture.gradient.sample(sample_value)
