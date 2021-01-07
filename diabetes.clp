(deftemplate diabetes
	(slot outcome (type SYMBOL) (allowed-symbols yes no))
	(slot glucose (type FLOAT) (range 0.0 154.5))
	(slot age (type FLOAT))
	(slot bmi (type FLOAT) (range 0.0 45.5))
	(slot pregnancies (type FLOAT) (range 0.0 9.5))
	(slot diabetesPedigreeFunction (type FLOAT) (range 0.0 1.0))
	(slot bloodPressure (type FLOAT) (range 0.0 92.0))
	(slot skinThickness (type FLOAT) (range 0.0 34.5)))

(deftemplate vstupne_premenne
        (slot glucose (type FLOAT) (range 0.0 154.5))
        (slot age (type FLOAT))
        (slot bmi (type FLOAT) (range 0.0 45.5))
        (slot pregnancies (type FLOAT) (range 0.0 9.5))
        (slot diabetesPedigreeFunction (type FLOAT) (range 0.0 1.0))
        (slot bloodPressure (type FLOAT) (range 0.0 92.0))
        (slot skinThickness (type FLOAT) (range 0.0 34.5)))

(deffacts diabetes_fakty
	(diabetes (outcome yes) (glucose 127.5) (age 28.5) (bmi 45.3) (pregnancies 7.5) (diabetesPedigreeFunction 0.0) (bloodPressure 0.0) (skinThickness 0.0))
	(diabetes (outcome yes) (glucose 127.5) (age 28.5) (bmi 45.3) (pregnancies 0.0) (diabetesPedigreeFunction 0.9) (bloodPressure 23.0) (skinThickness 0.0))
	(diabetes (outcome yes) (glucose 127.5) (age 62.5) (bmi 29.9) (pregnancies 2.5) (diabetesPedigreeFunction 0.0) (bloodPressure 79.0) (skinThickness 0.0))
	(diabetes (outcome yes) (glucose 127.5) (age 27.0) (bmi 29.9) (pregnancies 0.0) (diabetesPedigreeFunction 0.3) (bloodPressure 0.0) (skinThickness 0.0))
        (diabetes (outcome yes) (glucose 127.5) (age 56.5) (bmi 29.9) (pregnancies 9.5) (diabetesPedigreeFunction 0.2) (bloodPressure 0.0) (skinThickness 0.0))
	(diabetes (outcome yes) (glucose 127.5) (age 26.0) (bmi 29.9) (pregnancies 0.0) (diabetesPedigreeFunction 0.4) (bloodPressure 0.0) (skinThickness 0.0))
	(diabetes (outcome yes) (glucose 127.5) (age 42.0) (bmi 29.9) (pregnancies 0.0) (diabetesPedigreeFunction 0.4) (bloodPressure 72.0) (skinThickness 0.0))
	(diabetes (outcome yes) (glucose 127.5) (age 28.5) (bmi 26.3) (pregnancies 0.0) (diabetesPedigreeFunction 0.2) (bloodPressure 0.0) (skinThickness 0.0)))

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
	(printout t "AGE:")
	(bind ?o2 (read))
	(printout t "BMI:")
	(bind ?o3 (read))
	(printout t "PREGNANCIES:")
	(bind ?o4 (read))
	(printout t "DIABETESPEDIGREEFUNCTION:")
	(bind ?o5 (read))
	(printout t "BLOOTPRESSURE:")
	(bind ?o6 (read))
	(printout t "SKINTHICKNESS:")
	(bind ?o7 (read))

	(assert (vstupne_premenne (glucose ?o1) (age ?o2) (bmi ?o3) (pregnancies ?o4) (diabetesPedigreeFunction ?o5) (bloodPressure ?o6) (skinThickness ?o7))))

(defrule zisti_stav
	(vstupne_premenne (glucose ?o1) (age ?o2) (bmi ?o3) (pregnancies ?o4) (diabetesPedigreeFunction ?o5) (bloodPressure ?o6) (skinThickness ?o7))
	(diabetes (outcome ?x) (glucose ?o1) (age ?o2) (bmi ?o3) (pregnancies ?o4) (diabetesPedigreeFunction ?o5) (bloodPressure ?o6) (skinThickness ?o7))
=>
	(printout t " " crlf)
	(printout t "Podla danych udajov Vam bolo zistene diabetes" crlf))
	
(defrule ziadna_zhoda
	(vstupne_premenne (glucose ?o1) (age ?o2) (bmi ?o3) (pregnancies ?o4) (diabetesPedigreeFunction ?o5) (bloodPressure ?o6) (skinThickness ?o7))
	(not(diabetes (outcome ?x)(glucose ?o1) (age ?o2) (bmi ?o3) (pregnancies ?o4) (diabetesPedigreeFunction ?o5) (bloodPressure ?o6) (skinThickness ?o7)))
=>
	(printout t " " crlf)
	(printout t "Z danych bazov faktu Vam nebolo zistene diabetes !" crlf))

(defrule zrusit_vyhladavanie
	(declare (salience -1))
	?aktualne<-(volba V)
?odstranit<-(vstupne_premenne (glucose ?o1) (age ?o2) (bmi ?o3) (pregnancies ?o4) (diabetesPedigreeFunction ?o5) (bloodPressure ?o6) (skinThickness ?o7))
=>
	(retract ?odstranit ?aktualne)
	(assert(menu)))

(defrule spustit_dalsie_vyhladavanie_nie
	(volba K)
=>
	(printout t "---------------------------------------" crlf)
	(printout t "-----------<KONIEC PROGRAMU>-----------" crlf)
	(printout t "---------------------------------------" crlf))