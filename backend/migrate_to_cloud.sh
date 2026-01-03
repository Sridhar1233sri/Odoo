#!/bin/bash

# GlobeTrotter Database Migration Script
# This script helps you migrate from local PostgreSQL to Neon (cloud)

echo "🌍 GlobeTrotter - Database Migration to Cloud"
echo "=============================================="
echo ""

# Check if connection string is provided
if [ -z "$1" ]; then
    echo "❌ Error: Neon connection string required"
    echo ""
    echo "Usage: ./migrate_to_cloud.sh 'postgresql://user:pass@host/db?sslmode=require'"
    echo ""
    echo "Get your connection string from:"
    echo "1. Go to https://neon.tech"
    echo "2. Create a new project"
    echo "3. Copy the connection string"
    exit 1
fi

NEON_CONNECTION="$1"
LOCAL_CONNECTION="postgresql://sridhars:mypassword@localhost:5432/odoo"

echo "📊 Step 1: Testing local database connection..."
psql "$LOCAL_CONNECTION" -c "\dt" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Local database connected"
else
    echo "❌ Cannot connect to local database"
    exit 1
fi

echo ""
echo "☁️  Step 2: Testing Neon cloud database connection..."
psql "$NEON_CONNECTION" -c "SELECT version();" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Neon database connected"
else
    echo "❌ Cannot connect to Neon database"
    echo "Check your connection string"
    exit 1
fi

echo ""
echo "🏗️  Step 3: Creating tables in Neon database..."
cd "$(dirname "$0")"
export DATABASE_URL="$NEON_CONNECTION"
python init_db.py
if [ $? -eq 0 ]; then
    echo "✅ Tables created successfully"
else
    echo "❌ Failed to create tables"
    exit 1
fi

echo ""
echo "📤 Step 4: Exporting data from local database..."
pg_dump "$LOCAL_CONNECTION" \
    --data-only \
    --inserts \
    --column-inserts \
    -t users -t trips -t stops -t activities \
    > /tmp/globetrotter_data.sql 2>/dev/null

if [ -s /tmp/globetrotter_data.sql ]; then
    echo "✅ Data exported to /tmp/globetrotter_data.sql"
    
    echo ""
    echo "📥 Step 5: Importing data to Neon database..."
    psql "$NEON_CONNECTION" < /tmp/globetrotter_data.sql > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo "✅ Data imported successfully"
    else
        echo "⚠️  Warning: Some data may not have imported (this is OK if starting fresh)"
    fi
else
    echo "ℹ️  No local data to export (starting fresh in cloud)"
fi

echo ""
echo "🎉 Migration Complete!"
echo ""
echo "Next steps:"
echo "1. Update backend/.env with:"
echo "   DATABASE_URL=$NEON_CONNECTION"
echo "2. Test locally with new database"
echo "3. Deploy to Railway/Render"
echo ""
