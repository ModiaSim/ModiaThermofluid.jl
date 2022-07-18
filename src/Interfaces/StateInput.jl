"""
    connector StateInput for ModiaThermoFluid.jl

Thermodynamic state as an input connector.
(Default name for instances: `u`)

* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""

StateInput = Model(
    state = input | info"thermodynamic state assuming steady mass flow pressure"
)
