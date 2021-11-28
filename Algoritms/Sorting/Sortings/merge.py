def merge_sort(data):
	if len(data) == 1:
		return

	middle_index = len(data) // 2
	left_data = data[:middle_index]
	right_data = data[middle_index:]

	merge_sort(left_data)
	merge_sort(right_data)

	i = 0
	j = 0
	k = 0

	while i < len(left_data) and j < len(right_data):
		if left_data[i] <= right_data[j]:
			data[k] = left_data[i]
			i += 1
		else:
			data[k] = right_data[j]
			j += 1
		k += 1

	while i < len(left_data):
		data[k] = left_data[i]

		k += 1
		i += 1

	while j < len(right_data):
		data[k] = right_data[j]

		k += 1
		j += 1
		
if __name__ == "__main__":
   
   nums = [-3,-2,-1,1,2,1,0,-1,-2,-3]
   merge_sort(nums)
   print(nums)