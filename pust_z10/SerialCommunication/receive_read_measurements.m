function ok = receive_read_measurements(msg)
    global READ_MEASUREMENTS
    if(msg.id == READ_MEASUREMENTS)
        ok = true;
    else
        ok = false;
    end
end
