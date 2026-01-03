from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from app.database import get_db
from app.models import User, Trip, Stop, Activity
from app.schemas import (
    TripCreate, TripUpdate, TripResponse, TripListResponse,
    StopCreate, StopUpdate, StopResponse,
    ActivityCreate, ActivityUpdate, ActivityResponse,
    BudgetResponse
)
from app.utils.auth import get_current_user

router = APIRouter(prefix="/trips", tags=["Trips"])

# ============= Trip Endpoints =============
@router.post("", response_model=TripResponse, status_code=status.HTTP_201_CREATED)
def create_trip(
    trip_data: TripCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Create a new trip"""
    new_trip = Trip(
        user_id=current_user.id,
        title=trip_data.title,
        description=trip_data.description,
        start_date=trip_data.start_date,
        end_date=trip_data.end_date
    )
    
    db.add(new_trip)
    db.commit()
    db.refresh(new_trip)
    
    return new_trip

@router.get("", response_model=List[TripListResponse])
def get_my_trips(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get all trips for the current user"""
    trips = db.query(Trip).filter(Trip.user_id == current_user.id).all()
    return trips

@router.get("/{trip_id}", response_model=TripResponse)
def get_trip(
    trip_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Get a specific trip with all stops and activities"""
    trip = db.query(Trip).filter(
        Trip.id == trip_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not trip:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Trip not found"
        )
    
    return trip

@router.put("/{trip_id}", response_model=TripResponse)
def update_trip(
    trip_id: int,
    trip_data: TripUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Update a trip"""
    trip = db.query(Trip).filter(
        Trip.id == trip_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not trip:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Trip not found"
        )
    
    # Update fields
    update_data = trip_data.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(trip, field, value)
    
    db.commit()
    db.refresh(trip)
    
    return trip

@router.delete("/{trip_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_trip(
    trip_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Delete a trip"""
    trip = db.query(Trip).filter(
        Trip.id == trip_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not trip:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Trip not found"
        )
    
    db.delete(trip)
    db.commit()
    
    return None

# ============= Stop Endpoints =============
@router.post("/{trip_id}/stops", response_model=StopResponse, status_code=status.HTTP_201_CREATED)
def create_stop(
    trip_id: int,
    stop_data: StopCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Add a stop (city) to a trip"""
    # Verify trip ownership
    trip = db.query(Trip).filter(
        Trip.id == trip_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not trip:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Trip not found"
        )
    
    new_stop = Stop(
        trip_id=trip_id,
        city_name=stop_data.city_name,
        country=stop_data.country,
        start_date=stop_data.start_date,
        end_date=stop_data.end_date,
        order=stop_data.order
    )
    
    db.add(new_stop)
    db.commit()
    db.refresh(new_stop)
    
    return new_stop

@router.put("/stops/{stop_id}", response_model=StopResponse)
def update_stop(
    stop_id: int,
    stop_data: StopUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Update a stop"""
    stop = db.query(Stop).join(Trip).filter(
        Stop.id == stop_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not stop:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Stop not found"
        )
    
    update_data = stop_data.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(stop, field, value)
    
    db.commit()
    db.refresh(stop)
    
    return stop

@router.delete("/stops/{stop_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_stop(
    stop_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Delete a stop"""
    stop = db.query(Stop).join(Trip).filter(
        Stop.id == stop_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not stop:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Stop not found"
        )
    
    db.delete(stop)
    db.commit()
    
    return None

# ============= Activity Endpoints =============
@router.post("/stops/{stop_id}/activities", response_model=ActivityResponse, status_code=status.HTTP_201_CREATED)
def create_activity(
    stop_id: int,
    activity_data: ActivityCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Add an activity to a stop"""
    # Verify stop ownership through trip
    stop = db.query(Stop).join(Trip).filter(
        Stop.id == stop_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not stop:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Stop not found"
        )
    
    new_activity = Activity(
        stop_id=stop_id,
        name=activity_data.name,
        cost=activity_data.cost,
        duration=activity_data.duration,
        category=activity_data.category
    )
    
    db.add(new_activity)
    db.commit()
    db.refresh(new_activity)
    
    return new_activity

@router.put("/activities/{activity_id}", response_model=ActivityResponse)
def update_activity(
    activity_id: int,
    activity_data: ActivityUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Update an activity"""
    activity = db.query(Activity).join(Stop).join(Trip).filter(
        Activity.id == activity_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not activity:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Activity not found"
        )
    
    update_data = activity_data.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(activity, field, value)
    
    db.commit()
    db.refresh(activity)
    
    return activity

@router.delete("/activities/{activity_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_activity(
    activity_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Delete an activity"""
    activity = db.query(Activity).join(Stop).join(Trip).filter(
        Activity.id == activity_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not activity:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Activity not found"
        )
    
    db.delete(activity)
    db.commit()
    
    return None

# ============= Budget Endpoint =============
@router.get("/{trip_id}/budget", response_model=BudgetResponse)
def get_trip_budget(
    trip_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Calculate and return trip budget breakdown"""
    trip = db.query(Trip).filter(
        Trip.id == trip_id,
        Trip.user_id == current_user.id
    ).first()
    
    if not trip:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Trip not found"
        )
    
    stops_breakdown = []
    total_cost = 0.0
    
    for stop in trip.stops:
        stop_cost = sum(activity.cost for activity in stop.activities)
        total_cost += stop_cost
        
        stops_breakdown.append({
            "stop_id": stop.id,
            "city_name": stop.city_name,
            "total_cost": stop_cost
        })
    
    return {
        "trip_id": trip_id,
        "total_cost": total_cost,
        "stops_breakdown": stops_breakdown
    }
