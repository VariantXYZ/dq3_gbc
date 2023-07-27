INCLUDE "game/src/common/constants.asm"
INCLUDE "game/src/common/macros.asm"

SECTION "Map functions 1", ROM0[$2f1b]
DrawMap::
  ld a, $08
  ld [$2100], a
  call $6382
  push de
  ldh a, [$ff00+$bf]
  ld [$2100], a
  call $2d72
  ld a, BANK(MetamapPointers)
  ld [$2100], a
  push bc
  push hl
  ld a, b
  ld [$cde7], a
  ld hl, DrawMapHelper
  ld b, BANK(DrawMapHelper)
  rst $10
  pop hl
  pop bc
  ld c, b
  CallHack LoadPatchTilesetForMetamap ; Load a tileset if one is configured, returns bc as 3 * c
  ld hl, MetamapPointers
  add hl, bc
  ldi a, [hl]
  ld c, a
  ldi a, [hl]
  ld b, a
  ldi a, [hl]
  ld [$2100], a
  ld l, c
  ld h, b
  pop bc
  ldi a, [hl]
  ld [bc], a
  inc bc
  ldi a, [hl]
  ld [bc], a
  inc bc
  ld a, [C_CurrentBank]
  ld [bc], a
  inc bc
  ld a, e
  ld [bc], a
  inc bc
  ld a, d
  ld [bc], a
  inc bc
  ldi a, [hl]
  add e
  ld [bc], a
  inc bc
  ldi a, [hl]
  adc d
  ld [bc], a
  inc bc
  ldi a, [hl]
  add e
  ld [bc], a
  inc bc
  ldi a, [hl]
  adc d
  ld [bc], a
  inc bc
  ldi a, [hl]
  add e
  ld [bc], a
  inc bc
  ldi a, [hl]
  adc d
  ld [bc], a
  inc bc
  ld a, $20
  ld [bc], a
  inc bc
  ld e, c
  ld d, b
  ld b, $0d
  call CopyHLtoDE
  or a
  jr z, .asm_2fbe
  ldi a, [hl]
  ld [de], a
  inc de
  ldi a, [hl]
  ld [de], a
  inc de
  jr z, .asm_2fbe
  ld a, [$de50]
  ld c, a
  add $e0
  ld [de], a
  inc de
  ld a, $dd
  jr nc, .asm_2fa0
  inc a
.asm_2fa0
  ld [de], a
  inc de
  ld a, c
  swap a
  and $f0
  add $50
  rl b
  ld [de], a
  inc de
  ld a, c
  swap a
  and $0f
  srl b
  adc $d7
  ld [de], a
  inc de
  ld a, [hl]
  ld [de], a
  add c
  ld [$de50], a
.asm_2fbe
  ldh a, [$ff00+$bf]
  ld [$2100], a
  jp $2ddb

  padend $2fc6

SECTION "Map functions 2", ROMX[$5543], BANK[$09]
DrawMapHelper::
  push de
  ld a, [$cde7]
  ld hl, TilesetGoldAndAsterisk ; G* tileset
  ld de, $8a90
  ld bc, $20
  cp $0b
  jr z, .asm_25577
  cp $4b
  jr z, .asm_25577
  ld hl, TilesetGoldAndAsterisk + $10 ; just the *
  ld de, $8aa0
  ld bc, $0010
  cp $64
  jr z, .asm_25577
  cp $8f
  jr z, .asm_25577
  cp $94
  jr z, .asm_25577
  cp $95
  jr z, .asm_25577
  cp $96
  jr z, .asm_25577
  jr .asm_2558f
.asm_25577
  ldh a, [$ff00+$4f]
  push af
  ld a, $01
  ldh [$ff00+$4f], a
.asm_2557e
  ldh a, [$ff00+$41]
  bit 1, a
  jr nz, .asm_2557e
  ldi a, [hl]
  ld [de], a
  inc de
  dec bc
  ld a, c
  or b
  jr nz, .asm_2557e
  pop af
  ldh [$ff00+$4f], a
.asm_2558f
  pop de
  ret

  padend $5591

  ; MetamapPointers