import React from 'react';
import Header from './Header';
import FeedbackForm from './FeedbackForm';
import Footer from './Footer';

export default function App() {
  return (
    <div>
      <Header title="Tell us what you think" />
      <FeedbackForm />
      <Footer text="Copyright Appfolio Inc. Onboarding" />
    </div>
  );
}
