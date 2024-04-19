// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SignUp {
    struct User {
        string username;
        uint256 dateOfBirth;
        string gender;
        string email;
        string contact;
        string passwordHashIpfsHash;
    }

    mapping(address => User) public users;

    event UserSignedUp(address indexed userAddress, string username);

    function signUp(
        string memory _username,
        uint256 _dateOfBirth,
        string memory _gender,
        string memory _email,
        string memory _contact,
        string memory _password,
        string memory _confirmPassword,
        string memory _passwordHashIpfsHash // IPFS hash of password hash
    ) public {
        require(bytes(_username).length > 0, "Username must not be empty");
        require(_dateOfBirth > 0, "Date of birth must be specified");
        require(bytes(_email).length > 0, "Email must not be empty");
        require(bytes(_password).length > 0, "Password must not be empty");
        require(keccak256(bytes(_password)) == keccak256(bytes(_confirmPassword)), "Passwords do not match");
        require(users[msg.sender].dateOfBirth == 0, "User already signed up");

        users[msg.sender] = User({
            username: _username,
            dateOfBirth: _dateOfBirth,
            gender: _gender,
            email: _email,
            contact: _contact,
            passwordHashIpfsHash: _passwordHashIpfsHash
        });

        emit UserSignedUp(msg.sender, _username);
    }

    function getUser(address _userAddress) public view returns (User memory) {
        return users[_userAddress];
    }
}
