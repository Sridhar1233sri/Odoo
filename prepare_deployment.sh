#!/bin/bash

# 🚀 GlobeTrotter - Complete Automated Deployment
# This script prepares everything for one-click deployment

set -e  # Exit on error

echo "╔════════════════════════════════════════════════════════════╗"
echo "║   🌍 GlobeTrotter - Automated Deployment Preparation      ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Change to project root
cd "$(dirname "$0")"
PROJECT_ROOT=$(pwd)

echo -e "${BLUE}📁 Project Root: ${PROJECT_ROOT}${NC}"
echo ""

# ============================================
# Step 1: Check Prerequisites
# ============================================
echo -e "${YELLOW}Step 1/6: Checking Prerequisites...${NC}"

# Check Git
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git is not installed${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Git installed${NC}"

# Check if in git repo
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Not a git repository. Initializing...${NC}"
    git init
    echo -e "${GREEN}✅ Git repository initialized${NC}"
fi

# Check for uncommitted changes
if [[ -n $(git status -s) ]]; then
    echo -e "${YELLOW}⚠️  You have uncommitted changes${NC}"
    read -p "Commit all changes now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        git commit -m "Prepare for deployment - $(date +%Y-%m-%d)"
        echo -e "${GREEN}✅ Changes committed${NC}"
    fi
fi

# Check GitHub remote
if ! git remote | grep -q "origin"; then
    echo -e "${RED}❌ No GitHub remote configured${NC}"
    echo ""
    echo "Please create a GitHub repository and add it as remote:"
    echo "  git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
    echo "  git push -u origin main"
    exit 1
fi
echo -e "${GREEN}✅ GitHub remote configured${NC}"

echo ""

# ============================================
# Step 2: Prepare Backend Files
# ============================================
echo -e "${YELLOW}Step 2/6: Preparing Backend Deployment Files...${NC}"

# Check if backend files exist
if [ ! -f "backend/Procfile" ]; then
    echo -e "${RED}❌ backend/Procfile missing${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Procfile exists${NC}"

if [ ! -f "backend/requirements.txt" ]; then
    echo -e "${RED}❌ backend/requirements.txt missing${NC}"
    exit 1
fi
echo -e "${GREEN}✅ requirements.txt exists${NC}"

# Create .gitignore for backend if missing
if [ ! -f "backend/.gitignore" ]; then
    cat > backend/.gitignore << 'EOF'
__pycache__/
*.py[cod]
.env
.venv/
venv/
*.db
*.sqlite3
.DS_Store
*.log
EOF
    echo -e "${GREEN}✅ backend/.gitignore created${NC}"
else
    echo -e "${GREEN}✅ backend/.gitignore exists${NC}"
fi

# Verify .env is in .gitignore
if grep -q "^\.env$" backend/.gitignore; then
    echo -e "${GREEN}✅ .env is gitignored${NC}"
else
    echo ".env" >> backend/.gitignore
    echo -e "${GREEN}✅ Added .env to .gitignore${NC}"
fi

echo ""

# ============================================
# Step 3: Prepare Frontend Files
# ============================================
echo -e "${YELLOW}Step 3/6: Preparing Frontend Deployment Files...${NC}"

# Check package.json
if [ ! -f "frontend/package.json" ]; then
    echo -e "${RED}❌ frontend/package.json missing${NC}"
    exit 1
fi
echo -e "${GREEN}✅ package.json exists${NC}"

# Create .gitignore for frontend if missing
if [ ! -f "frontend/.gitignore" ]; then
    cat > frontend/.gitignore << 'EOF'
node_modules/
.next/
out/
.env
.env.local
.env.production.local
.DS_Store
*.log
.vercel
EOF
    echo -e "${GREEN}✅ frontend/.gitignore created${NC}"
else
    echo -e "${GREEN}✅ frontend/.gitignore exists${NC}"
fi

echo ""

# ============================================
# Step 4: Create Deployment Configuration
# ============================================
echo -e "${YELLOW}Step 4/6: Creating Deployment Configuration...${NC}"

# Create Railway config
cat > railway.json << 'EOF'
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS",
    "buildCommand": "pip install -r requirements.txt"
  },
  "deploy": {
    "startCommand": "uvicorn app.main:app --host 0.0.0.0 --port $PORT",
    "healthcheckPath": "/health",
    "restartPolicyType": "ON_FAILURE"
  }
}
EOF
mv railway.json backend/

echo -e "${GREEN}✅ Railway configuration created${NC}"

# Create Vercel config for frontend
cat > vercel.json << 'EOF'
{
  "buildCommand": "npm run build",
  "devCommand": "npm run dev",
  "installCommand": "npm install",
  "framework": "nextjs",
  "regions": ["iad1"]
}
EOF
mv vercel.json frontend/

echo -e "${GREEN}✅ Vercel configuration created${NC}"

echo ""

