all: roms/pzero/monitor.rom image.bin

roms/pzero/monitor.rom: src/monitor.a src/macros.a src/bytecodes.a src/primitive.a src/memory.a
	@mkdir -p roms/pzero
	acme -l rom.list -f plain -o $@ src/monitor.a

char.bin: fonts/8x8.a
	acme -f plain -o $@ $<

image.bin: image.a
	acme -f plain -o $@ image.a

