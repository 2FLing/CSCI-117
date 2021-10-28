% ----------------------------------part1------------------------------------------

% deal([1,2,3],([1,3],[2])).  mode:(+,+) Solution: true
% deal([1,2,3],A).  mode:(+,-) Solution: A = ([1, 3],[2])
deal([],([],[])).
deal([H|T],([H|Z],Y)) :- deal(T,(Y,Z)).

% merge([1,2,3],[4,5,6],[1,2,3,4,5,6]). mode:(+,+,+)  Solution: true
% merge([1,2,3],[4,5,6],A). mode:(+,+,-) Solution: A = [1, 2, 3, 4, 5, 6]
merge([],Y,Y).
merge(X,[],X).
merge([X|T],[Y|Z],[M|N]) :- X=<Y -> M=X, merge(T,[Y|Z],N).
merge([X|T],[Y|Z],[M|N]) :- X>Y -> M=Y, merge([X|T],Z,N).

% ms([3,1,5,4,2],[1,2,3,4,5]). mode:(+,+) Solution: true
% ms([3,1,5,4,2],A). mode:(+,-) Solution: A = [1, 2, 3, 4, 5]
ms([],[]).
ms([A],[A]).
ms(X,Y) :- deal(X,(M,N)),ms(M,L1),ms(N,L2),merge(L1,L2,Y).

% cons(3,snoc(snoc(nil,1),2),snoc(snoc(snoc(nil, 3), 1), 2)). mode:(+,+,+) Solution:true
% cons(3,snoc(snoc(nil,1),2),A). mode:(+,+,-) Solution: A = snoc(snoc(snoc(nil, 3), 1), 2)
% cons(A,snoc(snoc(nil,1),2),snoc(snoc(snoc(nil, 3), 1), 2)). mode:(-,+,+) Solution: A=3
% cons(3,A,snoc(snoc(snoc(nil, 3), 1), 2)). mode:(+,-,+) Solution: A = snoc(snoc(nil, 1), 2)
cons(E, nil, snoc(nil,E)).
cons(E, snoc(BL,N), snoc(EBL,N)) :- cons(E, BL, EBL).

% toBList([1,2,3],snoc(snoc(snoc(nil, 1), 2), 3)). mode: (+,+) Solution: true
% toBList([1,2,3],A). mode: (+,-) Solution: A = snoc(snoc(snoc(nil, 1), 2), 3).
toBList([],nil).
toBList([X|Y],Z) :- toBList(Y,V), cons(X,V,Z).

% snoc([1,2,3,4],5,[1,2,3,4,5]). mode: (+,+,+) Solution: true
% snoc(A,5,[1,2,3,4,5]). mode: (-,+,+) Solution: A = [1, 2, 3, 4]
% snoc([1,2,3,4],A,[1,2,3,4,5]). mode: (+,-,+) Solution: A = 5
% snoc([1,2,3,4],5,A). mode: (+,+,-) Solution: A = [1, 2, 3, 4, 5]
snoc(X,N,Y) :- append(X,[N],Y). 

% fromBList(snoc(snoc(snoc(nil,1),2),3),[1,2,3]). mode:(+,+) Solution: true
% fromBList(snoc(snoc(snoc(nil,1),2),3),A). mode:(+,-) Solution: A = [1,2,3]
fromBList(nil,[]).
fromBList(snoc(nil,E),E).
fromBList(snoc(BL,N),Res) :-  fromBList(BL,List),snoc(List,N,Res).

% num_empties(node(1,node(2,empty,empty),node(3,empty,empty)),4). mode: (+,+) Solution: true
% num_empties(node(1,node(2,empty,empty),node(3,empty,empty)),A). mode: (+,-) Solution: A = 4
num_empties(empty,1).
num_empties(node(_,L,R),Res) :- num_empties(L,R1),num_empties(R,R2), Res is R1+R2.

% num_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),3). mode: (+,+) Solution: true
% num_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),A). mode(+,-) Solution: A = 3
num_nodes(empty,0).
num_nodes(node(_,L,R),Res) :- num_nodes(L,R1),num_nodes(R,R2), Res is R1+R2+1.

% insert_left(1,node(3,empty,node(4,empty,empty)),node(3, node(1, empty, empty), node(4, empty, empty))). mode: (+,+) Solution: true
% insert_left(1,node(3,empty,node(4,empty,empty)),A). mode: (+,-) Solution: A = node(3, node(1, empty, empty), node(4, empty, empty))
insert_left(E,empty,node(E,empty,empty)).
insert_left(E,node(A,L,R),node(A,AL,R)) :- insert_left(E,L,AL). 

