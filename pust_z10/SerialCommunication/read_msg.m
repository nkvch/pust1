function msg = read_msg(s)
    global START STOP
    
    msg = struct('id', [], ...
                 'size', [], ...
                 'data', [], ...
                 'crc', [] ...
    );

    %% STATEs:
    i = getEnumerator(0);
    BEGIN  = i();
    ID     = i();
    LENGTH = i();
    DATA   = i();
    CRC    = i();
    END    = i();
    state = BEGIN;

    k = 0;
    while 1
        x = fread(s,1);
        switch state
        case BEGIN
            if( x == START )
                state = ID;
            end
        case ID
            msg.id = x;
            state = LENGTH;
        case LENGTH
            if(k == 0) % first byte of length
                k = k+1;
                msg.length = x*hex2dec('100');
            elseif(k == 1) % second byte of length
                msg.length = msg.length + x;
                k = 0;
                if(msg.length > 0) 
                    state = DATA;
                    msg.data = zeros(1,msg.length);
                else
                    state = CRC;
                    msg.data = [];
                end
            end
        case DATA
            k = k+1;
            msg.data(k) = x;
            if( k == msg.length)
                k = 0;
                state = CRC;
            end
        case CRC
            msg.crc = x;
            % someday I will implement CRC controll
            state = END;
        case END
            if( x == STOP )
                break;
            end
        end    
    end
end