function fun = getEnumerator(x,s)
    initialised = 0;
    if(nargin == 1)
        step = 1;
    else
        step = s;
    end
    function i = enumerator()
        persistent t
        if initialised == 0
           t = x;
           initialised = 1;
        end
        i = t;
        t = t+step;
    end

    fun = @enumerator;
end
