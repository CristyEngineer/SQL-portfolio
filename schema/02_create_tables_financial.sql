-- 02_create_tables_financial.sql
-- Financial tables for HVAC/BMS project (PostgreSQL)

------------------------------------------------------------
-- MATERIALS
------------------------------------------------------------
CREATE TABLE materials (
    material_id        SERIAL PRIMARY KEY,
    material_name      VARCHAR(150) NOT NULL,
    material_type      VARCHAR(100),
    unit_cost          DECIMAL(12,2),
    unit_of_measure    VARCHAR(20),       -- pcs, m, kg, etc.
    supplier_name      VARCHAR(150),
    notes              VARCHAR(255)
);

------------------------------------------------------------
-- LABOR HOURS
------------------------------------------------------------
CREATE TABLE labor_hours (
    labor_id           SERIAL PRIMARY KEY,
    technician_name    VARCHAR(150) NOT NULL,
    task_description   VARCHAR(255),
    hours_spent        DECIMAL(10,2) NOT NULL,
    hourly_rate        DECIMAL(10,2),
    work_date          DATE NOT NULL,
    ahu_id             INT,               -- optioneel: koppeling aan installatie
    zone_id            INT                -- optioneel: koppeling aan zone
);

------------------------------------------------------------
-- CHANGE ORDERS
------------------------------------------------------------
CREATE TABLE change_orders (
    change_order_id    SERIAL PRIMARY KEY,
    order_number       VARCHAR(50) NOT NULL,
    description        VARCHAR(255),
    cost_change        DECIMAL(12,2) NOT NULL,
    approved_by        VARCHAR(150),
    approval_date      DATE,
    related_ahu_id     INT,
    related_zone_id    INT
);

------------------------------------------------------------
-- COST BREAKDOWN
------------------------------------------------------------
CREATE TABLE cost_breakdown (
    cost_id            SERIAL PRIMARY KEY,
    cost_category      VARCHAR(100) NOT NULL,   -- materials, labor, subcontractor, etc.
    cost_amount        DECIMAL(12,2) NOT NULL,
    cost_date          DATE NOT NULL,
    ahu_id             INT,
    zone_id            INT,
    notes              VARCHAR(255)
);
