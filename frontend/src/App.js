import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Layout from './components/Layout';
import Courses from './pages/Courses';
import Enrollments from './pages/Enrollments';
import ManageFriends from './pages/ManageFriends';
import StudentCards from './pages/StudentCards';
import Users from './pages/Users';
import Home from './pages/Home';
import Syllabus from './pages/Syllabus';
import DailyMenu from './pages/DailyMenu';
import EmptyClassrooms from './pages/EmptyClassrooms';
import ValidatePaymentMethod from './pages/ValidatePaymentMethod';
import Login from './pages/Login';
import SignUp from './pages/SignUp';

function App() {
    return (
        <Router>
            <Routes>
                {/* Routes without Navbar */}
                <Route
                    path="/login"
                    element={
                        <Layout hideNavbar={true}>
                            <Login />
                        </Layout>
                    }
                />
                <Route
                    path="/signup"
                    element={
                        <Layout hideNavbar={true}>
                            <SignUp />
                        </Layout>
                    }
                />

                {/* Routes with Navbar */}
                <Route
                    path="/"
                    element={
                        <Layout hideNavbar={false}>
                            <Home />
                        </Layout>
                    }
                />
                <Route
                    path="/courses"
                    element={
                        <Layout hideNavbar={false}>
                            <Courses />
                        </Layout>
                    }
                />
                <Route
                    path="/enrollments"
                    element={
                        <Layout hideNavbar={false}>
                            <Enrollments />
                        </Layout>
                    }
                />
                <Route
                    path="/manage-friends"
                    element={
                        <Layout hideNavbar={false}>
                            <ManageFriends />
                        </Layout>
                    }
                />
                <Route
                    path="/student-cards"
                    element={
                        <Layout hideNavbar={false}>
                            <StudentCards />
                        </Layout>
                    }
                />
                <Route
                    path="/student-cards/validate-payment-method"
                    element={
                        <Layout hideNavbar={false}>
                            <ValidatePaymentMethod />
                        </Layout>
                    }
                />
                <Route
                    path="/users"
                    element={
                        <Layout hideNavbar={false}>
                            <Users />
                        </Layout>
                    }
                />
                <Route
                    path="/daily-menu"
                    element={
                        <Layout hideNavbar={false}>
                            <DailyMenu />
                        </Layout>
                    }
                />
                <Route
                    path="/empty-classrooms"
                    element={
                        <Layout hideNavbar={false}>
                            <EmptyClassrooms />
                        </Layout>
                    }
                />
                <Route
                    path="/syllabus"
                    element={
                        <Layout hideNavbar={false}>
                            <Syllabus />
                        </Layout>
                    }
                />
                <Route path="*" element={<h1>404 - Page Not Found</h1>} />
            </Routes>
        </Router>
    );
}

export default App;
