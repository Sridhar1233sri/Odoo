'use client';

import { useEffect, useState } from 'react';
import { useRouter, useParams } from 'next/navigation';
import Navbar from '@/components/Navbar';
import { tripService } from '@/lib/trips';
import { authService } from '@/lib/auth';

export default function TripDetailPage() {
  const router = useRouter();
  const params = useParams();
  const tripId = params.id;

  const [trip, setTrip] = useState(null);
  const [budget, setBudget] = useState(null);
  const [loading, setLoading] = useState(true);
  const [showStopForm, setShowStopForm] = useState(false);
  const [showActivityForm, setShowActivityForm] = useState(null);

  const [stopForm, setStopForm] = useState({
    city_name: '',
    country: '',
    start_date: '',
    end_date: '',
    order: 0,
  });

  const [activityForm, setActivityForm] = useState({
    name: '',
    cost: '',
    duration: '',
    category: 'sightseeing',
  });

  useEffect(() => {
    if (!authService.isAuthenticated()) {
      router.push('/auth/login');
      return;
    }
    loadTrip();
  }, [tripId]);

  const loadTrip = async () => {
    try {
      const [tripData, budgetData] = await Promise.all([
        tripService.getTrip(tripId),
        tripService.getTripBudget(tripId),
      ]);
      setTrip(tripData);
      setBudget(budgetData);
    } catch (err) {
      console.error('Failed to load trip', err);
    } finally {
      setLoading(false);
    }
  };

  const handleAddStop = async (e) => {
    e.preventDefault();
    try {
      const stopData = {
        ...stopForm,
        trip_id: parseInt(tripId),
        start_date: new Date(stopForm.start_date).toISOString(),
        end_date: new Date(stopForm.end_date).toISOString(),
      };
      await tripService.addStop(tripId, stopData);
      setShowStopForm(false);
      setStopForm({
        city_name: '',
        country: '',
        start_date: '',
        end_date: '',
        order: 0,
      });
      loadTrip();
    } catch (err) {
      alert('Failed to add stop');
    }
  };

  const handleAddActivity = async (e, stopId) => {
    e.preventDefault();
    try {
      const actData = {
        ...activityForm,
        stop_id: stopId,
        cost: parseFloat(activityForm.cost) || 0,
        duration: parseInt(activityForm.duration) || 0,
      };
      await tripService.addActivity(stopId, actData);
      setShowActivityForm(null);
      setActivityForm({
        name: '',
        cost: '',
        duration: '',
        category: '',
      });
      loadTrip();
    } catch (err) {
      alert('Failed to add activity');
    }
  };

  const handleDeleteStop = async (stopId) => {
    if (!confirm('Delete this stop and all its activities?')) return;
    try {
      await tripService.deleteStop(stopId);
      loadTrip();
    } catch (err) {
      alert('Failed to delete stop');
    }
  };

  const handleDeleteActivity = async (activityId) => {
    if (!confirm('Delete this activity?')) return;
    try {
      await tripService.deleteActivity(activityId);
      loadTrip();
    } catch (err) {
      alert('Failed to delete activity');
    }
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      month: 'short',
      day: 'numeric',
      year: 'numeric',
    });
  };

  if (loading) {
    return (
      <div>
        <Navbar />
        <div className="min-h-screen bg-gray-50 flex items-center justify-center">
          <div className="text-gray-600">Loading...</div>
        </div>
      </div>
    );
  }

  if (!trip) {
    return (
      <div>
        <Navbar />
        <div className="min-h-screen bg-gray-50 flex items-center justify-center">
          <div className="text-red-600">Trip not found</div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />

      <div className="container mx-auto px-4 py-8">
        {/* Trip Header */}
        <div className="bg-white rounded-xl shadow-md p-8 mb-6">
          <div className="flex justify-between items-start mb-4">
            <div>
              <h1 className="text-3xl font-bold text-gray-900 mb-2">{trip.title}</h1>
              <p className="text-gray-600">{trip.description}</p>
            </div>
            <button
              onClick={() => router.push('/dashboard')}
              className="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition"
            >
              ← Back
            </button>
          </div>
          <div className="flex items-center text-gray-600 space-x-6">
            <span>📅 {formatDate(trip.start_date)} → {formatDate(trip.end_date)}</span>
            <span>💰 Total Budget: ${budget?.total_cost.toFixed(2) || '0.00'}</span>
            <span>🗺️ {trip.stops?.length || 0} Stops</span>
          </div>
        </div>

        {/* Stops Section */}
        <div className="bg-white rounded-xl shadow-md p-8">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-2xl font-bold text-gray-900">Itinerary</h2>
            <button
              onClick={() => setShowStopForm(!showStopForm)}
              className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition"
            >
              {showStopForm ? 'Cancel' : '+ Add Stop'}
            </button>
          </div>

          {/* Add Stop Form */}
          {showStopForm && (
            <div className="bg-gray-50 rounded-lg p-6 mb-6">
              <h3 className="font-semibold mb-4">Add New Stop</h3>
              <form onSubmit={handleAddStop} className="grid grid-cols-2 gap-4">
                <input
                  type="text"
                  placeholder="City Name"
                  value={stopForm.city_name}
                  onChange={(e) => setStopForm({ ...stopForm, city_name: e.target.value })}
                  required
                  className="px-4 py-2 border rounded-lg text-gray-900"
                />
                <input
                  type="text"
                  placeholder="Country"
                  value={stopForm.country}
                  onChange={(e) => setStopForm({ ...stopForm, country: e.target.value })}
                  required
                  className="px-4 py-2 border rounded-lg text-gray-900"
                />
                <input
                  type="date"
                  value={stopForm.start_date}
                  onChange={(e) => setStopForm({ ...stopForm, start_date: e.target.value })}
                  required
                  className="px-4 py-2 border rounded-lg text-gray-900"
                />
                <input
                  type="date"
                  value={stopForm.end_date}
                  onChange={(e) => setStopForm({ ...stopForm, end_date: e.target.value })}
                  required
                  className="px-4 py-2 border rounded-lg text-gray-900"
                />
                <button type="submit" className="col-span-2 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700">
                  Add Stop
                </button>
              </form>
            </div>
          )}

          {/* Stops List */}
          {trip.stops?.length === 0 ? (
            <div className="text-center py-12 text-gray-500">
              <div className="text-4xl mb-2">📍</div>
              <p>No stops added yet. Add your first destination!</p>
            </div>
          ) : (
            <div className="space-y-6">
              {trip.stops?.map((stop, index) => (
                <div key={stop.id} className="border rounded-lg p-6">
                  <div className="flex justify-between items-start mb-4">
                    <div>
                      <h3 className="text-xl font-bold text-gray-900">
                        {index + 1}. {stop.city_name}, {stop.country}
                      </h3>
                      <p className="text-gray-600 text-sm">
                        {formatDate(stop.start_date)} - {formatDate(stop.end_date)}
                      </p>
                    </div>
                    <div className="flex gap-2">
                      <button
                        onClick={() => setShowActivityForm(showActivityForm === stop.id ? null : stop.id)}
                        className="px-3 py-1 text-sm bg-green-100 text-green-700 rounded hover:bg-green-200"
                      >
                        + Activity
                      </button>
                      <button
                        onClick={() => handleDeleteStop(stop.id)}
                        className="px-3 py-1 text-sm bg-red-100 text-red-700 rounded hover:bg-red-200"
                      >
                        Delete
                      </button>
                    </div>
                  </div>

                  {/* Add Activity Form */}
                  {showActivityForm === stop.id && (
                    <div className="bg-blue-50 border-2 border-blue-200 rounded-lg p-6 mb-4">
                      <h4 className="font-semibold text-gray-900 mb-4 flex items-center">
                        <span className="text-xl mr-2">➕</span>
                        Add New Activity
                      </h4>
                      <form onSubmit={(e) => handleAddActivity(e, stop.id)} className="space-y-4">
                        {/* Activity Name */}
                        <div>
                          <label className="block text-sm font-medium text-gray-700 mb-1">
                            Activity Name *
                          </label>
                          <input
                            type="text"
                            placeholder="e.g., Visit Eiffel Tower, Lunch at Cafe"
                            value={activityForm.name}
                            onChange={(e) => setActivityForm({ ...activityForm, name: e.target.value })}
                            required
                            className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900 placeholder-gray-400"
                          />
                        </div>

                        {/* Cost and Duration Row */}
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">
                              Budget / Cost ($) *
                            </label>
                            <input
                              type="number"
                              placeholder="e.g., 25.50"
                              step="0.01"
                              min="0"
                              value={activityForm.cost}
                              onChange={(e) => setActivityForm({ ...activityForm, cost: e.target.value })}
                              required
                              className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900 placeholder-gray-400"
                            />
                          </div>
                          <div>
                            <label className="block text-sm font-medium text-gray-700 mb-1">
                              Duration (minutes)
                            </label>
                            <input
                              type="number"
                              placeholder="e.g., 120"
                              min="0"
                              value={activityForm.duration}
                              onChange={(e) => setActivityForm({ ...activityForm, duration: e.target.value })}
                              className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900 placeholder-gray-400"
                            />
                          </div>
                        </div>

                        {/* Category */}
                        <div>
                          <label className="block text-sm font-medium text-gray-700 mb-1">
                            Category
                          </label>
                          <select
                            value={activityForm.category}
                            onChange={(e) => setActivityForm({ ...activityForm, category: e.target.value })}
                            className="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900"
                          >
                            <option value="sightseeing">🗺️ Sightseeing</option>
                            <option value="food">🍽️ Food & Dining</option>
                            <option value="transport">🚗 Transport</option>
                            <option value="accommodation">🏨 Accommodation</option>
                            <option value="activity">🎯 Activity & Entertainment</option>
                            <option value="shopping">🛍️ Shopping</option>
                            <option value="other">📌 Other</option>
                          </select>
                        </div>

                        {/* Action Buttons */}
                        <div className="flex gap-3 pt-2">
                          <button 
                            type="submit" 
                            className="flex-1 py-2.5 bg-green-600 text-white rounded-lg font-semibold hover:bg-green-700 transition shadow-sm"
                          >
                            Add Activity
                          </button>
                          <button
                            type="button"
                            onClick={() => {
                              setShowActivityForm(null);
                              setActivityForm({ name: '', cost: '', duration: '', category: 'sightseeing' });
                            }}
                            className="px-6 py-2.5 bg-gray-200 text-gray-700 rounded-lg font-semibold hover:bg-gray-300 transition"
                          >
                            Cancel
                          </button>
                        </div>
                      </form>
                    </div>
                  )}

                  {/* Activities List */}
                  {stop.activities?.length > 0 && (
                    <div className="mt-4 space-y-2">
                      <h4 className="font-medium text-gray-700 mb-2">Activities:</h4>
                      {stop.activities.map((activity) => (
                        <div key={activity.id} className="flex justify-between items-center bg-gray-50 p-3 rounded">
                          <div>
                            <span className="font-medium">{activity.name}</span>
                            {activity.category && (
                              <span className="ml-2 text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded">
                                {activity.category}
                              </span>
                            )}
                          </div>
                          <div className="flex items-center gap-4">
                            <span className="text-green-600 font-semibold">${activity.cost.toFixed(2)}</span>
                            {activity.duration && <span className="text-gray-500 text-sm">{activity.duration} min</span>}
                            <button
                              onClick={() => handleDeleteActivity(activity.id)}
                              className="text-red-600 hover:text-red-800 text-sm"
                            >
                              ✕
                            </button>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
