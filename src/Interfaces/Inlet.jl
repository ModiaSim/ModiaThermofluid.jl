"""
    connector inlet for ModiaThermoFluid.jl

Physical Interfaces of thermofluid components representing fluid inlet.

## Directed flow connector for fluids.
This connector assumes a positive mass-flow `w` - entering the component by the inlet. 
Therefore the state information of this connector is an input.


* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""

Inlet = FlowConnector | StateInput
