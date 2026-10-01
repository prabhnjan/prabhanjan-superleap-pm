-- Governed metric contracts for CARE (condition 3).
CREATE VIEW v_patients AS SELECT id, name, clinic_city, lower(trim(source)) AS source, enquiry_at, callback_requested_at, owner_id
  FROM patients WHERE merged_into IS NULL;
CREATE VIEW v_consultations AS SELECT c.id, c.patient_id, c.consult_no, c.scheduled_at, lower(trim(c.status)) AS status, c.doctor,
  p.clinic_city, p.owner_id FROM consultations c JOIN v_patients p ON p.id = c.patient_id;
CREATE VIEW v_hot_leads AS SELECT p.* FROM v_patients p WHERE p.callback_requested_at >= {h48_ago}
  AND NOT EXISTS (SELECT 1 FROM consultations c WHERE c.patient_id = p.id);
CREATE VIEW v_conversions AS SELECT k.id, k.patient_id, k.amount, k.purchased_at, p.clinic_city, p.owner_id, p.source
  FROM packages k JOIN v_patients p ON p.id = k.patient_id;
