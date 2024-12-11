def write_binary_files(file1, file2):
    with open(file1, 'w') as filei:
        with open(file2, 'w') as fileo:
            do_nothing_input = '01110000'
            count_up_input = '00110000'
            count_down_input = '01010000'
            clear_input = '11110000'
            load_input_prefix = '0110'
            default_output = '110000'
            last_string = '0000'
            nconbodef = '11'
            defout= '0000'
            num_bits_info = 4 
            
            # Counting UP
            for number in range(16):
                # UP command
                filei.write(count_up_input + '\n')
                filei.write(do_nothing_input + '\n')
                nconbo = '11'
                out_number = number + 1
                if out_number == 16:
                    out_number = 0
                    nconbo = '01'
                out_string = format(out_number, f'0{num_bits_info}b')
                # UP result
                fileo.write(nconbo + last_string + '\n')
                fileo.write(nconbodef + out_string + '\n')
                last_string = out_string
            
            # Counting DOWN
            for number in range(16):
                # WAIT during counting
                if number == 5:
                    for j in range(5):
                        filei.write(do_nothing_input + '\n')
                        fileo.write(nconbodef + last_string + '\n')
                # DOWN command
                filei.write(count_down_input + '\n')
                filei.write(do_nothing_input + '\n')
                nconbo = '11'
                out_number = 15 - number
                if out_number == 15:
                    nconbo = '10'
                out_string = format(out_number, f'0{num_bits_info}b')
                # DOWN result
                fileo.write(nconbo + last_string + '\n')
                fileo.write(nconbodef + out_string + '\n')
                last_string = out_string
            
            filei.write(load_input_prefix + '0011' + '\n') # LOAD 3
            fileo.write(nconbodef + '0011' + '\n')
            filei.write(count_up_input + '\n') # UP
            fileo.write(nconbodef + '0011' + '\n')
            filei.write('10110000' + '\n') # CLEAR during UP
            fileo.write(nconbodef + defout + '\n')
            filei.write(count_up_input + '\n') # UP
            fileo.write(nconbodef + '0000' + '\n')
            filei.write(do_nothing_input + '\n') # NOTHING (UP result = 1)
            fileo.write(nconbodef + '0001' + '\n')
            filei.write(do_nothing_input + '\n') # NOTHING
            fileo.write(nconbodef + '0001' + '\n')

            filei.write(count_up_input + '\n') # UP
            fileo.write(nconbodef + '0001' + '\n')
            filei.write('00100100' + '\n') # LOAD 8 during UP
            fileo.write(nconbodef + '0100' + '\n')
            filei.write(count_up_input + '\n') # UP
            fileo.write(nconbodef + '0100' + '\n')
            filei.write(do_nothing_input + '\n') # NOTHING (UP result = 9)
            fileo.write(nconbodef + '0101' + '\n')
            filei.write(do_nothing_input + '\n') # NOTHING
            fileo.write(nconbodef + '0101' + '\n')
            
            #######################################################################
            
            bits1 = 4
            bits2 = 8
            
            # loop through triggers' states
            for i in range(16):
                state = format(i, f'0{bits1}b')
                for j in range(256):
                    input = format(j, f'0{bits2}b')
                    if input[1] == '0' and input[2] == '0':
                        continue
                    # load current state
                    filei.write(load_input_prefix + state + '\n')
                    fileo.write(nconbodef + state + '\n')
                    # wait after async load
                    filei.write('0111' + state + '\n')
                    fileo.write(nconbodef + state + '\n')
                    last_string = state
                    # if CLEAR
                    # CLEAR + LOAD = CLEAR
                    if input[0] == '1':
                        # CLEAR
                        filei.write(input + '\n')
                        coboa = '11'
                        # CLEAR + DOWN = BO
                        if input[2] == '0':
                            coboa = '10'
                        fileo.write(coboa + defout + '\n')
                        last_string = '0000'
                        # if CLEAR + UP
                        if input[1] == '0':
                            # UP command without CLEAR to wait
                            filei.write('0011' + input[4:] + '\n')
                            fileo.write(coboa + defout + '\n')
                            # UP result
                            filei.write('0111' + input[4:] + '\n')
                            fileo.write(nconbodef + '0001' + '\n')
                            last_string = '0001'
                        # if CLEAR + DOWN
                        elif input[2] == '0':
                            # DOWN command without CLEAR to wait
                            filei.write('0101' + input[4:] + '\n')
                            fileo.write(coboa + defout + '\n')
                            # DOWN result
                            filei.write('0111' + input[4:] + '\n')
                            fileo.write(nconbodef + '1111' + '\n')
                            last_string = '1111'
                        else:
                            # wait after async clear
                            filei.write('0111' + input[4:] + '\n')
                            fileo.write(nconbodef + defout + '\n')
                    # not CLEAR
                    else:
                        # if LOAD
                        if input[3] == '0':
                            # LOAD
                            filei.write(input + '\n')
                            cobob = '11'
                            loadval = int(input[4:], 2)
                            # if LOAD + UP
                            if input[1] == '0':
                                # LOAD 1111 + UP = CO
                                if input[4:] == '1111':
                                    cobob = '01'
                                # LOAD result
                                fileo.write(cobob + input[4:] + '\n')
                                # UP command without CLEAR to wait
                                filei.write('0011' + input[4:] + '\n')
                                fileo.write(cobob + input[4:] + '\n')
                                # UP result
                                filei.write('0111' + input[4:] + '\n')
                                loadval += 1
                                if loadval == 16:
                                    loadval = 0
                                fileo.write(nconbodef + format(loadval, f'0{bits1}b') + '\n')
                                last_string = format(loadval, f'0{bits1}b')
                            # if LOAD + DOWN
                            elif input[2] == '0':
                                # LOAD 0000 + DOWN = BO
                                if input[4:] == '0000':
                                    cobob = '10'
                                # LOAD result
                                fileo.write(cobob + input[4:] + '\n')
                                # DOWN command without CLEAR to wait
                                filei.write('0101' + input[4:] + '\n')
                                fileo.write(cobob + input[4:] + '\n')
                                # DOWN result
                                filei.write('0111' + input[4:] + '\n')
                                loadval -= 1
                                if loadval == -1:
                                    loadval = 15
                                fileo.write(nconbodef + format(loadval, f'0{bits1}b') + '\n')
                                last_string = format(loadval, f'0{bits1}b')
                            else:
                                # LOAD result
                                fileo.write(cobob + input[4:] + '\n')
                                # wait after async load
                                filei.write('0111' + input[4:] + '\n')
                                fileo.write(cobob + input[4:] + '\n')
                                last_string = input[4:]
                        # not CLEAR and not LOAD
                        else:
                            # if UP
                            if input[1] == '0':
                                cobo = '11'
                                # UP command
                                filei.write(input + '\n')
                                if last_string == '1111':
                                    cobo = '01'
                                fileo.write(cobo + last_string + '\n')
                                # UP result
                                filei.write('0111' + input[4:] + '\n')
                                newnum = int(last_string, 2)
                                if newnum == 15:
                                    newnum = -1
                                newnum += 1
                                fileo.write(nconbodef + format(newnum, f'0{bits1}b') + '\n')
                                last_string = format(newnum, f'0{bits1}b')
                            else:
                                # if DOWN
                                if input[2] == '0':
                                    cobo = '11'
                                    # DOWN command
                                    filei.write(input + '\n')
                                    if last_string == '0000':
                                        cobo = '10'
                                    fileo.write(cobo + last_string + '\n')
                                    # DOWN result
                                    filei.write('0111' + input[4:] + '\n')
                                    newnum = int(last_string, 2)
                                    if newnum == 0:
                                        newnum = 16
                                    newnum -= 1
                                    fileo.write(nconbodef + format(newnum, f'0{bits1}b') + '\n')
                                    last_string = format(newnum, f'0{bits1}b')
                                # no command
                                else:
                                    filei.write(input + '\n')
                                    fileo.write(nconbodef + last_string + '\n')
                                
            
            #######################################################################
                
filename1 = 'full_input_counter.txt'
filename2 = 'full_output_counter.txt'
write_binary_files(filename1, filename2)
