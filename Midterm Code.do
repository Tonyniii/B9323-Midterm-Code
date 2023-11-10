import excel using "/Users/nizehua/Desktop/5states09to14.xlsx", firstrow clear
*use "/Users/nizehua/Desktop/5states09to14.dta"

egen county=group(County)
gen lnO3aqi=ln(O3AQI)
gen lnCOaqi=ln(COAQI)
gen lnSO2aqi=ln(SO2AQI)
gen lnNO2aqi=ln(NO2AQI)
gen year = year(Date)


* Descriptive
*use "/Users/nizehua/Desktop/CA.dta"
*sum2docx lnO3aqi lnCOaqi lnSO2aqi lnNO2aqi Treat TreatPost using Sum1.docx, replace stats(N sd(%9.3f) mean(%9.3f) min(%9.3f) median(%9.3f) max(%9.3f)) title("Table1 Descriptive Statistics for CA")
*use "/Users/nizehua/Desktop/5states.dta"
*sum2docx lnO3aqi lnCOaqi lnSO2aqi lnNO2aqi Treat TreatPost using Sum2.docx, replace stats(N sd(%9.3f) mean(%9.3f) min(%9.3f) median(%9.3f) max(%9.3f)) title("Table2 Descriptive Statistics for Other States")


* Main Regression
ssc install reg2docx 
reg lnO3aqi Treat i.year i.county
est store m1
reg lnCOaqi Treat i.year i.county
est store m2
reg lnSO2aqi Treat i.year i.county
est store m3
reg lnNO2aqi Treat i.year i.county
est store m4

reg2docx m1 m2 m3 m4 using OLS.docx, replace indicate("Year Effect = 2009.year" "County Effect = 1.county")  scalars(N r2(%9.3f) r2_a(%9.3f)) b(%9.3f) t(%9.3f) keep(Treat) title("Table2 Main Regression")

* Difference-in-Difference
ssc install reg2docx 
reg lnO3aqi Treat
est store m5
reg lnO3aqi Treat i.year i.county
est store m6
reg lnO3aqi TreatPost i.year i.county
est store m7
reg2docx m5 m6 m7 using DID1.docx, replace indicate("Year Effect = 2009.year" "County Effect = 1.county")  scalars(N r2(%9.3f) r2_a(%9.3f)) b(%9.3f) t(%9.3f) keep(Treat TreatPost) title("Table3 DID for O3")

reg lnCOaqi Treat
est store m8
reg lnCOaqi Treat i.year i.county
est store m9
reg lnCOaqi TreatPost i.year i.county
est store m10
reg2docx m8 m9 m10 using DID2.docx, replace indicate("Year Effect = 2009.year" "County Effect = 1.county")  scalars(N r2(%9.3f) r2_a(%9.3f)) b(%9.3f) t(%9.3f) keep(Treat TreatPost) title("Table4 DID for CO")

reg lnSO2aqi Treat
est store m11
reg lnSO2aqi Treat i.year i.county
est store m12
reg lnSO2aqi TreatPost i.year i.county
est store m13
reg2docx m11 m12 m13 using DID3.docx, replace indicate("Year Effect = 2009.year" "County Effect = 1.county")  scalars(N r2(%9.3f) r2_a(%9.3f)) b(%9.3f) t(%9.3f) keep(Treat TreatPost) title("Table5 DID for SO2")

reg lnNO2aqi Treat
est store m14
reg lnNO2aqi Treat i.year i.county
est store m15
reg lnNO2aqi TreatPost i.year i.county
est store m16
reg2docx m14 m15 m16 using DID4.docx, replace indicate("Year Effect = 2009.year" "County Effect = 1.county")  scalars(N r2(%9.3f) r2_a(%9.3f)) b(%9.3f) t(%9.3f) keep(Treat TreatPost) title("Table6 DID for NO2")


