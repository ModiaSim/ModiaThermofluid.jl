"""
    include all ModiaThermoFluid.Interfaces

Subset of ModiaThermoFluid containing the physical Interfaces of thermofluid components.

* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""

include("FlowConnector.jl")
include("StateInput.jl")
include("StateOutput.jl")
include("Inlet.jl")
include("Outlet.jl")
include("SISOFlow.jl")