% insert_right(2,node(4,empty,node(5,empty,empty)),node(4, empty, node(5, empty, node(2, empty, empty)))). mode: (+,+) Solution: true
% insert_right(2,node(4,empty,node(5,empty,empty)),A). mode: (+,-) Solution: A = node(4, empty, node(5, empty, node(2, empty, empty))).
insert_right(E,empty,node(E,empty,empty)).
insert_right(E,node(A,L,R),node(A,L,AR)) :- insert_right(E,R,AR).

% sum_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),6). mode: (+,+) Solution: true
% sum_nodes(node(1,node(2,empty,empty),node(3,empty,empty)),A). mode:(+,-) Solution: A = 6
sum_nodes(empty,0).
sum_nodes(node(E,L,R),Res) :- sum_nodes(L,Num2),sum_nodes(R,Num3), Res is E+Num2+Num3.

% inorder(node(4,node(2,node(1,empty,empty),node(3,empty,empty)),node(6,empty,empty)),[1,2,3,4,6]). mode: (+,+) Solution: true
% inorder(node(4,node(2,node(1,empty,empty),node(3,empty,empty)),node(6,empty,empty)),A). mode: (+,-) Solution: A = [1,2,3,4,6]
inorder(empty,[]).
inorder(node(E,empty,empty),[E]).
inorder(node(E,L,R),Res) :- inorder(L,List1),inorder(R,List2),append(List1,[E],FH),append(FH,List2,Res).

% num_elts(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),5). mode: (+,+) Solution: true.
% num_elts(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),A). mode: (+,-) Solution: A = 5
num_elts(T,N) :- neh([T],0,N).
neh([],A,A).
neh([leaf(_)|Ts],A,N) :- AE is A+1, neh(Ts,AE,N).
neh([node2(_,L,R)|Ts],A,N) :- AE is A+1, neh([L,R|Ts],AE,N). 

% sum_nodes2(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),15). mode: (+,+) Solution: true
% sum_nodes2(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),A). mode: (+,-) Solution: A = 15
sum_nodes2(leaf(E),E).
sum_nodes2(node2(E,L,R),Res) :- sum_nodes2(L,R1),sum_nodes2(R,R2), Res is E+R1+R2.

% inorder2(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),[3,2,4,1,5]). mode: (+,+) Solution: true
% inorder2(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),A). mode: (+,-) Solution: [3,2,4,1,5]
inorder2(leaf(E),[E]).
inorder2(node2(E,L,R),Res) :- inorder2(L,List1),inorder2(R,List2),append(List1,[E],FH),append(FH,List2,Res).

% conv21(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),node(1, node(2, node(3, empty, empty), node(4, empty, empty)), node(5, empty, empty))). mode: (+,+) Solution: true
% conv21(node2(1,node2(2,leaf(3),leaf(4)),leaf(5)),A). mode: (+,-) A = node(1, node(2, node(3, empty, empty), node(4, empty, empty)), node(5, empty, empty)).
conv21(leaf(E),node(E,empty,empty)).
conv21(node2(E,L,R),node(E,L2,R2)) :- conv21(L,L2),conv21(R,R2). 

% -------------------------------------------part2-----------------------------------------------------------------

% toBList_it([1,2,3], snoc(snoc(snoc(nil, 1), 2), 3)). mode:(+,+) Solution: true
% toBList_it([1,2,3],A). mode: (+,-) Solution: A = snoc(snoc(snoc(nil, 1), 2), 3).
% toBList_it(A,snoc(snoc(snoc(nil, 1), 2), 3)). mode: (-,+) Solution: A = snoc(snoc(snoc(nil, 1), 2), 3)
toBList_it(L,Res) :- ltob(L,nil,Res).
ltob([],A,A).
ltob([X],A,snoc(A,X)).
ltob(L,A,snoc(A2,C)) :- last(L,C), append(InitL,[C],L),ltob(InitL,A,A2).

% fromBList_it(snoc(snoc(snoc(nil, 1), 2), 3),[1,2,3]). mode: (+,+) Solution: true
% fromBList_it(snoc(snoc(snoc(nil, 1), 2), 3),A). mode: (+,-) Solution: A = [1,2,3]
% fromBList_it(A,[1,2,3]) mode: (-,+) Solution: A = snoc(snoc(snoc(nil, 1), 2), 3)
fromBList_it(A,Res) :- btol(A,[],Res).
btol(nil,L,L).
btol(snoc(A,E),L,Res) :- btol(A,L,L2),append(L2,[E],Res). 

