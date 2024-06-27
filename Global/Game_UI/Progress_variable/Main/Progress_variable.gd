extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	set_ui_money()
	Variables.money_changed.connect(set_ui_money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_ui_money():
	var currentMoney = Variables.MONEY
	var currentMoneyWithFormatting = Utils.format_rupiah(currentMoney)
	$HBoxContainer/Progress_money/Label.set_text(currentMoneyWithFormatting)

func set_ui_public_welfare():
	var currentPublicWelfare = Variables.VAR_KESEJAHTERAAN_MASYARAKAT
	
