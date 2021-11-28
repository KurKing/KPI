import csv
from os.path import isfile
from utility import *

def delete_data(index):
    block_number = get_block_number_for(index)
    if not block_number or not isfile('Data/Blocks/'+str(block_number)+'.csv'):
        return

    file_data = read_from_file('Data/Blocks/'+str(block_number)+'.csv')
    
    for record in file_data:
        if record.index == str(index):
            file_data.remove(record)
            break

    write_data_in_file('Data/Blocks/'+str(block_number)+'.csv', file_data)

if __name__ == '__main__':
    index = int(input('index: '))
    delete_data(index)