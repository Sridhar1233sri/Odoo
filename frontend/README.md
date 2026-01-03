# GlobeTrotter Frontend

Next.js frontend for the GlobeTrotter travel planning platform.

## Features

- 🔐 User Authentication (Signup/Login)
- 🗺️ Trip Management (Create, View, Edit, Delete)
- 📍 Multi-City Itineraries
- 💰 Budget Tracking
- 📱 Responsive Design

## Tech Stack

- **Framework:** Next.js 15 (App Router)
- **Styling:** Tailwind CSS
- **API Client:** Axios
- **Language:** JavaScript

## Setup

1. Install dependencies:
```bash
npm install
```

2. Configure environment variables:
- Copy `.env.local` and update if needed
- Backend API URL is set to `http://localhost:8000`

3. Run the development server:
```bash
npm run dev
```

4. Open [http://localhost:3000](http://localhost:3000) in your browser

## Pages

- `/` - Landing page
- `/auth/signup` - User registration
- `/auth/login` - User login
- `/dashboard` - User dashboard with all trips
- `/trips/create` - Create new trip
- `/trips/[id]` - Trip details with itinerary builder

## Project Structure

```
frontend/
├── app/
│   ├── auth/
│   │   ├── login/
│   │   └── signup/
│   ├── dashboard/
│   ├── trips/
│   │   ├── create/
│   │   └── [id]/
│   ├── layout.js
│   ├── page.js
│   └── globals.css
├── components/
│   └── Navbar.js
├── lib/
│   ├── api.js
│   ├── auth.js
│   └── trips.js
└── package.json
```

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm run lint` - Run ESLint

## API Integration

The frontend communicates with the FastAPI backend at `http://localhost:8000`.

Make sure the backend server is running before starting the frontend.
