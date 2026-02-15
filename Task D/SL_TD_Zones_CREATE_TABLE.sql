-- Task D: Create database and tourism_zones table
-- Database: SL_TD_Zones_2025
-- Run in pgAdmin Query Tool (connected to postgres first, then create DB via GUI)

-- 1. Create database via pgAdmin GUI: Right-click Databases → Create → Database → Name: SL_TD_Zones_2025

-- 2. Connect to SL_TD_Zones_2025, then run:

CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE tourism_zones (
    id SERIAL PRIMARY KEY,
    location_name VARCHAR(100),
    district_name VARCHAR(50),
    region VARCHAR(80),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    geom GEOMETRY(Point, 4326)
);

CREATE INDEX idx_tourism_zones_geom ON tourism_zones USING GIST(geom);

COMMENT ON TABLE tourism_zones IS 'SLTDA Tourism Development Zones - https://sltda.gov.lk/';
