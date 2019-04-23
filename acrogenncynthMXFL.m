mmx=[];mmn=[];
amnegcml=zeros(length(Mn1));
mmx=max(max(zerodiag(amcmlnet)));
mmn=min(min(amcmlnet(amcmlnet>0)));
for i=1:length(Mn1)
    for j=1:length(Mn1)
        if amcmlnet(i,j)>0
            amnegcml(i,j)=-amcmlnet(i,j)+mmx+mmn;
        end
    end
end

sr1=graphtraverse(sparse(amadjnet),177,'depth',1,'Method','BFS');
sr2=graphtraverse(sparse(amadjnet),177,'depth',2,'Method','BFS');
sr=setdiff(sr2,sr1);
sn1=graphtraverse(sparse(transpose(amadjnet)),679,'depth',1,'Method','BFS');
sn2=graphtraverse(sparse(transpose(amadjnet)),679,'depth',2,'Method','BFS');
sn=setdiff(sn2,sn1);

smat=amadjnet([177 sr2],[177 sr2]);
allPaths = findpaths(smat, unusedNodes, [], 1, 643);


[x,y,w]=find(zerodiag(amcmlnet));
G = digraph(x,y,w);
 for i=1:length(am)
    for j=1:length(am)
        if i~=j
            Mmaxflownet(i,j)= maxflow(G,am(i),am(j));
        end
    end
end
for i=1:length(av)
    for j=1:length(av)
        if i~=j
            Vmaxflownet(i,j)= maxflow(G,av(i),av(j));
        end
    end
end