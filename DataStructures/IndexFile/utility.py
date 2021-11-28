import csv

class Record:
    def __init__(self, row) -> None:
        self.index = row[0]
        self.data = row[1]

    def as_row(self):
        return [str(self.index), self.data]

def get_block_number_for(index):
    with open('Data/index.csv', mode='r') as file:
        reader = csv.reader(file)
        for row in reader:
            if str(index) == row[0]:
                return int(row[1])

def read_from_file(file_name):
    file_data = []
    with open(file_name, mode='r') as file:
            reader = csv.reader(file)
            for row in reader:
                file_data.append(Record(row))
    return file_data

def write_data_in_file(file_name, file_data):
    with open(file_name, mode='w') as file:
        writer = csv.writer(file)
        for record in file_data:
            writer.writerow(record.as_row())
