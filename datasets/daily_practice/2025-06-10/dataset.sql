CREATE DATABASE IF NOT EXISTS feedback_analysis_20250610_schema;
USE feedback_analysis_20250610_schema;

CREATE TABLE feedback (
    feedback_id INT,
    feedback_text TEXT,
    source_channel VARCHAR(50),
    comment_category VARCHAR(50)
);

INSERT INTO feedback (feedback_id, feedback_text, source_channel, comment_category) VALUES
(1, 'Great service, but the app crashes occasionally.', 'email', 'mid_length_comments'),
(2, 'Loved the friendly staff and quick response. Highly recommended.', 'survey', 'mid_length_comments'),
(3, 'Difficult to navigate the website, and customer support is slow.', 'email', 'mid_length_comments'),
(4, 'Fantastic experience with the new update!', 'email', 'mid_length_comments'),
(5, 'The app is good, but it lacks some features.', 'email', 'mid_length_comments'),
(6, 'Not satisfied with the service. It needs improvement.', 'email', 'mid_length_comments'),
(7, 'Amazing staff, very helpful and caring.', 'survey', 'short_comments'),
(8, 'The website could be more user-friendly.', 'email', 'short_comments'),
(9, 'Had some issues with billing, but they were resolved quickly.', 'social_media', 'mid_length_comments'),
(10, 'Good, but not great. The app needs more updates.', 'email', 'mid_length_comments'),
(11, 'Excellent service and prompt response.', 'social_media', 'short_comments'),
(12, 'User-friendly website and great customer support.', 'email', 'mid_length_comments'),
(13, 'I like the app, but it can be improved.', 'email', 'short_comments'),
(14, 'The new update made the app even better!', 'social_media', 'short_comments'),
(15, 'Terrible experience, the app crashes all the time.', 'social_media', 'mid_length_comments'),
(16, 'Staff is not very helpful, and the service is slow.', 'social_media', 'mid_length_comments'),
(17, 'Website navigation needs improvement.', 'survey', 'short_comments'),
(18, 'The app lacks essential features.', 'survey', 'short_comments'),
(19, 'I had a remarkable experience with the service. The staff was incredibly helpful and the response time was quick. Highly recommended for anyone looking for reliable support.', 'email', 'long_comments'),
(20, 'Navigating the website was challenging, and the customer support response time was slower than expected. Improvements in these areas would greatly enhance the user experience.', 'social_media', 'long_comments'),
(21, 'The latest app update has brought significant improvements. The user interface is now more intuitive, and I have encountered fewer issues. Keep up the good work!', 'email', 'long_comments'),
(22, 'While the app has some positive aspects, it lacks certain essential features that would greatly enhance its functionality. I hope to see these improvements in future updates.', 'survey', 'long_comments'),
(23, 'My experience with the service was less than satisfactory. The frequent app crashes were frustrating and need urgent attention. I also found the staff to be unhelpful and the service slow.', 'survey', 'long_comments'),
(24, 'The website layout could use some improvement to make it more user-friendly. Additionally, there are several missing features in the app that need to be addressed for a better user experience.', 'survey', 'long_comments'),
(25, 'App crashes frequently, needs fixing.', 'survey', 'short_comments'),
(26, 'Friendly staff but slow response time.', 'social_media', 'short_comments'),
(27, 'Website navigation is confusing.', 'survey', 'short_comments'),
(28, 'The app is missing critical features.', 'email', 'short_comments'),
(29, 'Service could be better, not fully satisfied.', 'social_media', 'mid_length_comments'),
(30, 'Great support from the staff.', 'social_media', 'short_comments');