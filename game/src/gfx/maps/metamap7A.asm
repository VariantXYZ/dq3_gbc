SECTION "Metamap 7A", ROMX[$6ED0], BANK[$76]
Metamap7A::
  dw Map7A
  dw $9C2D
  dw $9C2D
  dw $9C2D
  db $40,$01,$02,$01
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $18,$00,$88,$00
Map7A::
  db $0C,$03 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$13,$80,$32,$80,$38,$80,$35,$80,$31,$80,$24,$80,$2F,$80,$7E,$88,$7E,$88,$65,$A8; 01 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 02 