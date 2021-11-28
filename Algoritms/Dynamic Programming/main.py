from common_string import find_max_common_string
from common_string import find_min_common_string
from levenshtein_distance import levenshtein_distance
from add_bills import make_one_bill

# TASK 7.1
print(f"#TASK 7.1.{4 % 7 + 1}:")

string1 = "Lorem ipsum dolor sit amet," \
          "consectetur adipiscing elit, " \
          "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

string2 = "Test string with 'Lorem ipsum dolor sit amet' " \
          "inside this very interesting test string, " \
          "also it contains very beautiful word 'incididunt'"

print(find_max_common_string(string1, string2))
print("No string here:"+find_max_common_string("abc", "def")+".")
print("No string here:"+find_min_common_string("abc", "def")+".")

print(find_min_common_string(string1, string2, min_length=5))
print(find_min_common_string("abc", "abeabc"))

print(levenshtein_distance("gily","geely"))
print(levenshtein_distance("honda","huyndai"))

# TASK 7.2
print(f"\n#TASK 7.2.{4 % 3 + 1}:")
print(make_one_bill(
    bills = [3000, 6000, 9000, 5000]
))
