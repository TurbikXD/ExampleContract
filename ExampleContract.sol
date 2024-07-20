// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ExampleContract {
    // Variables
    uint public uintVariable;
    address public addressVariable;
    bool public boolVariable;

    // Constant and immutable
    uint public constant CONSTANT_VALUE = 100;
    uint public immutable immutableValue;

    // Mapping
    mapping(address => uint) public simpleMapping;

    // Nested mapping
    mapping(address => mapping(uint => bool)) public nestedMapping;

    // Mapping with structure
    struct InnerStruct {
        uint value;
        bool flag;
    }
    
    struct OuterStruct {
        uint id;
        InnerStruct inner;
    }

    mapping(address => OuterStruct) public structMapping;

    // Dynamic array
    uint[] public dynamicArray;

    // Array of structures
    OuterStruct[] public structArray;

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier notZeroAddress(address _address) {
        require(_address != address(0), "Address is zero");
        _;
    }

    // Contract owner
    address public owner;

    // Constructor
    constructor(uint _immutableValue) {
        owner = msg.sender;
        immutableValue = _immutableValue;
    }

    // Functions

    // 1. Change the contract owner's address with a check for zero address
    function changeOwner(address _newOwner) public onlyOwner notZeroAddress(_newOwner) {
        owner = _newOwner;
    }

    // 3. Add a value to the dynamic array
    function addToArray(uint _value) public {
        dynamicArray.push(_value);
    }

    // 4. Remove a value from the array and decrease its length
    function removeFromArray(uint _index) public {
        require(_index < dynamicArray.length, "Index out of bounds");
        for (uint i = _index; i < dynamicArray.length - 1; i++) {
            dynamicArray[i] = dynamicArray[i + 1];
        }
        dynamicArray.pop();
    }

    // 5. Add a value to the nested mapping
    function addToNestedMapping(address _addr, uint _key, bool _value) public {
        nestedMapping[_addr][_key] = _value;
    }

    // 6. Remove a value from the nested mapping
    function removeFromNestedMapping(address _addr, uint _key) public {
        delete nestedMapping[_addr][_key];
    }

    // 7. Add values to the struct mapping
    function addToStructMapping(address _addr, uint _id, uint _value, bool _flag) public {
        structMapping[_addr] = OuterStruct(_id, InnerStruct(_value, _flag));
    }

    // 8. Add a value to the array of structures
    function addToStructArray(uint _id, uint _value, bool _flag) public {
        structArray.push(OuterStruct(_id, InnerStruct(_value, _flag)));
    }

    // 9. Add an entry to the simple mapping indicating that the user received ether
    function receiveEther(address _addr, uint _amount) public {
        simpleMapping[_addr] += _amount;
    }
}
