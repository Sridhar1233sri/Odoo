# 🚀 Quick Deployment Checklist

## ✅ Pre-Deployment Checklist

- [ ] Code is working locally (both frontend and backend)
- [ ] All features tested (signup, login, trips, stops, activities)
- [ ] Database tables created
- [ ] Git repository is up to date

---

## 📝 Step-by-Step Deployment

### 1️⃣ Cloud Database Setup (5 minutes)

- [ ] Go to https://neon.tech
- [ ] Sign up with GitHub
- [ ] Create new project named "globetrotter"
- [ ] Copy connection string (starts with `postgresql://`)
- [ ] Run migration script:
  ```bash
  cd backend
  ./migrate_to_cloud.sh 'YOUR_NEON_CONNECTION_STRING_HERE'
  ```

**Your Neon Connection String:**
```
_____________________________________________________
```

---

### 2️⃣ Backend Deployment (10 minutes)

#### Option A: Railway.app (Recommended)

- [ ] Go to https://railway.app
- [ ] Sign up with GitHub
- [ ] Click "New Project" → "Deploy from GitHub repo"
- [ ] Select `Odoo` repository
- [ ] Root Directory: `backend`
- [ ] Add Environment Variables:
  ```
  DATABASE_URL=your_neon_connection_string
  SECRET_KEY=change-this-to-a-random-32-char-string
  ALGORITHM=HS256
  ACCESS_TOKEN_EXPIRE_MINUTES=30
  ```
- [ ] Deploy and wait 2-3 minutes
- [ ] Copy your backend URL: `https://__________.railway.app`

#### Option B: Render.com (Alternative)

- [ ] Go to https://render.com
- [ ] Sign up with GitHub
- [ ] New → Web Service
- [ ] Connect `Odoo` repository
- [ ] Root Directory: `backend`
- [ ] Build Command: `pip install -r requirements.txt`
- [ ] Start Command: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
- [ ] Add same environment variables as Railway
- [ ] Deploy

**Your Backend URL:**
```
_____________________________________________________
```

---

### 3️⃣ Update CORS in Backend

- [ ] Update `backend/app/main.py`:
  ```python
  allow_origins=[
      "http://localhost:3000",
      "https://your-frontend-url.vercel.app",  # Add your Vercel URL
  ]
  ```
- [ ] Push to GitHub (Railway/Render will auto-redeploy)

---

### 4️⃣ Frontend Deployment (5 minutes)

- [ ] Go to https://vercel.com
- [ ] Sign up with GitHub
- [ ] Click "Add New" → "Project"
- [ ] Import `Odoo` repository
- [ ] Root Directory: `frontend`
- [ ] Framework Preset: Next.js (auto-detected)
- [ ] Add Environment Variable:
  ```
  NEXT_PUBLIC_API_URL=your_railway_backend_url
  ```
  (e.g., `https://your-app.railway.app`)
- [ ] Click "Deploy"
- [ ] Wait 2-3 minutes

**Your Frontend URL:**
```
_____________________________________________________
```

---

### 5️⃣ Final Testing (5 minutes)

Visit your Vercel URL and test:

- [ ] Homepage loads
- [ ] Sign up works
- [ ] Login works
- [ ] Create trip works
- [ ] Add stops works
- [ ] Add activities works
- [ ] Budget calculation works
- [ ] Dashboard displays data

---

## 🎉 You're Live!

Your app is now deployed and running 24/7!

**Share your links:**
- 🌐 Frontend: https://________________.vercel.app
- 🔧 Backend API: https://________________.railway.app
- 📊 API Docs: https://________________.railway.app/docs

---

## 🔧 Maintenance

### Update Code
1. Make changes locally
2. Test locally
3. Push to GitHub:
   ```bash
   git add .
   git commit -m "Your changes"
   git push
   ```
4. Vercel and Railway will auto-deploy!

### View Logs
- **Railway**: Dashboard → Deployments → View Logs
- **Vercel**: Dashboard → Deployments → Function Logs

### Database Access
- **Neon**: Dashboard → SQL Editor
- **CLI**: `psql 'your_neon_connection_string'`

---

## 💰 Cost Breakdown

| Service | Free Tier | Limits |
|---------|-----------|--------|
| Neon.tech | ✅ FREE Forever | 3 GB storage, 500 MB compute |
| Railway | ✅ $5/month credit | ~500 hours/month |
| Vercel | ✅ FREE Forever | 100 GB bandwidth |

**Total Cost: $0/month** for hackathon/hobby projects!

---

## 🆘 Need Help?

- Railway Issues: https://railway.app/help
- Vercel Issues: https://vercel.com/support
- Neon Issues: https://neon.tech/docs

Good luck with your deployment! 🚀
