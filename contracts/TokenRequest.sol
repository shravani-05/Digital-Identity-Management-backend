// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenRequest {
    struct Token {
        uint256 documentId;
        string token;
    }

    mapping(address => Token[]) public userTokens;

    event TokenRequested(address indexed user, uint256 documentId, string token);

    // Function to request token for a document
    function requestToken(uint256[] memory _documentIds) public {
        for (uint256 i = 0; i < _documentIds.length; i++) {
            // Simulate fetching token from backend
            string memory token = fetchTokenFromBackend(_documentIds[i]);

            // Add token to user's tokens
            userTokens[msg.sender].push(Token({
                documentId: _documentIds[i],
                token: token
            }));

            // Emit event
            emit TokenRequested(msg.sender, _documentIds[i], token);
        }
    }

    // Function to fetch token from backend (simulated)
    function fetchTokenFromBackend(uint256 _documentId) internal pure returns (string memory) {
        // Simulated token generation
        return string(abi.encodePacked("TokenForDocument", toString(_documentId)));
    }

    // Function to convert uint to string (helper function)
    function toString(uint256 value) internal pure returns (string memory) {
        // Convert uint to string
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
