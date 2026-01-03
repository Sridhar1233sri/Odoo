# GlobeTrotter Backend

FastAPI backend for the GlobeTrotter travel planning platform.

## Setup

1. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On macOS/Linux
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Configure environment variables:
- Copy `.env` file and update `SECRET_KEY` if needed
- Database URL is already configured

4. Run the application:
```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

5. Access API documentation:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## API Endpoints

### Authentication
- POST `/api/auth/signup` - Register new user
- POST `/api/auth/login` - Login and get JWT token
- GET `/api/auth/me` - Get current user profile

### Trips
- POST `/api/trips` - Create new trip
- GET `/api/trips` - Get all user trips
- GET `/api/trips/{id}` - Get trip details
- PUT `/api/trips/{id}` - Update trip
- DELETE `/api/trips/{id}` - Delete trip

### Stops (Cities)
- POST `/api/trips/{trip_id}/stops` - Add stop to trip
- PUT `/api/trips/stops/{stop_id}` - Update stop
- DELETE `/api/trips/stops/{stop_id}` - Delete stop

### Activities
- POST `/api/trips/stops/{stop_id}/activities` - Add activity
- PUT `/api/trips/activities/{activity_id}` - Update activity
- DELETE `/api/trips/activities/{activity_id}` - Delete activity

### Budget
- GET `/api/trips/{trip_id}/budget` - Get trip budget breakdown
