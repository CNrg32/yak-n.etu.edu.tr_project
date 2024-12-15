import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './Home.css';
import { FaWallet, FaBook, FaList } from 'react-icons/fa';
import { getCurrentUserId } from '../utils/userUtils';

const Home = () => {
    const [userName, setUserName] = useState('');
    const [userBalance, setUserBalance] = useState(0);
    const [enrolledCourses, setEnrolledCourses] = useState(0);
    const [courseNames, setCourseNames] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    const navigate = useNavigate();

    useEffect(() => {
        const fetchData = async () => {
            const userId = getCurrentUserId();

            if (!userId) {
                setError('No user ID found. Redirecting to login...');
                setTimeout(() => navigate('/login'), 2000);
                return;
            }

            try {
                // Fetch user data and balance
                const [usersResponse, balanceResponse, enrollmentsResponse, coursesResponse] = await Promise.all([
                    axios.get(`${process.env.REACT_APP_API_URL}/users`),
                    axios.get(`${process.env.REACT_APP_API_URL}/student_cards`),
                    axios.get(`${process.env.REACT_APP_API_URL}/enrollments`),
                    axios.get(`${process.env.REACT_APP_API_URL}/courses`),
                ]);

                const user = usersResponse.data.find(user => user.user_id === parseInt(userId));
                setUserName(user ? user.name : 'User');

                const userCard = balanceResponse.data.find(card => card.user_id === parseInt(userId));
                setUserBalance(userCard ? parseFloat(userCard.balance) : 0);

                const userEnrollments = enrollmentsResponse.data.filter(enrollment => enrollment.user_id === parseInt(userId));
                setEnrolledCourses(userEnrollments.length);

                const courseIds = userEnrollments.map(enrollment => enrollment.course_id);
                const enrolledCourseNames = coursesResponse.data
                    .filter(course => courseIds.includes(course.course_id))
                    .map(course => course.course_name);
                setCourseNames(enrolledCourseNames);
            } catch (err) {
                console.error('Error fetching data:', err);
                setError('Failed to load data. Please try again.');
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, [navigate]);

    if (loading) {
        return <div className="loading">Loading...</div>;
    }

    if (error) {
        return <div className="error">{error}</div>;
    }

    return (
        <div className="home-container">
            <header className="header">
                <h1>Welcome, {userName}!</h1>
            </header>

            <main className="dashboard">
                <div className="info-cards">
                    <div className="info-card">
                        <FaWallet className="info-card-icon" />
                        <h3>Balance</h3>
                        <p>{userBalance.toFixed(2)} ₺</p>
                    </div>
                    <div className="info-card">
                        <FaBook className="info-card-icon" />
                        <h3>Enrolled Courses</h3>
                        <p>{enrolledCourses}</p>
                    </div>
                    <div className="info-card">
                        <FaList className="info-card-icon" />
                        <h3>Course Names</h3>
                        <ul>
                            {courseNames.map((courseName, index) => (
                                <li key={index}>{courseName}</li>
                            ))}
                        </ul>
                    </div>
                </div>

                <div className="quick-actions">
                    <h3>Quick Actions</h3>
                    <div className="actions-grid">
                        <button
                            className="action-button"
                            onClick={() => navigate('/student-cards/validate-payment-method')}
                        >
                            Add Money
                        </button>
                        <button
                            className="action-button"
                            onClick={() => navigate('/enrollments')}
                        >
                            View Syllabus
                        </button>
                        <button
                            className="action-button"
                            onClick={() => navigate('/empty-classrooms')}
                        >
                            View Empty Classrooms
                        </button>
                    </div>
                </div>
            </main>
        </div>
    );
};

export default Home;
