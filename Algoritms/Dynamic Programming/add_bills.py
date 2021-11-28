def make_one_bill(bills, P=0.1):
    while len(bills) > 1:

        bills.append(add_bills(
            bill1 = bills.pop(bills.index(min(bills))),
            bill2 = bills.pop(bills.index(min(bills))),
            P = P
        ))

    return bills[0]

def add_bills(bill1, bill2, P=0.1):
    return (bill1+bill2)*(1-P)

if __name__ == "__main__":
    print(make_one_bill([3000,6000,9000]))

    print(add_bills(add_bills(3000, 6000), 9000))
    print(add_bills(add_bills(3000, 9000), 6000))
    print(add_bills(add_bills(9000, 6000), 3000))