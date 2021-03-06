all: roms/pzero/monitor.rom image.bin
ec65k: roms/ec65/ec65k.ic19

roms/pzero/monitor.rom: src/monitor.a src/macros.a src/bytecodes.a src/primitive.a src/memory.a
	@mkdir -p roms/pzero
	acme -l rom.list -f plain -o $@ src/monitor.a

roms/ec65/ec65k.ic19: src/*.a
	acme -l ec65k.list -f plain -o $@ src/mon65k.a

char.bin: fonts/8x8.a
	acme -f plain -o $@ $<

image.bin: image.a
	acme -f plain -o $@ image.a

test.bin: test/*.a
	acme -f plain -o $@ $<

