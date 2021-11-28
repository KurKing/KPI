from Sortings.insertion import insertion_sort

def bucket_sort(data, elements_in_bucket = 20):
    arr = []

    buckets = len(data) // elements_in_bucket

    min_value = min(data)
    max_value = max(data)
    bucket_step = (max_value - min_value)/buckets

    for i in range(buckets):
        arr.append([])

    for j in data:
        if j != max_value:
            index = int((j+min_value) / bucket_step)
            arr[index].append(j)
        else :
            arr[-1].append(j)

    for i in range(buckets):
        arr[i] = insertion_sort(arr[i])

    data = []
    for i in range(buckets):
        for j in range(len(arr[i])):
            data.append(arr[i][j])

    return data

if __name__ == "__main__":
    from Tester import Tester
    T = Tester()

    for _ in range(0, 10):
        T.generateRandomArrays(10 ** 6, -999, 999)
        data = bucket_sort(T.data)
        T.data.sort()
        print(data == T.data)

