using Convex

type DiffVariable{T,D}
    v::Array{T,D}
    dv::AbstractExpr
end

DiffVariable{T,D}(v::Array{T,D}) = DiffVariable{T,D}(v,Variable(size(v)...))

import Base.transpose
transpose(v::DiffVariable) = DiffVariable(v.v',v.dv')

import Base.*
*(a::DiffVariable, b::DiffVariable) = (a.v + a.dv)*b.v + a.v*b.dv
*(a::DiffVariable, b::Array) = (a.v + a.dv)*b
*(a::Array, b::DiffVariable) = a*(b.v + b.dv)

export DiffVariable, transpose, *
