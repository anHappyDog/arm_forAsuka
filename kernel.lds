OUTPUT_ARCH(arm)
ENTRY(_start)


SECTIONS
{   
    . = 0x00000000;
    .text :
    {
        *(.boot)
        *(.text)
        *(.rodata*)
    } 

    .data :
    {
        *(.data)
    }

    .bss :
    {
        *(.bss)
    }
}