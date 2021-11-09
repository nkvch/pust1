function y = dec2int16(x)
    if (x ~= round(x))
        error('Input argument must be an integer');
    end
    if    (x >=      0 && x <= 32767) 
        y = x;
    elseif(x >= -32768 && x <      0) 
        y = 65536+x; 
    else
        error('Input argument must have value from -32768 to 32767');
    end
end
