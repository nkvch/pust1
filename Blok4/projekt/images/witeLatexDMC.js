//    \input{../images/DMC_N_100_Nu_50_mu1_1.00_mu2_1.00_mu3_1.00_la1_1.00_la2_1.00_la3_1.00_la4_1.00_E_14.0725.tex}

const DMCwriteLatex = path => {
    const [Npart] = path.match(/N_\d*/);
    const Nstr = Npart.replace('_', ' = ');

    const [Nupart] = path.match(/Nu_\d*/);
    const Nustr = Nupart.replace('_', ' = ');
  
    const musparts = path.match(/mu\d_\d*\.\d*/g);
    const musstr = '\\mu = [' + musparts.map(str => {
        const [num] = str.match(/\d*\.\d*/);
        const numstr = String(Number(num)).replace('.', ',');

        return numstr;
    }).join(' ') + ']';

    const lasparts = path.match(/la\d_\d*\.\d*/g);
    const lasstr = '\\lambda = [' + lasparts.map(str => {
        const [num] = str.match(/\d*\.\d*/);
        const numstr = String(Number(num)).replace('.', ',');

        return numstr;
    }).join(' ') + ']';

    const [epart] = path.match(/E_\d*\.\d*/);
    const estr = epart.replace('E_', '');
    const e = String(Number(estr)).replace('.', ',');

    console.log(`
\\begin{figure}[H]
    \\centering
    \\input{${path}}
    \\caption{$DMC oszczędny. ${Nstr}; ${Nustr}; ${musstr}; ${lasstr}.$}
\\end{figure}

\\begin{equation}
    E = ${e}
\\end{equation}
    `)
    
};