% sum_nodes_it(node(1,node(2,empty,empty),node(3,empty,empty)),6). mode: (+,+) Solution: true
% sum_nodes_it(node(1,node(2,empty,empty),node(3,empty,empty)),A). mode: (+,-) Solution: A = 6
sum_nodes_it(T, N) :- sum_help([T], 0, N).
sum_help([], A, A).
sum_help([empty|Ts], A, N) :- sum_help(Ts, A, N).
sum_help([node(E,L,R)|Ts], A, N) :- AE is A + E, sum_help([L,R|Ts], AE, N).

% num_empties_it(node(1,node(2,empty,empty),node(3,empty,empty)),4). mode: (+,+) Solution: true
% num_empties_it(node(1,node(2,empty,empty),node(3,empty,empty)),A). mode: (+,-) Solution: A = 4
num_empties_it(T,N) :- nempt_help([T],0,N).
nempt_help([],A,A).
nempt_help([empty|Ts],A,N) :- AE is A+1, nempt_help(Ts,AE,N).
nempt_help([node(_,L,R)|Ts],A,N) :- nempt_help([L,R|Ts],A,N).

% num_nodes_it(node(1,node(2,empty,empty),node(3,empty,empty)),3). mode: (+,+) Solution: true
% num_nodes_it(node(1,node(2,empty,empty),node(3,empty,empty)),A). mode: (+,-) Solution: A = 3
num_nodes_it(T,N) :- numn_help([T],0,N).
numn_help([],A,A).
numn_help([empty|Ts],A,N) :- numn_help(Ts,A,N).
numn_help([node(_,L,R)|Ts],A,N) :- AE is A+1, numn_help([L,R|Ts],AE,N).

% sum_nodes2(node2(1,node2(2,leaf(4),leaf(5)),leaf(3)),15). mode: (+,+) Solution: true
% sum_nodes2(node2(1,node2(2,leaf(4),leaf(5)),leaf(3)),A). mode: (+,-) Solution: A = 15
sum_nodes2_it(T,N) :- sum_help2([T],0,N).
sum_help2([],A,A).
sum_help2([leaf(E)|Ts],A,N) :- AE is A+E, sum_help2(Ts,AE,N).
sum_help2([node2(E,L,R)|Ts],A,N) :- AE is A+E, sum_help2([L,R|Ts],AE,N).

% inorder2_it(node2(1,node2(2,leaf(4),leaf(5)),leaf(3)),[4, 2, 5, 1, 3]). mode: (+,+) Solution: true
% inorder2_it(node2(1,node2(2,leaf(4),leaf(5)),leaf(3)),A). mode: (+,-) Solution: A =  [4, 2, 5, 1, 3]
inorder2_it(T,Res) :- inord([T],[],Res).
inord([],L,L).
inord([leaf(E)|Ts],L,Res) :- append([E],L,Ls), inord(Ts,Ls,Res).
inord([node2(E,L,R)|Ts],L0,Res) :- append([R],[leaf(E)],L1),append(L1,[L],L2),append(L2,Ts,Ls),inord(Ls,L0,Res).

% --------------------------------------extra credit ----------------------------------------------------

% all_child_leaves(node(1,node(2,empty,empty),node(3,empty,empty)),true). mode: (+,+) Solution: true.
% all_child_leaves(node(1,node(2,empty,empty),node(3,empty,empty)),A). mode: (+,-) Solution: A = true.
% all_child_leaves(node(1,node(2,empty,empty),node(3,node(1,empty,empty),empty)),A). mode: (+,-) Solution: A = false.
all_child_leaves(empty,false).
all_child_leaves(node(_,empty,empty),true).
all_child_leaves(node(_,_,empty),false).
all_child_leaves(node(_,empty,_),false).
all_child_leaves(node(_,L,R),Res) :- all_child_leaves(L,Res), all_child_leaves(R,Res).

