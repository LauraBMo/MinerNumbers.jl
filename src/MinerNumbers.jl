module MinerNumbers

export  nMiners
# import Nemo

# function _rationalize(x)
#     Qbar = Nemo.algebraic_closure(Nemo.QQ)
#     RR = Nemo.real_field()
#     # RR = Nemo.RealField()

#     err = RR("+/- 1e-5")
#     x = Nemo.guess(Qbar, x + err, 1)
#     return Int(Nemo.numerator(x)) // Int(Nemo.denominator(x))
# end

const ROUND_DIGITS = Ref(5)

function set_round!(n::Int)
    ROUND_DIGITS[] = n
end

struct nMiners <: Number
    int::Int
    fr::Rational{Int}
    function nMiners(x, y=zero(typeof(x)))
        _x = x + y
        n = floor(_x)
        fr = rationalize(round(_x - n; digits=ROUND_DIGITS[]))
        # fr = _rationalize(_x - n)
        new(n, fr)
    end
end

nMiners(x::nMiners) = x
function Base.show(io::IO, x::nMiners)
    print(io, x.int)
    if (x.fr > 0)
        print(io, "+", x.fr)
    end
end

unfold(x::nMiners) = (x.int, x.fr)
number(x::nMiners) = sum(unfold(x))
number(x) = x

import Base: +, -, *, /
+(x::nMiners, y::nMiners) = nMiners(x.int + y.int, x.fr + x.fr)
-(x::nMiners, y::nMiners) = nMiners(x.int - y.int, x.fr - x.fr)
*(x::nMiners, y::nMiners) = nMiners(*(number(x), number(y)))
/(x::nMiners, y::nMiners) = nMiners(/(number(x), number(y)))

import Base: promote_rule, convert
promote_rule(::Type{nMiners}, ::Type{<:Number}) = nMiners
convert(::Type{nMiners}, x::Number) = nMiners(x)

import Base: zero, one, ==, isless, abs, sqrt, Float64, Int
zero(::Type{nMiners}) = nMiners(0.0)
zero(x::nMiners) = zero(typeof(x))

one(::Type{nMiners}) = nMiners(1.0)
one(x::nMiners) = one(typeof(x))

==(x::nMiners, y::nMiners) = ((x.int == y.int) && (x.fr == y.fr))
==(x::nMiners, y::Number) = ==(promote(x, y)...)
==(x::Number, y::nMiners) = ==(y, x)

function Base.isless(x::nMiners, y::nMiners)
    if (x.int < y.int)
        return true
    end
    if (y.int < x.int)
        return false
    end
    return (x.fr < y.fr)
end

isless(x::nMiners, y::Number) = <(promote(x, y)...)
isless(x::Number, y::nMiners) = <(y, x)

abs(x::nMiners) = nMiners(abs(number(x)))

sqrt(x::nMiners) = nMiners(sqrt(number(x)))

Float64(x::nMiners) = number(x)
Int(x::nMiners) = x.int

end
