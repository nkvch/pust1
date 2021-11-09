function define_messages_id()
    global START STOP
    global MACK MNACK MODIFY_GROUP_ENTRY READ_GROUP_ENTRY
    global CLEAR_GROUP_TABLE MODIFY_ADDRESS_LIST READ_ADDRESS_LIST
    global WRITE_GROUP_CONTROL READ_MEASUREMENTS WAIT_FOR_NEW_ITERATION
    global SACK SNACK GIVE_GROUP_ENTRY GIVE_ADDRESS_LIST GIVE_MEASUREMENTS
    global NEW_ITERATION_READY ENTER_KEY_CODE SET_INPUT_DELAY 
    global SET_OUTPUT_DELAY 
    
    %% START and STOP flags
    START = hex2dec('f0');
    STOP  = hex2dec('0f');

    %% IDs:
    i = getEnumerator(hex2dec('00'));
    MACK = i();
    MNACK = i();
    MODIFY_GROUP_ENTRY = i();
    READ_GROUP_ENTRY = i();
    CLEAR_GROUP_TABLE = i();
    MODIFY_ADDRESS_LIST = i();
    READ_ADDRESS_LIST = i();
    WRITE_GROUP_CONTROL = i();
    READ_MEASUREMENTS = i();
    WAIT_FOR_NEW_ITERATION = i();
    ENTER_KEY_CODE = i();
    SET_INPUT_DELAY = i();
    SET_OUTPUT_DELAY = i();

    i = getEnumerator(hex2dec('80'));
    SACK = i();
    SNACK = i();
    GIVE_GROUP_ENTRY = i();
    GIVE_ADDRESS_LIST = i();
    GIVE_MEASUREMENTS = i();
    NEW_ITERATION_READY = i();
end
