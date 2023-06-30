def dice(n):
	R, _ = QQ['t'].objgen()
	return (1/n) * integrate(R(range(1,n+1)))

d4 = dice(4)
d6 = dice(6)
d8 = dice(8)
d12 = dice(12)
d20 = dice(20)

def variance(f):
	prime = derivative(f)
	mu = prime(1)
	prime_2 = derivative(prime)
	return prime_2(1) + mu - mu^2

g = d4(d6)(d8)(d12)(d20)
var = variance(g)
print(round(var, 4))
