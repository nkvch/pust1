function init_serial_control(s)
    global SOCKET    
    define_messages_id();
    delete(instrfindall);
    SOCKET = serial(s);
    set(SOCKET,'Terminator', 'CR/LF'); 
    set(SOCKET,'Timeout', 1000);
    fopen(SOCKET);
end
