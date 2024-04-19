// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MyContract {
    struct User {
        string username;
        string email;
        bool signedUp;
    }

    mapping(address => User) public users;

    event UserSignedUp(address indexed userAddress, string username, string email);

    function signUp(string memory _username, string memory _email) public {
        require(!users[msg.sender].signedUp, "User already signed up");
        users[msg.sender] = User(_username, _email, true);
        emit UserSignedUp(msg.sender, _username, _email);
    }

    function getUser(address _userAddress) public view returns (string memory, string memory, bool) {
        return (users[_userAddress].username, users[_userAddress].email, users[_userAddress].signedUp);
    }
}