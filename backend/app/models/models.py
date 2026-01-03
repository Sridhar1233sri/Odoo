from sqlalchemy import Column, Integer, String, Float, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship
from datetime import datetime
from app.database import Base

class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    name = Column(String, nullable=False)
    password_hash = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    
    # Relationships
    trips = relationship("Trip", back_populates="user", cascade="all, delete-orphan")

class Trip(Base):
    __tablename__ = "trips"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    title = Column(String, nullable=False)
    description = Column(Text)
    start_date = Column(DateTime, nullable=False)
    end_date = Column(DateTime, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    user = relationship("User", back_populates="trips")
    stops = relationship("Stop", back_populates="trip", cascade="all, delete-orphan", order_by="Stop.order")

class Stop(Base):
    __tablename__ = "stops"
    
    id = Column(Integer, primary_key=True, index=True)
    trip_id = Column(Integer, ForeignKey("trips.id"), nullable=False)
    city_name = Column(String, nullable=False)
    country = Column(String, nullable=False)
    start_date = Column(DateTime, nullable=False)
    end_date = Column(DateTime, nullable=False)
    order = Column(Integer, nullable=False, default=0)
    created_at = Column(DateTime, default=datetime.utcnow)
    
    # Relationships
    trip = relationship("Trip", back_populates="stops")
    activities = relationship("Activity", back_populates="stop", cascade="all, delete-orphan")

class Activity(Base):
    __tablename__ = "activities"
    
    id = Column(Integer, primary_key=True, index=True)
    stop_id = Column(Integer, ForeignKey("stops.id"), nullable=False)
    name = Column(String, nullable=False)
    cost = Column(Float, nullable=False, default=0.0)
    duration = Column(Integer, nullable=True)  # duration in minutes
    category = Column(String, nullable=True)  # e.g., "food", "transport", "activity", "accommodation"
    created_at = Column(DateTime, default=datetime.utcnow)
    
    # Relationships
    stop = relationship("Stop", back_populates="activities")
