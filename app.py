from flask import Flask, request, jsonify
from models import WeatherDetail, db, Station, Transportation, Park, Traffic, Weather, Pharmacy, WorkTime, Event, Request, RequestType
from datetime import datetime
from flask import abort
import os

# Initialize Flask app and SQLAlchemy
app = Flask(__name__)
basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = f'sqlite:///{os.path.join(basedir, "smart_city.db")}'
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
    return jsonify({'message': 'Event added successfully'}), 201

@app.route('/events', methods=['GET'])
def get_all_events():
    events = Event.query.all()
    result = [
        {
            'event_id': event.event_id,
            'work_time_id': event.work_time_id,
            'event_photo': event.event_photo,
            'event_name': event.event_name,
            'event_location': event.event_location,
            'event_is_liked': event.event_is_liked,
            'work_time': {
                'work_time_id': event.work_time.work_time_id,
                'work_time_start': event.work_time.work_time_start.strftime('%Y-%m-%d %H:%M:%S'),
                'work_time_end': event.work_time.work_time_end.strftime('%Y-%m-%d %H:%M:%S')
            }
        } for event in events
    ]
    return jsonify(result), 200

@app.route('/event/<int:event_id>', methods=['GET'])
def get_event_by_id(event_id):
    event = Event.query.get(event_id)
    if not event:
        abort(404, description="Event not found")
    return jsonify({
        'event_id': event.event_id,
        'work_time_id': event.work_time_id,
        'event_photo': event.event_photo,
        'event_name': event.event_name,
        'event_location': event.event_location,
        'event_is_liked': event.event_is_liked,
        'work_time': {
            'work_time_id': event.work_time.work_time_id,
            'work_time_start': event.work_time.work_time_start.strftime('%Y-%m-%d %H:%M:%S'),
            'work_time_end': event.work_time.work_time_end.strftime('%Y-%m-%d %H:%M:%S')
        }
    }), 200

@app.route('/transportation', methods=['POST'])
def add_transportation():
    data = request.get_json()
    new_transportation = Transportation(
        transportation_name=data['transportation_name'],
        transportation_plaque=data['transportation_plaque'],
        station_ids=data['station_ids'],
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
    result = []
    for transportation in transportations:
        transportation_data = {
            'transportation_id': transportation.transportation_id,
            'transportation_name': transportation.transportation_name,
            'transportation_plaque': transportation.transportation_plaque,
            'transportation_latitude': transportation.transportation_latitude,
            'transportation_longitude': transportation.transportation_longitude,
            'stations': []
        }
        # Fetch the stations using the station IDs
        for station_id in transportation.station_ids:
            station = Station.query.get(station_id)
            if station:
                transportation_data['stations'].append({
                    'station_id': station.station_id,
                    'station_name': station.station_name,
                    'station_latitude': station.station_latitude,
                    'station_longitude': station.station_longitude
                })
        result.append(transportation_data)
    return jsonify(result), 200

@app.route('/park', methods=['POST'])
def add_park():
    data = request.get_json()
    new_park = Park(
        park_name=data['park_name'],
        station_id=data['station_id'],
        park_full=data['park_full'],
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
            'park_full': park.park_full,
            'station' : {
                'station_id':park.station.station_id,
                'station_name':park.station.station_name,
                'station_latitude':park.station.station_latitude,
                'station_longitude':park.station.station_longitude
            }
        } for park in parks
    ]
    return jsonify(result), 200

# Example route for adding traffic
@app.route('/traffic', methods=['POST'])
def add_traffic():
    data = request.get_json()
    new_traffic = Traffic(
        crowd_situation=data['crowd_situation'],
        station_id=data['station_id'],
    )
    db.session.add(new_traffic)
    db.session.commit()
    return jsonify({'message': 'Traffic information added successfully'}), 201

# Example route for retrieving traffic information
@app.route('/traffics', methods=['GET'])
def get_traffics():
    traffic = Traffic.query.all()
    result = [
        {
            'traffic_id': item.traffic_id,
            'crowd_situation': item.crowd_situation,
            'station_id': item.station_id,
            'station' : {
                'station_id':item.station.station_id,
                'station_name':item.station.station_name,
                'station_latitude':item.station.station_latitude,
                'station_longitude':item.station.station_longitude
            }
        } for item in traffic
    ]
    return jsonify(result), 200

@app.route('/weather', methods=['POST'])
def add_weather():
    data = request.get_json()
    new_weather = Weather(
        weather_day=data['weather_day'],
        weather_detail_id=data['weather_detail_id'],
        weather_location=data['weather_location']
    )
    db.session.add(new_weather)
    db.session.commit()
    return jsonify({'message': 'Weather added successfully'}), 201

@app.route('/weather/<int:weather_id>', methods=['GET'])
def get_weather_by_id(weather_id):
    weather = Weather.query.get(weather_id)
    if not weather:
        abort(404, description="Weather not found")
    return jsonify({
        'weather_id': weather.weather_id,
        'weather_day': weather.weather_day,
        'weather_detail_id': weather.weather_detail_id,
        'weather_location': weather.weather_location,
        'weather_detail': {
            'weather_detail_id': weather.weather_detail.weather_detail_id,
            'weather_detail_type': weather.weather_detail.weather_detail_type,
            'weather_detail_temperature': weather.weather_detail.weather_detail_temperature,
            'weather_detail_time': weather.weather_detail.weather_detail_time.strftime('%Y-%m-%d %H:%M:%S')
        }
    }), 20

