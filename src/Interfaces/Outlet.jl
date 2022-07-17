"""
    connector outlet for ModiaThermoFluid.jl

Physical Interfaces of thermofluid components representing fluid outlet.

## Directed flow connector for fluids.
This connector assumes a negative mass-flow `w` - leaving the component by the outlet. 
Therefore the state information of this connector is an output.


* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""

Outlet = Model(
    r = potential | info"inertial pressure",
    w = flow | info"mass flow rate",
    state = output | info"thermodynamic state assuming steady mass flow pressure" #TODO: Need to find out later whether this input needs to be refined
)
