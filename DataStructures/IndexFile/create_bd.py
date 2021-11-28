import os, csv

def create_db(expectedDataAmount = 10**4):
    os.system('rm -r Data')
    os.mkdir('Data')
    os.mkdir('Data/Blocks')

    with open('Data/index.csv', mode='w') as file:
        writer = csv.writer(file, delimiter=',')
        for i in range(expectedDataAmount):
            writer.writerow([str(i), str(i//100+1)])

if __name__ == '__main__':
    create_db()