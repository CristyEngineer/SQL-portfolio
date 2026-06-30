-- 05_indexes.sql
-- Indexes for HVAC/BMS project (PostgreSQL)

------------------------------------------------------------
-- AHU UNITS
------------------------------------------------------------

-- Index on ahu_name for faster lookup by name
CREATE INDEX idx_ahu_units_name
ON ahu_units (ahu_name);

------------------------------------------------------------
-- SENSORS
------------------------------------------------------------

-- Index on ahu_id for faster joins between sensors and AHUs
CREATE INDEX idx_sensors_ahu_id
ON sensors (ahu_id);

-- Index on sensor_type for filtering by type
CREATE INDEX idx_sensors_type
ON sensors (sensor_type);

------------------------------------------------------------
-- SENSOR READINGS
------------------------------------------------------------

-- Index on sensor_id for fast time-series queries
CREATE INDEX idx_readings_sensor_id
ON sensor_readings (sensor_id);

-- Composite index for sensor_id + reading_time (most common query pattern)
CREATE INDEX idx_readings_sensor_time
ON sensor_readings (sensor_id, reading_time);

------------------------------------------------------------
-- ALARMS
------------------------------------------------------------

-- Index on ahu_id for alarm lookups per AHU
CREATE INDEX idx_alarms_ahu_id
ON alarms (ahu_id);

-- Index on sensor_id for alarm lookups per sensor
CREATE INDEX idx_alarms_sensor_id
ON alarms (sensor_id);

-- Index on alarm_severity for filtering
CREATE INDEX idx_alarms_severity
ON alarms (alarm_severity);

------------------------------------------------------------
-- ZONES
------------------------------------------------------------

-- Index on zone_name for quick lookup
CREATE INDEX idx_zones_name
ON zones (zone_name);

------------------------------------------------------------
-- AHU COMPONENTS
------------------------------------------------------------

-- Index on ahu_id for component lookups
CREATE INDEX idx_components_ahu_id
ON ahu_components (ahu_id);

------------------------------------------------------------
-- SETPOINTS
------------------------------------------------------------

-- Index on ahu_id for AHU-level setpoints
CREATE INDEX idx_setpoints_ahu_id
ON setpoints (ahu_id);

-- Index on zone_id for zone-level setpoints
CREATE INDEX idx_setpoints_zone_id
ON setpoints (zone_id);

-- Index on setpoint_type for filtering analog/digital
CREATE INDEX idx_setpoints_type
ON setpoints (setpoint_type);

------------------------------------------------------------
-- MATERIALS
------------------------------------------------------------

-- Index on material_name for fast lookup
CREATE INDEX idx_materials_name
ON materials (material_name);

------------------------------------------------------------
-- LABOR HOURS
------------------------------------------------------------

-- Index on work_date for time-based queries
CREATE INDEX idx_labor_work_date
ON labor_hours (work_date);

-- Index on ahu_id for cost analysis per AHU
CREATE INDEX idx_labor_ahu_id
ON labor_hours (ahu_id);

-- Index on zone_id for cost analysis per zone
CREATE INDEX idx_labor_zone_id
ON labor_hours (zone_id);

------------------------------------------------------------
-- CHANGE ORDERS
------------------------------------------------------------

-- Index on order_number for quick lookup
CREATE INDEX idx_change_orders_number
ON change_orders (order_number);

-- Index on related_ahu_id
CREATE INDEX idx_change_orders_ahu_id
ON change_orders (related_ahu_id);

-- Index on related_zone_id
CREATE INDEX idx_change_orders_zone_id
ON change_orders (related_zone_id);

------------------------------------------------------------
-- COST BREAKDOWN
------------------------------------------------------------

-- Index on cost_date for reporting
CREATE INDEX idx_cost_date
ON cost_breakdown (cost_date);

-- Index on cost_category for filtering
CREATE INDEX idx_cost_category
ON cost_breakdown (cost_category);

-- Index on ahu_id
CREATE INDEX idx_cost_ahu_id
ON cost_breakdown (ahu_id);

-- Index on zone_id
CREATE INDEX idx_cost_zone_id
ON cost_breakdown (zone_id);
