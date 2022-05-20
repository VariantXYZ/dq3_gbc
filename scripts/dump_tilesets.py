#!/bin/python
import os
import sys
from collections import OrderedDict

sys.path.append(os.path.join(os.path.dirname(__file__), 'common'))
from common import utils, gfx

# Constants
BYTES_PER_TILE = ((2 * 8 * 8) // 8)

# Arguments
script_name = sys.argv[0]
gfx_src_path = sys.argv[1]
gfx_raw_path = sys.argv[2]
gfx_out_path = sys.argv[3]

rom_filename = "baserom_en.gbc"

# We just manually define tilesets to dump, there's not really any table
tileset_information = (
    # Name, Address, Type (2bpp, compressed), Tile Count (ignored when compressed)
    ["TextAdditional", (0x1, 0x4ad1), "compressed", None],
    ["NormalCharacters", (0x1, 0x5000), "2bpp", 11 * 16],
    ["DoubleHeightCharacters", (0x1, 0x6000), "2bpp", 22 * 16],
)

gfx_src_filename = os.path.join(gfx_src_path, "tilesets_data.asm")

with open(rom_filename, "rb") as rom, open(gfx_src_filename, "w") as source_fp:
    source_fp.write(f"; File initially autogenerated by {script_name}\n")
    source_fp.write('\n')

    for tileset in tileset_information:
        assert tileset[2] in ["2bpp", "compressed"]
        name = tileset[0]
        address = utils.rom2realaddr(tileset[1]) if isinstance(tileset[1], tuple) else tileset[1]
        rom_address = tileset[1] if isinstance(tileset[1], tuple) else utils.real2romaddr(tileset[1])
        png_filename = os.path.join(gfx_raw_path, f"{name}.{tileset[2]}.png")
        out_filename = os.path.join(gfx_out_path, f"{name}.{tileset[2]}")
        size = 0

        rom.seek(address)
        data = []
        if tileset[2] == "2bpp":
            size = BYTES_PER_TILE * tileset[3]
            data = rom.read(size)
        elif tileset[2] == "compressed":
            size = utils.read_short(rom) # Total bytes, of uncompressed tileset
            # Note the byte that defines 'when' a repeat command starts, usually it's '01'
            compression_byte = utils.read_byte(rom)
            i = 0
            length = 0
            while (i < size):
                b = utils.read_byte(rom)

                if b == compression_byte:
                    offset_to_copy = utils.read_byte(rom)
                    flag = utils.read_byte(rom)
                    # The low nibble of the 'flag' define the count
                    count = (flag & 0xf) + 0x4 # Minimum count 4
                    if count == 0x13:
                        # If the count is 19 (0xf + 0x4, the maximum), the count is 19 + the next byte
                        count = utils.read_byte(rom)
                        count += 0x13
                    # High nibble of flag act as the high bytes for offset
                    offset_to_copy = ((flag & 0xf0) << 4) | offset_to_copy
                    for c in range(0, count):
                        d = data[offset_to_copy]
                        data.append(d)
                        offset_to_copy += 1
                    i += count
                else:
                    data.append(b)
                    i += 1

        gfx.dump_2bpp_to_png(png_filename, data)

        source_fp.write(f'SECTION "Tileset {name}", ROMX[${rom_address[1]:04X}], BANK[${rom_address[0]:02X}]\n')
        source_fp.write(f'Tileset{name}::\n')
        source_fp.write(f'  INCBIN "{out_filename}"\n')
        source_fp.write(f'SECTION "Tileset {name} End", ROMX[${utils.real2romaddr(rom.tell())[1]:04X}], BANK[${rom_address[0]:02X}]\n')
        
        source_fp.write('\n')