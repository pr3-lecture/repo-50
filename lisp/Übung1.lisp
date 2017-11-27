; Aufgabe 1
;----------

; (a) Elemente tauschen: Schreiben Sie eine Funktion rotiere, die eine Liste 
; als Argument erhäalt und eine neue Liste zuruckliefert, in der das 
; vormals erste Element nun das letzte ist.
(defun rotiere (arg1)
    (append(rest arg1) (list (first arg1)))
)
(print (rotiere '(eins zwei drei vier)))

; (b) Element einfugen : Schreiben Sie eine Funktion neues-vorletztes , 
; die eine Liste als Argument erhält und eine neue Liste zuruckliefert, 
; in der das vormals erste Element nun das letzte ist.
(defun abl (list)
    (loop for l on list
        while (rest l)
            collect (first l))
)

(defun neues-vorletztes(e l) 
    (append (append (abl l) (list e) (last l)))
)
(print (neues-vorletztes 'dreieinhalb '(eins zwei drei vier)))

; (c) Länge einer Liste berechnen: Schreiben Sie eine Funktion my-length
; zur Berechnung der Länge einer Liste.
(defun my-length (list)
    (cond ((null list) 0)
        (T
            (+ 1 (my-length (cdr list)))
        )
    )
)
(print (my-length '(eins zwei drei vier)))

; (d) Länge einer geschachtelten Liste berechnen: Schreiben Sie eine Funktion 
; my-lengthR zur Berechnung der Länge einer Liste und aller eingeschachtelten
; Listen.
(defun my-lengthR (list)
    (cond ((null list) 0) ; länge 0 bei leerer Liste
        ((listp (car list)) 
            (+ (my-lengthR (car list)) (my-lengthR (cdr list))) ; wenn erstes Element eine Liste ist,
            ; addiere das Ergebnis der inneren Liste mit dem Rest
        ) 
        (T
            (+ 1 (my-lengthR (cdr list))) ; bei Atom addiere 1 und rekursiv mit dem Rest der Liste
        )
    )
)
(print (my-lengthR '(eins zwei (zwei (zwei drei) eins) drei vier)))

; (e) Listen umkehren: Schreiben eine Funktion my-reverse zum Umkehren 
; einer Liste.
(defun my-reverse (list)
    (cond ((null list) '())
        (T 
            (append
                (my-reverse (cdr list))
                (list (car list))
            )
        )
    )
)
(print (my-reverse '(eins zwei (zwei (zwei drei) eins) drei vier)))

; (f) Geschachtelte Listen umkehren: Schreiben eine Funktion my-reverseR 
; zum Umkehren einer Liste.
(defun my-reverseR (list)
    (cond ((null list) '()) ; ist list die leere Liste?
        ((listp (car list)) ; wenn das aktuelle Element eine Liste ist
            (append 
                (my-reverseR (cdr list)) 
                (list (my-reverseR (car list)))
            )
        )
        (T ; sonst wie oben
            (append 
                (my-reverseR (cdr list)) 
                (list (car list))
            )
        )
    )
)
(print (my-reverseR '(eins zwei (zwei (zwei drei) eins) drei vier)))

; Aufgabe 2
;----------

; (a) Darstellung eines Binärbaums: Überlegen Sie, wie Sie mittels einer Liste 
; einen Binärbaum darstellen können.

; Ein Binärbaum besteht aus einer Menge von Knoten.
; Jeder Knoten eines Binärbaums besitzt einen Wert und jeweils zwei Nachfolger.
; Es gibt einen rechten und linken Nachfolger. Der linke Nachfolger ist immer kleiner, der rechte größer.

; -> ein Binärbaum kann durch geschachtelte Listen dargestellt werden. Jedes Element des Binärbaums besteht aus einer Liste
; mit 3 Elementen. Dem Wert und der Liste des rechten sowie des linken Nachfolgers.

; Beispiel: (3 5 8 4 2)
; Baum:      3
;           / \
;          2   5
;             / \
;            4   8

; [ohne Behebung unausgewogener Bäume]

; Definitionen
; ------------

; Baumstruktur = Liste aus drei Elementen
(defun create-tree-structure (root left right)
    (list root left right)
)

; Wurzel = erstes Element der Liste
(defun root (tree)
    (car tree)
)

; linker Nachfolger = zweites Element der Liste
(defun left-follower (tree)
    (cadr tree)
)

; rechter Nachfolger = drittes Element der Liste
(defun right-follower (tree)
    (caddr tree)
)

; Operationen
; -----------

; erstelle Baum aus Liste
(defun create-tree (list)
    (if (not (boundp 'tree))
        (setf tree nil)
    )
    (dolist (node list)
        (setf tree (tree-insert node tree)) ; füge aktuelles Element in Baum ein
    )
)

; dolist (var list-form [result-form]) declaration* {tag | statement}*
; (dolist 
;   (x '(a b c d)) (print x)
; )
; Für jedes Element "x" der Liste, wird print ausgeführt. - Ergebnis:
; A
; B
; C
; D

; füge Knoten in Baum ein
(defun tree-insert (node tree)
    (cond 
        ((null tree) (create-tree-structure node nil nil)) ; wenn der Baum null ist, erzeuge neuen Baum
        ((= node (root tree)) tree) ; gebe ursprünglichen Baum aus, wenn Element bereits vorhanden
        ((< node (root tree)) (create-tree-structure (root tree) (tree-insert node (left-follower tree)) (right-follower tree)))
        ((> node (root tree)) (create-tree-structure (root tree) (left-follower tree) (tree-insert node (right-follower tree))))
    )
)
(print "Binärbaum (3 5 8 4 2):")
(print (create-tree '(3 5 8 4 2)))

; (b) Baumtraversierung: Schreiben Sie 3 Funktionen zum Traversieren eines 
; Binärbaums, bei der auch die Knoteninhalte ausgegeben werden.

;inorder
(defun my-inorder (tree)
    ()
)

;postorder
(defun my-inorder (tree)
    ()
)

;preorder
(defun my-inorder (tree)
    ()
)