push!(LOAD_PATH, ".")
module rsa

export modpow, rsa_key_gen

function rsa_key_gen(l)
    p = Int64(5) #11 #5
    q = Int64(7) #13 #7
    N = p*q
    r = (p-1)*(q-1)
    if N < l
        println("ah")
    end
    e = Int64(13) #7 #13
    for i in range(e+1,(1<<30), step=1)
        hit = rem(e*i, r) == 1
        if hit
            global d = i
            break
        end
    end
    N, e, d
    #place holder
end

function modpow(base::Int64, power::Int64, mod::Int64)
    result = Int64(1)
    for i in range(1, power, step=1)
        result = rem((result * base), mod)
    end
    result
end

end # end of module

function main()
    p = Int64(11)
    q = Int64(13)
    N = p*q
    r = (p-1)*(q-1)
    d = 2
    e = Int64(7)

    for i in range(2,(1<<30), step=1)
        hit = rem(e*i, r) == 1
        if hit
            global d = i
            break
        end
    end

    println("public key is: ", N, ", ", e)
    println("private key is: ", N, ", ", d)

    m = Int64(9726)
    c = modpow(m, e, N)

    println("c is ", c)
    m_de = modpow(c, d, N)
    println("m is ", m, ", m_de is ", m_de)


    for i in 1:130
        fp = modpow(e, i, N)
        println("i is ", i," fp is ", fp)
    end
end

#main()