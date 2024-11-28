import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Login.css'; // Optional CSS for styling

const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [isButtonDisabled, setIsButtonDisabled] = useState(true);

    const navigate = useNavigate(); // Initialize the navigate function

    const handleEmailChange = (e) => {
        setEmail(e.target.value);
        checkFormValidity(e.target.value, password);
    };

    const handlePasswordChange = (e) => {
        setPassword(e.target.value);
        checkFormValidity(email, e.target.value);
    };

    const checkFormValidity = (email, password) => {
        if (email.trim() && password.trim()) {
            setIsButtonDisabled(false);
        } else {
            setIsButtonDisabled(true);
        }
    };

    const handleLogin = (e) => {
        e.preventDefault();
        console.log('Login successful with email:', email);

        // Simulate login logic
        const isAuthenticated = true; // Replace with real authentication logic
        if (isAuthenticated) {
            navigate('/'); // Redirect to the home page
        } else {
            alert('Invalid login credentials');
        }
    };

    const handleSignUpRedirect = () => {
        navigate('/signup'); // Redirect to the sign-up page
    };

    return (
        <div className="login-container">
            <h1>Welcome Back</h1>
            <form className="login-form" onSubmit={handleLogin}>
                <input
                    type="email"
                    placeholder="Email Address"
                    value={email}
                    onChange={handleEmailChange}
                    required
                />
                <input
                    type="password"
                    placeholder="Password"
                    value={password}
                    onChange={handlePasswordChange}
                    required
                />
                <button type="submit" disabled={isButtonDisabled}>
                    Login
                </button>
            </form>
            <p>
                Don’t have an account?{' '}
                <button type="button" onClick={handleSignUpRedirect} className="signup-button">
                    Sign Up
                </button>
            </p>
        </div>
    );
};

export default Login;
