#!/bin/sh

mkdir -p include libpico include/hardware_regs  include/hardware_structs

find ../pico-sdk/src/rp2040/hardware_regs -name '*.h' -exec cp '{}' include/hardware_regs \;
find ../pico-sdk/src/rp2040/hardware_structs -name '*.h' -exec cp '{}' include/hardware_structs \;

find ../pico-sdk/src/common -name '*.h' -exec cp '{}' include \;
find ../pico-sdk/src/rp2_common -name '*.h' -exec cp '{}' include \;
cp ../pico-sdk/src/boards/include/boards/pico.h include/boards_pico.h
cp ../pico-sdk/src/boards/include/boards/pico_w.h include/boards_pico_w.h
cp ../pico-examples/build/generated/pico_base/pico/version.h include
cp ../pico-sdk/src/common/pico_base/include/pico/config.h include

mv include/stdio.h include/pico_stdio.h
mv include/stdlib.h include/pico_stdlib.h
mv include/assert.h include/pico_assert.h
mv include/hardware_regs/platform_defs.h include

find ../pico-sdk/src/common -name '*.[cS]' -exec cp '{}' libpico \;
find ../pico-sdk/src/rp2_common -name '*.[cS]' -exec cp '{}' libpico \;

sam -d include/*.h include/*/*.h < sam.script
sam -d libpico/*.[cS] < sam.script
