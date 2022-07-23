"""
    model CreateState for ModiaThermoFluid.jl

Creates thermodynamic state based on variable inputs.

* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""

createState = Model(
    # Medium definition
    #mediumName = Par("SimpleAir", info="medium name as a string"),
    # mediumName = "N2",
    #medium = getMedium(mediumName),

    medium = getMedium("N2"),
    state = Var(info="medium state"),

    # State parameters
    setT = Par(true, info = "If true, set state from temperature, else from enthalpy"),
    p₀ = Par(start=0u"Pa", info = "specified state steady-state pressure of the medium"),
    T₀ = Par(start=0u"K", info = "specified state temperature of the medium"),
    h₀ = Par(start=0u"J", info = "specified state enthalpy of the medium"),

    equations = :[
        state = if setT; setState_pT(medium, p₀, T₀) else setState_pT(medium, p₀, h₀) end
    ]
)

mediumState = @instantiateModel(createState)
simulate!(mediumState, stopTime=0.1)