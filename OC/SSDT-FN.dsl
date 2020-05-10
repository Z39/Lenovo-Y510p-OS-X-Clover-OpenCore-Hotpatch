// BrightKey for Lenovo
// In config ACPI, _Q11 to XQ11(down)
// Find:     5F 51 31 31
// Replace:  58 51 31 31

// In config ACPI, _Q12 to XQ12(up)
// Find:     5F 51 31 32
// Replace:  58 51 31 32
//
DefinitionBlock("", "SSDT", 2, "OCLT", "BrightFN", 0)
{
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.XQ11, MethodObj)
    External(_SB.PCI0.LPCB.EC0.XQ12, MethodObj)

    Scope (_SB.PCI0.LPCB.PS2K)
    {
        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
        {
            If (LNot (Arg2))
            {
                Return (Buffer (One)
                {
                     0x03                                           
                })
            }

            Return (Package (0x04)
            {
                "RM,oem-id", 
                "LENOVO", 
                "RM,oem-table-id", 
                "Thinkpad_ClickPad"
            })
        }

        Name (RMCF, Package (0x0A)
        {
            "Controller", 
            Package (0x02)
            {
                "WakeDelay", 
                Zero
            }, 

            "Sentelic FSP", 
            Package (0x02)
            {
                "DisableDevice", 
                ">y"
            }, 

            "ALPS GlidePoint", 
            Package (0x02)
            {
                "DisableDevice", 
                ">y"
            }, 

            "Synaptics TouchPad", 
            Package (0x2A){}, 
            "Keyboard", 
            Package (0x14)
            {
                "ActionSwipeDown", 
                "37 d, 2e d, 2e u, 37 u", 
                "ActionSwipeLeft", 
                "37 d, 21 d, 21 u, 37 u", 
                "ActionSwipeRight", 
                "37 d, 1e d, 1e u, 37 u", 
                "ActionSwipeUp", 
                "3b d, 7e d, 7e u, 3b u", 
                "Breakless PS2", 
                Package (0x01)
                {
                    Package (0x00){}
                }, 

                "MaximumMacroTime", 
                0x017D7840, 
                "Custom ADB Map", 
                Package (0x01)
                {
                    Package (0x00){}
                }, 

                "Custom PS2 Map", 
                Package (0x06)
                {
                    Package (0x00){}, 
                    "e037=64"
                }, 

                "Function Keys Special", 
                Package (0x0B)
                {
                    Package (0x00){}, 
                    "3b=e05f", 
                    "3c=e05e", 
                    "3d=e005", 
                    "3e=e006", 
                    "3f=e02e", 
                    "40=e030", 
                    "41=e010", 
                    "42=e022", 
                    "43=e019", 
                    "44=e020"
                }, 

                "Function Keys Standard", 
                Package (0x01)
                {
                    Package (0x00){}
                }
            }
        })
    }
        
    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q11, 0, NotSerialized)//down
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQ11()
            }
        }
    
        Method (_Q12, 0, NotSerialized)//up
        {
            If (_OSI ("Darwin"))
            {
                Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC0.XQ12()
            }
        }
    }
}
//EOF