% conv12(node(1,node(2,empty,empty),node(3,empty,empty)),just(node2(1, leaf(2), leaf(3)))). mode: (+,+) Solution: true
% conv12(node(1,node(2,empty,empty),node(3,empty,empty)),A). mode: (+,-) Solution: A = just(node2(1, leaf(2), leaf(3)))
% conv12(node(1,node(2,empty,empty),node(3,node(4,empty,empty),empty)),A). mode: (+,-) Solution: A = nothing
conv12(empty,nothing).
conv12(node(E,empty,empty),just(leaf(E))).
conv12(node(_,empty,_),nothing).
conv12(node(_,_,empty),nothing).
conv12(node(E,L,R),Res) :- all_child_leaves(L,All),all_child_leaves(R,All), All == true ->  conv(L,NL), conv(R,NR), Res = just(node2(E,NL,NR));
    Res = nothing.
conv(node(E,empty,empty),leaf(E)).
conv(node(E,L,R),node2(E,NL,NR)) :- conv(L,NL),conv(R,NR).

% bst(node(5,node(3,node(2,empty,empty),node(4,empty,empty)),node(6,empty,empty)),true). mode: (+,+) Solution: true.
% bst(node(5,node(3,node(2,empty,empty),node(4,empty,empty)),node(6,empty,empty)),A). mode: (+,-) Solution: A = true.
% bst(node(5,node(3,node(2,empty,empty),node(9,empty,empty)),node(6,empty,empty)),A). mode: (+,-) Solution: A = false.

bst(empty,true).
bst(node(_,empty,empty),true).
bst(node(E,L,R),Res) :- bsth(L,E,Res1), bsth(R,E,Res2), Res1 == "LT", Res2 == "GT",Res = true,alless(L,E,Res),allgreat(R,E,Res),bst(L,Res),bst(R,Res),!.
bst(_,false).

alless(empty,_,true).
alless(node(E,empty,empty),N,Res) :- E<N, Res=true.
alless(node(E,L,empty),N,Res) :- E<N, Res=true,alless(L,N,Res).
alless(node(E,empty,R),N,Res) :- E<N, Res=true,alless(R,N,Res).
alless(node(E,L,R),N,Res) :- E<N, Res=true,alless(L,N,Res),alless(R,N,Res),!.
alless(_,_,false).

allgreat(empty,_,true).
allgreat(node(E,empty,empty),N,Res) :- E>N, Res=true.
allgreat(node(E,L,empty),N,Res) :- E>N, Res=true,allgreat(L,N,Res).
allgreat(node(E,empty,R),N,Res) :- E>N, Res=true,allgreat(R,N,Res).
allgreat(node(E,L,R),N,Res) :- E>N, Res=true,allgreat(L,N,Res),allgreat(R,N,Res),!.
allgreat(_,_,false).

bsth(empty,_,"GT").
bsth(node(E,_,_),X,Res) :-	E>X	->  Res = "GT".
bsth(node(E,_,_),X,Res) :- 	E==X ->  Res = "EQ".
bsth(node(E,_,_),X,Res) :-	E<X ->  Res = "LT".

% bst2(node2(5,node2(3,leaf(1),leaf(4)),leaf(6)),true). mode: (+,+) Solution: true.
% bst2(node2(5,node2(3,leaf(1),leaf(4)),leaf(6)),A). mode: (+,-) Solution: A = true.
% bst2(node2(5,node2(3,leaf(1),leaf(9)),leaf(6)),A). mode: (+,-) Solution: A = false.
bst2(leaf(_),true).
bst2(node2(E,L,R),Res) :- bsth2(L,E,Res1),bsth2(R,E,Res2), Res1 == "LT", Res2 == "GT", Res=true, alless2(L,E,Res),allgreat2(R,E,Res),bst2(L,Res),bst2(R,Res);
    Res=false.

alless2(leaf(E),N,Res) :- E<N,Res=true.
alless2(node2(E,L,R),N,Res) :- E<N,Res=true,alless2(L,N,Res),alless2(R,N,Res);
    Res=false.

allgreat2(leaf(E),N,Res) :- E>N,Res=true.
allgreat2(node2(E,L,R),N,Res) :- E>N,Res=true,allgreat2(L,N,Res),allgreat2(R,N,Res);
    Res=false.

bsth2(leaf(E),X,Res) :- E>X	->  Res = "GT".
bsth2(leaf(E),X,Res) :- E==X ->  Res = "EQ".
bsth2(leaf(E),X,Res) :- E<X	->  Res = "LT".
bsth2(node2(E,_,_),X,Res) :- E>X	->  Res = "GT".
bsth2(node2(E,_,_),X,Res) :- E==X ->  Res = "EQ".
bsth2(node2(E,_,_),X,Res) :- E<X	->  Res = "LT".
    
