def bubble_sort(nums):

	for i in range(len(nums)-1):
		isSorted = True
		for j in range(0,len(nums)-1-i,1):
			if nums[j] > nums[j+1]:
				isSorted = False
				nums[j], nums[j+1] = nums[j+1], nums[j]

		if isSorted: return nums

if __name__ == "__main__":
   
   a = [0,0,0,-1,-0,1,2,3,2,1]
   print(bubble_sort(a))
  