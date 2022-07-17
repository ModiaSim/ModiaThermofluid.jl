"""
    ModiaThermofluid.jl

ThermoFluid library of [Modia](https://github.com/ModiaSim/Modia.jl) component models.
(ModiaThermoFluid.jl is inspired from the Modelica library [ThermofluidStream](https://github.com/DLR-SR/ThermofluidStream) from DLR-SR).

* Developer: Clément Coïc  
* Copyright (c) 2022: DLR-SR and Clément Coïc
* License: 3-Clause BSD License

"""
module ModiaThermofluid

const path = dirname(dirname(@__FILE__))   # Absolute path of package directory

using Modia
using ModiaMedia

# Include sub-modules
folderNames = ["Interfaces",]
for folder in folderNames
    include(joinpath(folder, "include_all.jl"))
end

end
