SECTION "Metamap 82", ROMX[$5AF8], BANK[$76]
Metamap82::
  dw Map82
  dw $9C2D
  dw $9CAD
  dw $9C2D
  db $40,$01,$04,$06
  db $00,$00,$00,$00
  db $00,$00,$00,$00
  db $40,$00,$88,$00
Map82::
  db $0C,$07 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$21,$80,$7E,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$21,$80,$7E,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$DB,$80,$21,$80,$7E,$88,$7E,$88,$65,$A8; 05 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 06 