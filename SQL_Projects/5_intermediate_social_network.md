# Project 5: Social Network Graph (Intermediate)

## Objective
Model the relationships and interactions in a simplified social media platform (like Twitter or Instagram).

## Core Requirements
1.  **Users:** ID, Username, Bio, Join Date.
2.  **Follows:** Follower ID, Followee ID, Follow Date. (A table linking Users to other Users).
3.  **Posts:** ID, User ID, Content, Timestamp.
4.  **Likes:** User ID, Post ID, Timestamp.

## Tasks & Queries to Write
1.  **The News Feed:** Write a query for a specific User (e.g., User ID 1) that retrieves the 10 most recent Posts created by the people they follow, ordered by the newest timestamp.
2.  **Follower Counts:** Write a query that lists all Users and their total follower count. Order it from the most followed to the least.
3.  **Mutual Followers:** Write an advanced `INNER JOIN` query to find all "Mutual Follows" (User A follows User B, AND User B follows User A).
4.  **Viral Posts:** Identify any post that has more Likes than the User has Followers.

## Expected Learnings
*   Deep understanding of Self-Joins (Users following Users).
*   Pagination (`ORDER BY date DESC LIMIT 10`).
*   Complex multi-step filtering (News Feed generation).
