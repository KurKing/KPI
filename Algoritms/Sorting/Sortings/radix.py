def radix_sort(data):
	digits = len(str(max(data)))

	for i in range(0, digits):

		korz=[[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]

		for x in data:
			index = x//(10**i) % 10 + 9 if x >= 0 else 9 - (abs(x)//(10**i) % 10)
			korz[index].append(x)

		data=[]
		for x in korz:
			for y in x:
				data.append(y)

	return data

if __name__ == "__main__":
	from Tester import Tester
	T = Tester()

	for _ in range(0,10):
		T.generateRandomArrays(10**6,-999,999)
		data = radix_sort(T.data)
		T.data.sort()
		print(data == T.data)