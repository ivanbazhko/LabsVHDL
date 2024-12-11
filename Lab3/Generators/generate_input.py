def write_binary_file(filename, max_number):
    num_bits = max_number.bit_length() - 1

    with open(filename, 'w') as file:
        for number in range(max_number):
            binary_string = format(number, f'0{num_bits}b')
            file.write(binary_string + '\n')

filename = 'input_2048.txt'
max_number = 2048
write_binary_file(filename, max_number)