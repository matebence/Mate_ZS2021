(deftemplate diabetes
        (slot outcome (type SYMBOL) (allowed-symbols yes no))
        (slot glucose (type FLOAT))
        (slot bmi (type FLOAT))
        (slot age (type FLOAT))
        (slot bloodPressure (type FLOAT)))

(deftemplate vstupne_premenne
        (slot glucose (type FLOAT))
        (slot bmi (type FLOAT))
        (slot age (type FLOAT))
        (slot bloodPressure (type FLOAT)))

(deffacts pomocny_fakt
        (menu))

(defrule zobraz_menu
?odstranit<-(menu)
=>
        (retract ?odstranit)
        (printout t "-----------<MENU>-----------" crlf)
        (printout t "Vyhladavanie ..............V" crlf)
        (printout t "Koniec programu ...........K" crlf)
        (printout t "----------------------------" crlf)
        (printout t " " crlf)
        (printout t "Zadajte Vasu volbu:")
        (assert (volba (read))))

(defrule zadejte_vstupne_udaje
        (volba V)
=>
        (printout t "Zadajte nasledujuce udaje pre zistenie diabetesu" crlf)
        (printout t "================================================" crlf)
        (printout t "GLUCOSE:")
        (bind ?o1 (read))
        (printout t "BMI:")
        (bind ?o2 (read))
        (printout t "AGE:")
        (bind ?o3 (read))
        (printout t "BLOODPRESSURE:")
        (bind ?o4 (read))

        (assert (vstupne_premenne (glucose ?o1) (bmi ?o2) (age ?o3) (bloodPressure ?o4))))

(defrule zisti_stav
        (vstupne_premenne (glucose ?o1) (bmi ?o2) (age ?o3) (bloodPressure ?o4))
        (test (or
                  (and (<= ?o1 143.5) 
                       (<= ?o2 26.94))

                  (and (<= ?o1 143.5) 
                       (> ?o2 26.94)
                       (<= ?o3 30.5)
                       (> ?o4 37.0))

                  (and (<= ?o1 143.5) 
                       (> ?o2 26.94)
                       (> ?o3 30.5)
                       (<= ?o1 106.5))

                  (and (<= ?o1 143.5) 
                       (> ?o2 26.94)
                       (> ?o3 30.5)
                       (<= ?o1 106.5)
                       (> ?o3 56.5))
                )
        )
=>
        (printout t " " crlf)
        (printout t "Podla danych udajov Vam bolo zistene diabetes" crlf))

(defrule ziadna_zhoda
        (vstupne_premenne (glucose ?o1) (bmi ?o2) (age ?o3) (bloodPressure ?o4))
        (test (or
                  (and (<= ?o1 143.5) 
                       (> ?o2 26.94)
                       (<= ?o3 30.5)
                       (<= ?o4 37.0))

                  (and (<= ?o1 143.5) 
                       (> ?o2 26.94)
                       (> ?o3 30.5)
                       (<= ?o1 106.5)
                       (<= ?o3 56.5))

                  (and (> ?o1 143.5) 
                       (<= ?o1 166.5))

                  (and (> ?o1 143.5) 
                       (> ?o1 166.5))
                )
        )
=>
        (printout t " " crlf)
        (printout t "Z danych bazov faktu Vam nebolo zistene diabetes !" crlf))
        
(defrule zrusit_vyhladavanie
        (declare (salience -1))
        ?aktualne<-(volba V)
?odstranit<-(vstupne_premenne (glucose ?o1) (bmi ?o2) (age ?o3) (bloodPressure ?o4))
=>
        (retract ?odstranit ?aktualne)
        (assert(menu)))

(defrule spustit_dalsie_vyhladavanie_nie
        (volba K)
=>
        (printout t "---------------------------------------" crlf)
        (printout t "-----------<KONIEC PROGRAMU>-----------" crlf)
        (printout t "---------------------------------------" crlf))