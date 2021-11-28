from insert_data import insert_data
import uuid

for i in range(10**4):
    insert_data(i, uuid.uuid4().hex)