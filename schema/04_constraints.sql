-- 04_constraints.sql
-- Constraints for HVAC/BMS project (PostgreSQL)

------------------------------------------------------------
-- AHU UNITS
------------------------------------------------------------

-- ahu_name must not be empty
ALTER TABLE ahu_units
ALTER COLUMN ahu_name SET NOT NULL;

------------------------------------------------------------
-- SENSORS
------------------------------------------------------------

-- sensor_name must not be empty
ALTER TABLE sensors
ALTER COLUMN sensor_name SET NOT NULL;

-- sensor_type must be a valid value
ALTER TABLE sensors
ADD CONSTRAINT chk_sensor_type
CHECK (sensor_type IN ('temperature', 'pressure', 'flow', 'co2', 'humidity', 'status', 'other'));

------------------------------------------------------------
-- SENSOR READINGS
------------------------------------------------------------

-- reading_value must be within a realistic range
ALTER TABLE sensor_readings
ADD CONSTRAINT chk_reading_value
CHECK (reading_value > -1000 AND reading_value < 10000);

------------------------------------------------------------
-- ALARMS
------------------------------------------------------------

-- alarm_severity must be a valid value
ALTER TABLE alarms
ADD CONSTRAINT chk_alarm_severity
CHECK (alarm_severity IN ('LOW', 'MEDIUM', 'HIGH'));

------------------------------------------------------------
-- ZONES
------------------------------------------------------------

-- area_m2 cannot be negative
ALTER TABLE zones
ADD CONSTRAINT chk_zone_area
CHECK (area_m2 IS NULL OR area_m2 >= 0);

------------------------------------------------------------
-- AHU COMPONENTS
------------------------------------------------------------

-- maintenance_cycle must be positive if provided
ALTER TABLE ahu_components
ADD CONSTRAINT chk_maintenance_cycle
CHECK (maintenance_cycle IS NULL OR maintenance_cycle > 0);

------------------------------------------------------------
-- SETPOINTS
------------------------------------------------------------

-- setpoint_type must be valid
ALTER TABLE setpoints
ADD CONSTRAINT chk_setpoint_type
CHECK (setpoint_type IN ('analog', 'digital'));

-- analog setpoints must have a numeric value and no allowed_values
-- digital setpoints must have allowed_values and no numeric value
ALTER TABLE setpoints
ADD CONSTRAINT chk_setpoint_logic
CHECK (
    (setpoint_type = 'analog' AND setpoint_value IS NOT NULL AND allowed_values IS NULL)
    OR
    (setpoint_type = 'digital' AND allowed_values IS NOT NULL AND setpoint_value IS NULL)
);

-- analog setpoint_value must be within a realistic range
ALTER TABLE setpoints
ADD CONSTRAINT chk_setpoint_value_range
CHECK (
    setpoint_type = 'digital'
    OR
    (setpoint_value > -1000 AND setpoint_value < 10000)
);

------------------------------------------------------------
-- MATERIALS
------------------------------------------------------------

-- unit_cost cannot be negative
ALTER TABLE materials
ADD CONSTRAINT chk_material_cost
CHECK (unit_cost IS NULL OR unit_cost >= 0);

------------------------------------------------------------
-- LABOR HOURS
------------------------------------------------------------

-- hours_spent must be positive
ALTER TABLE labor_hours
ADD CONSTRAINT chk_hours_spent
CHECK (hours_spent > 0);

-- hourly_rate must be positive if provided
ALTER TABLE labor_hours
ADD CONSTRAINT chk_hourly_rate
CHECK (hourly_rate IS NULL OR hourly_rate > 0);

------------------------------------------------------------
-- CHANGE ORDERS
------------------------------------------------------------

-- cost_change cannot be zero (must be positive or negative)
ALTER TABLE change_orders
ADD CONSTRAINT chk_cost_change
CHECK (cost_change != 0);

------------------------------------------------------------
-- COST BREAKDOWN
------------------------------------------------------------

-- cost_amount must be positive
ALTER TABLE cost_breakdown
ADD CONSTRAINT chk_cost_amount
CHECK (cost_amount > 0);

-- cost_category must be valid
ALTER TABLE cost_breakdown
ADD CONSTRAINT chk_cost_category
CHECK (cost_category IN ('materials', 'labor', 'subcontractor', 'energy', 'other'));
