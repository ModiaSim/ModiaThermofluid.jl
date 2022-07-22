"""
    Flow connector for ModiaThermoFluid.jl

Acausal quantities necessary at the fluid connector of thermofluid components.


* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""

FlowConnector = Model(
    r = potential | info"inertial pressure",
    ṁ = flow | info"mass flow rate"
)
