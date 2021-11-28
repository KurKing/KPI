import csv
from os.path import isfile
from utility import *

def insert_data(index, data):
    block_number = get_block_number_for(index)

    if not block_number:
        return

    file_data = []

    if not isfile('Data/Blocks/'+str(block_number)+'.csv'):
        with open('Data/Blocks/'+str(block_number)+'.csv', mode='w') as file:
            csv.writer(file)
    else:
        file_data = read_from_file('Data/Blocks/'+str(block_number)+'.csv')
    
    should_append_data = True
    for record in file_data:
        if record.index == str(index):
            record.data = data
            should_append_data = False
            break
            
    if should_append_data:
        file_data.append(Record([str(index),data]))
        file_data.sort(key=lambda record: int(record.index))

    write_data_in_file('Data/Blocks/'+str(block_number)+'.csv', file_data)

if __name__ == '__main__':
    index = int(input('index: '))
    data = input('data: ')
    insert_data(index, data)