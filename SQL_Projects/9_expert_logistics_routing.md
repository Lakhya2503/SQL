# Project 9: Logistics & Routing (Expert)

## Objective
Model hierarchical and graph-based data in SQL. This represents a courier delivery network moving packages between distribution hubs.

## Core Requirements
1.  **Hubs:** Hub ID, City Name, Capacity.
2.  **Routes:** Route ID, Start Hub ID, End Hub ID, Distance (km), Estimated Time (hrs).
3.  **Packages:** Waybill Number, Origin Hub ID, Final Destination Hub ID, Current Hub ID, Status (In Transit, Arrived).

## Tasks & Queries to Write
1.  **Graph Representation:** You are modeling a directed graph where Nodes are Hubs and Edges are Routes.
2.  **Recursive CTE (The Path Finder):** This is the hardest query in SQL. Write a Recursive Common Table Expression (CTE) that calculates all possible routes (and their total distances) going from Sydney (Origin) to London (Destination).
    *   *Base Case:* Start at Sydney.
    *   *Recursive Case:* Join the current node to any neighboring nodes connected by a `Route` edge.
    *   *Termination:* Stop when you reach London.
3.  **Optimization:** Limit the Recursive CTE to only return the path with the *smallest* Total Distance (effectively implementing Dijkstra's Algorithm in pure SQL).

## Expected Learnings
*   Graph/Network modeling in relational databases.
*   Expert-level `WITH RECURSIVE` queries.
*   Infinite loop protection within recursive steps.
