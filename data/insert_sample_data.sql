-- ============================================
-- INSERT SAMPLE DATA FROM CSV FILES
-- ============================================

-- AHU units
COPY ahu_units (ahu_id, ahu_name, location, building, floor, commissioning_date)
FROM 'data/ahu_units.csv'
DELIMITER ','
CSV HEADER;

-- Sensors
COPY sensors (sensor_id, ahu_id, sensor_name, sensor_type, unit, is_active, install_date)
FROM 'data/sensors.csv'
DELIMITER ','
CSV HEADER;

-- Sensor readings
COPY sensor_readings (reading_id, sensor_id, reading_value, reading_time)
FROM 'data/sensor_readings.csv'
DELIMITER ','
CSV HEADER;

-- Alarms
COPY alarms (alarm_id, ahu_id, alarm_time, alarm_code, alarm_severity, description)
FROM 'data/alarms.csv'
DELIMITER ','
CSV HEADER;

-- Change orders
COPY change_orders (change_order_id, order_number, description, cost_change, approved_by, approval_date, related_ahu_id, related_zone_id)
FROM 'data/change_orders.csv'
DELIMITER ','
CSV HEADER;

-- Materials
COPY materials (material_id, change_order_id, material_name, quantity, unit_cost)
FROM 'data/materials.csv'
DELIMITER ','
CSV HEADER;

-- Labor hours
COPY labor_hours (labor_id, technician_name, task_description, hours_spent, hourly_rate, work_date, ahu_id, zone_id)
FROM 'data/labor_hours.csv'
DELIMITER ','
CSV HEADER;

-- Cost breakdown
COPY cost_breakdown (cost_id, change_order_id, cost_type, amount)
FROM 'data/cost_breakdown.csv'
DELIMITER ','
CSV HEADER;
