;Dimitry Nagorny, 1410351, repo-50
;Philipp Minges, 1426312, repo-52

; Aufgabe 1
;----------

; (a) Elemente tauschen: Schreiben Sie eine Funktion rotiere, die eine Liste 
; als Argument erhäalt und eine neue Liste zuruckliefert, in der das 
; vormals erste Element nun das letzte ist.
(defun rotiere (arg1)
    (append(rest arg1) (list (first arg1)))
)
(print "Rotiere Liste (eins zwei drei vier):")
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
(print "Neues Vorletztes 'dreieinhalb zur Liste (eins zwei drei vier):")
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
(print "Length der Liste (eins zwei drei vier):")
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
(print "Verschachtelte Length der Liste (eins zwei (zwei (zwei drei) eins) drei vier):")
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
(print "Umdrehen der Liste (eins zwei (zwei (zwei drei) eins) drei vier):")
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
(print "Verschachteltes Umdrehen der Liste (eins zwei (zwei (zwei drei) eins) drei vier):")
(print (my-reverseR '(eins zwei (zwei (zwei drei) eins) drei vier)))

; Aufgabe 2
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
        (setf tree (tree-insertNode node tree)) ; füge aktuelles Element in Baum ein
    )
)

; füge Knoten in Baum ein
(defun tree-insertNode (node tree)
    (cond 
        ((null tree) (create-tree-structure node nil nil)) ; wenn der Baum null ist, erzeuge neuen Baum
        ((= node (root tree)) tree) ; gebe ursprünglichen Baum aus, wenn Element bereits vorhanden
        ((< node (root tree)) (create-tree-structure (root tree) (tree-insertNode node (left-follower tree)) (right-follower tree)))
        ((> node (root tree)) (create-tree-structure (root tree) (left-follower tree) (tree-insertNode node (right-follower tree))))
    )
)

