-- ============================================
-- Week 7 - SQL Joins Homework
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