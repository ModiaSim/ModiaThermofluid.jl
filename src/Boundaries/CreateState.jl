"""
    model CreateState for ModiaThermoFluid.jl

Creates thermodynamic state based on variable inputs.

* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""
createState = Model(
    # Medium state definition
    state = MediumState(),

    # State parameters
    setT = Par(true, info = "If true, set state from temperature, else from enthalpy"),
    # p₀ = Par(1e5u"Pa", info = "specified state steady-state pressure of the medium"),
    # T₀ = Par(300u"K", info = "specified state temperature of the medium"),
    # h₀ = Par(500e3u"J", info = "specified state enthalpy of the medium"),
    p₀ = Par(1e5, info = "specified state steady-state pressure of the medium"),
    T₀ = Par(300, info = "specified state temperature of the medium"),
    h₀ = Par(500e3, info = "specified state enthalpy of the medium"),

    p = Var(),
    T = Var(),

    equations = :[
        state = if setT; setState_pT(useMedium(), p₀, T₀) else setState_pT(useMedium(), p₀, h₀) end
        p = pressure(state)
        T = temperature(state)
    ]
)