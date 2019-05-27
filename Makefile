all: roms/pzero/monitor.rom

roms/pzero/monitor.rom: src/monitor.a src/macros.a src/bytecodes.a src/primitive.a
	acme -l rom.list -f plain -o $@ src/monitor.a
