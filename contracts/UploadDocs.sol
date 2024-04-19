// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DocumentStorage {
    // Struct to represent a document
    struct Document {
        uint256 id;
        string name;
        string ipfsHash;
        uint256 folderId;
    }

    // Struct to represent a folder
    struct Folder {
        uint256 id;
        string name;
        uint256[] documentIds;
    }

    // Mapping of document ID to document
    mapping(uint256 => Document) public documents;

    // Mapping of folder ID to folder
    mapping(uint256 => Folder) public folders;

    // Counter for generating unique document IDs
    uint256 public documentCounter;

    // Counter for generating unique folder IDs
    uint256 public folderCounter;

    // Event emitted when a document is uploaded
    event DocumentUploaded(uint256 indexed documentId, string name, string ipfsHash, uint256 folderId);

    // Event emitted when a folder is created
    event FolderCreated(uint256 indexed folderId, string name);

    // Function to upload a document
    function uploadDocument(string memory _name, string memory _ipfsHash, uint256 _folderId) public {
        // Increment document counter
        documentCounter++;

        // Create new document
        Document memory newDocument = Document({
            id: documentCounter,
            name: _name,
            ipfsHash: _ipfsHash,
            folderId: _folderId
        });

        // Store document in mapping
        documents[documentCounter] = newDocument;

        // Add document ID to folder's document list
        folders[_folderId].documentIds.push(documentCounter);

        // Emit event
        emit DocumentUploaded(documentCounter, _name, _ipfsHash, _folderId);
    }

    // Function to create a folder
    function createFolder(string memory _name) public {
        // Increment folder counter
        folderCounter++;

        // Create new folder
        Folder memory newFolder = Folder({
            id: folderCounter,
            name: _name,
            documentIds: new uint256   // Initialize as an empty array
        });

        // Store folder in mapping
        folders[folderCounter] = newFolder;

        // Emit event
        emit FolderCreated(folderCounter, _name);
    }

    // Function to associate a document with a folder
    function associateDocumentWithFolder(uint256 _documentId, uint256 _folderId) public {
        // Check if document and folder exist
        require(documents[_documentId].id != 0, "Document does not exist");
        require(folders[_folderId].id != 0, "Folder does not exist");

        // Update document's folder ID
        documents[_documentId].folderId = _folderId;

        // Add document ID to folder's document list
        folders[_folderId].documentIds.push(_documentId);
    }
}
