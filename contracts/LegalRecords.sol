// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LegalRecords {
    struct Record {
        string content; 
        address owner;
    }

    mapping(address => Record[]) private userRecords;

    event RecordAdded(address indexed user, string content);
    event RecordRetrieved(address indexed user, string content);

    function addLegalRecord(string memory content) public {
        require(bytes(content).length > 0, "Record content cannot be empty");

        Record memory newRecord = Record({
            content: content, 
            owner: msg.sender
        });

        userRecords[msg.sender].push(newRecord);

        emit RecordAdded(msg.sender, content);
    }

    function getLegalRecordsCount() public view returns (uint256) {
        return userRecords[msg.sender].length;
    }

    function getLegalRecord(uint256 index) public view returns (string memory) {
        require(index < userRecords[msg.sender].length, "Invalid record index");

        Record storage record = userRecords[msg.sender][index];
        emit RecordRetrieved(msg.sender, record.content);
        
        return record.content;
    }
}