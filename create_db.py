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
        transportation_latitude FLOAT,
        transportation_longitude FLOAT,
        station_ids TEXT
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
        station_ids TEXT,
        FOREIGN KEY (station_id) REFERENCES station(station_id)
    );
    ''',
    '''
    CREATE TABLE weather (
        weather_id INTEGER PRIMARY KEY,
        weather_day INTEGER,
        weather_detail_id INTEGER,
        weather_location VARCHAR(255),
        FOREIGN KEY (weather_detail_id) REFERENCES weather_detail(weather_detail_id)
    );
    ''',
    '''
    CREATE TABLE weather_detail (
        weather_detail_id INTEGER PRIMARY KEY,
        weather_detail_type VARCHAR(255),
        weather_detail_temperature INTEGER,
        weather_detail_time DATE
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
     "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Station A', 41.332274, 36.285737);",
    "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Station B', 41.315229, 36.317191);",
    "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Station C', 41.331956, 36.269735);",
    "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Station D', 41.383577, 36.211915);",
    "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Station E', 41.383577, 36.211915);",
    "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Station F', 41.335498, 36.229937);",
    "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Park 1', 41.324861, 36.264752);",
    "INSERT INTO station (station_name, station_latitude, station_longitude) VALUES ('Park 2', 41.345429, 36.231139);",
    '''INSERT INTO transportation (transportation_name, transportation_plaque, transportation_latitude, transportation_longitude, station_ids) VALUES ('Bus 1', 'ABC123', 12.6234, -13.0060, '["1", "2"]')''',
    '''INSERT INTO transportation (transportation_name, transportation_plaque, transportation_latitude, transportation_longitude, station_ids) VALUES ('Bus 2', 'DEF456', 40.7128, -74.0060, '["3","4"]')''',
    "INSERT INTO park (park_name, station_id, park_full) VALUES ('Park X', 7, 0);",
    "INSERT INTO park (park_name, station_id, park_full) VALUES ('Park Y', 8, 1);",
    '''INSERT INTO traffic (crowd_situation, station_id, station_ids) VALUES (0.5, 1,'["3","4"]')''',
    '''INSERT INTO traffic (crowd_situation, station_id, station_ids) VALUES (0.8, 2,'["5","6"]')''',
    "INSERT INTO weather (weather_day, weather_detail_id, weather_location) VALUES ('2024-05-25', 1, 'New York');",
    "INSERT INTO weather (weather_day, weather_detail_id, weather_location) VALUES ('2024-05-26', 3, 'New York');",
    "INSERT INTO weather (weather_day, weather_detail_id, weather_location) VALUES ('2024-05-27', 2, 'New York');",
    "INSERT INTO weather (weather_day, weather_detail_id, weather_location) VALUES ('2024-05-28', 4, 'New York');",
    "INSERT INTO weather (weather_day, weather_detail_id, weather_location) VALUES ('2024-05-29', 5, 'New York');",
    "INSERT INTO weather (weather_day, weather_detail_id, weather_location) VALUES ('2024-05-30', 6, 'New York');",
    "INSERT INTO weather (weather_day, weather_detail_id, weather_location) VALUES ('2024-05-31', 1, 'New York');",
    "INSERT INTO weather_detail (weather_detail_id, weather_detail_type, weather_detail_temperature, weather_detail_time) VALUES (1,'Partly cloudy', 25, '2024-05-29 12:00:00');",
    "INSERT INTO weather_detail (weather_detail_id, weather_detail_type, weather_detail_temperature, weather_detail_time) VALUES (2,'Sunny', 32, '2024-05-29 13:00:00');",
    "INSERT INTO weather_detail (weather_detail_id, weather_detail_type, weather_detail_temperature, weather_detail_time) VALUES (3,'Rainy', 24, '2024-05-29 12:00:00');",
    "INSERT INTO weather_detail (weather_detail_id, weather_detail_type, weather_detail_temperature, weather_detail_time) VALUES (4,'Thund', 27, '2024-05-29 13:00:00');",
    "INSERT INTO weather_detail (weather_detail_id, weather_detail_type, weather_detail_temperature, weather_detail_time) VALUES (5,'Sunny', 33, '2024-05-29 12:00:00');",
    "INSERT INTO weather_detail (weather_detail_id, weather_detail_type, weather_detail_temperature, weather_detail_time) VALUES (6,'Cloudy', 31, '2024-05-29 13:00:00');",
    "INSERT INTO pharmacy (pharmacy_id,work_time_id, pharmacy_name, pharmacy_location, pharmacy_on_duty) VALUES (1,1, 'Pharmacy 1', 'New York', 1);",
    "INSERT INTO pharmacy (pharmacy_id,work_time_id, pharmacy_name, pharmacy_location, pharmacy_on_duty) VALUES (2,2, 'Pharmacy 2', 'Los Angeles', 0);",
    "INSERT INTO work_time (work_time_start, work_time_end) VALUES ('2024-05-25 08:00:00', '2024-05-26 17:00:00');",
    "INSERT INTO work_time (work_time_start, work_time_end) VALUES ('2024-05-26 09:00:00', '2024-05-27 18:00:00');",
    "INSERT INTO work_time (work_time_start, work_time_end) VALUES ('2024-05-27 09:00:00', '2024-05-30 18:00:00');",
    "INSERT INTO work_time (work_time_start, work_time_end) VALUES ('2024-06-15 09:00:00', '2024-06-25 15:00:00');",
    "INSERT INTO event (work_time_id, event_photo, event_name, event_location, event_is_liked) VALUES (1, 'https://www.kibrisrentacar.com/wp-content/uploads/k%C4%B1br%C4%B1s-gece-hayati-resim.jpg', 'Event 1', 'New York', 1);",
    "INSERT INTO event (work_time_id, event_photo, event_name, event_location, event_is_liked) VALUES (2, 'https://www.momondo.com.tr/discover/wp-content/uploads/sites/294/2018/12/6c8dbf68-6779-3fdf-96e8-b79f84afb20e.jpg', 'Event 2', 'Los Angeles', 0);",
    "INSERT INTO event (work_time_id, event_photo, event_name, event_location, event_is_liked) VALUES (3, 'https://eurodrivecyprus.com/storage/posts/December2023/kibrista-yapilacak-aktiviteler.webp', 'Event 3', 'Los Angeles', 0);",
    "INSERT INTO event (work_time_id, event_photo, event_name, event_location, event_is_liked) VALUES (4, 'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ydhn1QPAKsrbt6UWfn3YnA.jpeg', 'Event 4', 'Los Angeles', 0);",
    "INSERT INTO event (work_time_id, event_photo, event_name, event_location, event_is_liked) VALUES (1, 'https://groupgordon.com/wp-content/uploads/2022/04/Messe_Luzern_Corporate_Event.jpg', 'Event 5', 'Los Angeles', 0);",
    "INSERT INTO event (work_time_id, event_photo, event_name, event_location, event_is_liked) VALUES (2, 'https://content.jdmagicbox.com/comp/ernakulam/m4/0484px484.x484.140206113128.a9m4/catalogue/we-create-events-panampilly-nagar-ernakulam-event-management-companies-nsobpzm660.jpg', 'Event 6', 'Los Angeles', 0);",
    "INSERT INTO request (request_type_id, comment) VALUES (1, 'Request 1 comment');",
    "INSERT INTO request (request_type_id, comment) VALUES (2, 'Request 2 comment');",
    "INSERT INTO request_type (request_type) VALUES ('Type 1');",
    "INSERT INTO request_type (request_type) VALUES ('Type 2');"
]

# Execute SQL statements
a = 0
for statement in sql_statements:
    cur.execute(statement)
    print(a)
    a+=1

# Commit changes
conn.commit()

# Close connection
conn.close()

print("Database and tables created successfully.")