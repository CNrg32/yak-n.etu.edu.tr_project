import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom'; // For quick action navigation
import axios from 'axios';
import './Home.css'; // Custom CSS for styling
import { FaWallet, FaBook, FaList } from 'react-icons/fa'; // Import Font Awesome icons

const Home = () => {
    const [userName, setUserName] = useState(''); // To store user[1].name
    const [userBalance, setUserBalance] = useState(0); // Balance for user 1
    const [enrolledCourses, setEnrolledCourses] = useState(0); // Number of enrolled courses for user 1
    const [courseNames, setCourseNames] = useState([]); // Names of the enrolled courses for user 1
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    const navigate = useNavigate();

    useEffect(() => {
        const fetchData = async () => {
            try {
                // Fetch user information for user 1
                const usersResponse = await axios.get(`${process.env.REACT_APP_API_URL}/users`);
                const user = usersResponse.data.find(user => user.user_id === 1);
                setUserName(user ? user.name : 'User');

                // Fetch balance for user 1 from student_cards
                const balanceResponse = await axios.get(`${process.env.REACT_APP_API_URL}/student_cards`);
                const userCard = balanceResponse.data.find(card => card.user_id === 1);
                setUserBalance(userCard ? parseFloat(userCard.balance) : 0);

                // Fetch enrolled courses for user 1
                const enrollmentsResponse = await axios.get(`${process.env.REACT_APP_API_URL}/enrollments`);
                const userEnrollments = enrollmentsResponse.data.filter(enrollment => enrollment.user_id === 1);
                setEnrolledCourses(userEnrollments.length);

                // Fetch course names for the enrolled courses
                const courseIds = userEnrollments.map(enrollment => enrollment.course_id);
                const coursesResponse = await axios.get(`${process.env.REACT_APP_API_URL}/courses`);
                const enrolledCourseNames = coursesResponse.data
                    .filter(course => courseIds.includes(course.course_id))
                    .map(course => course.course_name);

                setCourseNames(enrolledCourseNames);
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
