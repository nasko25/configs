#set disassembly-flavor intel
#set disable-randomization off
#set follow-fork-mode child
target remote localhost:1234
symbol-file build/kernel.sym
b _switch_to_usermode

set pagination off

#b _save_state
define hook-stop
i r r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 sp lr pc
#i f
#i s
x/28x $sp
#echo The stack at the beginning was:\n
#x/20x 0x800256e8
#echo \n\n\n
info proc mappings
# help info proc                # for more info
end
