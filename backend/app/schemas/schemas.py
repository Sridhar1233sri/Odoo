from pydantic import BaseModel, EmailStr, Field
from datetime import datetime
from typing import Optional, List

# ============= User Schemas =============
class UserBase(BaseModel):
    email: EmailStr
    name: str

class UserCreate(UserBase):
    password: str = Field(..., min_length=6)

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserResponse(UserBase):
    id: int
    created_at: datetime
    
    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    email: Optional[str] = None

# ============= Activity Schemas =============
class ActivityBase(BaseModel):
    name: str
    cost: float = 0.0
    duration: Optional[int] = None
    category: Optional[str] = None

class ActivityCreate(ActivityBase):
    stop_id: int

class ActivityUpdate(BaseModel):
    name: Optional[str] = None
    cost: Optional[float] = None
    duration: Optional[int] = None
    category: Optional[str] = None

class ActivityResponse(ActivityBase):
    id: int
    stop_id: int
    created_at: datetime
    
    class Config:
        from_attributes = True

# ============= Stop Schemas =============
class StopBase(BaseModel):
    city_name: str
    country: str
    start_date: datetime
    end_date: datetime
    order: int = 0

class StopCreate(StopBase):
    trip_id: int

class StopUpdate(BaseModel):
    city_name: Optional[str] = None
    country: Optional[str] = None
    start_date: Optional[datetime] = None
    end_date: Optional[datetime] = None
    order: Optional[int] = None

class StopResponse(StopBase):
    id: int
    trip_id: int
    created_at: datetime
    activities: List[ActivityResponse] = []
    
    class Config:
        from_attributes = True

# ============= Trip Schemas =============
class TripBase(BaseModel):
    title: str
    description: Optional[str] = None
    start_date: datetime
    end_date: datetime

class TripCreate(TripBase):
    pass

class TripUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    start_date: Optional[datetime] = None
    end_date: Optional[datetime] = None

class TripResponse(TripBase):
    id: int
    user_id: int
    created_at: datetime
    updated_at: datetime
    stops: List[StopResponse] = []
    
    class Config:
        from_attributes = True

class TripListResponse(TripBase):
    id: int
    user_id: int
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True

# ============= Budget Schemas =============
class BudgetResponse(BaseModel):
    trip_id: int
    total_cost: float
    stops_breakdown: List[dict]  # List of {stop_id, city_name, total_cost}
