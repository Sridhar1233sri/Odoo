#!/bin/bash

# Test Production Deployment Script

echo "🧪 Testing GlobeTrotter Production Deployment"
echo "============================================="
echo ""

# Get backend URL from user
read -p "Enter your Backend URL (e.g., https://your-app.railway.app): " BACKEND_URL
read -p "Enter your Frontend URL (e.g., https://your-app.vercel.app): " FRONTEND_URL

echo ""
echo "Testing Backend..."
echo "-----------------"

# Test health endpoint
echo -n "1. Health Check: "
HEALTH=$(curl -s "$BACKEND_URL/health")
if [[ $HEALTH == *"healthy"* ]]; then
    echo "✅ PASSED"
else
    echo "❌ FAILED"
    echo "   Response: $HEALTH"
fi

# Test root endpoint
echo -n "2. Root Endpoint: "
ROOT=$(curl -s "$BACKEND_URL/")
if [[ $ROOT == *"GlobeTrotter"* ]]; then
    echo "✅ PASSED"
else
    echo "❌ FAILED"
fi

# Test API docs
echo -n "3. API Documentation: "
DOCS=$(curl -s -o /dev/null -w "%{http_code}" "$BACKEND_URL/docs")
if [[ $DOCS == "200" ]]; then
    echo "✅ PASSED - Visit: $BACKEND_URL/docs"
else
    echo "❌ FAILED (HTTP $DOCS)"
fi

echo ""
echo "Testing Frontend..."
echo "------------------"

echo -n "4. Homepage: "
HOMEPAGE=$(curl -s -o /dev/null -w "%{http_code}" "$FRONTEND_URL")
if [[ $HOMEPAGE == "200" ]]; then
    echo "✅ PASSED"
else
    echo "❌ FAILED (HTTP $HOMEPAGE)"
fi

echo -n "5. Signup Page: "
SIGNUP=$(curl -s -o /dev/null -w "%{http_code}" "$FRONTEND_URL/auth/signup")
if [[ $SIGNUP == "200" ]]; then
    echo "✅ PASSED"
else
    echo "❌ FAILED (HTTP $SIGNUP)"
fi

echo ""
echo "Summary"
echo "-------"
echo "✅ Backend URL: $BACKEND_URL"
echo "✅ Frontend URL: $FRONTEND_URL"
echo "📖 API Docs: $BACKEND_URL/docs"
echo ""
echo "🎯 Manual Tests Required:"
echo "1. Visit $FRONTEND_URL/auth/signup"
echo "2. Create a test account"
echo "3. Login and create a trip"
echo "4. Add stops and activities"
echo "5. Verify budget calculations"
echo ""
echo "Good luck! 🚀"
