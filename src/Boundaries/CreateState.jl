"""
    model CreateState for ModiaThermoFluid.jl

Creates thermodynamic state based on variable inputs.

* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""
CreateState = Model(
    # Medium state definition
    state = MediumState(),

    # State parameters
    # pressure
    use_pᵢₙ = Par(false, info = "If true, expects pᵢₙ from input, else p₀"),
    p₀ = Par(1e5, info = "specified state steady-state pressure of the medium - as parameter"),
    pᵢₙ = input | Var(start=0u"Pa", info = "specified state steady-state pressure of the medium - as input"),
    pₛ = Var(info = "specified state steady-state pressure of the medium"),

    # temperature
    setT = Par(true, info = "If true, set state from temperature, else from enthalpy"),
    use_Tᵢₙ = Par(false, info = "If true, expects Tᵢₙ from input, else T₀"),
    T₀ = Par(300, info = "specified state temperature of the medium - as parameter"),
    Tᵢₙ = input | Var(start=0u"K", info = "specified state temperature of the medium - as input"),
    Tₛ = Var(info = "specified state temperature of the medium"),

    # enthalpy
    use_hᵢₙ = Par(false, info = "If true, expects hᵢₙ from input, else h₀"),
    h₀ = Par(500e3, info = "specified state enthalpy of the medium - as parameter"),
    hᵢₙ = input | Var(start=0u"J", info = "specified state enthalpy of the medium - as input"),
    hₛ = Var(info = "specified state enthalpy of the medium"),

    p = Var(info = "steady state pressure of the medium"),
    T = Var(info = "temperature of the medium"),

    equations = :[
        pₛ = if use_pᵢₙ; pᵢₙ else p₀ end
        Tₛ = if use_Tᵢₙ; Tᵢₙ else T₀ end
        hₛ = if use_hᵢₙ; hᵢₙ else h₀ end
        state = if setT; setState_pT(useMedium(), pₛ, Tₛ) else setState_pT(useMedium(), pₛ, hₛ) end
        p = pressure(state)
        T = temperature(state)
    ]
)