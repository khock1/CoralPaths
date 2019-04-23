fmcml=1-amcmlnet;
fmcml(fmcml==1)=inf;
fmcml=zerodiag(fmcml);
amcmlnet=zerodiag(amcmlnet);
amadjnet=zerodiag(amadjnet);

for i=1:length(am)
    for j=1:length(am)
        [~,thispth,~] = graphshortestpath(sparse(zerodiag(amcmlnet)),am(i,1),am(j,1));
        thispw=0;
        for pth=1:(length(thispth)-1)
            thispw=thispw+(amcmlnet(thispth(1,pth), thispth(1,(pth+1))));
        end
        Mavglwnet(i,j)=thispw/(length(thispth-1));
    end
end

for i=1:length(am)
    for j=1:length(am)
        [costs,paths] = dijkstra(amadjnet,fmcml,am(i),am(j));
        thisfm=0;
        for pth=1:(length(paths)-1)
            thisfm=thisfm+(amcmlnet(paths(pth), paths(pth+1)));
        end
        
        Mavglwnet(i,j)=thispw/(length(thispth-1));
    end
end