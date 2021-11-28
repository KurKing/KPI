def quick_sort(data):
    quickSort(data, 0, len(data)-1)

def quickSort(data, left, right):
    if left >= right : return

    pivot = data[(left+right)//2]
    index = partition(data,left,right,pivot)

    quickSort(data, left, index-1)
    quickSort(data, index, right)

def partition(data,left,right,pivot):
    while left < right:
        while data[left] < pivot:
            left += 1

        while data[right] > pivot:
            right -= 1

        if left <= right:
            data[left],data[right] = data[right],data[left]
            left += 1
            right -= 1

    return left

if __name__ == "__main__":
   
   nums = [-2,-1,0,1,0,-1,-2]
   quick_sort(nums)
   print(nums)
  