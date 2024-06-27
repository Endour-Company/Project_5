extends Control

var texts = [
	"Ah, halo " + Variables.PLAYER_NAME + ". Akhirnya kamu datang juga, selamat datang di balai desa.",
	"Mobil polisi tadi? Mereka baru saja membawa mantan kepala desa.",
	"Dua hari yang lalu, dia tertangkap basah melakukan penggelapan dana desa. Hari ini dia dibawa polisi ke penjara di kota.",
	"Masih ingat, kan? Hasil dari rapat kemarin bersama dengan warga desa, kamu sudah ditunjuk sebagai penggantinya.",
	"Oke, jadi, hari ini kamu akan langsung bekerja, ya!",
	"Pertama-tama, ada tiga aspek yang harus kamu ingat sebagai kepala desa.",
	"Kamu harus memerhatikan pendapatan desa, kesejahteraan, dan kesehatan masyarakat.",
	"Kondisi fasilitas-fasilitas yang ada di seluruh desa akan memengaruhi ketiga aspek tersebut.",
	"Untuk menjadi kepala desa yang berhasil, kamu harus memajukan ketiga aspek tersebut.",
	"Selanjutnya, kamu harus paham keempat sektor yang dimiliki desa ini.",
	"Sekarang kita berada di sektor pusat desa. Di sini, ada balai desa, puskesmas, pasar, dan lapangan.",
	"Ini adalah pemukiman. Di sinilah tempat wargamu tinggal. Namun, dapat dilihat bahwa kondisinya masih kotor.",
	"Kamu dapat meningkatkan fasilitas-fasilitas di sini untuk memperbaiki kondisi lingkungan pemukiman.",
	"Ini adalah sawah. Sektor ini adalah salah satu sumber pendapatan desa.",
	"Jadi pastikan untuk meningkatkan fasilitas sektor ini untuk menambah pendapatan desa.",
	"Yang terakhir adalah sektor hutan. Seperti sektor sawah, sektor ini juga merupakan sumber pendapatan desa.",
	"Di sini, kamu dapat menanam beberapa jenis pohon yang dapat kamu tebang untuk menambah pendapatan.",
	"Namun, pastikan hutan tidak gundul supaya kondisi lingkungan tetap terjaga.",
	"Nah, itu semua adalah keempat sektor penting yang ada di desa ini.",
	"Ingat, kamu akan menjabat selama lima tahun. Gunakan waktumu sebaik-baiknya, dan jadilah kepala desa yang bijaksana.",
	"Kalau ada yang masih belum kamu pahami, kamu bisa buka tutorial melalui tombol Option yang ada di pojok kanan atas.",
	"Semoga berhasil!"
]

var dialogIndex = 0
var dialogDone = false
@onready var dialogLabel =  $DialogLabel
@onready var dialogNextLabel = $NextLabel
@onready var dialogTimer = $DialogTimer
@onready var anim = $AnimationPlayer
@onready var dialogNextAnim = $NextDialogAnim
@onready var SFX = $SFX

signal prolog_done

func _ready():
	SFX.set_volume_db(GameAudio.get_volume_sfx())

func show_text():
	clear_text()
	dialogLabel.set_text(texts[dialogIndex])
	dialogTimer.start()
	dialogIndex += 1

func clear_text():
	dialogDone = false
	dialogLabel.set_text("")
	dialogLabel.set_visible_characters(0)
	dialogNextLabel.set_visible(false)
	dialogNextAnim.stop()

func _on_dialog_timer_timeout():
	dialogLabel.visible_characters += 1
	if dialogLabel.visible_ratio == 1:
		# Dialog is done
		dialogTimer.stop()
		dialogNextAnim.play("next_idle")
		dialogNextLabel.set_visible(true)
		dialogDone = true

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Fade Out":
			prolog_done.emit()
		_:
			show_text()

func _process(delta):
	if dialogDone and Input.is_action_just_pressed("mb_left"):
		# Play click sfx
		GameAudio.play(SFX, GameAudio.SFX_Gameplay_Click)
		
		# Next slide
		if dialogIndex == 11:
			clear_text()
			anim.play("Transition Pemukiman")
		elif dialogIndex == 13:
			clear_text()
			anim.play("Transition Sawah")
		elif dialogIndex == 15:
			clear_text()
			anim.play("Transition Hutan")
		elif dialogIndex == 18:
			clear_text()
			anim.play("Transition Pusat Desa")
		elif dialogIndex == 22:
			clear_text()
			anim.play("Fade Out")
		else:
			show_text()
