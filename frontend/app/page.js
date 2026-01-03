import Link from "next/link";

export default function HomePage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-cyan-50">
      {/* Hero Section */}
      <div className="container mx-auto px-4 py-16">
        <div className="text-center max-w-4xl mx-auto">
          <h1 className="text-6xl font-bold text-gray-900 mb-6">
            🌍 GlobeTrotter
          </h1>
          <p className="text-2xl text-gray-600 mb-4">
            Your Ultimate Multi-City Travel Planner
          </p>
          <p className="text-lg text-gray-500 mb-12">
            Plan trips, manage budgets, and create unforgettable itineraries — all in one place.
          </p>

          {/* CTA Buttons */}
          <div className="flex gap-4 justify-center mb-16">
            <Link
              href="/auth/signup"
              className="px-8 py-4 bg-primary-600 text-white rounded-lg font-semibold hover:bg-primary-700 transition shadow-lg"
            >
              Get Started Free
            </Link>
            <Link
              href="/auth/login"
              className="px-8 py-4 bg-white text-primary-600 border-2 border-primary-600 rounded-lg font-semibold hover:bg-primary-50 transition"
            >
              Login
            </Link>
          </div>

          {/* Features Grid */}
          <div className="grid md:grid-cols-3 gap-8 mt-16">
            <div className="bg-white p-8 rounded-xl shadow-md">
              <div className="text-4xl mb-4">🗺️</div>
              <h3 className="text-xl font-bold mb-2">Multi-City Planning</h3>
              <p className="text-gray-600">
                Add multiple cities, arrange stops, and build your perfect route
              </p>
            </div>

            <div className="bg-white p-8 rounded-xl shadow-md">
              <div className="text-4xl mb-4">💰</div>
              <h3 className="text-xl font-bold mb-2">Budget Tracking</h3>
              <p className="text-gray-600">
                Track expenses per city and activity, stay within budget
              </p>
            </div>

            <div className="bg-white p-8 rounded-xl shadow-md">
              <div className="text-4xl mb-4">📅</div>
              <h3 className="text-xl font-bold mb-2">Smart Itineraries</h3>
              <p className="text-gray-600">
                Organize activities, set dates, and visualize your journey
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Footer */}
      <footer className="text-center py-8 text-gray-500 border-t">
        <p>© 2026 GlobeTrotter - Built for Odoo Hackathon</p>
      </footer>
    </div>
  );
}
