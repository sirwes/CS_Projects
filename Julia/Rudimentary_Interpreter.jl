#
# Class Interpreter 0
# Base interpreter with numbers, plus, and minus
#

module RudInt

push!(LOAD_PATH, pwd())

# using Revise
using Error
using Lexer
export parse, calc#, interp

#
# ==================================================
#

abstract type AE
end

# <AE> ::= <number>
struct NumNode <: AE
    n::Real
end

struct BinopNode <: AE
    op::Function
    lhs::AE
    rhs::AE
end

struct UniopNode <: AE
    op::Function
    val::AE
end
# RudInt.calc(RudInt.parse(Lexer.lex(+ 1 2)))


function SymbolDict(symbol)
    if symbol == :+
        return +
    elseif symbol == :-
        return -
    elseif symbol == :*
        return *
    elseif symbol == :/
        return /
    elseif symbol == :mod
        return mod
    elseif symbol == :collatz
        return collatz
    else
        throw(LispError("Whoa there! Unrecognizable Operator!"))
    end
end
#
# ==================================================
#

function parse( expr::Number )
    return NumNode( expr )
end

function parse( expr::Array{Any} )
    oper = expr[1]
    if oper == :+ || oper == :- || oper == :* || oper == :/ || oper == :mod
        if length(expr) == 3
            return BinopNode( SymbolDict(expr[1]), parse(expr[2]), parse(expr[3]))
        elseif length(expr) == 2 && oper == :-
            return UniopNode( SymbolDict(expr[1]), parse(expr[2]))
        end
        throw( LispError("Airity Error for $oper operator"))
    elseif oper == :collatz && length(expr) == 2
        return UniopNode( SymbolDict(expr[1]), parse(expr[2]))
    else
        throw(LispError("Unknown operator or improper airity for $oper"))
    end

end

function parse( expr::Any )
  throw( LispError("Invalid type $expr") )
end

#
# ==================================================
#

function calc( ast::NumNode )
    return ast.n
end

function calc( ast::BinopNode )
    oper = ast.op
    if oper == +
        return calc( ast.lhs ) + calc( ast.rhs )
    elseif oper == -
        return calc( ast.lhs ) - calc( ast.rhs )
    elseif oper == *
        return calc( ast.lhs ) * calc( ast.rhs )
    elseif oper == /
        if calc(ast.rhs) == 0
            throw(LispError("Cannot divide by 0"))
        else
            return calc( ast.lhs ) / calc( ast.rhs )
        end
    elseif oper == mod
        return mod(calc( ast.lhs ), calc( ast.rhs ))
    else
        throw(LispError("Invalid binary Operator: $oper"))
    end
end

function calc( ast::UniopNode)
    oper = ast.op
    if oper == -
        return -1*calc(ast.val)
    elseif oper == collatz
        if calc(ast.val) <= 0
            throw(LispError("Cannot collatz non-positive numbers"))
        else
            return collatz(calc(ast.val))
        end
    else
        throw(LispError("Invalid unary Operator: $oper"))
    end
end
#
# ==================================================
#

function interp( cs::AbstractString )
    lxd = Lexer.lex( cs )
    ast = parse( lxd )
    return calc( ast )
end

function collatz( n::Real )
  return collatz_helper( n, 0 )
end

function collatz_helper( n::Real, num_iters::Int )
  if n == 1
    return num_iters
  end
  if mod(n,2)==0
    return collatz_helper( n/2, num_iters+1 )
  else
    return collatz_helper( 3*n+1, num_iters+1 )
  end
end

end #module
