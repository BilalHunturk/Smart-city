from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Station(db.Model):
    station_id = db.Column(db.Integer, primary_key=True)
    station_name = db.Column(db.String(255))
    station_latitude = db.Column(db.Float)
    station_longitude = db.Column(db.Float)

class Transportation(db.Model):
    transportation_id = db.Column(db.Integer, primary_key=True)
    transportation_name = db.Column(db.String(255))
    transportation_plaque = db.Column(db.String(255))
    station_id = db.Column(db.Integer, db.ForeignKey('station.station_id'))
    transportation_latitude = db.Column(db.Float)
    transportation_longitude = db.Column(db.Float)

class Park(db.Model):
    park_id = db.Column(db.Integer, primary_key=True)
    park_name = db.Column(db.String(255))
    station_id = db.Column(db.Integer, db.ForeignKey('station.station_id'))
    park_full = db.Column(db.Integer)

class Traffic(db.Model):
    traffic_id = db.Column(db.Integer, primary_key=True)
    crowd_situation = db.Column(db.Float)
    station_id = db.Column(db.Integer, db.ForeignKey('station.station_id'))

class WeatherDetail(db.Model):
    weather_detail_id = db.Column(db.Integer, primary_key=True)
    weather_detail_type = db.Column(db.String(255))
    weather_detail_temperature = db.Column(db.Integer)
    weather_detail_time = db.Column(db.DateTime)

class Weather(db.Model):
    weather_id = db.Column(db.Integer, primary_key=True)
    weather_day = db.Column(db.Integer)
    weather_detail_id = db.Column(db.Integer, db.ForeignKey('weather_detail.weather_detail_id'))
    weather_location = db.Column(db.String(255))
    weather_detail = db.relationship('WeatherDetail', backref=db.backref('weathers', lazy=True))


class Pharmacy(db.Model):
    pharmacy_id = db.Column(db.Integer, primary_key=True)
    work_time_id = db.Column(db.Integer, db.ForeignKey('work_time.work_time_id'))
    pharmacy_name = db.Column(db.String(255))
    pharmacy_location = db.Column(db.String(255))
    pharmacy_on_duty = db.Column(db.Boolean)
    work_time = db.relationship('WorkTime',backref=db.backref('pharmacies', lazy=True))

class WorkTime(db.Model):
    work_time_id = db.Column(db.Integer, primary_key=True)
    work_time_start = db.Column(db.DateTime)
    work_time_end = db.Column(db.DateTime)

class Event(db.Model):
    event_id = db.Column(db.Integer, primary_key=True)
    work_time_id = db.Column(db.Integer, db.ForeignKey('work_time.work_time_id'))
    event_photo = db.Column(db.String(255))
    event_name = db.Column(db.String(255))
    event_location = db.Column(db.String(255))
    event_is_liked = db.Column(db.Boolean)
    work_time = db.relationship('WorkTime',backref=db.backref('events', lazy=True))

class Request(db.Model):
    request_id = db.Column(db.Integer, primary_key=True)
    request_type_id = db.Column(db.Integer, db.ForeignKey('request_type.request_type_id'))
    comment = db.Column(db.String(255))

class RequestType(db.Model):
    request_type_id = db.Column(db.Integer, primary_key=True)
    request_type = db.Column(db.String(255))
