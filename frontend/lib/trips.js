import apiClient from './api';

export const tripService = {
  // Get all trips
  async getTrips() {
    const response = await apiClient.get('/api/trips');
    return response.data;
  },

  // Get single trip with details
  async getTrip(tripId) {
    const response = await apiClient.get(`/api/trips/${tripId}`);
    return response.data;
  },

  // Create trip
  async createTrip(tripData) {
    const response = await apiClient.post('/api/trips', tripData);
    return response.data;
  },

  // Update trip
  async updateTrip(tripId, tripData) {
    const response = await apiClient.put(`/api/trips/${tripId}`, tripData);
    return response.data;
  },

  // Delete trip
  async deleteTrip(tripId) {
    await apiClient.delete(`/api/trips/${tripId}`);
  },

  // Add stop to trip
  async addStop(tripId, stopData) {
    const response = await apiClient.post(`/api/trips/${tripId}/stops`, stopData);
    return response.data;
  },

  // Update stop
  async updateStop(stopId, stopData) {
    const response = await apiClient.put(`/api/trips/stops/${stopId}`, stopData);
    return response.data;
  },

  // Delete stop
  async deleteStop(stopId) {
    await apiClient.delete(`/api/trips/stops/${stopId}`);
  },

  // Add activity to stop
  async addActivity(stopId, activityData) {
    const response = await apiClient.post(`/api/trips/stops/${stopId}/activities`, activityData);
    return response.data;
  },

  // Update activity
  async updateActivity(activityId, activityData) {
    const response = await apiClient.put(`/api/trips/activities/${activityId}`, activityData);
    return response.data;
  },

  // Delete activity
  async deleteActivity(activityId) {
    await apiClient.delete(`/api/trips/activities/${activityId}`);
  },

  // Get trip budget
  async getTripBudget(tripId) {
    const response = await apiClient.get(`/api/trips/${tripId}/budget`);
    return response.data;
  },
};
