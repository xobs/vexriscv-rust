#define REG_READ(name, offset) \
.section .text.__read_ ## name; \
.global __read_ ## name; \
__read_ ## name: \
    csrrs a0, offset, x0; \
    ret

#define REG_WRITE(name, offset) \
.section .text.__write_ ## name; \
.global __write_ ## name; \
__write_ ## name: \
    csrrw x0, offset, a0; \
    ret

#define REG_SET(name, offset) \
.section .text.__set_ ## name; \
.global __set_ ## name; \
__set_ ## name: \
    csrrs x0, offset, a0; \
    ret

#define REG_CLEAR(name, offset) \
.section .text.__clear_ ## name; \
.global __clear_ ## name; \
__clear_ ## name: \
    csrrc x0, offset, a0; \
    ret


#define REG_READ_WRITE(name, offset) REG_READ(name, offset); REG_WRITE(name, offset)
#define REG_SET_CLEAR(name, offset) REG_SET(name, offset); REG_CLEAR(name, offset)

#define RW(offset, name) REG_READ_WRITE(name, offset); REG_SET_CLEAR(name, offset)
#define RO(offset, name) REG_READ(name, offset)

#if __riscv_xlen == 32
#define RW32(offset, name) RW(offset, name)
#define RO32(offset, name) RO(offset, name)
#else
#define RW32(offset, name)
#define RO32(offset, name)
#endif


// VexRiscv custom registers
RW(0xBC0, vmim)     // Machine IRQ Mask
RO(0xFC0, vmip)     // Machine IRQ Pending
RW(0x9C0, vsim)     // Supervisor IRQ Mask
RO(0xDC0, vsip)     // Supervisor IRQ Pending
RO(0xCC0, vdci)     // DCache Info
