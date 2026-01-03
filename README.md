# 🌍 GlobeTrotter

**Multi-City Travel Planning Made Simple**

> A full-stack web application for planning, budgeting, and managing multi-city trips.  
> Built for the **Odoo Hackathon 2026**

[![Live Demo](https://img.shields.io/badge/Demo-Live-success)](https://globetrotter-odoo.vercel.app)
[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue)](https://github.com/Sridhar1233sri/Odoo)

---

## 🎯 Problem Statement

Planning multi-city trips today is fragmented across multiple tools:
- 🔍 Google for destinations
- 📊 Spreadsheets for budgets  
- 📝 Notes for itineraries
- 💬 Messaging apps for sharing

**Result:** Travelers waste time switching between apps and struggle to see the complete picture.

### Our Solution

**GlobeTrotter provides a unified platform** where users can:
- ✅ Plan entire trips in one place
- ✅ Track budgets automatically  
- ✅ Manage itineraries visually
- ✅ See the complete journey overview

---

## ✨ Features

### 🔒 Secure Authentication
- JWT-based user authentication
- Bcrypt password encryption
- Protected routes and data
- Session management

### 🗺️ Smart Trip Planning
- Create unlimited multi-city trips
- Add destinations as chronological stops
- Set dates for each location
- Drag-and-drop stop reordering

### 💰 Automatic Budget Tracking
- Add activities with costs per city
- Real-time budget calculations
- Category-based expense tracking (Food, Transport, Accommodation, Activities)
- Per-city and total trip cost breakdown

### 📱 Responsive Design
- Works seamlessly on desktop, tablet, and mobile
- Clean, modern interface with Tailwind CSS
- Intuitive navigation
- Fast and performant

---

## 🛠 Tech Stack

| Layer | Technology | Why We Chose It |
|-------|-----------|-----------------|
| **Frontend** | Next.js 15 (App Router) | SEO optimization, server-side rendering, modern React features |
| **Styling** | Tailwind CSS | Rapid development, consistent design, responsive utilities |
| **Backend** | FastAPI (Python 3.13) | High performance, async support, automatic API documentation |
| **Database** | PostgreSQL 16 | ACID compliance, relationships, reliability |
| **ORM** | SQLAlchemy 2.0 | Type-safe queries, migrations, productivity |
| **Authentication** | JWT + Bcrypt | Stateless tokens, secure password hashing |
| **Deployment** | Vercel + Railway + Neon | Serverless, auto-scaling, zero downtime |

---

## 📁 Project Structure

```
GlobeTrotter/
│
├── backend/                    # FastAPI Backend
│   ├── app/
│   │   ├── models/            # SQLAlchemy database models
│   │   │   └── models.py      # User, Trip, Stop, Activity
│   │   ├── routers/           # API route handlers
│   │   │   ├── auth.py        # Authentication endpoints
│   │   │   └── trips.py       # Trip management endpoints
│   │   ├── schemas/           # Pydantic request/response schemas
│   │   │   └── schemas.py     # Data validation models
│   │   ├── utils/             # Utility functions
│   │   │   └── auth.py        # JWT & password utilities
│   │   ├── database.py        # Database configuration
│   │   └── main.py            # FastAPI application
│   ├── init_db.py             # Database initialization script
│   ├── requirements.txt       # Python dependencies
│   ├── Procfile               # Deployment configuration
│   └── runtime.txt            # Python version specification
│
├── frontend/                   # Next.js Frontend
│   ├── app/
│   │   ├── auth/              # Authentication pages
│   │   │   ├── login/         # Login page
│   │   │   └── signup/        # Signup page
│   │   ├── dashboard/         # User dashboard
│   │   │   └── page.js        # Trips overview
│   │   ├── trips/             # Trip management
│   │   │   ├── create/        # Create trip page
│   │   │   └── [id]/          # Trip detail page
│   │   ├── layout.js          # Root layout
│   │   ├── page.js            # Landing page
│   │   └── globals.css        # Global styles
│   ├── components/            # Reusable components
│   │   └── Navbar.js          # Navigation bar
│   ├── lib/                   # Service layers
│   │   ├── api.js             # Axios API client
│   │   ├── auth.js            # Auth service
│   │   └── trips.js           # Trips service
│   ├── package.json           # Dependencies
│   └── tailwind.config.js     # Tailwind configuration
│
└── README.md                   # You are here!
```

---

## 🚀 Quick Start

### Prerequisites

- **Python 3.11+** ([Download](https://www.python.org/downloads/))
- **Node.js 18+** ([Download](https://nodejs.org/))
- **PostgreSQL 14+** ([Download](https://www.postgresql.org/download/))

### 1️⃣ Clone Repository

```bash
git clone https://github.com/Sridhar1233sri/Odoo.git
cd Odoo
```

### 2️⃣ Backend Setup

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Create .env file
cat > .env << EOF
DATABASE_URL=postgresql://sridhars:mypassword@localhost:5432/odoo
SECRET_KEY=your-super-secret-key-change-this-in-production-min-32-chars
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
EOF

# Initialize database
python init_db.py

# Run backend server
uvicorn app.main:app --reload --port 8000
```

✅ **Backend running at:** http://localhost:8000  
📖 **API Docs:** http://localhost:8000/docs

### 3️⃣ Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Create .env.local file
echo "NEXT_PUBLIC_API_URL=http://localhost:8000" > .env.local

# Run frontend server
npm run dev
```

✅ **Frontend running at:** http://localhost:3000

---

## 📊 Database Schema

```sql
┌─────────────────┐
│     users       │
├─────────────────┤
│ id (PK)         │
│ name            │
│ email (unique)  │
│ password_hash   │
│ created_at      │
└────────┬────────┘
         │
         │ 1:N
         ▼
┌─────────────────┐
│     trips       │
├─────────────────┤
│ id (PK)         │
│ user_id (FK)    │
│ title           │
│ description     │
│ start_date      │
│ end_date        │
│ created_at      │
│ updated_at      │
└────────┬────────┘
         │
         │ 1:N
         ▼
┌─────────────────┐
│     stops       │
├─────────────────┤
│ id (PK)         │
│ trip_id (FK)    │
│ city_name       │
│ country         │
│ start_date      │
│ end_date        │
│ order           │
│ created_at      │
└────────┬────────┘
         │
         │ 1:N
         ▼
┌─────────────────┐
│   activities    │
├─────────────────┤
│ id (PK)         │
│ stop_id (FK)    │
│ name            │
│ cost            │
│ duration        │
│ category        │
│ created_at      │
└─────────────────┘
```

---

## 🔗 API Endpoints

### Authentication

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/auth/signup` | Register new user | ❌ |
| POST | `/api/auth/login` | Login and get JWT | ❌ |
| GET | `/api/auth/me` | Get current user | ✅ |

### Trips

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/api/trips` | Get all user trips | ✅ |
| POST | `/api/trips` | Create new trip | ✅ |
| GET | `/api/trips/{id}` | Get trip details | ✅ |
| PUT | `/api/trips/{id}` | Update trip | ✅ |
| DELETE | `/api/trips/{id}` | Delete trip | ✅ |

### Stops

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/trips/{trip_id}/stops` | Add stop to trip | ✅ |
| PUT | `/api/trips/stops/{stop_id}` | Update stop | ✅ |
| DELETE | `/api/trips/stops/{stop_id}` | Delete stop | ✅ |

### Activities

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/api/trips/stops/{stop_id}/activities` | Add activity | ✅ |
| PUT | `/api/trips/activities/{activity_id}` | Update activity | ✅ |
| DELETE | `/api/trips/activities/{activity_id}` | Delete activity | ✅ |

### Budget

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/api/trips/{trip_id}/budget` | Get budget breakdown | ✅ |

---

## 🎯 Key Differentiators

| Feature | GlobeTrotter | Traditional Apps |
|---------|--------------|------------------|
| **Data Persistence** | ✅ PostgreSQL database | ❌ Local storage/JSON |
| **Real-time Budget** | ✅ Auto-calculated | ❌ Manual tracking |
| **Multi-city Planning** | ✅ Unlimited stops | ❌ Single destination |
| **User Authentication** | ✅ Secure JWT | ❌ No auth |
| **Responsive Design** | ✅ Mobile-first | ❌ Desktop only |
| **API Documentation** | ✅ Auto-generated | ❌ Manual docs |

---

## 🏆 Hackathon Highlights

### Why GlobeTrotter Stands Out:

1. **🏗️ Enterprise Architecture**
   - Separation of concerns (frontend/backend)
   - RESTful API design
   - Scalable database relationships

2. **🔒 Security First**
   - JWT token authentication
   - Bcrypt password hashing
   - CORS protection
   - Environment variable management

3. **💎 Code Quality**
   - Clean, readable code
   - Reusable components
   - Proper error handling
   - Type validation (Pydantic)

4. **🎨 User Experience**
   - Intuitive interface
   - Responsive across devices
   - Real-time feedback
   - Loading states & error messages

5. **📈 Production Ready**
   - Deployment configuration
   - Environment management
   - Database migrations
   - API versioning ready

---

## 🧪 Testing the Application

### 1. Test Authentication
```bash
# Signup
curl -X POST http://localhost:8000/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"test123"}'

# Login
curl -X POST http://localhost:8000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"test123"}'
```

### 2. Test Trip Creation
Visit http://localhost:3000 and:
1. ✅ Sign up for an account
2. ✅ Login with credentials
3. ✅ Create a new trip
4. ✅ Add cities (stops)
5. ✅ Add activities with budgets
6. ✅ View budget calculations

---

## 📝 Environment Configuration

### Backend (.env)
```env
# Database
DATABASE_URL=postgresql://username:password@localhost:5432/database_name

# JWT Configuration
SECRET_KEY=your-secret-key-min-32-characters-long-change-in-production
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# Optional: Frontend URL for CORS
FRONTEND_URL=http://localhost:3000
```

### Frontend (.env.local)
```env
# Backend API URL
NEXT_PUBLIC_API_URL=http://localhost:8000
```

---

## 🚀 Deployment

### Production Hosting (Free Tier)

| Component | Platform | Free Tier | Always On? |
|-----------|----------|-----------|------------|
| **Database** | [Neon.tech](https://neon.tech) | 3 GB storage | ✅ 24/7 |
| **Backend** | [Railway.app](https://railway.app) | $5/month credit | ✅ 24/7 |
| **Frontend** | [Vercel.com](https://vercel.com) | 100 GB bandwidth | ✅ 24/7 |

**Total Cost:** $0/month

### Quick Deploy Steps:

1. **Deploy Database (Neon)**
   - Create account at https://neon.tech
   - Create project "globetrotter"
   - Get connection string
   - Run database initialization

2. **Deploy Backend (Railway)**
   - Push code to GitHub
   - Connect Railway to repository
   - Add environment variables
   - Auto-deploy on push

3. **Deploy Frontend (Vercel)**
   - Push code to GitHub
   - Import repository in Vercel
   - Add `NEXT_PUBLIC_API_URL`
   - Auto-deploy on push

---

## 👥 Team

**Team GlobeTrotter** - Collaborative development for Odoo Hackathon 2026

| Name | Role | Contributions |
|------|------|---------------|
| **Sridhar S** | Full Stack Lead | Trip management, API integration, deployment |
| **Navbila K** | Frontend Developer | UI/UX design, trip pages, responsive layout |
| **Subhadevi K** | Backend Developer | Database models, schemas, API optimization |
| **Raghuram E S** | Auth & DevOps | Authentication system, security, deployment |

---

## 🚧 Future Enhancements

- [ ] 🌍 Public trip sharing via unique links
- [ ] 🗺️ Interactive map visualization with routes
- [ ] 📅 Calendar view for trip timeline
- [ ] ✈️ Flight and hotel booking integration
- [ ] 🌤️ Weather forecast for destinations
- [ ] 👥 Collaborative trip planning (invite friends)
- [ ] 📄 Export trips to PDF/Excel
- [ ] 📱 React Native mobile application
- [ ] 🔔 Email notifications for trip reminders
- [ ] 💱 Multi-currency support

---

## 📄 License

This project is licensed under the MIT License - see below for details:

```
MIT License

Copyright (c) 2026 Team GlobeTrotter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🙏 Acknowledgments

- **FastAPI** by Sebastián Ramírez - for the incredible Python framework
- **Next.js** by Vercel - for the powerful React framework
- **Tailwind CSS** by Tailwind Labs - for beautiful, responsive design
- **PostgreSQL** Global Development Group - for reliable data storage
- **Odoo** - for organizing this amazing hackathon

---

## 📞 Contact & Links

- **Repository:** https://github.com/Sridhar1233sri/Odoo
- **Live Demo:** [Coming Soon]
- **Documentation:** See individual README files in `backend/` and `frontend/`
- **Issues:** https://github.com/Sridhar1233sri/Odoo/issues

---

**Built with ❤️ by Team GlobeTrotter for Odoo Hackathon 2026**

*Making multi-city travel planning simple, intuitive, and beautiful.*