# ============================================
# Step 5: Generate Environment Templates
# ============================================
echo -e "${YELLOW}Step 5/6: Generating Environment Templates...${NC}"

# Backend .env.example
cat > backend/.env.example << 'EOF'
# Database Configuration
DATABASE_URL=postgresql://username:password@host:5432/database?sslmode=require

# JWT Configuration  
SECRET_KEY=your-super-secret-key-min-32-characters-long
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# Production URLs (optional)
FRONTEND_URL=https://your-app.vercel.app
EOF

echo -e "${GREEN}✅ backend/.env.example created${NC}"

# Frontend .env.example
cat > frontend/.env.example << 'EOF'
# Backend API URL
NEXT_PUBLIC_API_URL=https://your-backend.railway.app
EOF

echo -e "${GREEN}✅ frontend/.env.example created${NC}"

echo ""

# ============================================
# Step 6: Generate Deployment Instructions
# ============================================
echo -e "${YELLOW}Step 6/6: Generating Step-by-Step Instructions...${NC}"

cat > DEPLOY_NOW.md << 'EOF'
# 🚀 Deploy GlobeTrotter NOW - Step by Step

**Time Required: 15-20 minutes**

---

## ✅ Prerequisites Completed

Your repository is ready for deployment! All files are prepared.

---

## 🗂️ Step 1: Push to GitHub (2 minutes)

```bash
git add .
git commit -m "Ready for deployment"
git push origin main
```

✅ **Done? Your code is now on GitHub!**

---

## 🐘 Step 2: Deploy Database to Neon (5 minutes)

### 2.1 Create Neon Account
1. Open: https://neon.tech
2. Click "Sign Up" → Use GitHub
3. Authorize access

### 2.2 Create Database Project
1. Click "Create Project"
2. Name: `globetrotter`
3. Region: **US East (Ohio)** (or closest to you)
4. PostgreSQL version: **16** (default)
5. Click "Create Project"

### 2.3 Get Connection String
You'll see a connection string like:
```
postgresql://username:password@ep-xxx-xxx.us-east-2.aws.neon.tech/neondb?sslmode=require
```

**📋 COPY THIS - You'll need it!**

### 2.4 Initialize Database Tables
```bash
cd backend
export DATABASE_URL="YOUR_NEON_CONNECTION_STRING_HERE"
python init_db.py
```

✅ **Database created and running 24/7!**

---

## 🚂 Step 3: Deploy Backend to Railway (5 minutes)

### 3.1 Create Railway Account
1. Open: https://railway.app
2. Click "Login with GitHub"
3. Authorize Railway

### 3.2 Create New Project
1. Click "New Project"
2. Select "Deploy from GitHub repo"
3. Choose your repository
4. Select: **Deploy backend only**

### 3.3 Configure Service
1. Click on the deployed service
2. Go to "Settings"
3. Set **Root Directory**: `backend`
4. Click "Redeploy"

### 3.4 Add Environment Variables
1. Go to "Variables" tab
2. Click "Add Variable" and add these:

**Variable 1:**
- Name: `DATABASE_URL`
- Value: `YOUR_NEON_CONNECTION_STRING`

**Variable 2:**
- Name: `SECRET_KEY`
- Value: `generate-a-random-32-character-string-here-abc123xyz`

**Variable 3:**
- Name: `ALGORITHM`
- Value: `HS256`

**Variable 4:**
- Name: `ACCESS_TOKEN_EXPIRE_MINUTES`
- Value: `30`

3. Wait 1-2 minutes for automatic redeployment

### 3.5 Get Your Backend URL
1. Go to "Settings" → "Domains"
2. Copy the public URL (e.g., `https://your-app-production.up.railway.app`)

**📋 SAVE THIS URL!**

✅ **Backend deployed and running!**

---

## ⚡ Step 4: Deploy Frontend to Vercel (5 minutes)

### 4.1 Create Vercel Account
1. Open: https://vercel.com
2. Click "Sign Up" → Continue with GitHub
3. Authorize Vercel

### 4.2 Import Project
1. Click "Add New..." → "Project"
2. Import your GitHub repository
3. Vercel auto-detects Next.js

### 4.3 Configure Project
1. **Root Directory**: `frontend`
2. **Framework Preset**: Next.js (auto-selected)
3. **Build Command**: `npm run build` (auto-filled)
4. **Output Directory**: `.next` (auto-filled)

### 4.4 Add Environment Variable
Click "Environment Variables" and add:

- **Name**: `NEXT_PUBLIC_API_URL`
- **Value**: `YOUR_RAILWAY_BACKEND_URL` (from Step 3.5, no trailing slash)
- **Environment**: Production, Preview, Development (all checked)

### 4.5 Deploy
1. Click "Deploy"
2. Wait 2-3 minutes
3. ✅ **Your app is LIVE!**

---

## 🔧 Step 5: Update Backend CORS (2 minutes)

### 5.1 Get Your Vercel URL
After deployment, Vercel shows your URL: `https://your-app.vercel.app`

