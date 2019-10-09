function [ disparity1, E ] = alpha_expansion( row1, row2, disparity, alpha )
    
    %ERROR
    E = 1;
    disparity1 = disparity;
    inf = 1000000000;
    
    
    
    
    n = max( size(row1));
    
    
    %cap = zeros(n*2 + 2, n*2 + 2);
    edges = zeros(n*2 + 2, 5);
    
    
    %s is alpha, t is ~alpha
    s = n+1;
    t = n+2;
    num = n+2;
    
    for i=1:n
        val = V(1, 2);
        %add_edge(i,s, val);
        
        if(disparity(i) == alpha)
            inf = inf + 1;
        end
    end
    return;
    for i=1:n
        
        %link to s
        val = 0;
        val = D(row1, row2, i, alpha);
        add_edge(i, s, val);
        
        %link to t
        if disparity(i) == alpha
            add_edge(i, t, inf);
        else
            val = D(row1, row2, i, disparity(i));
            add_edge(i, t, val);
        end
        
        if i == n
            continue;
        end
        %linke to auxiliary node or neighbor pixel on the  right
        if disparity(i) == disparity(i+1)
            val = V(disparity(i), alpha);
            add_edge(i, i+1, val);
        else
            num = num + 1;
            aux = num;
            val = V(disparity(i), alpha);
            add_edge(i, aux, val);
            
            val = V(alpha, disparity(i+1));
            add_edge(aux, i+1, val);
            
            val = V(disparity(i), disparity(i+1));
            add_edge(aux, t, val);
        end
        
        
    end
    
    return;
    [E, res_cap] = max_flow(s, t, edges, cap, num);
    
    
    for i=1:n
        if res_cap(i, s) == 0
            disparity1(i) = alpha;
        end
    end
    
    function add_edge(u, v, w)
        %add_edge1(u, v, w);
        %add_edge1(v, u, w);
    end

    function add_edge1(u,v, w)
        %cnt = edges(u,1) + 1;
        %edges(u, 1) = cnt;
        %edges(u, 1 + cnt) = v;
        %cap(u, v) = w;
    end
end



