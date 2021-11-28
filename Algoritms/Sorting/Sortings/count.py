def count_sort(arr):
    max_element = max(arr)
    min_element = min(arr)
    range_of_elements = max_element - min_element + 1

    count_arr = [0 for _ in range(range_of_elements)]
    output_arr = [0 for _ in range(len(arr))]

    for i in range(0, len(arr)):
        count_arr[arr[i] - min_element] += 1

    for i in range(1, len(count_arr)):
        count_arr[i] += count_arr[i - 1]

    for i in range(len(arr) - 1, -1, -1):
        output_arr[count_arr[arr[i] - min_element] - 1] = arr[i]
        count_arr[arr[i] - min_element] -= 1

    for i in range(0, len(arr)):
        arr[i] = output_arr[i]

    return arr

if __name__ == "__main__":
	from Tester import Tester
	T = Tester()

	for _ in range(0,10):
		T.generateRandomArrays(10**6,-999,999)
		data = count_sort(T.data)
		T.data.sort()
		print(data == T.data)