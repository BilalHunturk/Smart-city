from flask import Flask, request, jsonify
from models import db, Station, Transportation, Park, Traffic, Weather, WeatherType, Pharmacy, WorkTime, Event, Request, RequestType
from datetime import datetime
from flask import abort

# Initialize Flask app and SQLAlchemy
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///smart_city.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

# Route to initialize the database
@app.route('/init_db')
def init_db():
    db.create_all()
    return "Database initialized!"

@app.route('/')
def index():
    return "Welcome to the Flask API!"

# Example route for adding a station
@app.route('/station', methods=['POST'])
def add_station():
    data = request.get_json()
    new_station = Station(
        station_name=data['station_name'],
        station_latitude=data['station_latitude'],
        station_longitude=data['station_longitude']
    )
    db.session.add(new_station)
    db.session.commit()
    return jsonify({'message': 'Station added successfully'}), 201

# Example route for retrieving stations
@app.route('/stations', methods=['GET'])
def get_stations():
    stations = Station.query.all()
    result = [
        {
            'station_id': station.station_id,
            'station_name': station.station_name,
            'station_latitude': station.station_latitude,
            'station_longitude': station.station_longitude
        } for station in stations
    ]
    return jsonify(result), 200


@app.route('/transportation', methods=['POST'])
def add_transportation():
    data = request.get_json()
    new_transportation = Transportation(
        transportation_name=data['transportation_name'],
        transportation_plaque=data['transportation_plaque'],
        station_id=data['station_id'],
        transportation_latitude=data['transportation_latitude'],
        transportation_longitude=data['transportation_longitude']
    )
    db.session.add(new_transportation)
    db.session.commit()
    return jsonify({'message': 'Transportation added successfully'}), 201


# Example route for retrieving transportation
@app.route('/transportations', methods=['GET'])
def get_transportations():
    transportations = Transportation.query.all()
    result = [
        {
            'transportation_id': transportation.transportation_id,
            'transportation_name': transportation.transportation_name,
            'transportation_plaque': transportation.transportation_plaque,
            'station_id': transportation.station_id,
            'transportation_latitude': transportation.transportation_latitude,
            'transportation_longitude': transportation.transportation_longitude
        } for transportation in transportations
    ]
    return jsonify(result), 200

@app.route('/park', methods=['POST'])
def add_park():
    data = request.get_json()
    new_park = Park(
        park_name=data['park_name'],
        station_id=data['station_id'],
        park_full=data['park_full']
    )
    db.session.add(new_park)
    db.session.commit()
    return jsonify({'message': 'Park added successfully'}), 201

# Example route for retrieving parks
@app.route('/parks', methods=['GET'])
def get_parks():
    parks = Park.query.all()
    result = [
        {
            'park_id': park.park_id,
            'park_name': park.park_name,
            'station_id': park.station_id,
            'park_full': park.park_full
        } for park in parks
    ]
    return jsonify(result), 200

# Example route for adding traffic
@app.route('/traffic', methods=['POST'])
def add_traffic():
    data = request.get_json()
    new_traffic = Traffic(
        crowd_situation=data['crowd_situation'],
        station_id=data['station_id']
    )
    db.session.add(new_traffic)
    db.session.commit()
    return jsonify({'message': 'Traffic information added successfully'}), 201

# Example route for retrieving traffic information
@app.route('/traffic', methods=['GET'])
def get_traffic():
    traffic = Traffic.query.all()
    result = [
        {
            'traffic_id': item.traffic_id,
            'crowd_situation': item.crowd_situation,
            'station_id': item.station_id
        } for item in traffic
    ]
    return jsonify(result), 200

@app.route('/weather', methods=['POST'])
def add_weather():
    data = request.get_json()
    new_weather = Weather(
        weather_day=data['weather_day'],
        weather_type_id=data['weather_type_id'],
        weather_location=data['weather_location']
    )
    db.session.add(new_weather)
    db.session.commit()
    return jsonify({'message': 'Weather information added successfully'}), 201

# Example route for retrieving weather information
@app.route('/weather', methods=['GET'])
def get_weather():
    weather = Weather.query.all()
    result = [
        {
            'weather_id': item.weather_id,
            'weather_day': item.weather_day,
            'weather_type_id': item.weather_type_id,
            'weather_location': item.weather_location
        } for item in weather
    ]
    return jsonify(result), 200

# Example route for adding pharmacy
@app.route('/pharmacy', methods=['POST'])
def add_pharmacy():
    data = request.get_json()
    new_pharmacy = Pharmacy(
        work_time_id=data['work_time_id'],
        pharmacy_name=data['pharmacy_name'],
        pharmacy_location=data['pharmacy_location'],
        pharmacy_on_duty=data['pharmacy_on_duty']
    )
    db.session.add(new_pharmacy)
    db.session.commit()
    return jsonify({'message': 'Pharmacy information added successfully'}), 201

