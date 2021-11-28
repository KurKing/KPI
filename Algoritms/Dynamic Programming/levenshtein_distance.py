from matrix_builder import *

def levenshtein_distance(word_a, word_b):
    if len(word_a) < len(word_b):
        word_a, word_b = word_b, word_a

    max_elements_in_row = list(map(max, make_matrix(word_a, word_b)))

    distance = 0
    for i in max_elements_in_row:
        if i == 0:
            distance += 1

    return distance