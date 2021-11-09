function x = int16a2dec(a)
    y = bitshift(a(1),8)+a(2);
    x = int162dec(y);
end
