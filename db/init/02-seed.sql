-- 02-seed.sql - starter rows so the page has something to show.
-- Only inserts if the table is empty, so re-running never
-- duplicates data.

USE ParksDb;
GO

IF NOT EXISTS (SELECT 1 FROM Parks)
BEGIN
    INSERT INTO Parks (Name, State, Established, Acres, Description) VALUES
        (N'Itasca State Park', N'MN', 1891, 32482,
         N'Minnesota''s oldest state park, where the Mississippi River begins its journey as a small stream.'),
        (N'Custer State Park', N'SD', 1912, 71000,
         N'Granite peaks and rolling grassland in the Black Hills, home to a famous herd of about 1,400 bison.'),
        (N'Humboldt Redwoods State Park', N'CA', 1921, 53000,
         N'Home to Rockefeller Forest, the largest remaining stand of old-growth coast redwoods on Earth.'),
        (N'Palo Duro Canyon State Park', N'TX', 1934, 29000,
         N'The second-largest canyon in the United States, carved 800 feet deep by a prairie river.'),
        (N'Myakka River State Park', N'FL', 1941, 37000,
         N'Wetlands, hammocks, and prairie along the wild and scenic Myakka River, with a CCC-built canopy walkway.'),
        (N'Porcupine Mountains Wilderness State Park', N'MI', 1945, 60000,
         N'Michigan''s largest state park: old-growth hemlock forest, Lake Superior shoreline, and the Lake of the Clouds.'),
        (N'Dead Horse Point State Park', N'UT', 1959, 5362,
         N'A narrow peninsula of rock 2,000 feet above the Colorado River with sweeping canyon-country views.');
END
GO
