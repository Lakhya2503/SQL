# Project 7: Hospital Management System (Advanced)

## Objective
Model a highly normalized, complex institutional database emphasizing Many-to-Many relationships and strict scheduling logic.

## Core Requirements
1.  **Staff:** ID, Name, Role (Doctor, Nurse, Admin), Department ID.
2.  **Patients:** ID, Name, DOB, Blood Type.
3.  **Appointments:** ID, Patient ID, Doctor ID, Appointment Date/Time, Status.
4.  **Prescriptions:** ID, Patient ID, Doctor ID, Medication Name, Dosage, Issue Date.
5.  **Room_Assignments:** Patient ID, Room Number, Admit Date, Discharge Date.

## Tasks & Queries to Write
1.  **Normalisation:** Design the schema carefully. A Patient can have Many Doctors, and a Doctor can have Many Patients. They intersect at Appointments and Prescriptions.
2.  **The Scheduling Conflict Query:** Write a query to prevent a doctor from double-booking. Create a `CHECK` constraint or a Before-Insert Trigger that verifies the new Appointment time does not overlap with any existing Appointment time for that specific `Doctor ID`.
3.  **CTEs:** Write a Common Table Expression that calculates the average length of stay (Admit Date to Discharge Date) for all patients grouped by specific conditions (or age brackets).
4.  **Patient History:** Retrieve a complete patient dossier: All doctors they have seen, all medications prescribed, and total days spent admitted to the hospital.

## Expected Learnings
*   Highly Normalized Data Architecture (3NF).
*   Date Overlap mathematics.
*   Enforcing constraints securely.
*   Advanced Common Table Expressions (CTEs).
