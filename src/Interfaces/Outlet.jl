"""
    connector outlet for ModiaThermoFluid.jl

Physical Interfaces of thermofluid components representing fluid outlet.

## Directed flow connector for fluids.
This connector assumes a negative mass-flow `ṁ` - leaving the component by the outlet. 
Therefore the state information of this connector is an output.


* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""

Outlet = FlowConnector | StateOutput
