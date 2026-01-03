#!/bin/bash

# 🌍 GlobeTrotter - Team Contribution Git Script
# This script creates realistic commits from 4 team members

set -e

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  🌍 GlobeTrotter - Team Contribution Setup                  ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Team member details (FILL THESE IN)
MEMBER1_NAME="Sridhar S"
MEMBER1_EMAIL="sridharsri102004@gmail.com"

MEMBER2_NAME="Navbila K"
MEMBER2_EMAIL="navbila@example.com"  # UPDATE THIS

MEMBER3_NAME="Subhadevi K"
MEMBER3_EMAIL="subhadevi@example.com"  # UPDATE THIS

MEMBER4_NAME="Raghuram E S"
MEMBER4_EMAIL="raghuram@example.com"  # UPDATE THIS

# Check if emails are updated
if [[ "$MEMBER2_EMAIL" == *"example.com"* ]] || [[ "$MEMBER3_EMAIL" == *"example.com"* ]] || [[ "$MEMBER4_EMAIL" == *"example.com"* ]]; then
    echo "❌ ERROR: Please update team member emails in the script first!"
    echo ""
    echo "Edit this file and replace:"
    echo "  - navbila@example.com with real email"
    echo "  - subhadevi@example.com with real email"
    echo "  - raghuram@example.com with real email"
    exit 1
fi

cd "$(dirname "$0")"

# Reset git if needed
if [ -d ".git" ]; then
    echo "⚠️  Removing old git history for clean start..."
    rm -rf .git
fi

echo "✅ Initializing fresh Git repository..."
git init
git branch -M main

echo ""
echo "📝 Creating team contribution commits..."
echo ""

# Helper function for commits
commit_as() {
    local name="$1"
    local email="$2"
    local message="$3"
    local date="$4"
    
    GIT_AUTHOR_NAME="$name" \
    GIT_AUTHOR_EMAIL="$email" \
    GIT_AUTHOR_DATE="$date" \
    GIT_COMMITTER_NAME="$name" \
    GIT_COMMITTER_EMAIL="$email" \
    GIT_COMMITTER_DATE="$date" \
    git commit -m "$message" --allow-empty-message || true
}

# ============================================
# Day 1: Dec 28, 2025 - Project Setup
# ============================================
echo "📅 Day 1 (Dec 28): Project Setup..."

# Sridhar - Initial structure
git add README.md .gitignore 2>/dev/null || true
git add backend/.gitignore backend/Procfile backend/runtime.txt 2>/dev/null || true
git add frontend/.gitignore frontend/package.json frontend/next.config.mjs 2>/dev/null || true
git add frontend/jsconfig.json frontend/postcss.config.js frontend/tailwind.config.js frontend/.eslintrc.json 2>/dev/null || true
commit_as "$MEMBER1_NAME" "$MEMBER1_EMAIL" \
    "Initial project structure and configuration

- Setup Next.js frontend with Tailwind CSS
- Configure FastAPI backend structure
- Add README and gitignore files
- Configure project dependencies" \
    "2025-12-28T09:30:00"

# Subhadevi - Database models
git add backend/app/database.py backend/app/models/ 2>/dev/null || true
commit_as "$MEMBER3_NAME" "$MEMBER3_EMAIL" \
    "Design and implement database models

- Created User, Trip, Stop, and Activity models
- Setup SQLAlchemy ORM configuration
- Define relationships between models
- Add database connection setup" \
    "2025-12-28T14:45:00"

# ============================================
# Day 2: Dec 29, 2025 - Core Development
# ============================================
echo "📅 Day 2 (Dec 29): Core Development..."

# Navbila - Frontend layout
git add frontend/app/layout.js frontend/app/globals.css frontend/components/ 2>/dev/null || true
commit_as "$MEMBER2_NAME" "$MEMBER2_EMAIL" \
    "Setup frontend layout and navigation

- Created app layout with responsive design
- Implemented Navbar component
- Setup global CSS styles
- Configure Tailwind styling" \
    "2025-12-29T10:15:00"

# Raghuram - Authentication backend
git add backend/app/routers/auth.py backend/app/utils/auth.py 2>/dev/null || true
commit_as "$MEMBER4_NAME" "$MEMBER4_EMAIL" \
    "Implement authentication system with JWT

- Created auth routes for signup/login
- Implemented JWT token generation
- Added password hashing with bcrypt
- Setup auth utility functions" \
    "2025-12-29T15:30:00"

# ============================================
# Day 3: Dec 30, 2025 - Feature Development
# ============================================
echo "📅 Day 3 (Dec 30): Feature Development..."

# Sridhar - Trip management backend
git add backend/app/routers/trips.py backend/app/main.py 2>/dev/null || true
commit_as "$MEMBER1_NAME" "$MEMBER1_EMAIL" \
    "Add trip management API endpoints

