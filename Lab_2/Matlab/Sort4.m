function out = Sort4( input )
    layer1 = zeros(4,2);
    [layer1(1,:), layer1(2,:)] = Comparator_C( input(1,:), input(2,:) );
    [layer1(3,:), layer1(4,:)] = Comparator_C( input(3,:), input(4,:) );

    layer2 = zeros(4,2);
    [layer2(1,:), layer2(2,:)] = Comparator_C( layer1(1,:), layer1(3,:) );
    [layer2(3,:), layer2(4,:)] = Comparator_C( layer1(2,:), layer1(4,:) );

    out = layer2;
    [out(2,:), out(3,:)] = Comparator_C( layer2(2,:), layer2(3,:) );
end

