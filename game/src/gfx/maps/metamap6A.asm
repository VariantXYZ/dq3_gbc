SECTION "Metamap 6A", ROMX[$4C7E], BANK[$76]
Metamap6A::
  dw Map6A
  dw $9C2D
  dw $9D2D
  dw $9C2D
  db $40,$01,$06,$01
  db $00,$00,$A0,$00
  db $00,$00,$00,$00
  db $00,$20,$8D,$00
Map6A::
  db $0B,$0A ; Width, Height
  ;   T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A , T , A 
  db $64,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$66,$88,$64,$A8; 00 
  db $65,$88,$7E,$88,$DA,$88,$DB,$88,$D9,$88,$6F,$88,$6E,$88,$6E,$88,$DF,$88,$7E,$88,$65,$A8; 01 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 02 
  db $65,$88,$7E,$88,$D3,$88,$D2,$88,$D7,$88,$6F,$88,$6E,$88,$6E,$88,$DF,$88,$7E,$88,$65,$A8; 03 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 04 
  db $65,$88,$7E,$88,$DD,$88,$D5,$88,$DB,$88,$6F,$88,$6E,$88,$6E,$88,$DF,$88,$7E,$88,$65,$A8; 05 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 06 
  db $65,$88,$7E,$88,$D5,$88,$D8,$88,$DB,$88,$6F,$88,$6E,$88,$6E,$88,$DF,$88,$7E,$88,$65,$A8; 07 
  db $65,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$7E,$88,$65,$A8; 08 
  db $65,$88,$7E,$88,$D7,$88,$DC,$88,$D4,$88,$D6,$88,$6F,$88,$6E,$88,$6E,$88,$DF,$88,$65,$A8; 09 