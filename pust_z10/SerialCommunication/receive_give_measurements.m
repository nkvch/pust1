function [ok, size, measurements] = receive_give_measurements(msg)
    global GIVE_MEASUREMENTS
    if(msg.id == GIVE_MEASUREMENTS)
        size = msg.data(1);
        measurements = zeros(1,size);
        for nr = 1:size
            measurements(nr) = int16a2dec(msg.data((nr-1)*2+1+(1:2)))/100.0;
        end
        ok = true;
    else
        ok = false;
    end
end
