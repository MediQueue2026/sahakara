import React from 'react';

export const Card = ({ children, className = "" }) => (
  <div className={`bg-white rounded-xl border border-stone-200 ${className}`}>{children}</div>
);