(create-tree '(3 5 8 4 2))
(print "Binärbaum (3 5 8 4 2):")
(print tree)

(print "Insert 1 in Binärbaum (3 5 8 4 2):")
(setf tree (tree-insertNode 1 tree))
(print tree)

; (b) Baumtraversierung: Schreiben Sie 3 Funktionen zum Traversieren eines 
; Binärbaums, bei der auch die Knoteninhalte ausgegeben werden.

; inorder
(defun inorder (tree)
    (cond ((null tree))
        (T 
            (inorder (left-follower tree))
            (print (root tree))
            (inorder (right-follower tree))
        )
    )
)
(print "Inorder vom Binärbaum (3 5 8 4 2):")
(inorder tree)

; postorder
(defun postorder (tree)
    (cond ((null tree))
        (T 
            (postorder (left-follower tree))
            (postorder (right-follower tree))
            (print (root tree))
        )
    )
)
(print "Postorder vom Binärbaum (3 5 8 4 2):")
(postorder tree)

; preoder
(defun preorder (tree)
    (cond ((null tree))
        (T 
            (print (root tree))
            (preorder (left-follower tree))
            (preorder (right-follower tree))
        )
    )
)
(print "Preorder vom Binärbaum (3 5 8 4 2):")
(preorder tree)

;füge Werte aus Liste in baum ein
(defun tree-insertListValues (li tri)
	(if li
		(let ((newTree (tree-insertNode (first li) tri)))
			(tree-insertListValues (rest li) newTree)
		)
		tri
	)
)

;Werte aus Datei in Liste umwandeln
(defun getListFromFile (filePath)
	(with-open-file (in filePath)
		(loop for val = (read in nil)
			while val
				collect val
		)
	)
)

; füge Werte aus Datei in Baum ein
(defun tree-insertFileValues (filePath tri)
    (let ((listValues (getListFromFile filePath)))
		(tree-insertListValues listValues tri)
	)
)
(setf tree (tree-insertFileValues "./nodes.txt" tree))
(print "Insert von 10 20 30 aus der Datei nodes.txt zum Tree:")
(print tree)

;Check ob ein Element im Baum vorhanden ist
(defun tree-containsValue (node tree)
	(if tree
		(cond 
			((= node (root tree)) T)
			((< node (root tree)) (tree-containsValue node (left-follower tree)))
			((> node (root tree)) (tree-containsValue node (right-follower tree)))
		)
		nil
	)
)
(print "Ist 7 im Baum?")
(print (if (tree-containsValue 7 tree) "Ja." "Nein."))
(print "Ist 2 im Baum?")
(print (if (tree-containsValue 2 tree) "Ja." "Nein."))

;Ermittelt Anzahl aller Nodes im Baum
(defun tree-size (tree)
    (cond ((null tree) 0) ; länge 0 bei leerem Baum
        ((listp (root tree)) 
            (+ (tree-size (root tree)) (tree-size (left-follower tree)) (tree-size (right-follower tree))) 
        ) 
        (T
            (+ 1 (tree-size (left-follower tree)) (tree-size (right-follower tree)))
        )
    )
)
(print "Anzahl aller Knoten im Baum:")
(print (tree-size tree))

;Ermittelt grössten Wert im Baum
(defun tree-maxValue (tree)
    (if (right-follower tree)
		(tree-maxValue (right-follower tree))
		(root tree)
	)
)
(print "Biggest Wert im Baum:")
(print (tree-maxValue tree))

;Ermittelt kleinsten Wert im Baum
(defun tree-minValue (tree)
    (if (left-follower tree)
		(tree-minValue (left-follower tree))
		(root tree)
	)
)
(print "Kleinster Wert im Baum:")
(print (tree-minValue tree))

;Checkt ob der Baum keine Knoten hat
(defun tree-isEmpty (tree)
    (if (root tree)
		nil
		T
	)
)
(print "Ist aktueller Baum leer?")
(print (if (tree-isEmpty tree) "Ja." "Nein."))
(print "Ist Baum (NIL NIL NIL) leer?")
(print (if (tree-isEmpty '(NIL NIL NIL)) "Ja." "Nein."))

;Ermittelt Höhe des Baums
(defun tree-height (tree)
	(if (tree-isEmpty tree)
		0
		(let ((leftHeight (+ 1 (tree-height (left-follower tree)))))
			(let ((rightHeight (+ 1 (tree-height (right-follower tree)))))
				(if (> leftHeight rightHeight)
					leftHeight
					rightHeight
				)
			)
		)
	)
)
(print "Height des aktuellen Baumes:")
(print (tree-height tree))
(print "Height des Baumes (4 (3 NIL NIL) (5 NIL NIL)):")
(print (tree-height '(4 (3 NIL NIL) (5 NIL NIL))))
(print "Height des Baumes (4 (3 (2 NIL NIL) NIL) (5 NIL NIL)):")
(print (tree-height '(4 (3 (2 NIL NIL) NIL) (5 NIL NIL))))

;Entfernt Wert ausm Baum, falls vorhanden
(defun tree-remove (val tree)
	(if (tree-containsValue val tree)
		"removed value" ;TODO
		"Tree has no such value"
	)
)
(print "Entferne 7 ausm Baum:")
(print (tree-remove 7 tree))
(print "Entferne 2 ausm Baum:")
(print (tree-remove 2 tree))

;Fügt aktuellem tri einen gegebenen Baum otherTree hinzu
(defun tree-addAll (otherTree tri)
	(if (not (tree-isEmpty otherTree))
		(let ((newTree (tree-insertNode (root otherTree) tri)))
			(let ((newTree2 (tree-addAll (left-follower otherTree) newTree)))
				(tree-addAll (right-follower otherTree) newTree2)
			)
		)
		tri
	)
)
(print "Adde dem aktuellem Baum den Baum (3 (0 NIL NIL) (11 NIL NIL)) hinzu:")
(setf tree (tree-addAll '(3 (0 NIL NIL) (11 NIL NIL)) tree))
(print tree)

;levelorder
(defun levelorder (tree)
	;TODO Scheiß Arbeit...
)
(print "Levelorder vom aktuellen Baum:")
(levelorder tree)
    
(setf tree '())