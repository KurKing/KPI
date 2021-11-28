def make_matrix(word_a, word_b):
    len_a = len(word_a)
    len_b = len(word_b)

    matrix = generate_matrix_with_zeros(len_a,len_b)

    for i in range(len_a):
        for j in range(len_b):

            if word_a[i] == word_b[j]:
                matrix[i][j] = matrix[i-1][j-1] + 1

    return matrix

def generate_matrix_with_zeros(heigth, lenth):
    matrix = []
    for _ in range(heigth):
        row = []
        for _ in range(lenth):
            row.append(0)
        matrix.append(row)

    return matrix