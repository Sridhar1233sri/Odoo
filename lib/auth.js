import apiClient from './api';

export const authService = {
  // Signup
  async signup(userData) {
    const response = await apiClient.post('/api/auth/signup', userData);
    return response.data;
  },

  // Login
  async login(credentials) {
    const response = await apiClient.post('/api/auth/login', credentials);
    if (response.data.access_token) {
      localStorage.setItem('token', response.data.access_token);
      // Fetch user profile
      const user = await this.getProfile();
      localStorage.setItem('user', JSON.stringify(user));
    }
    return response.data;
  },

  // Get current user profile
  async getProfile() {
    const response = await apiClient.get('/api/auth/me');
    return response.data;
  },

  // Logout
  logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    window.location.href = '/auth/login';
  },

  // Check if user is authenticated
  isAuthenticated() {
    return !!localStorage.getItem('token');
  },

  // Get current user from localStorage
  getCurrentUser() {
    const userStr = localStorage.getItem('user');
    return userStr ? JSON.parse(userStr) : null;
  },
};
