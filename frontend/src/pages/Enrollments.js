import React, { useEffect, useState } from 'react';
import axios from 'axios';
import './Syllabus.css'; // Reuse the CSS file for styling

const Enrollments = () => {
    const [schedule, setSchedule] = useState([]); // Weekly schedule
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    const timeSlots = ['08:00', '10:00', '12:00', '14:00', '16:00']; // Time slots

    useEffect(() => {
        const fetchData = async () => {
            try {
                // Fetch enrollments for user_id = 1
                const enrollmentsResponse = await axios.get(`${process.env.REACT_APP_API_URL}/enrollments`);
                const userEnrollments = enrollmentsResponse.data.filter(enrollment => enrollment.user_id === 1);

                console.log('User Enrollments:', userEnrollments); // Debug log

                // Get course IDs for user 1
                const courseIds = userEnrollments.map(enrollment => enrollment.course_id);

                console.log('Course IDs:', courseIds); // Debug log

                // Fetch all courses
                const coursesResponse = await axios.get(`${process.env.REACT_APP_API_URL}/courses`);
                const courses = coursesResponse.data.filter(course => courseIds.includes(course.course_id));

                console.log('Filtered Courses:', courses); // Debug log

                // Create a blank schedule
                const blankSchedule = timeSlots.map(time => ({
                    time,
                    lessons: days.reduce((acc, day) => ({ ...acc, [day]: '' }), {})
                }));

                // Assign courses to schedule based on their days and times
                courses.forEach(course => {
                    const courseDays = course.days.split(','); // Split the days into an array
                    const courseTimes = course.times.split(','); // Split the times into an array

                    courseDays.forEach((day, index) => {
                        const time = courseTimes[index]; // Match day and time
                        const rowIndex = timeSlots.indexOf(time); // Find the row index for the time slot
                        if (rowIndex !== -1) {
                            blankSchedule[rowIndex].lessons[day] = course.course_name;
                        }
                    });
                });

                setSchedule(blankSchedule);
            } catch (err) {
                setError('Error fetching data.');
                console.error(err);
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    if (loading) {
        return <div>Loading...</div>;
    }

    if (error) {
        return <div>{error}</div>;
    }

    return (
        <div className="syllabus-container">
            <div className="syllabus-header">
                <h1>Syllabus</h1>
            </div>
            <table className="syllabus-table">
                <thead>
                    <tr>
                        <th>Time</th>
                        {days.map(day => (
                            <th key={day}>{day}</th>
                        ))}
                    </tr>
                </thead>
                <tbody>
                    {schedule.map((slot, rowIndex) => (
                        <tr key={rowIndex}>
                            <td className="time-cell">{slot.time}</td>
                            {days.map((day, colIndex) => (
                                <td key={colIndex} className={`lesson-cell color-${(rowIndex + colIndex) % 5}`}>
                                    <div className="lesson-name">{slot.lessons[day]}</div>
                                </td>
                            ))}
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default Enrollments;