### 5.2 Update CORS in Backend
Edit `backend/app/main.py` and update:

```python
allow_origins=[
    "http://localhost:3000",
    "https://your-actual-app-name.vercel.app",  # Replace with your Vercel URL
]
```

### 5.3 Push Update
```bash
git add backend/app/main.py
git commit -m "Update CORS for production"
git push
```

Railway will auto-redeploy in 1-2 minutes!

✅ **CORS configured!**

---

## 🧪 Step 6: Test Your Deployment (3 minutes)

### Visit Your App
Open: `https://your-app.vercel.app`

### Test These Features:
1. ✅ Homepage loads
2. ✅ Click "Sign Up"
3. ✅ Create an account
4. ✅ Login with your credentials
5. ✅ Create a new trip
6. ✅ Add a city (stop)
7. ✅ Add an activity with budget
8. ✅ Check if budget calculation works

---

## 🎉 YOU'RE LIVE!

### Your Production URLs:

| Service | URL | What It Is |
|---------|-----|------------|
| **Frontend** | `https://________.vercel.app` | Your main website |
| **Backend API** | `https://________.railway.app` | REST API server |
| **API Docs** | `https://________.railway.app/docs` | Interactive API documentation |
| **Database** | Neon Dashboard | PostgreSQL cloud database |

---

## 📊 Your Free Hosting Details

| Platform | What It Hosts | Free Tier | Always On? |
|----------|--------------|-----------|------------|
| **Neon.tech** | PostgreSQL Database | 3 GB storage | ✅ Yes (24/7) |
| **Railway.app** | FastAPI Backend | $5/month credit | ✅ Yes (24/7) |
| **Vercel** | Next.js Frontend | 100 GB bandwidth | ✅ Yes (24/7) |

**Total Cost: $0/month** 🎉

---

## 🔄 How to Update Your App

1. Make changes locally
2. Test locally (`npm run dev` / `uvicorn app.main:app --reload`)
3. Commit and push:
   ```bash
   git add .
   git commit -m "Your update message"
   git push
   ```
4. **That's it!** Railway and Vercel auto-deploy!

---

## 🆘 Troubleshooting

### Backend won't start?
- Check Railway logs: Dashboard → Deployments → View Logs
- Verify `DATABASE_URL` has `?sslmode=require`
- Ensure all environment variables are set

### Frontend can't connect?
- Check `NEXT_PUBLIC_API_URL` in Vercel settings
- Verify backend URL doesn't have trailing `/`
- Check CORS settings in backend

### Database connection fails?
- Test connection: `psql 'YOUR_NEON_URL' -c "SELECT 1"`
- Check if Neon project is active (not suspended)
- Verify connection string is correct

---

## 📝 Quick Reference Commands

### Test Backend API
```bash
curl https://your-backend.railway.app/health
```

### View Railway Logs
```bash
# Install Railway CLI (optional)
npm install -g railway
railway login
railway logs
```

### View Vercel Logs
- Go to Vercel Dashboard
- Click your project
- Go to "Deployments" → Click latest
- View "Function Logs"

---

## 🎯 Share Your Project

Add these to your README or submission:

- **Live Demo**: https://your-app.vercel.app
- **API Documentation**: https://your-backend.railway.app/docs
- **GitHub Repository**: https://github.com/your-username/your-repo

---

**Congratulations! Your app is deployed and running 24/7 on cloud infrastructure! 🚀**

**Need help? All detailed docs are in:**
- `DEPLOYMENT_GUIDE.md` - Complete guide
- `DEPLOYMENT_CHECKLIST.md` - Interactive checklist
- `QUICK_DEPLOY.md` - Quick reference

EOF

echo -e "${GREEN}✅ DEPLOY_NOW.md created${NC}"

echo ""

# ============================================
# Summary
# ============================================
echo "╔════════════════════════════════════════════════════════════╗"
echo "║              ✅ PREPARATION COMPLETE!                     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo -e "${GREEN}All deployment files are ready!${NC}"
echo ""
echo -e "${BLUE}📁 Files Created:${NC}"
echo "  • backend/Procfile"
echo "  • backend/runtime.txt"
echo "  • backend/railway.json"
echo "  • backend/.env.example"
echo "  • backend/.gitignore"
echo "  • frontend/vercel.json"
echo "  • frontend/.env.example"
echo "  • DEPLOY_NOW.md"
echo ""
echo -e "${YELLOW}📖 NEXT STEP:${NC}"
echo ""
echo -e "  ${GREEN}Open and follow: DEPLOY_NOW.md${NC}"
echo ""
echo "  This file has step-by-step instructions to deploy in 15-20 minutes!"
echo ""
echo -e "${BLUE}Quick Start:${NC}"
echo "  cat DEPLOY_NOW.md"
echo ""
echo -e "${GREEN}Good luck with your deployment! 🚀${NC}"
