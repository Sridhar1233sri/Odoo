# 🚀 GlobeTrotter - Complete Deployment Guide

## Overview
Deploy your full-stack travel planning app with **FREE 24/7 cloud hosting**.

---

## 📊 Step 1: Set Up Cloud PostgreSQL Database (Neon.tech)

### Why Neon?
- ✅ FREE forever tier
- ✅ Always running (24/7)
- ✅ Auto-scaling
- ✅ PostgreSQL compatible
- ✅ No credit card required

### Setup Instructions:

1. **Create Account**
   - Go to: https://neon.tech
   - Click "Sign Up" (use GitHub for faster signup)

2. **Create Database**
   - Click "Create Project"
   - Project Name: `globetrotter`
   - Region: Choose closest to you (e.g., US East)
   - PostgreSQL Version: 16 (default)
   - Click "Create Project"

3. **Get Connection String**
   - After creation, you'll see a connection string like:
   ```
   postgresql://username:password@ep-xxx.region.aws.neon.tech/neondb?sslmode=require
   ```
   - **SAVE THIS!** You'll need it later.

4. **Create Tables in Cloud Database**
   
   Copy this connection string and run:
   ```bash
   # Set the connection string (replace with YOUR connection string from Neon)
   export NEON_DB="postgresql://username:password@ep-xxx.region.aws.neon.tech/neondb?sslmode=require"
   
   # Run your init script
   cd /Users/sridhars/Projects/Odoo/backend
   python init_db.py
   ```

---

## 🐍 Step 2: Prepare Backend for Deployment

### Files to Create:

#### 1. Create `requirements.txt` (production dependencies)
Already exists, but verify it has:
```
fastapi==0.115.0
uvicorn[standard]==0.32.1
sqlalchemy==2.0.36
psycopg2-binary==2.9.10
python-jose[cryptography]==3.3.0
bcrypt==4.0.1
python-multipart==0.0.17
pydantic==2.10.3
pydantic-settings==2.6.1
python-dotenv==1.0.1
email-validator
```

#### 2. Create `Procfile` (for deployment)
In `backend/` folder:
```
web: uvicorn app.main:app --host 0.0.0.0 --port $PORT
```

#### 3. Create `runtime.txt` (Python version)
In `backend/` folder:
```
python-3.13.7
```

---

## 🚂 Step 3: Deploy Backend to Railway.app

### Why Railway?
- ✅ FREE $5/month credit (no credit card needed initially)
- ✅ Auto-deploys from GitHub
- ✅ Easy environment variables
- ✅ Fast deployment

### Setup Instructions:

1. **Create Railway Account**
   - Go to: https://railway.app
   - Sign up with GitHub

2. **Create New Project**
   - Click "New Project"
   - Choose "Deploy from GitHub repo"
   - Select your `Odoo` repository
   - Root Directory: `backend`

3. **Configure Environment Variables**
   - In Railway dashboard, go to "Variables"
   - Add these:
   ```
   DATABASE_URL=your_neon_connection_string_here
   SECRET_KEY=your-super-secret-key-min-32-chars-change-this
   ALGORITHM=HS256
   ACCESS_TOKEN_EXPIRE_MINUTES=30
   ```

4. **Deploy**
   - Railway will auto-detect Python and deploy
   - Wait for deployment (2-3 minutes)
   - Copy the public URL: `https://your-app.railway.app`

---

## ⚡ Step 4: Deploy Frontend to Vercel

### Why Vercel?
- ✅ 100% FREE for hobby projects
- ✅ Created by Next.js team
- ✅ Auto-deploys from GitHub
- ✅ Global CDN

### Setup Instructions:

1. **Create Vercel Account**
   - Go to: https://vercel.com
   - Sign up with GitHub

2. **Import Project**
   - Click "Add New" → "Project"
   - Import your `Odoo` repository
   - Root Directory: `frontend`
   - Framework Preset: Next.js (auto-detected)

3. **Configure Environment Variables**
   - Add this in Vercel:
   ```
   NEXT_PUBLIC_API_URL=https://your-backend.railway.app
   ```
   (Replace with your Railway backend URL)

4. **Deploy**
   - Click "Deploy"
   - Wait 2-3 minutes
   - Your app will be live at: `https://your-app.vercel.app`

---

## 🧪 Step 5: Test Production Deployment

### Test Checklist:

1. ✅ Visit your Vercel frontend URL
2. ✅ Click "Sign Up" and create an account
3. ✅ Login with your credentials
4. ✅ Create a new trip
5. ✅ Add stops (cities)
6. ✅ Add activities
7. ✅ Check budget calculations

---

## 🔧 Alternative: Deploy Backend to Render.com

If Railway doesn't work, use Render:

1. Go to: https://render.com
2. Sign up with GitHub
3. Create "New Web Service"
4. Connect your GitHub repo
5. Settings:
   - Root Directory: `backend`
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
   - Environment Variables: Same as Railway

---

## 📝 Important Notes

### CORS Configuration
Your backend already has CORS configured for localhost. After deployment, you need to update it:

In `backend/app/main.py`, update:
```python
allow_origins=[
    "http://localhost:3000",
    "https://your-app.vercel.app",  # Add your Vercel URL
]
```

### Database Migration
Your local data won't automatically transfer. Options:
1. **Start fresh** in production (recommended for hackathon)
2. **Export/Import** data using `pg_dump` and `pg_restore`

---

## 🎯 Quick Summary

| What | Where | URL |
|------|-------|-----|
| Database | Neon.tech | Connection string in env vars |
| Backend | Railway.app | `https://your-app.railway.app` |
| Frontend | Vercel | `https://your-app.vercel.app` |

---

## 🆘 Troubleshooting

**Backend not connecting to database?**
- Check DATABASE_URL environment variable
- Ensure connection string includes `?sslmode=require`

**Frontend can't reach backend?**
- Check NEXT_PUBLIC_API_URL in Vercel
- Update CORS in backend main.py

**Build failures?**
- Check Python version in runtime.txt
- Verify all packages in requirements.txt

---

## 🎉 Next Steps

Once deployed, your app will be:
- ✅ Accessible worldwide 24/7
- ✅ Auto-scaling based on traffic
- ✅ Backed by cloud PostgreSQL
- ✅ Free to run (within limits)

Ready to share your project link! 🌍
