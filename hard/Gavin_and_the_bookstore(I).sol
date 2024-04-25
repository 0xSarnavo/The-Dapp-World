// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Bookstore {
    address immutable owner;

    struct Book {
        string title;
        string author;
        string publication;
        bool available;
    }

    mapping (uint => Book) public books;
    uint public bookCount=1;

    constructor() {
        owner = msg.sender;
    }

    function addBook(string memory _title, string memory _author, string memory _publication) public {
        require(msg.sender == owner, "Only the owner can add books");
        require(bytes(_title).length != 0 && bytes(_author).length != 0 && bytes(_publication).length != 0, "Book details cannot be empty");
        books[bookCount++] = Book(_title, _author, _publication, true);
    }

    function removeBook(uint id) public {
        require(msg.sender == owner, "Only the owner can remove books");
        require(id>0 && id<=bookCount, "Enter a valid ID");
        books[id].available =false;
    }

    function updateDetails(uint _id, string memory _title, string memory _author, string memory _publication, bool _available) public {
        require(msg.sender == owner, "Only the owner can update details");
        require(_id < bookCount && bytes(_title).length != 0 && bytes(_author).length != 0 && bytes(_publication).length != 0, "Invalid book ID or empty details");
        books[_id] = Book(_title, _author, _publication, _available);
    }

    function findBookByTitle(string memory _title) public view returns (uint[] memory) {
        require(bytes(_title).length != 0, "Title cannot be empty");
        uint count;
        for (uint i = 0; i < bookCount; i++) {
            if (keccak256(bytes(books[i].title)) == keccak256(bytes(_title))) {
                count++;
            }
        }

        uint[] memory bookIds = new uint[](count);
        count = 0;
        if (msg.sender != owner){
            for (uint i = 0; i < bookCount; i++) {
            if (keccak256(bytes(books[i].title)) == keccak256(bytes(_title)) && books[i].available == true) {
                bookIds[count++] = i;
            }
        }
        }
        else if (msg.sender == owner) {
            for (uint i = 0; i < bookCount; i++) {
            if (keccak256(bytes(books[i].title)) == keccak256(bytes(_title))) {
                bookIds[count++] = i;
            }
        }
        }
        if (bookIds.length == 0){
            revert();
        }
        else 
        return bookIds;
        
    }

    function findAllBooksOfPublication(string memory _publication) public view returns (uint[] memory) {
        require(bytes(_publication).length != 0, "Publication cannot be empty");
        uint count;
        for (uint i = 0; i < bookCount; i++) {
            if (keccak256(bytes(books[i].publication)) == keccak256(bytes(_publication))) {
                count++;
            }
        }

        uint[] memory bookIds = new uint[](count);
        count = 0;
        if (msg.sender != owner){
            for (uint i = 0; i < bookCount; i++) {
            if (keccak256(bytes(books[i].publication)) == keccak256(bytes(_publication)) && books[i].available == true) {
                bookIds[count++] = i;
            }
        }
        }
        else if (msg.sender == owner) {
            for (uint i = 0; i < bookCount; i++) {
            if (keccak256(bytes(books[i].publication)) == keccak256(bytes(_publication))) {
                bookIds[count++] = i;
            }
        }
        }
        if (bookIds.length == 0){
            revert();
        }
        else 
        return bookIds;
    }

    function findAllBooksOfAuthor(string memory _author) public view returns (uint[] memory) {
        require(bytes(_author).length != 0, "Author cannot be empty");
        uint count;
        for (uint i = 0; i < bookCount; i++) {
            if (keccak256(bytes(books[i].author)) == keccak256(bytes(_author))) {
                count++;
            }
        }

        uint[] memory bookIds = new uint[](count);
        count = 0;
        if (msg.sender != owner){
            for (uint i = 0; i < bookCount; i++) {
            if (keccak256(bytes(books[i].author)) == keccak256(bytes(_author)) && books[i].available == true) {
                bookIds[count++] = i;
            }
        }
        }
        else if (msg.sender == owner) {
            for (uint i = 0; i < bookCount; i++) {
            if (keccak256(bytes(books[i].author)) == keccak256(bytes(_author))) {
                bookIds[count++] = i;
            }
        }
        }

        if (bookIds.length == 0){
            revert();
        }
        else 
        return bookIds;
    }

    function getDetailsById(uint id) public view returns (string memory, string memory, string memory, bool) {
        require(id < bookCount, "Invalid book ID");
        Book memory book = books[id];
        return (book.title, book.author, book.publication, book.available);
    }
}
