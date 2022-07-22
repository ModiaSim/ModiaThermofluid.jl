"""
    connector StateOutput for ModiaThermoFluid.jl

Thermodynamic state as an output connector.
(Default name for instances: `y`)

* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""

StateOutput = Model(
    state = input | info"thermodynamic state assuming steady mass flow pressure"
)
