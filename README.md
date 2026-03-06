# Tutorial 4 — Game Development

## Level 2: Snow Stage

### Deskripsi

Level 2 adalah stage bertema **salju (snow)** yang lebih sulit dibandingkan Level 1. Perbedaan utama:

| Aspek | Level 1 | Level 2 |
|-------|---------|---------|
| **Tileset** | Grass + Dirt | **Snow + Stone** |
| **Rintangan jatuh** | Ikan biru (FallingFish) | **Gergaji berputar (FallingSaw)** |
| **Tema** | Padang rumput | **Pegunungan salju** |

### Fitur Level 2

1. **Tileset berbeda** — Menggunakan `spritesheet_gr_snow.png` dan `spritesheet_gr_stone.png` sebagai tile map, memberikan nuansa lingkungan salju/pegunungan yang berbeda dari level pertama.

2. **Rintangan baru: Falling Saw** — Objek gergaji (saw blade) yang berjatuhan secara periodik dari spawner di atas map. Saw blade ini **berputar saat jatuh** (polishing) dan akan hilang ketika mengenai tanah.

3. **Jurang (Pit)** — Area kosong di bawah map yang berfungsi sebagai death zone. Jika pemain jatuh ke jurang, maka akan langsung ke LoseScreen.

4. **Spawner periodik** — Spawner yang secara terus-menerus menghasilkan objek `FallingSaw` dari posisi acak di atas map.

### Proses Implementasi

#### 1. Membuat Obstacle Baru (`falling_saw.gd` & `falling_saw.tscn`)
- Membuat script `falling_saw.gd` yang mirip dengan `falling_fish.gd` tetapi dengan tambahan fitur rotasi otomatis (`rotation_speed`) agar saw blade terlihat berputar saat jatuh.
- Menggunakan `class_name FallingSaw` agar dapat dideteksi oleh player melalui keyword `is`.
- Menggunakan `contact_monitor` dan signal `body_entered` untuk mendeteksi tabrakan dengan tanah dan menghapus diri sendiri (`queue_free()`).
- Scene menggunakan `RigidBody2D` dengan `CircleShape2D` (bentuk bulat sesuai saw blade) dan sprite `saw.png` dari Kenney Platformer Pack.
- `collision_layer = 2` dan `collision_mask = 2` agar konsisten dengan sistem collision yang sudah ada.

#### 2. Membuat Level 2 Scene (`Level2.tscn`)
- Menggunakan `TileSet` baru dengan sumber atlas dari `spritesheet_gr_snow.png` (sebagai permukaan atas/snow) dan `spritesheet_gr_stone.png` (sebagai dekorasi bawah tanah).
- Layout platform dirancang untuk memaksa pemain melakukan lompatan-lompatan presisi.
- Menambahkan `ChangeSceneArea` di bagian bawah map sebagai death pit yang mengarahkan ke `LoseScreen`.
- Menambahkan area kemenangan (Goal) dengan `ChangeSceneArea` yang mengarahkan ke `WinScreen`.
- Spawner menggunakan `spawner.gd` yang sudah ada, tetapi dengan obstacle diubah ke `falling_saw.tscn`.

#### 3. Mengupdate Player (`player.gd`)
- Menambahkan deteksi `FallingSaw` pada fungsi `_on_hit_box_body_entered`:
  ```gdscript
  if body is FallingFish or body is FallingSaw:
      get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")
  ```

### Polishing (Nilai 4)

- **Rotasi saw blade** — Gergaji berputar saat jatuh, memberikan visual yang lebih menarik dan berbahaya.
- **Layout yang menantang** — Platform yang membutuhkan lompatan presisi dan timing yang tepat untuk menghindari saw blade.
- **Tileset tematik** — Penggunaan tileset salju yang memberikan suasana berbeda dari level pertama.

### Referensi

- [Kenney Platformer Pack](https://kenney.nl/assets/platformer-pack-redux) — Asset pack yang digunakan untuk sprite tiles, enemies, dan items.
- [Godot Engine Documentation - TileMap](https://docs.godotengine.org/en/stable/classes/class_tilemap.html) — Referensi untuk penggunaan TileMap di Godot.
- [Godot Engine Documentation - RigidBody2D](https://docs.godotengine.org/en/stable/classes/class_rigidbody2d.html) — Referensi untuk contact monitoring pada RigidBody2D.
- [Godot Engine Documentation - class_name](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#registering-named-classes) — Referensi untuk penggunaan `class_name` dan keyword `is` di GDScript.
