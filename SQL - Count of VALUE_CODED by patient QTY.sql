SELECT
obs.value_coded 'Codigo PF',
cn.name 'Nombre Metodo', 
count(obs.person_id) as 'Cantidad de Pacientes'
FROM openmrs.obs
inner join openmrs.person on obs.person_id = person.person_id
inner join encounter e on e.encounter_id = obs.encounter_id
inner join concept_name cn on cn.concept_id = obs.value_coded and cn.locale = 'es' and cn.locale_preferred = 1
where obs.concept_id='163316' and obs.voided=0 and person.voided=0
    and e.encounter_datetime >= :startDate
    and e.encounter_datetime < addDate(:endDate,1)
group by obs.value_coded;
 