(deftemplate diabetes
	(slot outcome (type SYMBOL) (allowed-symbols yes no))
	(slot glucose (type FLOAT) (range 127.5 154.5))
	(slot age (type INTEGER))
	(slot bmi (type FLOAT) (range 29.94 45.5))
	(slot pregnancies (type SYMBOL))
	(slot diabetesPedigreeFunction (type FLOAT) (range 0.2 0.5))
	(slot bloodPressure (type FLOAT) (range 92.0 106.0))
	(slot skinThickness (type FLOAT) (range 34.5 36.0)))

(deftemplate vstupne_premenne
	(slot glucose (type FLOAT) (range 127.5 154.5))
	(slot age (type INTEGER))
	(slot bmi (type FLOAT) (range 29.94 45.5))
	(slot pregnancies (type SYMBOL))
	(slot diabetesPedigreeFunction (type FLOAT) (range 0.2 0.5))
	(slot bloodPressure (type FLOAT) (range 92.0 106.0))
	(slot skinThickness (type FLOAT) (range 34.5 36.0)))

(deffacts diabetes_fakty
	(diabetes (outcome yes) (glucose 127.5) (age 29) (bmi 45.39) (pregnancies ano) (diabetesPedigreeFunction 0.3) (bloodPressure 92.0) (skinThickness 34.5))
	(diabetes (outcome yes) (glucose 127.5) (age 28) (bmi 45.39) (pregnancies nie) (diabetesPedigreeFunction 0.4) (bloodPressure 92.0) (skinThickness 34.5))
	(diabetes (outcome yes) (glucose 154.5) (age 28) (bmi 45.39) (pregnancies nie) (diabetesPedigreeFunction 0.3) (bloodPressure 96.0) (skinThickness 34.5))
	(diabetes (outcome yes) (glucose 154.5) (age 28) (bmi 31.40) (pregnancies ano) (diabetesPedigreeFunction 0.4) (bloodPressure 94.0) (skinThickness 34.5))
	(diabetes (outcome yes) (glucose 154.5) (age 35) (bmi 31.40) (pregnancies ano) (diabetesPedigreeFunction 0.4) (bloodPressure 93.0) (skinThickness 34.5))
	(diabetes (outcome yes) (glucose 127.5) (age 35) (bmi 31.40) (pregnancies nie) (diabetesPedigreeFunction 0.4) (bloodPressure 92.0) (skinThickness 34.5))
	(diabetes (outcome yes) (glucose 127.5) (age 28) (bmi 31.40) (pregnancies ano) (diabetesPedigreeFunction 0.3) (bloodPressure 96.0) (skinThickness 36.0))
	(diabetes (outcome yes) (glucose 127.5) (age 35) (bmi 31.40) (pregnancies nie) (diabetesPedigreeFunction 0.4) (bloodPressure 92.0) (skinThickness 34.5)))

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