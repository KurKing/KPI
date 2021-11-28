from utility import *
from os.path import isfile

class BinarySearch:
    def __init__(self) -> None:
        self.compare = 0

    def binarySearch(self, array, current, change, index):
        curr = array[current].index;
        if curr == index: return array[current].data
        self.compare += 1
        if curr < index:
            return self.binarySearch(array, current + (change // 2 + 1), change // 2, index)
        else :
            return self.binarySearch(array, current - (change // 2 + 1), change // 2, index)


def search(index):
    block_number = get_block_number_for(index)

    if not block_number or not isfile('Data/Blocks/'+str(block_number)+'.csv'):
        return
    file_data = read_from_file('Data/Blocks/'+str(block_number)+'.csv')

    search = BinarySearch()
    result = search.binarySearch(file_data, len(file_data)//2, len(file_data)//2, index)
    print(result, search.compare)


if __name__ == '__main__':
    index = input('index: ')
    search(index)