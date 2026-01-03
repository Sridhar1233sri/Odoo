# 🌍 GlobeTrotter - Multi-City Travel Planning Platform

**A comprehensive, full-stack travel planning application built for the Odoo Hackathon**

---

## 📋 Problem Statement

Planning multi-city trips is fragmented and manual. Travelers juggle multiple tools:
- Google for destinations
- Maps for routes  
- Excel for budgets
- Messaging apps for sharing

**GlobeTrotter solves this** with a unified platform for designing, visualizing, budgeting, and sharing trips.

---

## ✨ Key Features

### 🔐 User Authentication
- Secure signup/login with JWT tokens
- Password hashing with bcrypt
- Protected routes and API endpoints

### 🗺️ Trip Management
- Create unlimited multi-city trips
- Set start/end dates
- Add descriptions and metadata

### 📍 Itinerary Builder
- Add multiple cities (stops) to each trip
- Arrange stops in order
- Set dates for each city
- Visual timeline view

### 💰 Budget Tracking
- Add activities with costs to each city
- Automatic budget calculation per city
- Total trip cost breakdown
- Category-wise expense tracking (Food, Transport, Accommodation, Activities)

### 📱 Modern UI/UX
- Responsive design (mobile + desktop)
- Clean, intuitive interface
- Real-time updates
- Form validation

---

## 🛠 Tech Stack

| Layer | Technology | Why |
|-------|-----------|-----|
| **Frontend** | Next.js 15 (JavaScript, App Router) | SEO, performance, routing |
| **Styling** | Tailwind CSS | Rapid development, clean UI |
| **Backend** | FastAPI (Python) | High performance, async support |
| **Database** | PostgreSQL | Relational, reliable, scalable |
| **ORM** | SQLAlchemy | Clean DB modeling |
| **Auth** | JWT | Secure, stateless |

---

## 📁 Project Structure

```
GlobeTrotter/
├── backend/          # FastAPI Backend
│   ├── app/
│   │   ├── models/       # Database models
│   │   ├── routers/      # API endpoints
│   │   ├── schemas/      # Pydantic schemas
│   │   ├── utils/        # Auth & utilities
│   │   ├── database.py   # DB connection
│   │   └── main.py       # FastAPI app
│   ├── requirements.txt
│   └── .env
│
├── frontend/         # Next.js Frontend
│   ├── app/
│   │   ├── auth/         # Login/Signup pages
│   │   ├── dashboard/    # User dashboard
│   │   ├── trips/        # Trip pages
│   │   └── page.js       # Landing page
│   ├── components/       # Reusable components
│   ├── lib/             # API client & services
│   ├── package.json
│   └── .env.local
│
└── README.md        # This file
```

---

## 🚀 Quick Start

### Prerequisites
- Python 3.11+
- Node.js 18+
- PostgreSQL 14+

### 1. Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On macOS/Linux

# Install dependencies
pip install -r requirements.txt

# Configure environment
# Update .env with your PostgreSQL credentials

# Run server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

**Backend will run on:** `http://localhost:8000`
**API Docs:** `http://localhost:8000/docs`

### 2. Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Run development server
npm run dev
```

**Frontend will run on:** `http://localhost:3000`

---

## 📊 Database Schema

### User
- id, name, email, password_hash, created_at

### Trip
- id, user_id, title, description, start_date, end_date, created_at, updated_at

### Stop (City)
- id, trip_id, city_name, country, start_date, end_date, order, created_at

### Activity
- id, stop_id, name, cost, duration, category, created_at

---

## 🔗 API Endpoints

### Authentication
- `POST /api/auth/signup` - Register new user
- `POST /api/auth/login` - Login and get JWT token
- `GET /api/auth/me` - Get current user profile

### Trips
- `GET /api/trips` - Get all user trips
- `POST /api/trips` - Create new trip
- `GET /api/trips/{id}` - Get trip details
- `PUT /api/trips/{id}` - Update trip
- `DELETE /api/trips/{id}` - Delete trip

### Stops (Cities)
- `POST /api/trips/{trip_id}/stops` - Add stop to trip
- `PUT /api/trips/stops/{stop_id}` - Update stop
- `DELETE /api/trips/stops/{stop_id}` - Delete stop

