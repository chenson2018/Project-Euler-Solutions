def dice(n):
	R, t = QQ['t'].objgen()
	return (1/n) * integrate(R(range(1,n+1)))

pete = dice(4)^9
colin = dice(6)^6

ans = 0

for roll, pete_prob in enumerate(pete.list()):
    colin_lose = colin.list()[:roll]
    ans += pete_prob * sum(colin_lose)

print(round(ans, 7))
