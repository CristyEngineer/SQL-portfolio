-- 01_create_tables_technical.sql
-- Technical tables for HVAC/BMS project (PostgreSQL)

------------------------------------------------------------
-- AHU UNITS
------------------------------------------------------------
CREATE TABLE ahu_units (
    ahu_id              SERIAL PRIMARY KEY,
    ahu_name            VARCHAR(100) NOT NULL,
    location            VARCHAR(100),
    building            VARCHAR(100),
    floor               VARCHAR(50),
    commissioning_date  DATE
);

------------------------------------------------------------
-- SENSORS
------------------------------------------------------------
CREATE TABLE sensors (
    sensor_id       SERIAL PRIMARY KEY,
    ahu_id          INT NOT NULL,
    sensor_name     VARCHAR(100) NOT NULL,
    sensor_type     VARCHAR(50),
    unit            VARCHAR(20),
    is_active       BOOLEAN DEFAULT TRUE,
    install_date    DATE
);

------------------------------------------------------------
-- SENSOR READINGS
------------------------------------------------------------
CREATE TABLE sensor_readings (
    reading_id      BIGSERIAL PRIMARY KEY,
    sensor_id       INT NOT NULL,
    reading_time    TIMESTAMP NOT NULL,
    reading_value   DECIMAL(18,4) NOT NULL
);

------------------------------------------------------------
-- ALARMS
------------------------------------------------------------
CREATE TABLE alarms (
    alarm_id        BIGSERIAL PRIMARY KEY,
    sensor_id       INT,
    ahu_id          INT,
    alarm_time      TIMESTAMP NOT NULL,
    alarm_code      VARCHAR(50) NOT NULL,
    alarm_severity  VARCHAR(20),
    alarm_message   VARCHAR(255)
);

------------------------------------------------------------
-- ZONES (NEW)
------------------------------------------------------------
CREATE TABLE zones (
    zone_id        SERIAL PRIMARY KEY,
    zone_name      VARCHAR(100) NOT NULL,
    building       VARCHAR(100),
    floor          VARCHAR(50),
    area_m2        DECIMAL(10,2),
    description    VARCHAR(255)
);

------------------------------------------------------------
-- AHU COMPONENTS (NEW)
------------------------------------------------------------
CREATE TABLE ahu_components (
    component_id      SERIAL PRIMARY KEY,
    ahu_id            INT NOT NULL,
    component_name    VARCHAR(100) NOT NULL,
    component_type    VARCHAR(50),
    install_date      DATE,
    maintenance_cycle INT,
    notes             VARCHAR(255)
);

------------------------------------------------------------
-- SETPOINTS (NEW)
------------------------------------------------------------
CREATE TABLE setpoints (
    setpoint_id     SERIAL PRIMARY KEY,
    ahu_id          INT,
    zone_id         INT,
    setpoint_name   VARCHAR(100) NOT NULL,
    setpoint_type   VARCHAR(20) NOT NULL,        -- analog / digital
    setpoint_value  DECIMAL(10,2),               -- analog
    unit            VARCHAR(20),                 -- °C, Pa, m3/h, ppm
    allowed_values  VARCHAR(100),                -- digital ('ON,OFF')
    effective_from  TIMESTAMP NOT NULL DEFAULT NOW(),
    effective_to    TIMESTAMP
);
