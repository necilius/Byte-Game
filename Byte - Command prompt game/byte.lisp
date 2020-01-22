
;-----------------------------------------------------------------------------------------------------------------------------------------;
;-----------------------------------------------------------------------------------------------------------------------------------------;
;                                                     POMORAVSKA DIVIZIJA - BYTE                                                          ;
;-----------------------------------------------------------------------------------------------------------------------------------------;
;-----------------------------------------------------------------------------------------------------------------------------------------;


;SPISAK NAJBITNIH FUNKCIJA:

;   (inicijalno-stanje (n)) - vraca inicijalno stanje za prosledjenu velicinu table  
;   (odigraj-potez (stanje potez)) - Menja se stanje tako sto se odigra potez, potez u formatu ((i j) (k l) 'visina)   
;   (prikaz-stanja (stanje)) - Prikazuje trenutni skor i tablu u stanju
;   (unos-poteza (stanje igrac) - Unosi se potez za igraca 'x ili 'o sve dok format ne bude odgovarajuci. Kada je format odgovarajuci vraca se formatiran potez koji se koristi u funkciji za odigravanje poteza
;   (testiraj-ciljno-stanje (stanje)) - Ako je iks pobednik vraca 1, ako je oks pobednik vraca -1, ako jos nema pobednika vraca 0
;   (cekiraj-stanje (stanje) - Proverava da li u tabli postoji pun stek na nekom polju i ako postoji, izbacuje stek sa table i uvecava skor igracu koji je osvojio stek
;   (svi-potezi (stanje igrac)) - Vraca listu svih mogucih poteza koje igrac moze odigrati u trenutnom stanju
;   (sva-stanja (stanje igrac)) - Na osnovu liste svih mogucih poteza za odredjenog igraca u odredjenom stanju, vraca listu svih mogucih narednih stanja
;   (racunar-potez (stanje igrac)) - Iz liste svih mogucih poteza koje moze da odigra, racunar bira jedan potez nasumicno (RANDOM)
;   (alpha-beta (stanje dubina alfa beta min-max igrac her-igrac)) - Funkcija vraca novo stanje u koje se prelazi kada racunar odigra potez koristeci alpha-beta pruning algoritam                                                





;                                                INICIJALIZACIJA STANJA
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------

;   Stanje je lista koja sadrzi sledece elemente  (tabla stek-x stek-o min-stek)
;   1.Tabla je lista koja sadrzi vrste, svaka vrsta je posebna lista koja sadrzi n-elemenata, svaki element je lista
;           ( ((x)()(x)()) (()(o)()(o)) ((x)()(x)()) (()(o)()(o)) )
;           Svaki element je lista koja sadrzi stek (x o x x)
;   2.stek-x i stek-o su stekovi koji cuvaju broj osvojenih stekova za igrace X i O respektivno
;   3.min-stek je minimalan broj stekova koje je potrebno da igrac osvoji kako bi pobedio - zavisi od velicine table 


;Glavne f-je:
;               (inicijalno-stanje (n)) - vraca inicijalno stanje za prosledjenu velicinu table





(defun prazna (n)
      (cond 
        ((= n 0) '())
        (t (cons '() (prazna (1- n)) ))
      )
)
(defun redoviX(brojXeva)
      (cond 
            ((= brojXeva 0) '())
            (t (append  (list '()) (list (list 'x)) (redoviX(1- brojXeva)) )  )
      )
)
(defun redoviO(brojOxeva)
      (cond 
            ((= brojOxeva 0) '())
            (t (append  (list (list 'o))  (list '()) (redoviO(1- brojOxeva)) )  )
      )

)


(defun popuna(n br fleg)
      (cond 
            ((= n 0) NIL )
            ((= fleg 0) (append (list(redoviX br)) (popuna (1- n) br 1) ) )
            ((= fleg 1) (append (list(redoviO br)) (popuna (1- n) br 0) ))
      
      )

)
(defun cela(n n2 n12)
      
      (append (list(prazna n)) (popuna n2 n12  0 ) (list(prazna n)))

)
(defun vratiInicijalnaPolja (n)
      (let*
          (
            (n12 (/ n '2.0))
            (n2 (- n '2))
          )
          (cela n n2 n12)
      
      )
)

(defun broj-figura (n)
        ( * (- n 2)(/ n 2)))

(defun broj-stekova (n)
       (floor (broj-figura n)8))

(defun maxStek(n)
      (+ (/ (- (broj-stekova n) 1) 2) 1)
)

(defun maxStek2(n)
    (1+ (floor (floor (broj-figura n) 8) 2))
 )

(defun inicijalno-stanje (n)
    (list (vratiInicijalnaPolja n) '0 '0 (maxStek2 n))
)





;                                                PRIKAZ STANJA
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------

;Glavne f-je:
;               (prikaz-table (tabla n) - Prikazuje izgled table nekog stanja u kojoj je igra trenutno
;                                         n - je velicina table  
;               (prikaz-stanja (stanje)) - Prikazuje trenutni skor i tablu u stanju




(defun zaglavlje-string (n)
    (append (zg-string '() n) '("~%"))
)

(defun zg-string (lista n)
    (cond
        ( (= n 0) '() )
        ((> n 9) (append (zg-string lista (1- n)) (list "    " (write-to-string n) "")))
        (t 
            (append (zg-string lista (1- n)) (list "    " (write-to-string n) " "))
        )
    )
)


(defun zaglavlje-obrada (lista)
    (cond
        ((null lista) '())
        (t
            (format t (car lista))
            (zaglavlje-obrada (cdr lista))
        )
    ) 
)

(defun zaglavlje-prikaz (n)
    (zaglavlje-obrada (zaglavlje-string n))
)

(defun prikaz-vrste (vrsta brvrste el) ; Za el se uvek prosledjue 3
    (cond
        ((= el -1) '())
        (t
            (progn
                (prikaz-red vrsta el brvrste)
                (format t "~%")
                (prikaz-vrste vrsta brvrste (1- el))
            )
        )
    ) 
)

(defun prikaz-red (vrsta el brvrste)
   (cond
        ;;Pocetak reda
        ((= el 2) (format t (string (code-char (+ 65 brvrste)))) (format t "  ") (prikaz-polja vrsta el (mod brvrste 2) 0))
        ;;Ostatak reda sa poljima
        (t (format t "   ") (prikaz-polja vrsta el (mod brvrste 2) 0))
   )
)

(defun prikaz-polja (vrsta el parno kolona)
    (cond 
        ((null vrsta) '())
        (t 
            (let*
                (
                    ( e1 (nth el (car vrsta)))
                    ( e2 (nth (+ 4 el) (car vrsta)))
                )
                (progn
                    (cond
                        ((and (= parno 0) (= (mod kolona 2) 0))
                            (progn
                                (cond
                                    ((null e1) (format t "- "))
                                    ((equal e1 'o) (format t "o "))
                                    ((equal e1 'x) (format t "x ")) 
                                )
                                (cond
                                    ((null e2) (format t "-   "))
                                    ((equal e2 'o) (format t "o   "))
                                    ((equal e2 'x) (format t "x   ")) 
                                )
                                (prikaz-polja (cdr vrsta) el parno (1+ kolona))
                            )
                        )
                        ( (= parno 0) (format t "      ") (prikaz-polja (cdr vrsta) el parno (1+ kolona)))
                    )
                    (cond
                        ((and (= parno 1) (= (mod kolona 2) 1))
                            (progn
                                (cond
                                    ((null e1) (format t "- "))
                                    ((equal e1 'o) (format t "o "))
                                    ((equal e1 'x) (format t "x ")) 
                                )
                                (cond
                                    ((null e2) (format t "-   "))
                                    ((equal e2 'o) (format t "o   "))
                                    ((equal e2 'x) (format t "x   ")) 
                                )
                                (prikaz-polja (cdr vrsta) el parno (1+ kolona))
                            )
                        )
                        ( (= parno 1) (format t "      ") (prikaz-polja (cdr vrsta) el parno (1+ kolona)))
                    )
                )
            )    
        )
    )
)

(defun prikaz-svih-vrsta (tabla n)
    (let*
        (
            (brvrste (- n (length tabla)))
        )
        (cond
            ((null tabla) '())
            (t
                (progn
                    (prikaz-vrste (car tabla) brvrste 3)
                    ;(format t "~%")
                    (prikaz-svih-vrsta (cdr tabla) n)
                )
            )
        )
    )
)

(defun prikaz-table (tabla n)
    (progn
        (zaglavlje-prikaz n)
        (prikaz-svih-vrsta tabla n)
    )
)

(defun prikaz-stanja (stanje)
    (let*
        (
            (stekX (cadr stanje))
            (stekO (caddr stanje))
            (minstek (cadddr stanje))
            (velicina (length (car stanje)))
        )
        (progn
            (format t "~%Minimalan broj stekova za pobedu: ")
            (format t (write-to-string minstek))
            (format t "~%Igrax X do sad osvojio: ")
            (format t (write-to-string stekX))
            (format t "~%Igrac O do sad osvojio: ")
            (format t (write-to-string stekO))
            (format t "~%~%")
            (prikaz-table (car stanje) velicina)
            (format t "~%")
        )
    )
)





;                                                ODIGRAVANJE POTEZA
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------

;Glavne f-je:
;           (stavi-na (i j k l visina tablaa)) - Na osnovu odigravanja poteza pri pomeranju steka sa jednog polja na drugo
;                                                formira 2 nova polja table ((polje1) (polje2))
;           (zameni-polje (tabla i j elem))    - Menja element i,j element na tabli koji se prosledjue preko elem parametra
;           (odigraj-potez (stanje potez)) - Menja se stanje tako sto se odigra potez, potez u formatu ((i j) (k l) 'visina)





(defun vrati-polje (lista i j)
    (nth j (nth i lista)))

(defun vrati-polje-stanje (stanje i j)
    (nth j (nth i (car stanje)))
)

(defun stavi-na (i j k l visina tablaa)
    (let* 
        (   
            ;;(tabla (car stanje))
            (stek1 (vrati-polje tablaa i j))
            (stek2 (vrati-polje tablaa k l))
            (stek1novi (car (podeli stek1 visina)))
            (stek2novi (append stek2 (cadr (podeli stek1 visina))))
        )
        (list stek1novi stek2novi)
        
    )
)

(defun podeli (lista pos)
  (list (podeli-levo lista pos) (podeli-desno lista pos))
)

(defun podeli-levo (lista pos)
    (cond
     ((<= pos 0) ())
     ((null lista) lista)
     (t (cons (car lista) (podeli-levo (cdr lista) (1- pos))))
     )
)

(defun podeli-desno (lista pos)
    (cond
     ((<= pos 0) lista)
     ((null lista) ())
     (t (podeli-desno (cdr lista) (1- pos)))
     )
)



(defun zameni-element (lista n elem)
  (cond
    ((null lista) ())
        ((= n 0) (cons elem (cdr lista)))
        (t (cons (car lista) (zameni-element (cdr lista) (- n 1) elem)))))

(defun zameni-polje (tabla i j elem)
    (cond
        ((null tabla) ())
        ((= i 0) (cons (zameni-element (car tabla) j elem) (cdr tabla)))
        (t (cons (car tabla) (zameni-polje (cdr tabla) (- i 1) j elem)))))

(defun zameni-polje-stanje (stanje i j elem)
    (cons (zameni-polje (car stanje) i j elem) (cdr stanje))
)


;Potez u formatu ((i j) (k l) 'visina)
(defun odigraj-potez (stanje potez)
    (cond
        ((null potez) stanje)
        (t 
            (let*
                (
                    (i (caar potez))
                    (j (cadar potez))
                    (k (caadr potez))
                    (l (cadadr potez))
                    (visina (caddr potez))
                    (novapolja (stavi-na i j k l visina (car stanje)))
                    (tabla1 (zameni-polje (car stanje) i j (car novapolja)))
                    (tabla2 (zameni-polje tabla1 k l (cadr novapolja)))
                )
                (cons tabla2 (cdr stanje))
            )
        )
    )
)


;                                                       UNOS SA TASTATURE
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------

;Glavne f-je:
;           (formatiraj-potez (potez)) - Kada korisnik unese potez tipa ((A 3) (B 4) 9) formatira taj unos u obliku koji je pogodan
                                         ;za funkciju (odigraj potez) gde se A 3 B 4 - pretvaraju u indekse 0 2 i 1 3
                                         ;to su indeksi za pristup tabli i stanju
;           (deformatiraj-potez (potez)) - Radi suprotno od (formatiraj-potez (potez))
;           (validacija-formata-unosa (potez stanje)) - Proverava da li je korisnik uneo potez u validnom formatu
                                                        ;FORMAT UNOSA: ((a 3) (c 4) 5)  ili ((a 3) (c 3)) ako je visina steka 0
                                                        ;a moze i ((a 3) (c 4) 0)
                                                        ;Postoje i ogranicenja da se mogu unositi samo slova koja ogranicava velicina table
                                                        ;kao i ogranicenja o visini steka koji se pomera sa jednog polja na drugo i koji
                                                        ;moze biti od 0 do 7
                                                        ;Vraca potez prosledjeni potez ako je sve regularno ili '() ako je korisnik pogresio unos
;            (unos-poteza (stanje igrac) - Unosi se potez za igraca 'x ili 'o sve dok format ne bude odgovarajuci. Kada je format odgovarajuci
                                        ;vraca se formatiran potez koji se koristi u funkciji za odigravanje poteza



(defun formatiraj-potez (potez)
    (list 
        (list (- (char-code (char (string (caar potez)) 0)) 65)  (1- (cadar potez))) 
        (list (- (char-code (char (string (caadr potez)) 0)) 65)  (1- (cadadr potez)))
        (cond
            ((null (caddr potez)) 0) 
            (t (caddr potez))
        )
    )
)

(defun deformatiraj-potez (potez)
    (list 
        (list (intern (string (code-char (+ (nth 0 (nth 0 potez)) 65)))) (1+ (nth 1 (nth 0 potez))) ) 
        (list (intern (string (code-char (+ (nth 0 (nth 1 potez)) 65)))) (1+ (nth 1 (nth 1 potez))) ) 
        (nth 2 potez)
    )
)


;FORMAT UNOSA       ((a 3) (c 4) 5)  ili ((a 3) (c 3)) 
(defun validacija-formata-unosa (potez stanje)
    (let*
        (
            (granica (1- (length (car stanje))))
        )
        (cond
        ((not (listp potez)) '())
        ((and (> (length potez) 3)(< (length potez) 2)) '())
        ((not (listp (car potez))) '())
        ((not (listp (cadr potez))) '())
        ((/=  (length (car potez)) 2) '())
        ((/=  (length (cadr potez)) 2) '())
        ((not (atom (caar potez))) '())
        ((not (atom (caadr potez))) '())
        ((numberp (caar potez)) '())
        ((numberp (caadr potez)) '())
        ((not (numberp (cadar potez))) '())
        ((not (numberp (cadadr potez))) '())
        ((or (> (- (char-code (char (string (caar potez)) 0)) 65) granica) (< (- (char-code (char (string (caar potez)) 0)) 65) 0)) '())
        ((or (> (- (char-code (char (string (caadr potez)) 0)) 65) granica) (< (- (char-code (char (string (caadr potez)) 0)) 65) 0)) '())
        ((or (> (cadar potez) (1+ granica)) (< (cadar potez) 1)) '())
        ((or (> (cadadr potez) (1+ granica)) (< (cadadr potez) 1)) '())
        ((and (= (length potez) 3)(not (numberp (caddr potez))))    '())
        ((and (= (length potez) 3) (or (> (caddr potez) 7) (< (caddr potez) 0)))    '())
        (t potez)
        )
    )
)

(defun unos-ptz (stanje)
    (let*
        (
            (potez (read))
            (provera (validacija-formata-unosa potez stanje))
        )
        (cond
            (
                (null provera)
                (format t "Neispravan format unosa! ((a 3) (b 4) 0) ili ((a 3) (b 4)).~%Unesi opet: ")
                (unos-ptz stanje)
            )
            (t (formatiraj-potez potez))
        )
    )
)

(defun unos-poteza (stanje igrac)
    (cond
        ((equal igrac 'x)
            (progn
                (format t "Potez X: ")
                (unos-ptz stanje)
            )  
        )
        ((equal igrac 'o)
            (progn
                (format t "Potez O: ")
                (unos-ptz stanje)
            )  
        )
    )
)


(defun validirani-unos-poteza(stanje igrac)
    (let*
        (
            (sviMoguciPotezi (svi-potezi stanje igrac))
        )
        (cond
            ((null sviMoguciPotezi) '())
            (t
                (let*
                    (
                        (potez (unos-poteza stanje igrac))
                    )
                    (cond
                        ((clanp potez sviMoguciPotezi) potez)
                        (t 
                            (format t "NEVALIDAN POTEZ~%")
                            (validirani-unos-poteza stanje igrac)
                        )
                    )
                )
            )
        )
    )
)




;                                                PROVERA STANJA
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------

;Glavne f-je:
;           (testiraj-ciljno-stanje (stanje)) - Ako je iks pobednik vraca 1, ako je oks pobednik vraca -1, ako jos nema pobednika vraca 0
;           (povecaj-rezultat (stanje igrac)) - Za igraca posalji 'x da bi uvecao x-igracu skor, 'o za oks-igraca
;           (cekiraj-stanje (stanje) - Proverava da li u tabli postoji pun stek na nekom polju i ako postoji, izbacuje stek sa table i uvecava skor igracu koji je osvojio stek
;
;
                                                



;; Ako je iks pobednik vraca 1, ako je oks pobednik vraca -1, ako jos nema pobednika vraca 0
(defun testiraj-ciljno-stanje (stanje)
    (cond
        ((= (nth 1 stanje)(nth 3 stanje)) 1)
        ((= (nth 2 stanje) (nth 3 stanje)) -1)
        (t 0)
    )
)

;Za igraca posalji 'x da bi uvecao x-igracu skor, 'o za oks-igraca
(defun povecaj-rezultat (stanje igrac)
    (cond
        ((equalp igrac 'x) (cons (car stanje)(cons (1+ (nth 1 stanje)) (cddr stanje))))
        ((equalp igrac 'o) (cons (car stanje)(cons (cadr stanje)(cons (1+ (nth 2 stanje)) (cdddr stanje)))))
        (t stanje)
    )
)

;Ako nadje pun stek u tabli vraca poziciju i j tog elementa i vraca vrh steka 'x ili 'o u formatu (i j x) ili (i j o)
(defun nadji-stek (tabla i j n)
   (cond
        ((null tabla) '())
        ((null (car tabla)) (nadji-stek (cdr tabla) i j n))
        ((< (length (caar tabla)) 8)(nadji-stek (append (list (cdar tabla)) (cdr tabla)) (mod (+ i (floor j (1- n))) n) (mod (1+ j) n)  n))
        (t (list i j (nth 7 (caar tabla)))) 

   )
)

;Proverava da li u tabli postoji pun stek na nekom polju i ako postoji, izbacuje stek sa table i uvecava skor igracu koji je osvojio stek
(defun cekiraj-stanje (stanje)
    (let*
        (
            (rez (nadji-stek (car stanje) 0 0 (length (car stanje))))
        )
        (cond
            ((null rez) stanje)
            (t (zameni-polje-stanje (povecaj-rezultat stanje (nth 2 rez)) (nth 0 rez) (nth 1 rez) '())
            )
        )
        
    )
)


;                                                       VALIDACIJA POTEZA
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------

(defun svi-potezi (stanje igrac)
    (lista-svih-poteza stanje 0 0 igrac)
)


(defun lista-svih-poteza (stanje i j igrac)
    (cond
        ((and (= i (length (car stanje))) (= j 0)) '())
        (t
            (append (lista-svih-poteza-za-polje stanje i j igrac) (lista-svih-poteza stanje (+ i (floor j (1- (length (car stanje))))) (mod (1+ j) (length (car stanje))) igrac))
        )
    )
)


(defun lista-svih-poteza-za-polje (stanje i j igrac)
     (cond
        (
          ;;;AKO JE i,j POLJE PRAZNO VRACA SE PRAZNA LISTA POTEZA
            (null (vrati-polje (car stanje) i j)) 
                '()
        )
        (
            ;;;AKO POLJE IMA SUSEDE POSTOJE 2 VARJANTE: 1. NA i,j STOJI SAMO JEDNA FIGURA  2. NA i,j STOJI STEK VISINE VECE OD 1
            (polje-ima-susede stanje i j)
                (let*
                    (
                        (stek (vrati-polje (car stanje) i j))
                    )
                    (cond
                        ;;PRVA VARJANTA DAJE DVA SLEDECA SLUCAJEVA: 1. FIGURA NA i,j SE NEPOKLAPA SA IGRACEM, VRACA SE PRAZNA LISTA 2. FIGURA SE POKLAPA, VRACAJU SE POTEZI OBLIKA ((i j) (k l) 0) PRI CEMU SU k i l neki od susednih polja na kojima postoje stekovi
                        ( (and (= (length stek) 1) (not (equalp (nth 0 stek) igrac)))   '()   )
                        ( 
                            (and (= (length stek) 1) (equalp (nth 0 stek) igrac))
                            (kreiraj-listu-poteza-za-stek-1 stanje i j) 
                        )

                        ;;DRUGA VARJANTA STEK VECI OD DUZINE JEDAN
                        ((and (> (length stek ) 1) (not (clanp igrac stek))) '())
                        ((and (> (length stek ) 1) )  (kreiraj-listu-poteza-za-stek-h stanje i j igrac) )
                    )

                )
           
        )
        ;3. SLUCAJ. POLJE NEMA SUSEDE, MOZE SAMO DA SE POMERA CEO STEK U PRAVCU NAJBLIZE FIGURE
        (t
            (cond
                ;STEK NE POCINJE FIGUROM KOJOM IGRAC IGRA, TAKO DA NE MOZE DA SE POMERA
                (  (not (equal igrac (nth 0 (vrati-polje (car stanje) i j)))) '())
                (t (vrati-poteze-za-moguce-puteve (vrati-moguce-puteve stanje i j) i j))
            )
        )

    )
)

;VRACA LISTU POTEZA ZA VISINU STEKA 1 I ZA SUSEDNA POLJA KOJA IMAJU FIGURU
(defun kreiraj-listu-poteza-za-stek-1 (stanje i j)
    (stek-1-potezi (vrati-not-null-susede stanje i j) i j)
)

(defun stek-1-potezi (susedi i j)
    (cond
        ((null susedi) '())
        (t 
            (cons (list (list i j) (caar susedi) '0) (stek-1-potezi (cdr susedi) i j)))
        ) 
)

(defun vrati-not-null-susede (stanje i j)
    (not-null-susedi (vrati-listu-suseda stanje i j))
)

(defun not-null-susedi (susedi)
    (cond
        ((null susedi) '())
        ((null (cadar susedi)) (not-null-susedi (cdr susedi)))
        (t (cons (car susedi) (not-null-susedi(cdr susedi))))
    )
)

(defun polje-ima-susede (stanje i j)
    (ima-susede (vrati-listu-suseda stanje i j))
)

(defun ima-susede (susedi)
    (cond
        ((null susedi) '())
        ((null (cadar susedi)) (ima-susede (cdr susedi)))
        (t t)
    )
)

(defun vrati-listu-suseda (stanje i j)
    (vrati-susedna-polja (susedni-indeksi i j (length (car stanje))) (car stanje))
)

(defun vrati-susedna-polja (lindexa tabla)
   (cond
       ((null lindexa) '())
       (t (cons (list (car lindexa) (vrati-polje tabla (caar lindexa) (cadar lindexa))) (vrati-susedna-polja (cdr lindexa) tabla)))
   )
) 

(defun susedni-indeksi (i j n)
    (izbaci-nevalidne-indekse (append (list (list (1- i) (1- j)) (list (1- i) (1+ j))) (list (list (1+ i) (1- j)) (list (1+ i) (1+ j)))) n)
)

(defun izbaci-nevalidne-indekse (lista n)
    (cond
        ((null lista) '())
        ( (or (< (caar lista) 0) (> (caar lista) (1- n))) (izbaci-nevalidne-indekse (cdr lista) n))
        ( (or (< (cadar lista) 0) (> (cadar lista) (1- n))) (izbaci-nevalidne-indekse (cdr lista) n))
        (t (cons (car lista) (izbaci-nevalidne-indekse (cdr lista) n)))
    )
)





(defun stek-kombinacije (m n k l stek1 stek2 i igrac)
    (let*
        (
            (novistek (append  stek2 (cadr (podeli stek1 i))))     
        )

        (cond
            ((> i (1- (length stek1))) '())
            ((not (equalp (nth i stek1) igrac)) (stek-kombinacije m n k l stek1 stek2 (1+ i) igrac))
            ( (> (length novistek) 8) (stek-kombinacije m n k l stek1 stek2 (1+ i) igrac))
            ( (< (length novistek) (length stek1)) (stek-kombinacije m n k l stek1 stek2 (1+ i) igrac))
            ( (> (length novistek) (length stek1)) (cons (list (list m n) (list k l) i) (stek-kombinacije m n k l stek1 stek2 (1+ i) igrac)))
            ( (= (length novistek) (length stek1)) '())

        )
    )
)

(defun stek-h-potezi (stanje susedi i j igrac)
    (cond
        ((null susedi) '())
        (t 
            (append (stek-kombinacije i j (nth 0 (caar susedi)) (nth 1 (caar susedi)) (vrati-polje-stanje stanje i j) (cadar susedi) '0 igrac) 
                (stek-h-potezi stanje (cdr susedi) i j igrac)
            )
        ) 
    )
)



(defun kreiraj-listu-poteza-za-stek-h (stanje i j igrac)
    (stek-h-potezi stanje (vrati-listu-suseda stanje i j) i j igrac)
)





;                               ODREDJIVANJE NAJKRACEG PUTA
;                               ZA POLJE KOJE NEMA SUSEDE - KORISTI SE U DOBIJANJU LISTE SVIH POTEZA - IZNAD - KAO 3. SLUCAJ
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------
;Glavne f-je:
;   vrati-moguce-puteve (stanje i j) - Vraca indekse svih susednih polja cija je udaljenost medjusobno jednaka
;                                      u odnosu na najblizu figuru na tabli. Koristi se kod validacije poteza
;
;   najblizi-cvor (stanje zaObradu obradjeni putevi) - Algoritam je napravljen kao trazenje po sirini
;   
;
;

(defun clanp (cvor cvorovi)
    (cond 
        ((null cvorovi) '())
        ((equal cvor (car cvorovi)) t)
        (t (clanp cvor (cdr cvorovi)))
    )
)

(defun vrati-poteze-za-moguce-puteve (putevi i j)
    (cond
        ((null putevi) '())
        (t (cons (list (list i j) (car putevi) '0) (vrati-poteze-za-moguce-puteve (cdr putevi) i j)))
    )
)


(defun vrati-moguce-puteve (stanje i j)
    (let*
        (
            (incCvorovi (incijalizacija-cvorova-za-obradu stanje (susedni-indeksi i j (length (car stanje)))))
            (modifikovanoStanje (zameni-polje-stanje stanje i j '()))
            (obradjeniCvorovi (formiraj-cvor-zaObradu i j 0))
        )
        (najblizi-cvor modifikovanoStanje  incCvorovi (list obradjeniCvorovi) '())
    )
)

(defun incijalizacija-cvorova-za-obradu(stanje susedniIndeksi)
    (cond
        ((null susedniIndeksi) '())
        (t (cons (formiraj-cvor-zaObradu (nth 0 (car susedniIndeksi)) (nth 1 (car susedniIndeksi)) 1 ) (incijalizacija-cvorova-za-obradu stanje (cdr susedniIndeksi))))
    )
)

(defun najblizi-cvor (stanje zaObradu obradjeni putevi)
    (cond
        ((null zaObradu)  (cadr putevi))
        ((clanp (car zaObradu) obradjeni) (najblizi-cvor stanje (cdr zaObradu) obradjeni putevi))
        (t
            (cond
                ((polje-ima-susede stanje (nth 0 (nth 0 (car zaObradu))) (nth 1 (nth 0 (car zaObradu))))  
                        (najblizi-cvor stanje (cdr zaObradu) (cons (car zaObradu) obradjeni) (dodaj-put (car zaObradu) putevi))
                )
                (t
                    (najblizi-cvor stanje (dodaj-potomke (kreiraj-susedne-cvorove stanje (car zaObradu) obradjeni) zaObradu) (cons (car zaObradu) obradjeni) putevi)
                )
            )
        )

    )
)

(defun dodaj-put (cvor putevi)
    (cond
        ((null putevi) (cdr cvor))
        ((< (nth 1 cvor) (nth 0 putevi)) (cdr cvor))
        ((= (nth 1 cvor) (nth 0 putevi)) (cdr (modifikuj-cvor (nth 2 cvor) (cons '(-1 -1) putevi))))
        (t putevi)

    )
)

(defun dodaj-potomke (cvorovi zaObradu)
    (cond
        ((null cvorovi) zaObradu)
        (t  (dodaj-potomke (cdr cvorovi) (dodaj-potomak (car cvorovi) zaObradu)) )
    )
)

(defun dodaj-potomak (cvor zaObradu)
    (cond
        ((null zaObradu) (list cvor))
        ((and (equalp (caar zaObradu) (car cvor)) (= (nth 1 cvor) (nth 1 (car zaObradu))) ) (cons (modifikuj-cvor (nth 2 cvor) (car zaObradu)) (cdr zaObradu)))        
        (t (cons (car zaObradu) (dodaj-potomak cvor (cdr zaObradu))))

    )
)

(defun modifikuj-cvor (listaPiPj cvor)
    (cond
        ((null listaPiPj) cvor)
        ((clanp (car listaPiPj) (nth 2 cvor)) (modifikuj-cvor (cdr listaPiPj) cvor))
        (t (modifikuj-cvor (cdr listaPiPj)     (list (nth 0 cvor) (nth 1 cvor) (cons (car listaPiPj) (nth 2 cvor)))))
    )
)

;ZA CVOR KOJI NIJE FINALAN KREIRA SVE SUSEDNE CVOROVE KOJI CE SE OBRADJIVATI (idu u za-obradu) A NE NALAZE SE U OBRADJENIM CVOROVIMA 
(defun kreiraj-susedne-cvorove (stanje cvor obradjeni)
    (izbaci-obradjene-cvorove (formiraj-susedne-cvorove stanje cvor) obradjeni)             
)

;Od cvora koji nije finalan, bira njegove susede koji se ne nalaze u obradjenim cvorovima
(defun izbaci-obradjene-cvorove (listaCvorova obradjeni)
    (cond
        ((null listaCvorova) '())
        ((not (cvor-ne-postoji (car listaCvorova) obradjeni)) (izbaci-obradjene-cvorove (cdr listaCvorova) obradjeni))
        (t (cons (car listaCvorova) (izbaci-obradjene-cvorove (cdr listaCvorova) obradjeni)))
    )
)

(defun cvor-ne-postoji (cvor obradjeni)
    (cond
        ((null obradjeni) t)
        ((equalp (car cvor) (caar obradjeni)) '())
        (t (cvor-ne-postoji cvor (cdr obradjeni)))
    )
)

;Koristi se za slucaj kada cvor nije finalni cvor i onda kreira listu cvorova sledbenika
(defun formiraj-susedne-cvorove(stanje cvor)
    (formiraj-cvorove (susedni-indeksi (nth 0 (car cvor)) (nth 1 (car cvor)) (length (car stanje))) cvor) 
)

(defun formiraj-cvorove (susedniIndeksi cvor)
    (cond
        ((null susedniIndeksi) '())
        (t 
            (cons 
                (formiraj-cvor (nth 0 (car susedniIndeksi)) (nth 1 (car susedniIndeksi)) (1+ (nth 1 cvor)) (nth 2 cvor)) 
                (formiraj-cvorove (cdr susedniIndeksi) cvor)
            )
        )
    )
)

;CVOR i j pozicija cvora, h najmanja visina od izvora. Cvor je oblika ((4 4) 2 ((0 9)) - 4 4 indeksi cvora koji se obradjuje, 2 udaljenost od izvora, ((0 9)) lista susednih cvorova od prvih od izvora pod pretpostavkom da izvorni cvor nema susede jer je to treci slucaj validacije koji se obradjuje 
(defun formiraj-cvor (i j h listaPiPj)
    (append (list (list i j) h) (list listaPiPj))
)

(defun formiraj-cvor-zaObradu (i j h)
    (append (list (list i j) h)  (list (list (list i j))))
)





;                                                       KREIRANJE IGRE
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------




(defun inicijalizacija-igre ()
    (let*
        (   
            (n (unesi-velicinu-table ))
            (mod-igre (unesi-mod-igre ))
            (iksoks 
                (cond 
                    ( (equal mod-igre 1)  1)
                    (t (unesi-prvog-igraca )) 
                )
            )
            (stanje (inicijalno-stanje n))
        )
        (cond
            ((equalp iksoks 'r) (cons stanje (list 1 'x mod-igre)) )
            (t (cons stanje (list 0 'x mod-igre)))
        )
        
    )
)

(defun unesi-velicinu-table ()
    (format t "Unesi velicinu table (paran broj veci ili jednak 8): ")
    (let*
        (
            (velicina (read ))
        )
        (cond
            ((not (numberp velicina)) (unesi-velicinu-table ))
            ( (or (< velicina 8) (= (mod velicina 2) 1)) (unesi-velicinu-table ))
            (t velicina)
        )
    )
)

(defun unesi-prvog-igraca ()
    (format t "Ako prvi igra racunar, kao X igrac, unesi r, bilo sta drugo da igra kao Oks igrac: ")
    (read )
)

(defun unesi-mod-igre ()
    (format t "Unesi 1 za igru Covek protiv Coveka, bilo sta drugo za Covek protiv Racunara: ")
    (read )
)



;                                               ODIGRAVANJE POTEZA RACUNARA
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------

;Zbog simulacije, racunar bira random potez iz liste mogucih poteza
;To je ujedno i prikaz generisanja svih mogucih stanja u nekom trenutku

(defun racunar-potez (stanje igrac)
    (let*
        (
            (sviMoguciPotezi (svi-potezi stanje igrac))
        )
        (cond
            ;Trenutak kad nema poteza, pa se potez prepusta drugom igracu
            ((null sviMoguciPotezi) (format t "Racunar je propustio potez.~%") '())
            (t 
                (progn
                    (format t "Racunar je odigrao svoj potez.~%")
                    (nth (mod (random 1000) (length sviMoguciPotezi)) sviMoguciPotezi)
                ) 
            ) 
        )
    )
)


;                                               LISTA SVIH STANJA
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------

;; (defun sva-stanja (stanje igrac)
;;     (sva-stanja-pom stanje (svi-potezi stanje igrac))
;; )

;;Vraca se lista stanja, u koje igrac odigravanjem svih mogucih poteza koje ima na raspolaganju u datom trenutku, moze preci iz tekuceg stanja
;;Ako igrac nema potez, vraca se lista, koja sadrzi to tekuce stanje. Taj slucaj je bitan za alpha-beta algoritam
;;da bi stablo moglo nadalje da se produbljuje iako (min ili max) igrac u datom trenutku cvoru nema sta da odigra
(defun sva-stanja (stanje igrac)
     (let*
        (
            (potezi (svi-potezi stanje igrac))
        )
        (cond
            ((null potezi) (list stanje))
            (t  (sva-stanja-pom stanje potezi))
        )
     )
     
)

;Dodata je funkcija cekiraj-stanje, jer mozda neko stanje ima popunje stek, a posto se funkcija koristi u alpha beta algoritmu, mora u njoj da
;se ubaci ta provera
(defun sva-stanja-pom (stanje lpoteza)
    (cond
        ((null lpoteza) '())
        (t (cons (cekiraj-stanje (odigraj-potez stanje (car lpoteza))) (sva-stanja-pom stanje (cdr lpoteza))))
    )
)


;                                               ALPHA - BETA PRUNING ALGORITAM
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------


;1 max
;0 min
;-beskonacno=-9999
;+beskonacno=9999
;alpha i beta i vrednost moraju da budu oblika kao heuristika '(() vrednost)
;vrednost je privremena promenljiva koja pamti minimalnu ili maximalnu vrednost
;na osnovu her-igrac racuna se heuristika na terminalnom cvoru. Heuristika se razlicito racuna za x ili oks igraca, tako da zavisi
;da li kompjuter kad igra potez, igra kao x ili kao oks igrac
;kroz promenljivu igrac, prenosi se ko u datoj visini stabla treba da povuce potez, da li x ili oks igrac i od toga zavisi kakva ce deca biti u tom cvoru
(defun alpha-beta (stanje dubina alfa beta min-max igrac her-igrac)
     (cond
        ((= dubina 0) (heuristika stanje her-igrac))
        ((not (= (testiraj-ciljno-stanje stanje) 0)) (heuristika stanje her-igrac))
        (
            (= min-max 1)
            (let*
                (
                    (vrednost (list '() -9999))
                    (deca (sva-stanja stanje igrac))
                )
                ;;ovde se vraca rezulata foreach-a
                (alpha-beta-foreach deca dubina alfa beta min-max igrac vrednost her-igrac)                
            )
            
        )
        (
            (= min-max 0)
            (let*
                (
                    (vrednost (list '() 9999))
                    (deca (sva-stanja stanje igrac))
                )
                ;;ovde se vraca rezulata foreach-a
                (alpha-beta-foreach deca dubina alfa beta min-max igrac vrednost her-igrac)
            )
           
        )
    )
)

;Implementira foreach petlju za svako detence
(defun alpha-beta-foreach (lstanja dubina alfa beta min-max igrac vrednost her-igrac)
    (cond
        ((null lstanja) vrednost)
        (
            (= min-max 1)
            (let*
                (
                    (nova-vrednost (alpha-beta-max (list (car lstanja) (nth 1 vrednost)) (alpha-beta (car lstanja) (1- dubina) alfa beta 0 (promena-igraca igrac) her-igrac)))
                    (nova-alfa (alpha-beta-max alfa nova-vrednost))
                )
                (cond
                    ( (>= (nth 1 nova-alfa) (nth 1 beta)) (cond ((> (nth 1 nova-vrednost) (nth 1 vrednost)) nova-vrednost) (t vrednost))) ;; slucaj kad se prekida petlja - beta odsecanje
                    (t (alpha-beta-foreach (cdr lstanja) dubina nova-alfa beta min-max igrac (cond ((> (nth 1 nova-vrednost) (nth 1 vrednost)) nova-vrednost) (t vrednost)) her-igrac))
                )
            )
        )
        (
            (= min-max 0)
             (let*
                (
                    (nova-vrednost (alpha-beta-min (list (car lstanja) (nth 1 vrednost)) (alpha-beta (car lstanja) (1- dubina) alfa beta 1 (promena-igraca igrac) her-igrac)))
                    (nova-beta (alpha-beta-min beta nova-vrednost))
                )
                (cond
                    ( (>= (nth 1 alfa) (nth 1 nova-beta)) (cond ((< (nth 1 nova-vrednost) (nth 1 vrednost)) nova-vrednost) (t vrednost))) ;; slucaj kad se prekida petlja - alpha odsecanje
                    (t (alpha-beta-foreach (cdr lstanja) dubina alfa nova-beta min-max igrac (cond ((< (nth 1 nova-vrednost) (nth 1 vrednost)) nova-vrednost) (t vrednost)) her-igrac))
                )
            )
        )
    )
)

;Funkcija vraca heuristiku za odredjeno stanje i igraca koji treba da igra u tom trenutku
;kao listu koja je u obliku (stanje vrednost-heuristike)
;vrednost-heuristike se racuna kao razlika izmedju broja osvojenih stekova igraca i broja osvojenih stekova protivnika
(defun heuristika (stanje igrac)
    (cond
        (
            (equalp igrac 'x) 
            (list stanje (+ (* (- (nth 1 stanje) (nth 2 stanje)) 100) (heuristika-brza stanje igrac)))
        )
        (
            (equalp igrac 'o) 
            (list stanje (+ (* (- (nth 2 stanje) (nth 1 stanje)) 100) (heuristika-brza stanje igrac)))
        )
    )
)

;Vraca vecu heuristiku od heuristika h1 i h2
;pri cemu cuva vrednost stanja u h1 i uzima od h2 samo vrednost heuristike ako je heuristika u h2 veca od h1
(defun alpha-beta-max (h1 h2)
    (cond
        ((> (nth 1 h2) (nth 1 h1)) (list (car h1) (nth 1 h2)))
        (t h1)
    )
)

;Vraca manju heuristiku od heuristika h1 i h2
;pri cemu cuva vrednost stanja u h1 i uzima od h2 samo vrednost heuristike ako je heuristika u h2 veca od h1
(defun alpha-beta-min (h1 h2)
    (cond
        ((< (nth 1 h2) (nth 1 h1)) (list (car h1) (nth 1 h2)))
        (t h1)
    )
)

(defun promena-igraca (igrac)
    (cond 
        ((equalp igrac 'x) 'o)
        ((equalp igrac 'o) 'x)
    )
)

(defun dubina (stanje)
    (cond
        ((= (length (car stanje)) 8) (+ 5 (+ (nth 1 stanje) (nth 2 stanje))))
        (t (+ 3 (+ (nth 1 stanje) (nth 2 stanje))))
    )
)

;                                               ODIGRAVANJE POTEZA RACUNARA
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------

;Kada alpha-beta funkcija vrati novo stanje, izracunaj-potez treba da vrati potez koji je prethodno stanje prebacilo u novo stanje, u formatu ((A 4) (B 5) 2)
(defun izracunaj-potez (stanje1 stanje2 igrac)
   (izracunaj-potez-lista (svi-potezi stanje1 igrac) stanje1 stanje2)
)

(defun izracunaj-potez-lista (lpoteza stanje1 stanje2)
    (cond
        ((null lpoteza) '())
        ( (equalp (cekiraj-stanje (odigraj-potez stanje1 (car lpoteza))) stanje2) (deformatiraj-potez (car lpoteza)))
        (t (izracunaj-potez-lista (cdr lpoteza) stanje1 stanje2))
    )
)

(defun alpha-beta-potez (stanje igrac)
    (cond
        ((null (svi-potezi stanje igrac)) (format t "Racunar nema potez.~%") stanje)
        (t
            (let*
                (
                    (novo-stanje (cekiraj-stanje (car (alpha-beta stanje (dubina stanje) (list '() -9999) (list '() 9999) 1 igrac igrac))))
                    (potez (izracunaj-potez stanje novo-stanje igrac))
                )
                (progn
                    (format t "Racunar je odigrao potez: ")
                    (print potez)
                    novo-stanje
                )
            )
        )
       
    )
)



;                                               HEURISTIKA BEZ MASINE ZA ZAKLJUCIVANJE
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------


(defun heuristika-brza  (stanje igrac)
    (her-brza stanje igrac 0 0 0)
)

(defun her-brza (stanje igrac i j zbir)
     (cond
        ((and (= i (length (car stanje))) (= j 0)) zbir)
        (t
            (let*
                (
                    (polje (nth j (nth i (car stanje))))
                    (duzina (length polje))
                )
                (cond
                    (
                        ;;Preskacemo polje koja su prazna i ona na kojima nema vise od jedne figure
                        (< duzina 2) 
                        (her-brza stanje igrac (+ i (floor j (1- (length (car stanje))))) (mod (1+ j) (length (car stanje))) zbir)
                    )
                    (
                        ;;Slucaj kad vrh steka i prva figura steka pripada igracu koji je na potezu
                        (and (equalp (nth (1- duzina) polje) igrac) (equalp (nth 0 polje) igrac))
                        (her-brza stanje igrac (+ i (floor j (1- (length (car stanje))))) (mod (1+ j) (length (car stanje))) (+ (+ zbir (* duzina 10)) 5))
                    )
                    (
                        ;;Slucaj kad samo vrh steka pripada igracu koji je na potezu
                        (equalp (nth (1- duzina) polje) igrac)
                        (her-brza stanje igrac (+ i (floor j (1- (length (car stanje))))) (mod (1+ j) (length (car stanje))) (+ zbir (* duzina 10)))
                    )
                    (t
                        ;;Default
                        (her-brza stanje igrac (+ i (floor j (1- (length (car stanje))))) (mod (1+ j) (length (car stanje))) zbir) 
                    )
                )
            ) 
        )
    )
)


;                                                       MAIN LOOP
;-----------------------------------------------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------------------------------------------


;;ODKOMENTARISI AKO ZELIS DA TI CMD BUDE U FULLSCREEN-U 
;; (run-shell-command "mode con:cols=1000 lines=1000")
(defun main (igra)
    (let*
        (
            (stanje (car igra))
            (pom (prikaz-stanja stanje))
            (igrac (nth 2 igra))
            (novo-stanje
                (cond
                    ( (and (= (nth 1 igra) 1) (not (equal (nth 3 igra) 1))) (alpha-beta-potez stanje igrac))
                    (t (cekiraj-stanje (odigraj-potez stanje (validirani-unos-poteza stanje igrac))))
                )
            )
            (test (testiraj-ciljno-stanje novo-stanje))
        )
            (cond
            ((= test 1) (format t "IGRAC X JE POBEDNIK."))
            ((= test -1) (format t "IGRAC OKS JE POBEDNIK."))
            ((equalp igrac 'x) (main (cons novo-stanje (list (mod (1+ (nth 1 igra)) 2) 'o (nth 3 igra)))))
            ((equalp igrac 'o) (main (cons novo-stanje (list (mod (1+ (nth 1 igra)) 2) 'x (nth 3 igra)))))
        )
    )
    
)

(main (inicijalizacija-igre ))








