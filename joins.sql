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


-- 3. Produce a list of all members who have recommended another member

SELECT DISTINCT
    mems.firstname,
    mems.surname
FROM cd.members mems
JOIN cd.members recs
    ON recs.recommendedby = mems.memid
ORDER BY mems.surname, mems.firstname;


-- 4. Produce a list of all members, along with their recommender

SELECT
    mems.firstname AS member_firstname,
    mems.surname AS member_surname,
    recs.firstname AS recommender_firstname,
    recs.surname AS recommender_surname
FROM cd.members mems
LEFT OUTER JOIN cd.members recs
    ON recs.memid = mems.recommendedby
ORDER BY mems.surname, mems.firstname;


-- 5. Produce a list of all members who have used a tennis court

SELECT DISTINCT
    mems.firstname || ' ' || mems.surname AS member,
    facs.name AS facility
FROM cd.members mems
JOIN cd.bookings bks
    ON mems.memid = bks.memid
JOIN cd.facilities facs
    ON bks.facid = facs.facid
WHERE facs.name IN ('Tennis Court 1', 'Tennis Court 2')
ORDER BY member, facility;


-- 6. Produce a list of costly bookings

SELECT
    mems.firstname || ' ' || mems.surname AS member,
    facs.name AS facility,
    CASE
        WHEN mems.memid = 0
            THEN bks.slots * facs.guestcost
        ELSE bks.slots * facs.membercost
    END AS cost
FROM cd.members mems
JOIN cd.bookings bks
    ON mems.memid = bks.memid
JOIN cd.facilities facs
    ON bks.facid = facs.facid
WHERE bks.starttime >= '2012-09-14'
  AND bks.starttime < '2012-09-15'
  AND (
        (mems.memid = 0 AND bks.slots * facs.guestcost > 30)
        OR
        (mems.memid <> 0 AND bks.slots * facs.membercost > 30)
      )
ORDER BY cost DESC;


-- 7. Produce a list of all members,
--    along with their recommender, using no joins

SELECT
    mems.firstname || ' ' || mems.surname AS member,
    (
        SELECT recs.firstname || ' ' || recs.surname
        FROM cd.members recs
        WHERE recs.memid = mems.recommendedby
    ) AS recommender
FROM cd.members mems
ORDER BY member;


-- 8. Produce a list of costly bookings, using a subquery

SELECT
    member,
    facility,
    cost
FROM (
    SELECT
        mems.firstname || ' ' || mems.surname AS member,
        facs.name AS facility,
        CASE
            WHEN mems.memid = 0
                THEN bks.slots * facs.guestcost
            ELSE bks.slots * facs.membercost
        END AS cost
    FROM cd.members mems
    JOIN cd.bookings bks
        ON mems.memid = bks.memid
    JOIN cd.facilities facs
        ON bks.facid = facs.facid
    WHERE bks.starttime >= '2012-09-14'
      AND bks.starttime < '2012-09-15'
) AS bookings
WHERE cost > 30
ORDER BY cost DESC;