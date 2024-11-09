extends State
signal insturction(state)
signal insturction_2(state)
signal Runat(state)
@export var D2:State
@export var SearchState:State
var command=true
func enter() ->void:
	var nodes_in_group = get_tree().get_nodes_in_group("skeli")
	for node in nodes_in_group:
		node.connect("colliding", Callable(self, "state_func"))
		node.connect("Notcolliding", Callable(self, "RunAt_from_attack"))
func _unhandled_input(_event: InputEvent) ->void:
	pass
func process_physics(_delta: float) -> State:
	var nodes_in_group = get_tree().get_nodes_in_group("skeli")
	for node in nodes_in_group:
		if node.position == player.position and command:
			command=false
			Sig_Attack()
		elif node.position != player.position and command:
			command=false
			Sig_RunAt()
	if Global.skeli==0:
		return SearchState
	return null
func _process(_delta: float) -> void:
	pass
func state_func(info) -> State:
	emit_signal("insturction_2",info)
	return null
func Sig_Attack():
	emit_signal("insturction","attack:")
func Sig_RunAt():
	emit_signal("insturction","runat")
func Sig_Defend():
	emit_signal("insturction","defend")
func RunAt_from_attack(info):
	emit_signal("Runat",info)
