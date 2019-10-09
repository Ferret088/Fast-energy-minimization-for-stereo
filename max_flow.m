function [ E, res_cap ] = max_flow( s, t, edges, cap, num )
    %initialize
    E = 0;
    n = num;

    res_cap = cap;
    P = zeros(1, num);
    
    
    Tree = zeros(1, num);
    Tree(s) = 1;
    Tree(t) = 2;
    
    A = zeros(1, n + 2);
    mA = zeros(1, n);
    A(n+2) = 1; %head
    
    addA(s);
    addA(t);
    
    
    O = zeros(1, n + 2);
    mO = zeros(1, n);
    O(n+2) = 1; %head

    
    while true %while
        
    %growth
    [p, q] = grow();
    
    
    
    
    if p == 0
        return;
    end
    
    %augmentation
    min_cap = res_cap(p, q);
    p1 = p;
    while P(p1) ~= 0
        tree_cap = res_cap(P(p1), p1);
        if tree_cap < min_cap
            min_cap = tree_cap;
        end
        p1 = P(p1);
    end
    
    q1 = q;
    while P(q1) ~= 0
        tree_cap = res_cap(q1, P(q1));
        if tree_cap < min_cap
            min_cap = tree_cap;
        end
        q1 = P(q1);
    end
    
    pushFlow(p, q, min_cap);
    p1 = p;
    while P(p1) ~= 0
        pushFlow(P(p1), p1, min_cap);
        tmp = P(p1);
        if res_cap(P(p1), p1) == 0
            P(p1) = 0;
            addO(p1);
        end
        p1 = tmp;
    end
    
    q1 = q;
    while P(q1) ~= 0
        pushFlow(q1, P(q1), min_cap);
        tmp = P(q1);
        if res_cap(q1, P(q1)) == 0
            P(q1) = 0;
            addO(q1);
        end
        q1 = tmp;
    end
    
    
    E = E + min_cap;
    
    %adoption
    while true
        p = pollO;
        if p == 0
            break;
        end
        
        nEdge = edges(p, 1);
        for i=2:(1+nEdge);
            q = edges(p, i);
            
            valid = 0;
            if Tree(p) == Tree(q) && treeCap(q, p, Tree(q), res_cap(q,p), res_cap(p, q)) > 0
                q1 = q;
                while P(q1) ~= 0
                    if P(q1) == s || P(q1) == t
                        valid = 1;
                    end
                    q1 = P(q1);
                end
                
                if valid
                    P(p) = q;
                    break;
                end
            end
        end
        
        if valid == 1
            continue;
        end
        
        nEdge = edges(p, 1);
        for i=2:(1+nEdge);
            q = edges(p, i);
            
            if Tree(p) == Tree(q) 
                if treeCap(q, p, Tree(q), res_cap(q,p), res_cap(p, q)) > 0
                    addA(q);
                end
                
                if P(q) == p
                    addO(q);
                    P(q) = 0;
                end
                
            end
        end
        
        Tree(p) = 0;
      
        [A, mA] = del(A, mA, p);
        

    end
    
    
    end%while
function pushFlow(p, q, min_cap)
    res_cap(p,q) = res_cap(p,q) - min_cap;
    res_cap(q,p) = res_cap(q,p) + min_cap;
end

function [p, q] = grow()
    
    
    while true
        p = peekA;
        if p == 0
            break;
        end
        
        nEdge = edges(p, 1);
        for i=2:(1+nEdge)
            q = edges(p, i);
            
            tree_cap = treeCap(p, q, Tree(p), res_cap(p, q), res_cap(q,p));
            
            
            if tree_cap > 0
                if Tree(q) == 0
                    Tree(q) = Tree(p);
                    P(q) = p;
                    addA(q);
                   
                else 
                    if Tree(q) ~= Tree(p)
                        if Tree(p) == 2
                            tmp = p;
                            p = q;
                            q = tmp;
                        end
                        
                        return;
                    end
                end
            end
            
        end
        pollA;
    end
    p = 0;
    q = 0;
end
    
function tree_cap = treeCap(p, q, tree_p, res_cap1, res_cap2)
    tree_cap = 0;
    if tree_p == 1
        tree_cap = res_cap1;
    elseif tree_p == 2
        tree_cap = res_cap2;
    else
        display('error');
    end
end

function ret = myMod(a, b)
    if a > b
        ret = a-b;
    else
        ret = a;
    end
    ret = uint32(ret);
end




function addA(x)
     
    if mA(x) == 1
        return
    end

    pos = myMod(A(n+2) + A(n+1), n);
    A(pos) = x;
    A(n+1) = A(n+1) + 1;
    mA(x) = 1;
end

function x = pollA()
    x = 0;
    
    if A(n+1) == 0
        return
    end
    
    pos = A(n+2);
    x = A(pos);
    A(pos) = 0;
    A(n+2) = myMod(A(n+2) + 1, n);
    A(n+1) = A(n+1) - 1;
    mA(x) = 0;
end

function addO(x)
     
    if mO(x) == 1
        return
    end

    pos = myMod(O(n+2) + O(n+1), n);
    O(pos) = x;
    O(n+1) = O(n+1) + 1;
    mO(x) = 1;
end

function x = pollO()
    x = 0;
    
    if O(n+1) == 0
        return
    end
    
    pos = O(n+2);
    x = O(pos);
    O(pos) = 0;
    O(n+2) = myMod(O(n+2) + 1, n);
    O(n+1) = O(n+1) - 1;
    mO(x) = 0;
end

function [Q, mQ] = del(Q1, mQ1, x)
    if mQ1(x) == 0
        Q = Q1;
        mQ = mQ1;
        return
    end
    mQ = mQ1;
    mQ(x) = 0;
    
    n = max(size(mQ1));
    Q = zeros(1, n+2);
    Q(n+2) = 1;
    
    head = Q1(n+2);
    cnt = Q1(n+1);
    
    for i=head: (head + cnt - 1)
        tmp = Q1(myMod(i,n));
        if tmp ~= x
            Q(Q(n+2)+Q(n+1)) = tmp;
            Q(n+1) = Q(n+1) + 1;
        end
    end
end
            
    
function [x] = peekA()
    x = 0;
    
    if A(n+1) == 0
        return
    end
    
    x = A(A(n+2));
end

end


