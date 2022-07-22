"""
    base model with basic equations for SISO of ModiaThermoFluid.jl

Single Inlet, Single Outlet interface of thermofluid components.

## Directed flow connector for fluids.
    
Interface class for all components with an Inlet and an Outlet and a massflow without a mass storage between.

This class already implements the equations that are common for such components, namely:
    * the conservation of mass without storage,
    * the intertance equation, as well as
    * the clipping of `p_out` to `p_min` - this can be turned off. If the clipping is active, should `p_out` be lower than `p_min`, the remaining pressure drop is added on the difference in inertial pressure `r` - accelerating or decelerating the massflow `ṁ`.

The component offers different initialization methods for the mass flow, as well as several parameters used in the equations above.


* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""

SISOFlow = Model(
    # connectors
    inlet = Inlet,
    outlet = Outlet,
    
    # common parameters
    L = Par(0.01u"1/m", min = 0.0, info = "Inertance of the flow"),

    # mass fow variables

    ṁ = Var(start = 0u"kg/s", min = 0.0, info = "mass flow rate, positive when entering the inlet"),
    m̈ = Var(start = 0u"kg/s^2", info = "derivative of mass flow rate"),
    # ṁ = Var(init = if init_ṁ; ṁ₀ else nothing end, start = 0u"kg/s", min = 0.0, info = "mass flow rate, positive when entering the inlet"),
    # m̈ = Var(init =  if !init_ṁ; (if init_steady; 0 else m̈₀ end) else nothing end, start = 0u"kg/s^2", info = "derivative of mass flow rate"),
    # init_ṁ = Par(true, info = "If true, initialize from mass flow value"),
    # init_steady = Par(false, info = "If true and `init_ṁ == false`, initialize in steady mass flow, else m̈ is set to m̈₀"),
    # ṁ₀ = Par(0.0u"kg/s", info = "Initial value for mass flow rate (ṁ)"),
    # m̈₀ = Par(0.0u"kg/s^2", info = "Initial value for m̈"),

    # inlet state quantities
    pᵢₙ = Var(start=0u"Pa", info = "inlet (static) pressure"),
    Tᵢₙ = Var(start=0u"J", info = "temperature of the medium at the inlet"),
    hᵢₙ = Var(start=0u"J", info = "enthalpy of the medium at the inlet"),
    #Xiᵢₙ = Var(start=0u"1", info = "mass fraction of the medium at the inlet"),

    # outlet state quantities
    pₒᵤₜ = Var(start=0u"Pa", info = "outlet (static) pressure"),
    Tₒᵤₜ = Var(start=0u"J", info = "enthalpy of the medium at the outlet"),
    hₒᵤₜ = Var(start=0u"J", info = "enthalpy of the medium at the outlet"),
    #Xiₒᵤₜ = Var(start=0u"1", info = "mass fraction of the medium at the outlet"),

    # pressure differences
    Δp = Var(start=0u"Pa", info = "(static) pressure difference"),
    Δ̂p = Var(start=0u"Pa", info = "steady mass flow pressure difference"),
    Δr = Var(start=0u"Pa", info = "intertial pressure difference"),

    # Pressure clipping
    clip_p_out = Par(start=true, info="If true, outlet static pressure is limited to `p_min`"),
    p_min = Par(100u"Pa", info="Minimal outlet static pressure"),
    Δr_corr = Var(start=0u"Pa", info = "intertial pressure difference"),
    
    equations = :[
        inlet.ṁ + outlet.ṁ = 0 # mass conservation without storage
        ṁ = inlet.ṁ # mass flow rate as inlet by sign convention
        Δr = outlet.r - inlet.r # inertial pressure difference definition
        m̈ = der(ṁ) # derivative of mass flow rate
        -Δr + Δr_corr = L * m̈ # inertance equation
        Δ̂p = pₒᵤₜ - pᵢₙ # steady-state pressure difference
        pₒᵤₜ = if clip_p_out; max(p_min, pᵢₙ + Δp) else pᵢₙ + Δp end # pressure clipping
        Δr_corr = if clip_p_out; Δp - Δ̂p else 0 end # inertial pressure correction if pressure clipping
        Tᵢₙ = specificEnthalpy(inlet.state)
        hᵢₙ = temperature(inlet.state)
        #Xiᵢₙ not implemented in medium?
        # Tₒᵤₜ defined in extending classes
        # hₒᵤₜ defined in extending classes
        #Xiₒᵤₜ not implemented in medium 
        outlet.state = setState_pT!(inlet.state, pₒᵤₜ, Tₒᵤₜ) # set outlet state
    ]

)