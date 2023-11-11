-- Insert data into Users table
INSERT INTO Users (UserID, Username, Email) VALUES
(1, 'john_doe', 'john.doe@example.com'),
(2, 'jane_smith', 'jane.smith@example.com'),
(3, 'bob_johnson', 'bob.johnson@example.com');

-- Insert data into BlogPosts table
INSERT INTO BlogPosts (PostID, UserID, TITLE, CONTENT, Timestamp) VALUES
(101, 1, 'Introduction to SQL', 'This is a blog post about SQL.', '2023-01-01 12:00:00'),
(102, 2, 'Data Modeling Techniques', 'Exploring various data modeling approaches.', '2023-01-02 14:30:00'),
(103, 3, 'Building Scalable Systems', 'Tips for designing scalable systems.', '2023-01-03 10:45:00');

-- Insert data into Comments table
INSERT INTO Comments (CommentID, PostID, CommentName, CommentText, Timestamp) VALUES
(1001, 101, 'Alice', 'Great post!', '2023-01-01 12:30:00'),
(1002, 101, 'Bob', 'I learned a lot from this.', '2023-01-01 13:15:00'),
(1003, 102, 'Charlie', 'Looking forward to more content.', '2023-01-02 15:00:00'),
(1004, 103, 'Eva', 'Scalability is crucial for success.', '2023-01-03 11:30:00');
