#!/bin/bash

export PROJECTNAME="."
echo "the project location is : $PROJECTNAME"
# clean source and bench libs
echo "removing libs"
vdel -lib $PROJECTNAME/lib/source -all
vdel -lib $PROJECTNAME/lib/bench -all

# create source and bench libs
echo "creating work libs"
vlib $PROJECTNAME/lib/source
vmap source $PROJECTNAME/lib/source
vlib $PROJECTNAME/lib/bench
vmap bench $PROJECTNAME/lib/bench
# map existing AESLibrary lib
vlib $PROJECTNAME/lib/AESLibrary
vmap AESLibrary $PROJECTNAME/lib/AESLibrary

# compile sources and launch the VHDL simulator
echo "compile vhdl sources"
vcom -work source $PROJECTNAME/sources/KeyExpansion_table.vhd
vcom -work source $PROJECTNAME/sources/S_box.vhd
vcom -work source $PROJECTNAME/sources/InvShiftRows.vhd
vcom -work source $PROJECTNAME/sources/InvAddRoundKey.vhd
vcom -work source $PROJECTNAME/sources/InvSubBytes.vhd
vcom -work source $PROJECTNAME/sources/InvMixColumns.vhd
vcom -work source $PROJECTNAME/sources/counter.vhd
vcom -work source $PROJECTNAME/sources/state_definition_package.vhd
vcom -work source $PROJECTNAME/sources/InvFSM.vhd
vcom -work source $PROJECTNAME/sources/RTL_MUX.vhd
vcom -work source $PROJECTNAME/sources/InvAESRound.vhd
vcom -work source $PROJECTNAME/sources/InvAES.vhd
#vcom -work source $PROJECTNAME/bench/state_definition_package.vhd

echo "compile vhdl test bench"
vcom -work bench $PROJECTNAME/bench/KeyExpansion_table_tb.vhd
vcom -work bench $PROJECTNAME/bench/S_box_tb.vhd
vcom -work bench $PROJECTNAME/bench/InvShiftRows_tb.vhd
vcom -work bench $PROJECTNAME/bench/InvAddRoundKey_tb.vhd
vcom -work bench $PROJECTNAME/bench/InvSubBytes_tb.vhd
vcom -work bench $PROJECTNAME/bench/InvMixColumns_tb.vhd
vcom -work bench $PROJECTNAME/bench/counter_tb.vhd
vcom -work bench $PROJECTNAME/bench/InvFSM_tb.vhd
vcom -work bench $PROJECTNAME/bench/RTL_MUX_tb.vhd
vcom -work bench $PROJECTNAME/bench/InvAESRound_tb.vhd
vcom -work bench $PROJECTNAME/bench/InvAES_tb.vhd
echo "compilation finished"
echo "start simulation..."
#vsim bench.keyexpansion_table_tb &
#vsim bench.s_box_tb &
#vsim bench.invshiftrows_tb &
#vsim bench.invaddroundKey_tb &
#vsim bench.invSubbytes_tb &
#vsim bench.invMixColumns_tb &
#vsim bench.counter_tb &
vsim bench.InvAES_tb &

