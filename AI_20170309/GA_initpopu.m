function popu=GA_initpopu(popuSize, bit_n, var_n)
popu = rand(popuSize, bit_n*var_n) > 0.5;

end