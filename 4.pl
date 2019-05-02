:- op(500,xfx,'is_parent').
ais_parent b. c is_parent g. f is_parent l. j is_parent q.
ais_parent c. c is_parent h. f is_parent m. j is_parent r.
ais_parent d. c is_parenti. h is_parent n. j is_parent s.
bis_parent e. d is_parent j. iis_parent o. m is_parent t.
bis_parent f. e is_parent k. iis_parent p.
/* X and Y are siblings */
:- op(500,xfx,'is_sibling_of').
X is_sibling_ofY :- Z is_parent X, Z is_parent Y, X /* The tree database */
:- op(500,xfx,'is_parent').
a is_parent b.
c is_parent g.
f is_parent l.
j is_parent q.
a is_parent c.
c is_parent h.
f is_parent m.
j is_parent r.
a is_parent d.
c is_parent i.
h is_parent n.
j is_parent s.
b is_parent e.
d is_parent j.
i is_parent o.
m is_parent t.
b is_parent f.
e is_parent k.
i is_parent p.


:- op(500,xfx,'is_sibling_of').
X is_sibling_of Y :- Z is_parent X,
                     Z is_parent Y,
                     X \== Y.

/* X and Y are on the same level in the tree. */
:-op(500,xfx,'is_same_level_as').
X is_same_level_as X .
X is_same_level_as Y :- W is_parent X,
                        Z is_parent Y,
                        W is_same_level_as Z.


/* Depth of node in the tree. */
:- op(500,xfx,'has_depth').
a has_depth 0 :- !.
Node has_depth D :- Mother is_parent Node,
                    Mother has_depth D1,
                    D is D1 + 1.

/* Locate node by finding a path from root down to the node. */
locate(Node) :- path(Node),
                write(Node),
                nl.
path(a). /* Can start at a. */
path(Node) :- Mother is_parent Node, /* Choose parent, */
path(Mother), /* find path and then */
write(Mother),
write(' --> ').

/* Calculate the height of a node, length of longest path to
a leaf under the node. */
height(N,H) :- setof(Z,ht(N,Z),Set), /* See section 2.8 for 'setof'. */
max(Set,0,H).
ht(Node,0) :- leaf(Node), !.
ht(Node,H) :- Node is_parent Child,
ht(Child,H1),
H is H1 +1.
leaf(Node) :- not(is_parent(Node,Child)). %/* Node grounded */
max([],M,M).
max([X|R],M,A) :- (X > M -> max(R,X,A) ; max(R,M,A)).


