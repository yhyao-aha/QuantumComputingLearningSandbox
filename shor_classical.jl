push!(LOAD_PATH, ".")

#using PyPlot
using Plots; gr()

using rsa
using dft

N, e, d = rsa_key_gen(0)
l = e
n = convert(Int64, floor(log2(l)))
println("N: ", N, ", e: ", e, ", d: ", d)

#sample(x, range())

fx = zeros(Int64, 0)
r_gt = 4
sample_period_cnt = 100
f = 1.0/convert(Float32, r_gt) #Hz, angular frequncy
sample_length = r_gt * sample_period_cnt

for i in 1:sample_length
    fp = modpow(e, i, N)
    #fp = round(1000.0*sin(2.0 * π * f * i))
    append!(fx, convert(Int64, fp))
end
display(fx)

#if gcd(x, N) == 1
#end

y = DFT(fx) # convert into freq

fx_amplitude = abs.(y)
fx_amplitude[1:div(sample_length,2)+1] .= 0
#display(fx_amplitude)

#freq_max = findmax(fx_amplitude)
#println("freq_max is ", freq_max)
freq_max = findmax(fx_amplitude)[2] - 1

freq_max = sample_length - freq_max
r = sample_length / freq_max

println(" r is ", r, ", r ground truth is ", r_gt)
#println(" r is ", sample_length / freq_max)


r = convert(Int64, round(r))

if (r%2) == 0
    half_r = convert(UInt128, r>>1)
    println("r is ", r, " half_r is ", half_r)
    e = convert(UInt128, e)

    #ah = (e^(half_r) + 1)*(e^(half_r) - 1)
    ah = (e^(half_r) + 1)
    bo = (e^(half_r) - 1)

    println("ah is ", ah, " bo is ", bo)

    p = gcd(ah, N)
    q = gcd(bo, N)
    println("p is ", p, " q is ", q)
else

end