SECTION "Metamap 2B", ROMX[$7EB8], BANK[$74]
Metamap2B::
  dw Map2B
  dw $9C2D
  dw $9C6D
  dw $9C2D
  db $40,$01,$03,$05
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$00,$88,$00
Map2B::
  db $0B,$05 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$0B,$80,$3C,$80,$7E,$88,$1D,$80,$3C,$80,$33,$80,$28,$80,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$0A,$80,$7E,$88,$37,$80,$32,$80,$7E,$88,$23,$80,$7E,$88,$7E,$88,$65,$A8; 03 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 04 