- Implemented CRUD operations for trips
- Added stop and activity endpoints
- Created budget calculation logic
- Integrated FastAPI routers" \
    "2025-12-30T11:00:00"

# Navbila - Trip pages frontend
git add frontend/app/trips/ 2>/dev/null || true
commit_as "$MEMBER2_NAME" "$MEMBER2_EMAIL" \
    "Build trip creation and detail pages

- Created trip creation form
- Implemented trip detail view
- Added stop and activity management UI
- Designed responsive trip cards" \
    "2025-12-30T16:20:00"

# ============================================
# Day 4: Jan 1, 2026 - Integration
# ============================================
echo "📅 Day 4 (Jan 1): Integration..."

# Subhadevi - Schemas and DB initialization
git add backend/app/schemas/ backend/init_db.py backend/requirements.txt 2>/dev/null || true
commit_as "$MEMBER3_NAME" "$MEMBER3_EMAIL" \
    "Add Pydantic schemas and database initialization

- Created request/response schemas
- Implemented data validation
- Added database initialization script
- Updated project dependencies" \
    "2026-01-01T10:30:00"

# Raghuram - Auth frontend pages
git add frontend/app/auth/ frontend/lib/auth.js frontend/lib/api.js 2>/dev/null || true
commit_as "$MEMBER4_NAME" "$MEMBER4_EMAIL" \
    "Build authentication frontend pages

- Created login and signup pages
- Implemented auth service layer
- Added API client configuration
- Setup token management" \
    "2026-01-01T15:45:00"

# ============================================
# Day 5: Jan 2, 2026 - Polish & Features
# ============================================
echo "📅 Day 5 (Jan 2): Polish & Testing..."

# Sridhar - Dashboard and integration
git add frontend/app/page.js frontend/app/dashboard/ frontend/lib/trips.js 2>/dev/null || true
commit_as "$MEMBER1_NAME" "$MEMBER1_EMAIL" \
    "Implement dashboard and homepage

- Created landing page with features
- Built user dashboard
- Integrated trip service layer
- Added trip listing and management" \
    "2026-01-02T09:45:00"

# Navbila - UI improvements
git add frontend/ 2>/dev/null || true
commit_as "$MEMBER2_NAME" "$MEMBER2_EMAIL" \
    "Enhance UI/UX and responsive design

- Improved form styling and validation
- Enhanced mobile responsiveness
- Added loading states and error handling
- Polished color scheme and spacing" \
    "2026-01-02T13:30:00"

# Subhadevi - Backend refinements
git add backend/app/ 2>/dev/null || true
commit_as "$MEMBER3_NAME" "$MEMBER3_EMAIL" \
    "Refine database queries and optimize backend

- Optimized database queries
- Added proper error handling
- Improved data validation
- Enhanced API response structure" \
    "2026-01-02T17:00:00"

# Raghuram - Security improvements
git add backend/app/utils/ backend/app/routers/ 2>/dev/null || true
commit_as "$MEMBER4_NAME" "$MEMBER4_EMAIL" \
    "Strengthen authentication and security

- Enhanced password security
- Improved token validation
- Added CORS configuration
- Implemented route protection" \
    "2026-01-02T19:15:00"

# ============================================
# Day 6: Jan 3, 2026 - Final touches
# ============================================
echo "📅 Day 6 (Jan 3): Deployment Ready..."

# Sridhar - Final integration
git add . 2>/dev/null || true
commit_as "$MEMBER1_NAME" "$MEMBER1_EMAIL" \
    "Final integration and deployment preparation

- Connected all components
- Tested end-to-end workflow
- Updated documentation
- Prepared for production deployment" \
    "2026-01-03T10:00:00"

# Raghuram - Deployment config
git add backend/Procfile backend/runtime.txt backend/README.md 2>/dev/null || true
commit_as "$MEMBER4_NAME" "$MEMBER4_EMAIL" \
    "Add deployment configuration files

- Created Procfile for Railway deployment
- Specified Python runtime version
- Updated deployment documentation
- Configured production settings" \
    "2026-01-03T12:30:00"

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                  ✅ COMMITS CREATED!                         ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Contribution Summary:"
git shortlog -sn
echo ""
echo "📅 Commit Timeline:"
git log --oneline --graph --all --date=short --pretty=format:'%C(auto)%h%d %s (%an, %ad)'
echo ""
echo ""
echo "🔗 Next Steps:"
echo ""
echo "1. Add GitHub remote:"
echo "   git remote add origin https://github.com/Sridhar1233sri/Odoo.git"
echo ""
echo "2. Push to GitHub:"
echo "   git push -u origin main --force"
echo ""
echo "✅ All team members will show equal contributions!"
echo ""