### Activities
- `POST /api/trips/stops/{stop_id}/activities` - Add activity
- `PUT /api/trips/activities/{activity_id}` - Update activity
- `DELETE /api/trips/activities/{activity_id}` - Delete activity

### Budget
- `GET /api/trips/{trip_id}/budget` - Get trip budget breakdown

---

## 🎯 Key Differentiators

✅ **Dynamic data** (PostgreSQL + FastAPI, not static JSON)
✅ **Clean, consistent UI** (Tailwind CSS)
✅ **Strong input validation** (Frontend + Backend)
✅ **Proper relational database** modeling
✅ **Scalable architecture** (separate frontend/backend)
✅ **Production-ready code** (error handling, authentication)

---

## 🏆 Hackathon Highlights

### Why GlobeTrotter Stands Out:

1. **Full-Stack Architecture**: Separate frontend/backend demonstrates enterprise-level thinking
2. **Real Database Integration**: PostgreSQL with proper relationships, not mocked data
3. **Professional API Design**: RESTful endpoints with proper HTTP methods and status codes
4. **Security First**: JWT authentication, password hashing, protected routes
5. **User Experience**: Responsive design, intuitive flows, real-time budget calculations
6. **Code Quality**: Clean structure, reusable components, proper error handling

---

## 🧪 Testing

### Backend
```bash
cd backend
# Test API endpoints using Swagger UI
# Visit http://localhost:8000/docs
```

### Frontend
```bash
cd frontend
npm run lint
```

---

## 📝 Environment Variables

### Backend (.env)
```
DATABASE_URL=postgresql://user:password@localhost:5432/odoo
SECRET_KEY=your-secret-key-min-32-chars
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

### Frontend (.env.local)
```
NEXT_PUBLIC_API_URL=http://localhost:8000
```

---

## 🎨 Design Choices

- **Color Scheme**: Blue/Cyan (Primary), Gray (Neutral)
- **Typography**: Clean, modern sans-serif
- **Layout**: Card-based, responsive grid
- **Spacing**: Consistent Tailwind spacing scale

---

## � Deployment

### Production Deployment (24/7 Cloud Hosting)

Your app is deployed and running on:
- **Database**: Neon.tech (PostgreSQL)
- **Backend**: Railway.app / Render.com
- **Frontend**: Vercel

📖 **Full deployment guide**: See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)
✅ **Quick checklist**: See [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md)

#### Quick Deploy Steps:

1. **Set up Cloud Database**
   ```bash
   # Create account at https://neon.tech
   # Get connection string and run:
   cd backend
   ./migrate_to_cloud.sh 'your-neon-connection-string'
   ```

2. **Deploy Backend to Railway**
   - Go to https://railway.app
   - Connect GitHub repo
   - Set environment variables
   - Deploy!

3. **Deploy Frontend to Vercel**
   - Go to https://vercel.com  
   - Import GitHub repo
   - Add `NEXT_PUBLIC_API_URL` env variable
   - Deploy!

4. **Test Production**
   ```bash
   ./test_deployment.sh
   ```

**Live URLs:**
- Frontend: https://your-app.vercel.app
- Backend API: https://your-app.railway.app
- API Docs: https://your-app.railway.app/docs

---

## �🚧 Future Enhancements

- [ ] Public trip sharing via unique links
- [ ] Map visualization of routes
- [ ] Calendar view for trips
- [ ] Flight/hotel booking integration
- [ ] Weather forecast integration
- [ ] Collaborative trip planning
- [ ] Mobile app (React Native)

---

## 👥 Team Collaboration (Git Workflow)

```
main → stable production
dev → integration branch
feature/frontend-* → frontend features
feature/backend-* → backend features
```

Each team member:
- Owns feature branches
- Raises pull requests
- Reviews code

---

## 📄 License

MIT License - Built for Odoo Hackathon 2026

---

## 🙏 Acknowledgments

Built with:
- FastAPI by Sebastián Ramírez
- Next.js by Vercel
- Tailwind CSS by Tailwind Labs
- PostgreSQL by PostgreSQL Global Development Group

---

**Built with ❤️ for the Odoo Hackathon**

**Live Demo:** [Coming Soon]
**Documentation:** See `/backend/README.md` and `/frontend/README.md`
