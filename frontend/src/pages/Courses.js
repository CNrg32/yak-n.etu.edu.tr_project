import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Table } from 'react-bootstrap';
import { setCurrentUserId } from '../utils/userUtils';

const Courses = () => {
    const [courses, setCourses] = useState([]);

    useEffect(() => {
        const fetchCourses = async () => {
            try {
                const response = await axios.get(`${process.env.REACT_APP_API_URL}/courses`);
                setCourses(response.data);
            } catch (error) {
                console.error('Error fetching courses:', error);
            }
        };
        fetchCourses();
    }, []);

    return (
        <div className="container mt-5">
            <h1 className="mb-4">Courses</h1>
            <Table striped bordered hover>
                <thead>
                    <tr>
                        <th>Course Name</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    {courses.map(course => (
                        <tr key={course.course_id}>
                            <td>{course.course_name}</td>
                            <td>{course.course_description}</td>
                        </tr>
                    ))}
                </tbody>
            </Table>
        </div>
    );
};

export default Courses;
