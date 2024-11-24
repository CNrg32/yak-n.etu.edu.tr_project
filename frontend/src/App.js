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

function App() {
    return (
        <Router>
            <Layout>
                <Routes>
                    <Route path="/" element={<Home />} />
                    <Route path="/courses" element={<Courses />} />
                    {/* <Route path="/syllabus" element={<Syllabus />} /> */}
                    <Route path="/daily-menu" element={<DailyMenu />} />
                    <Route path="/empty-classrooms" element={<EmptyClassrooms />} />
                    <Route path="/enrollments" element={<Enrollments />} />
                    <Route path="/manage-friends" element={<ManageFriends />} />
                    <Route path="/student-cards" element={<StudentCards />} />
                  <Route path="/student-cards/validate-payment-method" element={<ValidatePaymentMethod />} />
                    <Route path="/users" element={<Users />} />
                    <Route path="*" element={<h1>404 - Page Not Found</h1>} />
                </Routes>
            </Layout>
        </Router>
    );
}

export default App;
