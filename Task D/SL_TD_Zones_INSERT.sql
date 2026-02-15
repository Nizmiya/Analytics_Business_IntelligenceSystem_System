-- Task D: INSERT template for SLTDA Tourism Development Zones
-- Database: SL_TD_Zones_2025
-- Replace latitude, longitude with your Google Earth coordinates
-- ST_MakePoint(longitude, latitude) - ORDER IS LON, LAT!
-- Data source: https://sltda.gov.lk/

-- Run after: CREATE TABLE tourism_zones (...); and CREATE EXTENSION postgis;

-- Colombo & Greater Colombo
INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Negombo', 'Gampaha', 'Colombo & Greater Colombo', 7.2088, 79.8358, ST_SetSRID(ST_MakePoint(79.8358, 7.2088), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Colombo', 'Colombo', 'Colombo & Greater Colombo', 6.9271, 79.8612, ST_SetSRID(ST_MakePoint(79.8612, 6.9271), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Mount Lavinia', 'Colombo', 'Colombo & Greater Colombo', 6.8381, 79.8632, ST_SetSRID(ST_MakePoint(79.8632, 6.8381), 4326));

-- South Coast
INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Wadduwa', 'Kalutara', 'South Coast', 6.6500, 79.9333, ST_SetSRID(ST_MakePoint(79.9333, 6.6500), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Kalutara', 'Kalutara', 'South Coast', 6.5833, 79.9667, ST_SetSRID(ST_MakePoint(79.9667, 6.5833), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Beruwala', 'Kalutara', 'South Coast', 6.4667, 79.9833, ST_SetSRID(ST_MakePoint(79.9833, 6.4667), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Bentota', 'Galle', 'South Coast', 6.4167, 79.9833, ST_SetSRID(ST_MakePoint(79.9833, 6.4167), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Balapitiya', 'Galle', 'South Coast', 6.2667, 80.0667, ST_SetSRID(ST_MakePoint(80.0667, 6.2667), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Ahungalla', 'Galle', 'South Coast', 6.3333, 80.0500, ST_SetSRID(ST_MakePoint(80.0500, 6.3333), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Hikkaduwa', 'Galle', 'South Coast', 6.1333, 80.1000, ST_SetSRID(ST_MakePoint(80.1000, 6.1333), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Galle', 'Galle', 'South Coast', 6.0531, 80.2110, ST_SetSRID(ST_MakePoint(80.2110, 6.0531), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Unawatuna', 'Galle', 'South Coast', 6.0167, 80.2500, ST_SetSRID(ST_MakePoint(80.2500, 6.0167), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Koggala', 'Galle', 'South Coast', 5.9833, 80.3333, ST_SetSRID(ST_MakePoint(80.3333, 5.9833), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Weligama', 'Matara', 'South Coast', 5.9667, 80.4167, ST_SetSRID(ST_MakePoint(80.4167, 5.9667), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Mirissa', 'Matara', 'South Coast', 5.9500, 80.4667, ST_SetSRID(ST_MakePoint(80.4667, 5.9500), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Matara', 'Matara', 'South Coast', 5.9495, 80.5492, ST_SetSRID(ST_MakePoint(80.5492, 5.9495), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Tangalle', 'Hambantota', 'South Coast', 6.0167, 80.8000, ST_SetSRID(ST_MakePoint(80.8000, 6.0167), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Hambantota', 'Hambantota', 'South Coast', 6.1167, 81.1167, ST_SetSRID(ST_MakePoint(81.1167, 6.1167), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Tissamaharama', 'Hambantota', 'South Coast', 6.2833, 81.2833, ST_SetSRID(ST_MakePoint(81.2833, 6.2833), 4326));

-- East Coast
INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Arugambay', 'Ampara', 'East Coast', 6.8500, 81.8500, ST_SetSRID(ST_MakePoint(81.8500, 6.8500), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Pasikudah', 'Batticaloa', 'East Coast', 7.9167, 81.5667, ST_SetSRID(ST_MakePoint(81.5667, 7.9167), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Trincomalee', 'Trincomalee', 'East Coast', 8.5874, 81.2152, ST_SetSRID(ST_MakePoint(81.2152, 8.5874), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Nilaveli', 'Trincomalee', 'East Coast', 8.7000, 81.1667, ST_SetSRID(ST_MakePoint(81.1667, 8.7000), 4326));

-- West Coast
INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Kalpitiya', 'Puttalam', 'West Coast', 8.2333, 79.7667, ST_SetSRID(ST_MakePoint(79.7667, 8.2333), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Marawila', 'Gampaha', 'West Coast', 7.4167, 79.8333, ST_SetSRID(ST_MakePoint(79.8333, 7.4167), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Waikkala', 'Gampaha', 'West Coast', 7.2833, 79.8500, ST_SetSRID(ST_MakePoint(79.8500, 7.2833), 4326));

-- High Country
INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Nuwara Eliya', 'Nuwara Eliya', 'High Country', 6.9497, 80.7891, ST_SetSRID(ST_MakePoint(80.7891, 6.9497), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Bandarawela', 'Badulla', 'High Country', 6.8333, 80.9833, ST_SetSRID(ST_MakePoint(80.9833, 6.8333), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Maskeliya', 'Nuwara Eliya', 'High Country', 6.8667, 80.5833, ST_SetSRID(ST_MakePoint(80.5833, 6.8667), 4326));

-- Ancient Cities
INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Polonnaruwa', 'Polonnaruwa', 'Ancient Cities', 7.9333, 81.0000, ST_SetSRID(ST_MakePoint(81.0000, 7.9333), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Habarana', 'Anuradhapura', 'Ancient Cities', 8.0833, 80.7500, ST_SetSRID(ST_MakePoint(80.7500, 8.0833), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Sigiriya', 'Matale', 'Ancient Cities', 7.9569, 80.7600, ST_SetSRID(ST_MakePoint(80.7600, 7.9569), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Giritale', 'Polonnaruwa', 'Ancient Cities', 7.9833, 80.9167, ST_SetSRID(ST_MakePoint(80.9167, 7.9833), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Anuradhapura', 'Anuradhapura', 'Ancient Cities', 8.3114, 80.4037, ST_SetSRID(ST_MakePoint(80.4037, 8.3114), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Dambulla', 'Matale', 'Ancient Cities', 7.8567, 80.6514, ST_SetSRID(ST_MakePoint(80.6514, 7.8567), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Kandy', 'Kandy', 'Ancient Cities', 7.2936, 80.6334, ST_SetSRID(ST_MakePoint(80.6334, 7.2936), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Matale', 'Matale', 'Ancient Cities', 7.4678, 80.6244, ST_SetSRID(ST_MakePoint(80.6244, 7.4678), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Victoria', 'Kandy', 'Ancient Cities', 7.2333, 80.7833, ST_SetSRID(ST_MakePoint(80.7833, 7.2333), 4326));

-- Other
INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Yala', 'Hambantota', 'Other', 6.3667, 81.5167, ST_SetSRID(ST_MakePoint(81.5167, 6.3667), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Udawalawa', 'Monaragala', 'Other', 6.4500, 80.8833, ST_SetSRID(ST_MakePoint(80.8833, 6.4500), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Wasgamuwa', 'Matale', 'Other', 7.7333, 80.9167, ST_SetSRID(ST_MakePoint(80.9167, 7.7333), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Pinnawala', 'Kegalle', 'Other', 7.3000, 80.3833, ST_SetSRID(ST_MakePoint(80.3833, 7.3000), 4326));

INSERT INTO tourism_zones (location_name, district_name, region, latitude, longitude, geom)
VALUES ('Ratnapura', 'Ratnapura', 'Other', 6.6847, 80.4036, ST_SetSRID(ST_MakePoint(80.4036, 6.6847), 4326));

-- Verify: SELECT id, location_name, district_name, region, latitude, longitude FROM tourism_zones ORDER BY id;