@app.route('/weather', methods=['GET'])
def get_weather():
    weathers = Weather.query.all()
    if not weathers:
        abort(404, description="Weather not found")

    result = [
        {
            'weather_id': weather.weather_id,
            'weather_day': weather.weather_day,
            'weather_detail_id': weather.weather_detail_id,
            'weather_location': weather.weather_location,
            'weather_detail': {
                'weather_detail_id': weather.weather_detail.weather_detail_id,
                'weather_detail_type': weather.weather_detail.weather_detail_type,
                'weather_detail_temperature': weather.weather_detail.weather_detail_temperature,
                'weather_detail_time': weather.weather_detail.weather_detail_time.strftime('%Y-%m-%d %H:%M:%S')}
        }for weather in weathers
    ]
    
    return jsonify(result), 20

# Example route for adding weather type
@app.route('/weather_detail', methods=['POST'])
def add_weather_detail():
    data = request.get_json()
    weather_detail_time = datetime.strptime(data['weather_detail_time'], '%Y-%m-%d %H:%M:%S')
    new_weather_detail = WeatherDetail(
        weather_detail_type=data['weather_detail_type'],
        weather_detail_temperature=data['weather_detail_temperature'],
        weather_detail_time=weather_detail_time
    )
    db.session.add(new_weather_detail)
    db.session.commit()
    return jsonify({'message': 'WeatherDetail added successfully'}), 201

@app.route('/weather_detail/<int:weather_detail_id>', methods=['GET'])
def get_weather_detail_by_id(weather_detail_id):
    weather_detail = WeatherDetail.query.get(weather_detail_id)
    if not weather_detail:
        abort(404, description="WeatherDetail not found")
    return jsonify({
        'weather_detail_id': weather_detail.weather_detail_id,
        'weather_detail_type': weather_detail.weather_detail_type,
        'weather_detail_temperature': weather_detail.weather_detail_temperature,
        'weather_detail_time': weather_detail.weather_detail_time.strftime('%Y-%m-%d %H:%M:%S')
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

# @app.route('/event', methods=['POST'])
# def add_event():
#     data = request.get_json()
#     new_event = Event(
#         work_time_id=data['work_time_id'],
#         event_photo=data['event_photo'],
#         event_name=data['event_name'],
#         event_location=data['event_location'],
#         event_is_liked=data['event_is_liked']
#     )
#     db.session.add(new_event)
#     db.session.commit()
#     return jsonify({'message': 'Event information added successfully'}), 201

@app.route('/pharmacy', methods=['POST'])
def add_pharmacy():
    data = request.get_json()
    new_pharmacy = Pharmacy(
        pharmacy_name = data['pharmacy_name'],
        pharmacy_location = data['pharmacy_location'],
        pharmacy_on_duty = data['pharmacy_on_duty'],
        pharmacy_latitude =data['pharmacy_latitude'],
        pharmacy_longitude = data['pharmacy_longitude'],
        work_time_id = data['work_time_id']
    )
    db.session.add(new_pharmacy)
    db.session.commit()
    return jsonify({'message': 'Pharmacy information added successfully'}), 201

@app.route('/pharmacy/<int:pharmacy_id>', methods=['GET'])
def get_pharmacy_by_id(pharmacy_id):
    pharmacy = Pharmacy.query.get(pharmacy_id)
    if not pharmacy:
        abort(404, description="Pharmacy not found")
    return jsonify({
        'pharmacy_id': pharmacy.pharmacy_id,
        'work_time_id': pharmacy.work_time_id,
        'pharmacy_name': pharmacy.pharmacy_name,
        'pharmacy_location': pharmacy.pharmacy_location,
        'pharmacy_on_duty': pharmacy.pharmacy_on_duty,
        'work_time': {
            'work_time_id': pharmacy.work_time.work_time_id,
            'work_time_start': pharmacy.work_time.work_time_start.strftime('%Y-%m-%d %H:%M:%S'),
            'work_time_end': pharmacy.work_time.work_time_end.strftime('%Y-%m-%d %H:%M:%S')
        }
    }), 200

# Example route for retrieving event information
@app.route('/pharmacies', methods=['GET'])
def get_all_pharmacies():
    pharmacies = Pharmacy.query.all()
    result = [
        {
            'pharmacy_id': pharmacy.pharmacy_id,
            'work_time_id': pharmacy.work_time_id,
            'pharmacy_name': pharmacy.pharmacy_name,
            'pharmacy_location': pharmacy.pharmacy_location,
            'pharmacy_on_duty': pharmacy.pharmacy_on_duty,
            'work_time': {
                'work_time_id': pharmacy.work_time.work_time_id,
                'work_time_start': pharmacy.work_time.work_time_start.strftime('%Y-%m-%d %H:%M:%S'),
                'work_time_end': pharmacy.work_time.work_time_end.strftime('%Y-%m-%d %H:%M:%S')
            },
            'pharmacy_latitude':pharmacy.pharmacy_latitude,
            'pharmacy_longitude':pharmacy.pharmacy_longitude
        } for pharmacy in pharmacies
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
            'comment': item.comment,
            'request_type':{
                'request_type_id':item.request_type.request_type_id,
                'request_type':item.request_type.request_type
            }
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
