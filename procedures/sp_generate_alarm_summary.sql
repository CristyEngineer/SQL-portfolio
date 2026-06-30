-- sp_generate_alarm_summary.sql
-- Generates a summary of alarms per AHU for reporting purposes

CREATE OR REPLACE FUNCTION sp_generate_alarm_summary()
RETURNS VOID AS $$
BEGIN
    -- Remove existing summary table if it exists
    DROP TABLE IF EXISTS alarm_summary;

    -- Create a new summary table
    CREATE TABLE alarm_summary AS
    SELECT 
        a.ahu_id,
        u.ahu_name,
        
        -- Total alarms
        COUNT(*) AS total_alarms,

        -- Severity breakdown
        SUM(CASE WHEN a.alarm_severity = 'HIGH' THEN 1 ELSE 0 END) AS high_alarms,
        SUM(CASE WHEN a.alarm_severity = 'MEDIUM' THEN 1 ELSE 0 END) AS medium_alarms,
        SUM(CASE WHEN a.alarm_severity = 'LOW' THEN 1 ELSE 0 END) AS low_alarms,

        -- Most recent alarm timestamp
        MAX(a.alarm_time) AS last_alarm_time

    FROM alarms a
    LEFT JOIN ahu_units u ON u.ahu_id = a.ahu_id
    GROUP BY a.ahu_id, u.ahu_name
    ORDER BY a.ahu_id;

END;
$$ LANGUAGE plpgsql;

