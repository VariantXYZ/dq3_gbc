SECTION "Metamap 68", ROMX[$4C00], BANK[$76]
Metamap68::
  dw Map68
  dw $9C2D
  dw $9C6D
  dw $9C2D
  db $40,$01,$03,$01
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$30,$8D,$00
Map68::
  db $0A,$05 ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$47,$88,$DE,$88,$E3,$88,$E6,$88,$DE,$88,$E1,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$D9,$88,$DE,$88,$E3,$88,$DF,$88,$E4,$88,$E2,$88,$7E,$88,$65,$A8; 03 
  db $64,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$66,$C8,$64,$E8; 04 