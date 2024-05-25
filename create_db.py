import sqlite3

# Connect to SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect('smart_city.db')

# Create a cursor object
cur = conn.cursor()

# SQL statements
sql_statements = [
    '''
    CREATE TABLE station (
        station_id INTEGER PRIMARY KEY,
        station_name VARCHAR(255),
        station_latitude FLOAT,
        station_longitude FLOAT
    );
    ''',
    '''
    CREATE TABLE transportation (
        transportation_id INTEGER PRIMARY KEY,
        transportation_name VARCHAR(255),
        transportation_plaque VARCHAR(255),
        station_id INTEGER,
        transportation_latitude FLOAT,
        transportation_longitude FLOAT,
        FOREIGN KEY (station_id) REFERENCES station(station_id)
    );
    ''',
    '''
    CREATE TABLE park (
        park_id INTEGER PRIMARY KEY,
        park_name VARCHAR(255),
        station_id INTEGER,
        park_full INTEGER,
        FOREIGN KEY (station_id) REFERENCES station(station_id)
    );
    ''',
    '''
    CREATE TABLE traffic (
        traffic_id INTEGER PRIMARY KEY,
        crowd_situation FLOAT,
        station_id INTEGER,
        FOREIGN KEY (station_id) REFERENCES station(station_id)
    );
    ''',
    '''
    CREATE TABLE weather (
        weather_id INTEGER PRIMARY KEY,
        weather_day INTEGER,
        weather_type_id INTEGER,
        weather_location VARCHAR(255),
        FOREIGN KEY (weather_type_id) REFERENCES weather_type(weather_type_id)
    );
    ''',
    '''
    CREATE TABLE weather_type (
        weather_type_id INTEGER PRIMARY KEY,
        weather_type VARCHAR(255),
        weather_type_temperature INTEGER,
        work_time_id INTEGER,
        FOREIGN KEY (work_time_id) REFERENCES work_time(work_time_id)
    );
    ''',
    '''
    CREATE TABLE pharmacy (
        pharmacy_id INTEGER PRIMARY KEY,
        work_time_id INTEGER,
        pharmacy_name VARCHAR(255),
        pharmacy_location VARCHAR(255),
        pharmacy_on_duty BOOLEAN,
        FOREIGN KEY (work_time_id) REFERENCES work_time(work_time_id)
    );
    ''',
    '''
    CREATE TABLE work_time (
        work_time_id INTEGER PRIMARY KEY,
        work_time_start DATE,
        work_time_end DATE
    );
    ''',
    '''
    CREATE TABLE event (
        event_id INTEGER PRIMARY KEY,
        work_time_id INTEGER,
        event_photo VARCHAR(255),
        event_name VARCHAR(255),
        event_location VARCHAR(255),
        event_is_liked BOOLEAN,
        FOREIGN KEY (work_time_id) REFERENCES work_time(work_time_id)
    );
    ''',
    '''
    CREATE TABLE request (
        request_id INTEGER PRIMARY KEY,
        request_type_id INTEGER,
        comment VARCHAR(255),
        FOREIGN KEY (request_type_id) REFERENCES request_type(request_type_id)
    );
    ''',
    '''
    CREATE TABLE request_type (
        request_type_id INTEGER PRIMARY KEY,
        request_type VARCHAR(255)
    );
    ''',
     "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Station A', 40.7128, -74.0060);",
    "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Station B', 34.0522, -118.2437);",
    "INSERT INTO transportation (transportation_name, transportation_plaque, station_id, transportation_latitude, transportation_longitude) VALUES ('Bus 1', 'ABC123', 1, 40.7128, -74.0060);",
    "INSERT INTO transportation (transportation_name, transportation_plaque, station_id, transportation_latitude, transportation_longitude) VALUES ('Bus 2', 'XYZ456', 2, 34.0522, -118.2437);",
    "INSERT INTO park (park_name, station_id, park_full) VALUES ('Park X', 1, 0);",
    "INSERT INTO park (park_name, station_id, park_full) VALUES ('Park Y', 2, 1);",
    "INSERT INTO traffic (crowd_situation, station_id) VALUES (0.5, 1);",
    "INSERT INTO traffic (crowd_situation, station_id) VALUES (0.8, 2);",
    "INSERT INTO weather (weather_day, weather_type_id, weather_location) VALUES (20240525, 1, 'New York');",
    "INSERT INTO weather (weather_day, weather_type_id, weather_location) VALUES (20240526, 2, 'Los Angeles');",
    "INSERT INTO weather_type (weather_type, weather_type_temperature, work_time_id) VALUES ('Sunny', 30, 1);",
    "INSERT INTO weather_type (weather_type, weather_type_temperature, work_time_id) VALUES ('Rainy', 20, 2);",
    "INSERT INTO pharmacy (work_time_id, pharmacy_name, pharmacy_location, pharmacy_on_duty) VALUES (1, 'Pharmacy 1', 'New York', 1);",
    "INSERT INTO pharmacy (work_time_id, pharmacy_name, pharmacy_location, pharmacy_on_duty) VALUES (2, 'Pharmacy 2', 'Los Angeles', 0);",
    "INSERT INTO work_time (work_time_start, work_time_end) VALUES ('2024-05-25 08:00:00', '2024-05-26 17:00:00');",
    "INSERT INTO work_time (work_time_start, work_time_end) VALUES ('2024-05-26 09:00:00', '2024-05-27 18:00:00');",
    "INSERT INTO event (work_time_id, event_photo, event_name, event_location, event_is_liked) VALUES (1, 'event1.jpg', 'Event 1', 'New York', 1);",
    "INSERT INTO event (work_time_id, event_photo, event_name, event_location, event_is_liked) VALUES (2, 'event2.jpg', 'Event 2', 'Los Angeles', 0);",
    "INSERT INTO request (request_type_id, comment) VALUES (1, 'Request 1 comment');",
    "INSERT INTO request (request_type_id, comment) VALUES (2, 'Request 2 comment');",
    "INSERT INTO request_type (request_type) VALUES ('Type 1');",
    "INSERT INTO request_type (request_type) VALUES ('Type 2');"
]

# Execute SQL statements
for statement in sql_statements:
    cur.execute(statement)

# Commit changes
conn.commit()

# Close connection
conn.close()

print("Database and tables created successfully.")