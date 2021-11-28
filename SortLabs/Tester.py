from random import randint
import time

class Tester():
	def generateRandomArrays(self, size, min_value, max_value):
		self.data = []

		for _ in range(0,size) :
			self.data.append(randint(min_value,max_value))

	def generateSortedArray(self, size):
		self.data = list(range(0,size))

	def countTime(self, sortFunc):

		current_data = self.data.copy()

		start = time.time()
		sortFunc(current_data)
		end = time.time()

		return round((end - start)*1000,3)

	def printTime(self, name, size, time):
		print(f"{name} 10^{size} elements: {time} ms.")

if __name__ == "__main__":

	from Sortings.bubble import bubble_sort

	T = Tester()

	T.generateRandomArrays(2,1,5)
	T.printTime("Bubble", 2, T.countTime(bubble_sort))
