"""
    model CreateState for ModiaThermoFluid.jl

Creates thermodynamic state based on variable inputs.

* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""
module CreateState

using Unitful
using Modia
using ModiaMedia

const MediumState() = Var(size=(), hideResult=true)
const Medium        = getMedium("N2")
@inline useMedium() = Medium

include("../../src/Boundaries/CreateState.jl")

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

myState = @instantiateModel(createState, unitless=true, logCode=true)
simulate!(myState, stopTime = 10.0u"s", log=true, logEvaluatedParameters=true)

showInfo(myState)  # print info about the result
writeSignalTable("myState.json", myState, indent=2, log=true)

@usingModiaPlot   # Use plot package defined with
                  # ENV["SignalTablesPlotPackage"] = "XXX" or with 
usePlotPackage("PyPlot")
plot(myState, [("p", "h₀"); "T"], figure = 1)

end