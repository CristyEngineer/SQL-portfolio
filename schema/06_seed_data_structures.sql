-- 06_seed_data_structure.sql
-- Seed data structure for HVAC/BMS project (PostgreSQL)
-- This file inserts example (fictional) data into all tables.

------------------------------------------------------------
-- AHU UNITS
------------------------------------------------------------
INSERT INTO ahu_units (ahu_name, location, building, floor, commissioning_date)
VALUES
('AHU-01', 'North Wing', 'Building A', '1', '2020-03-15'),
('AHU-02', 'South Wing', 'Building A', '2', '2021-07-10');

------------------------------------------------------------
-- ZONES
------------------------------------------------------------
INSERT INTO zones (zone_name, building, floor, area_m2, description)
VALUES
('Zone 101', 'Building A', '1', 45.5, 'Office area'),
('Zone 202', 'Building A', '2', 60.0, 'Meeting rooms');

------------------------------------------------------------
-- SENSORS
------------------------------------------------------------
INSERT INTO sensors (ahu_id, sensor_name, sensor_type, unit, is_active, install_date)
VALUES
(1, 'Supply Air Temp Sensor', 'temperature', '°C', TRUE, '2020-03-20'),
(1, 'Return Air CO2 Sensor', 'co2', 'ppm', TRUE, '2020-03-20'),
(2, 'Static Pressure Sensor', 'pressure', 'Pa', TRUE, '2021-07-15');

------------------------------------------------------------
-- SENSOR READINGS
------------------------------------------------------------
INSERT INTO sensor_readings (sensor_id, reading_time, reading_value)
VALUES
(1, NOW() - INTERVAL '10 minutes', 18.4),
(1, NOW() - INTERVAL '5 minutes', 18.7),
(2, NOW() - INTERVAL '5 minutes', 650),
(3, NOW() - INTERVAL '5 minutes', 145);

------------------------------------------------------------
-- ALARMS
------------------------------------------------------------
INSERT INTO alarms (sensor_id, ahu_id, alarm_time, alarm_code, alarm_severity, alarm_message)
VALUES
(3, 2, NOW() - INTERVAL '1 hour', 'ALM-PS-01', 'HIGH', 'Static pressure too low');

------------------------------------------------------------
-- AHU COMPONENTS
------------------------------------------------------------
INSERT INTO ahu_components (ahu_id, component_name, component_type, install_date, maintenance_cycle, notes)
VALUES
(1, 'Supply Fan', 'fan', '2020-03-15', 180, 'Main supply fan'),
(2, 'Return Fan', 'fan', '2021-07-10', 180, 'Return air fan');

------------------------------------------------------------
-- SETPOINTS
------------------------------------------------------------
INSERT INTO setpoints (ahu_id, zone_id, setpoint_name, setpoint_type, setpoint_value, unit, allowed_values)
VALUES
(1, NULL, 'Supply Air Temp Setpoint', 'analog', 19.5, '°C', NULL),
(NULL, 1, 'Zone Occupancy Mode', 'digital', NULL, NULL, 'OCCUPIED,UNOCCUPIED');

------------------------------------------------------------
-- MATERIALS
------------------------------------------------------------
INSERT INTO materials (material_name, material_type, unit_cost, unit_of_measure, supplier_name, notes)
VALUES
('G4 Filter', 'filter', 12.50, 'pcs', 'HVAC Supplies Ltd', 'Standard panel filter'),
('Belt Type A', 'belt', 8.90, 'pcs', 'Mechanical Parts Co', 'Fan belt');

------------------------------------------------------------
-- LABOR HOURS
------------------------------------------------------------
INSERT INTO labor_hours (technician_name, task_description, hours_spent, hourly_rate, work_date, ahu_id, zone_id)
VALUES
('John Smith', 'Filter replacement', 1.5, 45.00, '2024-05-12', 1, NULL),
('Emily Brown', 'Sensor calibration', 2.0, 50.00, '2024-05-13', 1, 1);

------------------------------------------------------------
-- CHANGE ORDERS
------------------------------------------------------------
INSERT INTO change_orders (order_number, description, cost_change, approved_by, approval_date, related_ahu_id, related_zone_id)
VALUES
('CO-001', 'Add CO2 sensor', 350.00, 'Project Manager', '2024-04-10', 1, NULL);

------------------------------------------------------------
-- COST BREAKDOWN
------------------------------------------------------------
INSERT INTO cost_breakdown (cost_category, cost_amount, cost_date, ahu_id, zone_id, notes)
VALUES
('materials', 12.50, '2024-05-12', 1, NULL, 'Filter replacement'),
('labor', 67.50, '2024-05-12', 1, NULL, 'Technician labor');
