#!/bin/python
import os
import sys
from collections import OrderedDict

sys.path.append(os.path.join(os.path.dirname(__file__), 'common'))
from common import utils

# Arguments
script_name = sys.argv[0]
script_res_path = sys.argv[1]
gfx_src_path = sys.argv[2]
map_src_path = sys.argv[3]

rom_version = "en"
rom_ptrs_bank = 0x9
rom_ptrs_addr = 0x5591
rom_map_count = 157
rom_filename = f"baserom_{rom_version}.gbc"
gfx_src_filename = os.path.join(gfx_src_path, "maps_data.asm")

meta_filename = os.path.join(script_res_path, "meta_map_files.tbl")
meta_filetable = {}
meta_fp = None
if os.path.exists(meta_filename):
    meta_filetable = utils.read_table(meta_filename, keystring=True)
else:
    meta_fp = open(meta_filename, 'w')

try:
    with open(rom_filename, 'rb') as rom:
        with open(gfx_src_filename, 'w') as source_fp:
            tilemaps = []
            tilemap_banks = []
            metamaps = []
            
            source_fp.write(f"; File initially autogenerated by {script_name}\n")
            source_fp.write('INCLUDE "game/src/common/macros.asm"\n')
            source_fp.write('\n')

            source_fp.write(f'SECTION "Metamap Pointers", ROMX[${rom_ptrs_addr:04X}], BANK[${rom_ptrs_bank:02X}]\n')
            source_fp.write(f'MetamapPointers::\n')

            rom.seek(utils.rom2realaddr((rom_ptrs_bank, rom_ptrs_addr)))
            for metamap_idx in range(0, rom_map_count):
                ptr = utils.read_short(rom)
                bank = utils.read_byte(rom)
                metamap_name = f"{metamap_idx:02X}"

                if metamap_name in meta_filetable:
                    metamap_name = meta_filetable[metamap_name]
                elif meta_fp is not None:
                    meta_fp.write(f'{metamap_name}={metamap_name}\n')

                if(ptr == 0x0000 and bank == 0x00):
                    # An empty entry
                    source_fp.write(f'  dwb $0000, $00 ; Index {metamap_idx:02X}\n')
                else:
                    source_fp.write(f'  dwb Metamap{metamap_name}, BANK(Metamap{metamap_name})\n')

                metamaps.append((bank, ptr))
            source_fp.write('MetamapPointersEnd::\n')


        for metamap_idx, metamap in enumerate(metamaps):
            bank = metamap[0]
            ptr = metamap[1]

            if ptr == 0x0000 and bank == 0x00:
                continue

            metamap_name = f"{metamap_idx:02X}"

            if metamap_name in meta_filetable:
                metamap_name = meta_filetable[metamap_name]  

            map_src_filename = os.path.join(map_src_path, f"metamap{metamap_name}.asm")

            with open(map_src_filename, 'w') as source_fp: 
                source_fp.write(f'SECTION "Metamap {metamap_name}", ROMX[${ptr:04X}], BANK[${bank:02X}]\n')
                source_fp.write(f'Metamap{metamap_name}::\n')
                rom.seek(utils.rom2realaddr(metamap))
                tilemap_ptr = utils.read_short(rom)
                
                idx = len(tilemaps)
                try:
                    idx = tilemaps.index(tilemap_ptr)
                except ValueError:
                    tilemaps.append(tilemap_ptr)
                    tilemap_banks.append(bank)
                source_fp.write(f'  dw Map{idx:02X}\n')

                # Record the metadata, even though we don't know exactly what it all does yet
                source_fp.write(f'  dw ${utils.read_short(rom):04X}\n') # Seems to be a VRAM address
                source_fp.write(f'  dw ${utils.read_short(rom):04X}\n') # Seems to be a VRAM address
                source_fp.write(f'  dw ${utils.read_short(rom):04X}\n') # Seems to be a VRAM address
                source_fp.write(f'  db ${utils.read_byte(rom):02X},${utils.read_byte(rom):02X},${utils.read_byte(rom):02X},${utils.read_byte(rom):02X}\n') # tbd
                source_fp.write(f'  db ${utils.read_byte(rom):02X},${utils.read_byte(rom):02X},${utils.read_byte(rom):02X},${utils.read_byte(rom):02X}\n') # tbd
                source_fp.write(f'  db ${utils.read_byte(rom):02X},${utils.read_byte(rom):02X},${utils.read_byte(rom):02X},${utils.read_byte(rom):02X}\n') # tbd
                source_fp.write(f'  db ${utils.read_byte(rom):02X},${utils.read_byte(rom):02X},${utils.read_byte(rom):02X},${utils.read_byte(rom):02X}\n') # tbd
                
                # The map is always right after the metadata
                source_fp.write(f'Map{idx:02X}::\n')
                width = utils.read_byte(rom)
                height = utils.read_byte(rom)
                source_fp.write(f'  db ${width:02X},${height:02X} ; Width, Height\n')

                # Each tile is [Tile Idx, Attribute], so width is actually 2x
                source_fp.write('  ;  ' + ",".join([" T , A "] * width) + '\n')
                for h in range(0, height):
                    source_fp.write('  db ')
                    source_fp.write(",".join([f"${utils.read_byte(rom):02X}" for w in range(0, width * 2)]))
                    source_fp.write(f'; {h:02X} \n')
finally:
    if meta_fp:
        meta_fp.close()