module ReversedStrings
using AutoHashEquals

export ReversedString, reversed
@auto_hash_equals struct ReversedString{V}<:AbstractString
    representation::V
    lastindex::Int
    ReversedString(x) =
        # if lastindex(x) == 1
        #     x
        # else
        new{typeof(x)}(x, lastindex(x))
        ##end
end
"""
    reversed(x::AbstractString)

A lazy implementation of `Base.reverse` for `String`s.
"""
reversed(x::ReversedString) = x.representation
reversed(x::AbstractString) = ReversedString(x)

"""
    reverse_index(x::ReversedString,i)

Return corresponding index in unreversed String `x.lastindex-i+1`.
Cap at `0:lastindex+1`.
(can be optimized maybe)
"""
@inline function reverse_index(x::ReversedString,i)
    ri = x.lastindex-i+1
end

@inline reverse_index(x::AbstractString,i) =
    i

@inline Base.SubString(x::ReversedString,start::Int,stop::Int) =
    reversed(SubString(x.representation, reverse_index(x, stop), reverse_index(x, start)))

@inline Base.ncodeunits(x::ReversedString) = ncodeunits(x.representation)
@inline Base.codeunit(s::ReversedString, i::Integer) = codeunit(x.representation, reverse_index(x,i))

@inline Base.isvalid(x::ReversedString,i::Int) =
    isvalid(x.representation,reverse_index(x,i))

@inline Base.firstindex(x::ReversedString) = 1
@inline Base.lastindex(x::ReversedString) = x.lastindex

@inline Base.length(s::ReversedString) =
    length(s.representation)

"""
    Base.getindex(x::ReversedString,is::UnitRange{<:Integer})

`ReversedString` of getindex(x
"""
@inline Base.getindex(x::ReversedString,is::UnitRange{<:Integer}) =
    reversed(getindex(x.representation,reverse_index(x,is.stop):reverse_index(x,is.start)))

@inline Base.getindex(x::ReversedString,i::Int) =
    getindex(x.representation,reverse_index(x,i))

@inline function Base.thisind(x::ReversedString,i::Int)
    ri = reverse_index(x, i)
    reverse_index(x, thisind(x.representation, ri))
end

@inline function Base.nextind(x::ReversedString,i::Int)
    ri = reverse_index(x, i)
    reverse_index(x, prevind(x.representation, ri))
end

@inline function Base.nextind(x::ReversedString,i::Int,n::Int)
    ri = reverse_index(x, i)
    reverse_index(x, prevind(x.representation, ri, n))
end

@inline function Base.prevind(x::ReversedString,i::Int)
    ri = reverse_index(x, i)
    reverse_index(x, nextind(x.representation, ri))
end

@inline function Base.prevind(x::ReversedString,i::Int,n::Int)
    ri = reverse_index(x, i)
    reverse_index(x,nextind(x.representation, ri, n))
end

@inline Base.iterate(x::ReversedString) =
    iterate(x,1)

@inline Base.iterate(x::ReversedString,i::Int) =
    if reverse_index(x,i) >= 1 && reverse_index(x,i) <= lastindex(x) # ? <=
        x[i], nextind(x,i)
    else
        nothing
    end

end # module
