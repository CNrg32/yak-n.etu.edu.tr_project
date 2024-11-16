import React, { useEffect, useState } from 'react';
import axios from 'axios';

const Enrollments = () => {
    const [enrollments, setEnrollments] = useState([]);

    useEffect(() => {
        const fetchEnrollments = async () => {
            try {
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/enrollments`);
                setEnrollments(response.data);
            } catch (error) {
                console.error('Error fetching enrollments:', error);
            }
        };
        fetchEnrollments();
    }, []);

    return (
        <div>
            <h1>Enrollments</h1>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Course ID</th>
                    </tr>
                </thead>
                <tbody>
                    {enrollments.map(enrollment => (
                        <tr key={enrollment.enrollment_id}>
                            <td>{enrollment.user_id}</td>
                            <td>{enrollment.course_id}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default Enrollments;
