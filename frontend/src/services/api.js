import axios from 'axios';

const API_URL = 'http://localhost:5000/api';

export const getState = async () => {
  const res = await axios.get(`${API_URL}/state`);
  return res.data;
};

export const updateState = async (updates) => {
  const res = await axios.post(`${API_URL}/state`, updates);
  return res.data;
};
