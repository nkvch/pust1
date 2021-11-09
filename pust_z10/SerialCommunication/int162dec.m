function x = int162dec(y)
    if (y ~= round(y))
        error('Input argument must be an integer');
    end
    if    (y >=      0 && y <= 32767) 
        x = y;
    elseif(y >= 32768 && y <   65536) 
        x = y-65536; 
    else
        error('Input argument must have value from 0 to 65535');
    end
end
