import "./globals.css";

export const metadata = {
  title: "GlobeTrotter - Multi-City Travel Planner",
  description: "Plan your perfect multi-city trip with budget tracking and itinerary management",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className="antialiased">
        {children}
      </body>
    </html>
  );
}
