def write_binary_file(filename1, filename2, max_number):
    num_bits = max_number.bit_length() - 1
    
    # Input: 0-XMIT 1-PARITY 2-I 3-G 4-H 5-F 6-E 7-D 8-C 9-B 10-A
    # Output: 0-PARITY 1-PERR

    with open(filename1, 'w') as file1:
        with open(filename2, 'w') as file2:
            for number in range(max_number):
                binary_string = format(number, f'0{num_bits}b')
                substr1 = binary_string[2:]
                xmit = int(binary_string[0])
                parity = int(binary_string[1])
                num1s = substr1.count('1') % 2
                resperr = 0
                resparity = 0
                resstr = ''
                shresstr = ''
                if xmit == 0:
                    resperr = 1
                    if num1s == 0:
                        resparity = 1
                    else:
                        resparity = 0
                    resstr = str(resparity) + str(resperr)
                    shresstr = resstr
                else:
                    resparity = parity
                    if num1s == 0:
                        if(parity == 0):
                            resperr = 0
                        else:
                            resperr = 1
                    else:
                        if(parity == 0):
                            resperr = 1
                        else:
                            resperr = 0
                    resstr = str(resparity) + str(resperr)
                    shresstr = 'i' + str(resparity) + str(resperr)
                file1.write(binary_string + ' ' + shresstr + '\n')
                file2.write(resstr + '\n')

filename_showcase = 'output_2048_showcase.txt'
filename = 'output_2048.txt'

max_number = 2048
write_binary_file(filename_showcase, filename, max_number)