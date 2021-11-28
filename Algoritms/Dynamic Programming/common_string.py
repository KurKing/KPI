from matrix_builder import *

def find_max_common_string(word_a, word_b):
    matrix = make_matrix(word_a, word_b)

    max_element = 0
    index = 0

    for i in range(len(matrix)):
        for j in range(len(matrix[0])):
            if matrix[i][j] > max_element:
                max_element = matrix[i][j]
                index = i

    return word_a[index-max_element+1:index+1]

def find_min_common_string(word_a, word_b, min_length = 1):
    matrix = make_matrix(word_a, word_b)
    end_elements = []

    for i in range(len(word_a)):
        for j in range(len(word_b)):
            if i+1 < len(word_a) and j+1 < len(word_b):
                if matrix[i][j] != matrix[i+1][j+1] - 1 and matrix[i][j] >= min_length:
                    end_elements.append([matrix[i][j],i])
    if end_elements:
        min_element = end_elements[0]

        for i in range(len(end_elements)):
            if end_elements[i][0] < min_element[0]:
                min_element = end_elements[i]

        element, index = min_element
        return word_a[index-element+1:index+1]
    return ""