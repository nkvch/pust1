function U = DMC_roz(yzad, y)
    
    persistent init s M  MP K dup Ku Ke Upop
    liczba_reg = 3;
    param = [0 10 30 40; 30 40 60 70; 60 70 90 100];
    D={20,20,20};
    lambda={1,1,1};
    N=D;
    Nu=D;
    w(1:size(param,1)) = 0;
    
    param(1,1:2)=-inf;
    param(liczba_reg,3:4)=inf;
    
    if isempty(init)
        %Inicjalizacja macierzy i wektor?w dla regulator?w
        dup=cell(1,liczba_reg); 
        M=cell(1,liczba_reg);   
        MP=cell(1,liczba_reg);
        K=cell(1,liczba_reg);
        Ku=cell(1,liczba_reg);
        Ke=cell(1,liczba_reg);
        s=cell(1, liczba_reg); %Wektory odpowiedzi skokowych
        %s{i}=s_tmp; %czytanie wspo?czynnik?w odpowiedzi skokowych
        s{1}(1, D{1}) = 1;
        s{2}(1, D{2})= 1;
        s{3}(1, D{3})= 1;
        s{1}(D{1}+1:D{1}+N{1})=s{1}(D{1});
        s{2}(D{2}+1:D{2}+N{2})=s{2}(D{2});
        s{3}(D{3}+1:D{3}+N{3})=s{3}(D{3});

        for k=1:liczba_reg
            dup{k}(1:D{k}-1) = 0;

            M{k}=zeros(N{k},Nu{k});
            for i=1:Nu{k}
                M{k}(i:N{k},i)=s{k}(1:N{k}-i+1);
            end
            MP{k}=zeros(N{k},D{k}-1);
            for i=1:(D{k}-1)
                MP{k}(1:N{k},i)=s{k}(i+1:N{k}+i)-s{k}(i);
            end

            K{k}=((M{k}'*M{k}+lambda{k}*eye(Nu{k}))^-1)*M{k}';
            Ku{k}=K{k}(1,:)*MP{k};
            Ke{k}=sum(K{k}(1,:));
        end
        Upop = 31;
        init = 1;
    end

    Gmax = 100;
    Gmin = 0;
    e = yzad-y;
    du_sum = 0;
    for i=1:liczba_reg
        du{i}=Ke{i}*e-Ku{i}*dup{i}'; %regulator
        
        for n=D{i}-1:-1:2
            dup{i}(n)=dup{i}(n-1); %przesuni?cie warto?ci wektora dup
        end
        dup{i}(1)=du{i};
        w(i)=trapmf(Upop,param(i,:));%trapezowa funkcja przynaleznosci
        du_sum = du_sum + du{i}*w(i);
    end
    
    U = Upop+du_sum/sum(w);
  
    if U > Gmax
        U = Gmax;
    end
    
    if U < Gmin
        U = Gmin;
    end
    
    Upop = U;
end