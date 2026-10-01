-- Governed metric contracts for EDU (condition 3). The platform guarantees these definitions.
CREATE VIEW v_leads AS SELECT id, name, city, branch, program, lower(trim(source)) AS source, lead_score,
  lower(trim(stage)) AS stage, counsellor_id, enquiry_at, updated_at, enrolled_at FROM leads WHERE merged_into IS NULL;
CREATE VIEW v_hot_leads AS SELECT * FROM v_leads WHERE stage IN ('contacted','counselling booked')
  AND ((enquiry_at >= 1782844200000 AND lead_score >= 70) OR (enquiry_at < 1782844200000 AND lead_score >= 60));
CREATE VIEW v_enrolled AS SELECT * FROM v_leads WHERE stage = 'enrolled';
CREATE VIEW v_open_opportunity_leads AS SELECT DISTINCT l.* FROM v_leads l JOIN opportunities o ON o.lead_id = l.id WHERE o.stage = 'Open';
