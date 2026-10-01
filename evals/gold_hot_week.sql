SELECT COUNT(*) FROM leads
WHERE merged_into IS NULL AND lead_score >= 70
  AND lower(trim(stage)) IN ('contacted','counselling booked')
  AND enquiry_at >= :week_start AND enquiry_at < :week_end
