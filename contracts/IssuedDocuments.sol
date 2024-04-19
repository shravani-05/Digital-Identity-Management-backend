// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IssuedDocuments {
    struct Document {
        string name;
        string ipfsHash;
    }

    mapping(address => Document[]) public userDocuments;

    event DocumentUploaded(address indexed user, string name, string ipfsHash);
    event DocumentUpdated(address indexed user, uint256 index, string newName);
    event DocumentDeleted(address indexed user, uint256 index);

    function uploadDocument(string memory _name, string memory _ipfsHash) public {
        userDocuments[msg.sender].push(Document({
            name: _name,
            ipfsHash: _ipfsHash
        }));
        emit DocumentUploaded(msg.sender, _name, _ipfsHash);
    }

    function updateDocument(uint256 _index, string memory _newName) public {
        require(_index < userDocuments[msg.sender].length, "Invalid document index");
        userDocuments[msg.sender][_index].name = _newName;
        emit DocumentUpdated(msg.sender, _index, _newName);
    }

    function deleteDocument(uint256 _index) public {
        require(_index < userDocuments[msg.sender].length, "Invalid document index");
        delete userDocuments[msg.sender][_index];
        emit DocumentDeleted(msg.sender, _index);
    }
}
