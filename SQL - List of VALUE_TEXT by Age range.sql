SELECT
obs.value_text'Diagnostico',
e.encounter_datetime'Fecha de Encuentro',
patient_identifier.identifier 'ID',
TIMESTAMPDIFF(YEAR, person.birthdate, CURDATE()) AS Edad,
(SELECT 
	CASE
		WHEN Edad <15 THEN 'Menor de 15'
        WHEN Edad BETWEEN 15 and 19 THEN '15-19'
        WHEN Edad BETWEEN 20 and 24 THEN '20-24'
        WHEN Edad BETWEEN 25 and 29 THEN '25-29'
        WHEN Edad BETWEEN 30 and 39 THEN '30-39'
        WHEN Edad BETWEEN 40 and 49 THEN '40-49'
        WHEN Edad >= 50 THEN 'Mas de 50'
        WHEN Edad IS NULL THEN '(NULL)'
    END as age_range) as RangoEdad
FROM openmrs.obs
inner join openmrs.person on obs.person_id = person.person_id
inner join encounter e on e.encounter_id = obs.encounter_id
inner join patient_identifier on obs.person_id = patient_identifier.patient_id 
where obs.concept_id='159393' and obs.voided=0 and person.voided=0
    and e.encounter_datetime >= :startDate
    and e.encounter_datetime < addDate(:endDate,1)
group by obs.encounter_id;