def shell_sort(data):
    n = len(data)
    gap = n // 2

    while gap > 0:
        for i in range(gap, n):
            temp = data[i]
            j = i
            while j >= gap and data[j - gap] > temp:
                data[j] = data[j - gap]
                j -= gap

            data[j] = temp
        gap //= 2

# def shell_sort(data):
#     n = len(data)
#
#     for gap in [1750, 701, 301, 132, 57, 23, 10, 4, 1]:
#         if gap < n:
#             for i in range(gap, n):
#                 temp = data[i]
#                 j = i
#                 while j >= gap and data[j - gap] > temp:
#                     data[j] = data[j - gap]
#                     j -= gap
#
#                 data[j] = temp


if __name__ == "__main__":
    nums = [-1, 4, 5, 2, -2, 0, 1, 2, 3, 2, 1, 0, 1, 2, 3]
    shell_sort(nums)
    print(nums)