# Example route for retrieving pharmacy information
@app.route('/pharmacy', methods=['GET'])
def get_pharmacy():
    pharmacy = Pharmacy.query.all()
    result = [
        {
            'pharmacy_id': item.pharmacy_id,
            'work_time_id': item.work_time_id,
            'pharmacy_name': item.pharmacy_name,
            'pharmacy_location': item.pharmacy_location,
            'pharmacy_on_duty': item.pharmacy_on_duty
        } for item in pharmacy
    ]
    return jsonify(result), 200

# Example route for adding weather type
@app.route('/weather_type', methods=['POST'])
def add_weather_type():
    data = request.get_json()
    new_weather_type = WeatherType(
        weather_type=data['weather_type'],
        weather_type_temperature=data['weather_type_temperature'],
        work_time_id=data['work_time_id']
    )
    db.session.add(new_weather_type)
    db.session.commit()
    return jsonify({'message': 'Weather type information added successfully'}), 201

# Example route for retrieving weather type information
@app.route('/weather_type', methods=['GET'])
def get_weather_type():
    weather_types = WeatherType.query.all()
    result = [
        {
            'weather_type_id': item.weather_type_id,
            'weather_type': item.weather_type,
            'weather_type_temperature': item.weather_type_temperature,
            'work_time_id': item.work_time_id
        } for item in weather_types
    ]
    return jsonify(result), 200

@app.route('/weather_type/<int:weather_type_id>', methods=['GET'])
def get_weather_type_by_id(weather_type_id):
    weather_type = WeatherType.query.get(weather_type_id)
    return jsonify({
        'weather_type_id': weather_type.weather_type_id,
        'weather_type': weather_type.weather_type,
        'weather_type_temperature': weather_type.weather_type_temperature,
        'work_time_id': weather_type.work_time_id
    }), 200

@app.route('/work_time', methods=['POST'])
def add_work_time():
    data = request.get_json()
    work_time_start = datetime.strptime(data['work_time_start'], '%Y-%m-%d %H:%M:%S')
    work_time_end = datetime.strptime(data['work_time_end'], '%Y-%m-%d %H:%M:%S')
    new_work_time = WorkTime(
        work_time_start=work_time_start,
        work_time_end=work_time_end
    )
    db.session.add(new_work_time)
    db.session.commit()
    return jsonify({'message': 'Work time information added successfully'}), 201


# Example route for retrieving work time information
@app.route('/work_time', methods=['GET'])
def get_work_time():
    work_times = WorkTime.query.all()
    result = [
        {
            'work_time_id': item.work_time_id,
            'work_time_start': str(item.work_time_start),
            'work_time_end': str(item.work_time_end)
        } for item in work_times
    ]
    return jsonify(result), 200

@app.route('/work_time/<int:work_time_id>', methods=['GET'])
def get_work_time_by_id(work_time_id):
    work_time = WorkTime.query.get(work_time_id)
    if not work_time:
        abort(404, description="WorkTime not found")
    return jsonify({
        'work_time_id': work_time.work_time_id,
        'work_time_start': work_time.work_time_start.strftime('%Y-%m-%d %H:%M:%S'),
        'work_time_end': work_time.work_time_end.strftime('%Y-%m-%d %H:%M:%S')
    }), 200

@app.route('/event', methods=['POST'])
def add_event():
    data = request.get_json()
    new_event = Event(
        work_time_id=data['work_time_id'],
        event_photo=data['event_photo'],
        event_name=data['event_name'],
        event_location=data['event_location'],
        event_is_liked=data['event_is_liked']
    )
    db.session.add(new_event)
    db.session.commit()
    return jsonify({'message': 'Event information added successfully'}), 201

# Example route for retrieving event information
@app.route('/event', methods=['GET'])
def get_event():
    events = Event.query.all()
    result = [
        {
            'event_id': item.event_id,
            'work_time_id': item.work_time_id,
            'event_photo': item.event_photo,
            'event_name': item.event_name,
            'event_location': item.event_location,
            'event_is_liked': item.event_is_liked
        } for item in events
    ]
    return jsonify(result), 200

# Example route for adding request
@app.route('/request', methods=['POST'])
def add_request():
    data = request.get_json()
    new_request = Request(
        request_type_id=data['request_type_id'],
        comment=data['comment']
    )
    db.session.add(new_request)
    db.session.commit()
    return jsonify({'message': 'Request information added successfully'}), 201

# Example route for retrieving request information
@app.route('/request', methods=['GET'])
def get_request():
    requests = Request.query.all()
    result = [
        {
            'request_id': item.request_id,
            'request_type_id': item.request_type_id,
            'comment': item.comment
        } for item in requests
    ]
    return jsonify(result), 200

# Example route for adding request type
@app.route('/request_type', methods=['POST'])
def add_request_type():
    data = request.get_json()
    new_request_type = RequestType(
        request_type=data['request_type']
    )
    db.session.add(new_request_type)
    db.session.commit()
    return jsonify({'message': 'Request type added successfully'}), 201

# Example route for retrieving request types
@app.route('/request_types', methods=['GET'])
def get_request_types():
    request_types = RequestType.query.all()
    result = [
        {
            'request_type_id': request_type.request_type_id,
            'request_type': request_type.request_type
        } for request_type in request_types
    ]
    return jsonify(result), 200

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
