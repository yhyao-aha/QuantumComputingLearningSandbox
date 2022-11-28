push!(LOAD_PATH, ".")
module dft

export DFT

function DFT(x̄::Array{<:Number})
    n = length(x̄)
    ȳ = zeros(Complex, n)
    
    factor = convert(Complex, 1.0 / sqrt(n))
    for k = 0:n-1
        sum = 0+0im
        for j = 0:n-1
            τ = exp(2π*im*j*k/n)
            sum = sum + τ * x̄[j+1]
        end
        ȳ[k+1] = sum * factor
    end
    ȳ
end

end # end of module

function main()
    x̄ = [1 1 0im 2]
    ȳ = DFT(x̄)
    display(ȳ)
end

#main()

