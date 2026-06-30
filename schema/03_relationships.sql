-- 03_relationships.sql
-- Foreign key relationships for HVAC/BMS project (PostgreSQL)

------------------------------------------------------------
-- TECHNICAL RELATIONSHIPS
------------------------------------------------------------

-- sensors → ahu_units
ALTER TABLE sensors
ADD CONSTRAINT fk_sensors_ahu
FOREIGN KEY (ahu_id) REFERENCES ahu_units(ahu_id);

-- sensor_readings → sensors
ALTER TABLE sensor_readings
ADD CONSTRAINT fk_readings_sensor
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id);

-- alarms → sensors
ALTER TABLE alarms
ADD CONSTRAINT fk_alarms_sensor
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id);

-- alarms → ahu_units
ALTER TABLE alarms
ADD CONSTRAINT fk_alarms_ahu
FOREIGN KEY (ahu_id) REFERENCES ahu_units(ahu_id);

-- ahu_components → ahu_units
ALTER TABLE ahu_components
ADD CONSTRAINT fk_components_ahu
FOREIGN KEY (ahu_id) REFERENCES ahu_units(ahu_id);

-- setpoints → ahu_units
ALTER TABLE setpoints
ADD CONSTRAINT fk_setpoints_ahu
FOREIGN KEY (ahu_id) REFERENCES ahu_units(ahu_id);

-- setpoints → zones
ALTER TABLE setpoints
ADD CONSTRAINT fk_setpoints_zone
FOREIGN KEY (zone_id) REFERENCES zones(zone_id);

------------------------------------------------------------
-- FINANCIAL RELATIONSHIPS
------------------------------------------------------------

-- labor_hours → ahu_units
ALTER TABLE labor_hours
ADD CONSTRAINT fk_labor_ahu
FOREIGN KEY (ahu_id) REFERENCES ahu_units(ahu_id);

-- labor_hours → zones
ALTER TABLE labor_hours
ADD CONSTRAINT fk_labor_zone
FOREIGN KEY (zone_id) REFERENCES zones(zone_id);

-- change_orders → ahu_units
ALTER TABLE change_orders
ADD CONSTRAINT fk_change_orders_ahu
FOREIGN KEY (related_ahu_id) REFERENCES ahu_units(ahu_id);

-- change_orders → zones
ALTER TABLE change_orders
ADD CONSTRAINT fk_change_orders_zone
FOREIGN KEY (related_zone_id) REFERENCES zones(zone_id);

-- cost_breakdown → ahu_units
ALTER TABLE cost_breakdown
ADD CONSTRAINT fk_cost_ahu
FOREIGN KEY (ahu_id) REFERENCES ahu_units(ahu_id);

-- cost_breakdown → zones
ALTER TABLE cost_breakdown
ADD CONSTRAINT fk_cost_zone
FOREIGN KEY (zone_id) REFERENCES zones(zone_id);
