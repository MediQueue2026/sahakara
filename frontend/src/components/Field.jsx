import React from 'react';

export const Field = ({ label, value, onChange, type = "text", disabled }) => (
  <div>
    <label className="block text-sm text-stone-600 mb-1">{label}</label>
    <input
      type={type}
      value={value}
      onChange={(e) => onChange(e.target.value)}
      disabled={disabled}
      className="w-full px-3 py-2 rounded-lg border border-stone-300 disabled:bg-stone-50 disabled:text-stone-500"
    />
  </div>
);
