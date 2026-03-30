# Project 4: Hotel Reservation System (Intermediate)

## Objective
Build a dynamic booking system that accurately tracks hotel room availability, prevents double-booking, and handles customer folios.

## Core Requirements
1.  **Rooms:** Room Number (Primary Key), Room Type (Single, Double, Suite), Price Per Night, Max Occupancy.
2.  **Guests:** Guest ID, Name, Phone, Email.
3.  **Reservations:** Res ID, Guest ID, Room Number, Check-In Date, Check-Out Date, Status (Booked, Cancelled, Completed).

## Tasks & Queries to Write
1.  **Availability Query (The Challenge):** Write a query to find all Rooms of type 'Suite' that are physically available (not booked) between '2024-12-20' and '2024-12-25'. *(Hint: You must use `LEFT JOIN` or `NOT EXISTS` against the reservations table looking for overlapping dates).*
2.  **Date Math:** Write a query to calculate the total expected bill for a specific reservation (Price Per Night * Number of Nights). You will need to use SQL date difference functions (like `DATEDIFF` or `AGE()`).
3.  **Aggregation:** Find the most popular Room Type based on the count of historical reservations.

## Expected Learnings
*   Complex filtering using Date Overlaps.
*   `NOT EXISTS` or `LEFT JOIN ... IS NULL` patterns for finding exclusions.
*   Date Mathematics.
