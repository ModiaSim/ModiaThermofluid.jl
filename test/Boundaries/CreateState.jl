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

myState = @instantiateModel(createState, unitless=true, logCode=true)
simulate!(myState, stopTime = 10.0u"s", log=true, logEvaluatedParameters=true)

showInfo(myState)  # print info about the result
writeSignalTable("myState.json", myState, indent=2, log=true)

@usingModiaPlot   # Use plot package defined with
                  # ENV["SignalTablesPlotPackage"] = "XXX" or with 
usePlotPackage("PyPlot")
plot(myState, [("p", "h₀"); "T"], figure = 1)

end