-- Drop existing tables if they exist
-- DROP TABLE IF EXISTS spacecraft CASCADE;
-- DROP TABLE IF EXISTS moon CASCADE;
-- DROP TABLE IF EXISTS planet CASCADE;
-- DROP TABLE IF EXISTS star CASCADE;
-- DROP TABLE IF EXISTS galaxy CASCADE;

create database universe owner freecodecamp;

\c universe
-- Create the galaxy table
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    description TEXT,
    distance_from_earth INT NOT NULL,
    has_life BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    number_of_stars BIGINT,  -- Changed to BIGINT for larger values
    age_in_millions_of_years NUMERIC
);

-- Insert data into galaxy table
INSERT INTO galaxy (name, description, distance_from_earth, has_life, is_spherical, number_of_stars, age_in_millions_of_years)
VALUES 
    ('Milky Way', 'Our home galaxy', 0, TRUE, TRUE, 100000000000, 13600),
    ('Andromeda', 'Closest spiral galaxy to the Milky Way', 2537000, FALSE, TRUE, 1000000000000, 10000),
    ('Triangulum', 'A smaller nearby galaxy', 3000000, FALSE, TRUE, 40000000, 9000),
    ('Whirlpool', 'Famous spiral galaxy with companion', 23000000, FALSE, TRUE, 160000000000, 15000),
    ('Sombrero', 'Bright, large galaxy', 31000000, FALSE, TRUE, 80000000000, 11000),
    ('Messier 81', 'A galaxy similar to the Milky Way', 12000000, FALSE, TRUE, 250000000000, 13000);

-- Create the star table
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    age_in_millions_of_years INT NOT NULL,
    galaxy_id INT REFERENCES galaxy(galaxy_id),
    is_bright BOOLEAN NOT NULL,
    star_type VARCHAR,
    luminosity NUMERIC,
    mass NUMERIC
);

-- Insert data into star table
INSERT INTO star (name, age_in_millions_of_years, galaxy_id, is_bright, star_type, luminosity, mass)
VALUES 
    ('Sun', 4500, 1, TRUE, 'G-type', 1, 1),
    ('Proxima Centauri', 4700, 2, TRUE, 'M-type', 0.0017, 0.123),
    ('Betelgeuse', 10000, 1, TRUE, 'Red supergiant', 14000, 20),
    ('Rigel', 8600, 3, TRUE, 'Blue supergiant', 120000, 21),
    ('Vega', 455, 1, TRUE, 'A-type', 37, 2.1),
    ('Sirius', 200, 1, TRUE, 'A-type', 25, 2.0);

-- Create the planet table
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    distance_from_star NUMERIC NOT NULL,
    has_life BOOLEAN NOT NULL,
    is_habitable BOOLEAN,
    star_id INT REFERENCES star(star_id),
    radius INT,
    orbital_period INT
);

-- Insert data into planet table
INSERT INTO planet (name, distance_from_star, has_life, is_habitable, star_id, radius, orbital_period)
VALUES 
    ('Earth', 1.0, TRUE, TRUE, 1, 6371, 365),
    ('Mars', 1.52, FALSE, FALSE, 1, 3389, 687),
    ('Jupiter', 5.2, FALSE, FALSE, 1, 69911, 4333),
    ('Proxima b', 0.05, FALSE, FALSE, 2, 7143, 11),
    ('Kepler-452b', 1.046, FALSE, FALSE, 4, 8586, 385),
    ('GJ 504b', 43.5, FALSE, FALSE, 3, 71500, 14300),
    ('Neptune', 30.1, FALSE, FALSE, 1, 24622, 60190),
    ('Venus', 0.72, FALSE, FALSE, 1, 6052, 225),
    ('Saturn', 9.58, FALSE, FALSE, 1, 58232, 10759),
    ('Alpha Centauri Bb', 0.04, FALSE, FALSE, 2, 1.1, 3.24),
    ('Gliese 581d', 0.22, FALSE, FALSE, 4, 7271, 67),
    ('PSR B1257+12 A', 0.19, FALSE, FALSE, 5, 192, 25);

-- Create the moon table
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    size_in_km NUMERIC NOT NULL,
    is_visible BOOLEAN NOT NULL,
    planet_id INT REFERENCES planet(planet_id),
    crater_count INT,
    rotation_period NUMERIC
);

-- Insert data into moon table
INSERT INTO moon (name, size_in_km, is_visible, planet_id, crater_count, rotation_period)
VALUES 
    ('Moon', 3474.2, TRUE, 1, 5000, 27),
    ('Phobos', 22.4, TRUE, 2, 1000, 0.3),
    ('Deimos', 12.4, TRUE, 2, 500, 1.26),
    ('Europa', 3121.6, FALSE, 3, 100, 85),
    ('Io', 3643.2, FALSE, 3, 1000, 42),
    ('Ganymede', 5262.4, FALSE, 3, 500, 171),
    ('Titan', 5149.5, FALSE, 9, 1500, 16),
    ('Enceladus', 504.2, FALSE, 9, 400, 2),
    ('Mimas', 396.4, FALSE, 9, 150, 23),
    ('Callisto', 4820.6, TRUE, 3, 100, 16),
    ('Oberon', 1523.4, FALSE, 7, 200, 13),
    ('Triton', 2706.8, TRUE, 7, 300, 6),
    ('Charon', 1207.4, TRUE, 9, 0, 6),
    ('Miranda', 471.6, FALSE, 7, 100, 10),
    ('Ariel', 1157.8, TRUE, 7, 150, 6),
    ('Umbriel', 1169.4, FALSE, 7, 200, 13),
    ('Tethys', 1071.6, FALSE, 9, 50, 16),
    ('Dione', 1122.4, TRUE, 9, 100, 23),
    ('Iapetus', 1469.6, TRUE, 9, 500, 30),
    ('Rhea', 1528.4, TRUE, 9, 400, 36);

-- Create the spacecraft table (optional)
CREATE TABLE spacecraft (
    spacecraft_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE,
    capacity INT,
    is_operational BOOLEAN NOT NULL,
    planet_id INT REFERENCES planet(planet_id),
    mission_duration INT,
    crew_capacity INT
);

-- Insert data into spacecraft table (optional)
INSERT INTO spacecraft (name, capacity, is_operational, planet_id, mission_duration, crew_capacity)
VALUES 
    ('Apollo 11', 3, TRUE, 1, 8, 3),
    ('Mars Rover', 2, TRUE, 2, 0, 5),
    ('Voyager 1', 1, TRUE, 3, 40, 1);
