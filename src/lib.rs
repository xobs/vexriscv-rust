//! Low level access to VexRiscv RISC-V cores

#![no_std]
#![cfg_attr(feature = "inline-asm", feature(asm))]

pub mod register;
