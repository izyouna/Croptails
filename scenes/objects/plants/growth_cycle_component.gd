class_name GrowthCycleComponent
extends Node2D

@export var current_growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Gremination 
@export_range(5, 365) var day_until_harvest: int = 7

signal crop_maturity
signal crop_harvesting

var is_waterd: bool
var starting_day: int
var current_day: int

func _ready() -> void:
	DayAndNightCycleManager.time_tick_day.connect(on_time_tick_day)
	
func on_time_tick_day(day: int) -> void:
	if is_waterd:
		if starting_day == 0:
			starting_day = day

		growth_states(starting_day, day)
		harvest_state(starting_day, day)

func growth_states(starting_day : int,current_day: int):
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		return
		
	var num_states = 5
	var growth_day_passed = (current_day - starting_day) % num_states
	var state_index = growth_day_passed % num_states + 1
	
	current_growth_state = state_index
	
	var name = DataTypes.GrowthStates.keys()[current_growth_state]
	print("Current growth state", name , "State index" , state_index)
	
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		crop_maturity.emit()
		
func harvest_state(starting_day: int, current_day: int) -> void:
	if current_growth_state == DataTypes.GrowthStates.Harvesting:
		return
		
	var days_passed = (current_day - starting_day) % day_until_harvest
	
	if days_passed == day_until_harvest - 1:
		current_growth_state = DataTypes.GrowthStates.Harvesting
		crop_harvesting.emit()
	
func get_current_growth_state() -> DataTypes.GrowthStates:
	return current_growth_state		
