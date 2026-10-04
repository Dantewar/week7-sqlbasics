-- ============================================
-- Week 7 - SQL Joins Homework
-- Country Club Relationships, JOINs & Subqueries
-- ============================================


-- ============================================
-- Skill 2: Country Club Relationships
-- ============================================


-- 1. Which columns in cd.bookings are foreign keys,
--    and which tables do they point to?
--
-- cd.bookings.memid points to cd.members.memid.
-- cd.bookings.facid points to cd.facilities.facid.


-- 2. What kind of relationship is there between
--    members and facilities?
--
-- Members and facilities have a many-to-many relationship.
-- One member can book many facilities,
-- and one facility can be booked by many members.
--
-- cd.bookings is the junction table that connects
-- cd.members and cd.facilities.


-- 3. The recommendedby column in cd.members points
--    back to cd.members itself. What kind of relationship is that?
--
-- This is a self-referencing relationship.
-- One member can recommend another member.
-- The recommendedby column contains the memid
-- of another row in the same cd.members table.


-- ============================================
-- Skill 3: Joins and Subqueries Exercises
-- ============================================


-- 1. Retrieve the start times of members' bookings

SELECT bks.starttime
FROM cd.bookings bks
JOIN cd.members mems
    ON mems.memid = bks.memid
WHERE mems.firstname = 'David'
  AND mems.surname = 'Farrell';


-- 2. Work out the start times of bookings for tennis courts

SELECT
    bks.starttime AS start,
    facs.name
FROM cd.facilities facs
JOIN cd.bookings bks
    ON facs.facid = bks.facid
WHERE facs.name IN ('Tennis Court 1', 'Tennis Court 2')
  AND bks.starttime >= '2012-09-21'
  AND bks.starttime < '2012-09-22'
ORDER BY bks.starttime;