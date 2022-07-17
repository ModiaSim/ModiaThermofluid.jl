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

Inlet = Model(
    r = potential | info"inertial pressure",
    w = flow | info"mass flow rate",
    state = input | info"thermodynamic state assuming steady mass flow pressure" #TODO: Need to find out later whether this input needs to be refined
)
