const writeLatex = path => {
    //newPID_u1_to_y2_u2_to_y3_u3_is_0.00_u4_to_y1_K1_is_0.60_Ti1_is_1.00_Td1_is_1.00_K2_is_3.00_Ti2_is_0.10_Td2_is_1.00_K3_is_1.00_Ti3_is_1.00_Td3_is_1.00_E_is_143.3710

    const [uconstpart] = path.match(/u\d_is_\d*.\d*/);
    const uconstrstr = uconstpart.replace('_is_', ' = ').replace('u', 'u_').replace('.', ',');

    const [k1part] = path.match(/K1_is_\d*\.\d*/);
    const k1str = k1part.replace('K1_is_', '');
    const k1 = String(Number(k1str)).replace('.', ',');

    const [ti1part] = path.match(/Ti1_is_\d*\.\d*/);
    const ti1str = ti1part.replace('Ti1_is_', '');
    const ti1 = String(Number(ti1str)).replace('.', ',');
    
    const [td1part] = path.match(/Td1_is_\d*\.\d*/);
    const td1str = td1part.replace('Td1_is_', '');
    const td1 = String(Number(td1str)).replace('.', ',');
    
    const [k2part] = path.match(/K2_is_\d*\.\d*/);
    const k2str = k2part.replace('K2_is_', '');
    const k2 = String(Number(k2str)).replace('.', ',');

    const [ti2part] = path.match(/Ti2_is_\d*\.\d*/);
    const ti2str = ti2part.replace('Ti2_is_', '');
    const ti2 = String(Number(ti2str)).replace('.', ',');
    
    const [td2part] = path.match(/Td2_is_\d*\.\d*/);
    const td2str = td2part.replace('Td2_is_', '');
    const td2 = String(Number(td2str)).replace('.', ',');
    
    const [k3part] = path.match(/K3_is_\d*\.\d*/);
    const k3str = k3part.replace('K3_is_', '');
    const k3 = String(Number(k3str)).replace('.', ',');

    const [ti3part] = path.match(/Ti3_is_\d*\.\d*/);
    const ti3str = ti3part.replace('Ti3_is_', '');
    const ti3 = String(Number(ti3str)).replace('.', ',');
    
    const [td3part] = path.match(/Td3_is_\d*\.\d*/);
    const td3str = td3part.replace('Td3_is_', '');
    const td3 = String(Number(td3str)).replace('.', ',');
    
    const [epart] = path.match(/E_is_\d*\.\d*/);
    const estr = epart.replace('E_is_', '');
    const e = String(Number(estr)).replace('.', ',');

    console.log(`
\\begin{figure}[H]
    \\centering
    \\input{${path}}
    \\caption{$${uconstrstr}; K_1 = ${k1}; Ti_1 = ${ti1}; Td_1 = ${td1}; K_2 = ${k2}; Ti_2 = ${ti2}; Td_2 = ${td2}; K_3 = ${k3}; Ti_3 = ${ti3}; Td_3 = ${td3}.$}
\\end{figure}

\\begin{equation}
    E = ${e}
\\end{equation}
    `);
};