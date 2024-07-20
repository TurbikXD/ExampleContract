# ExampleContract

This Solidity contract demonstrates the use of various Solidity features including variables, mappings, nested mappings, structs, dynamic arrays, and modifiers. The contract also includes functions to interact with these features. The contract is written in Solidity version 0.8.20.

## Features

### Variables
- `uint public uintVariable`
- `address public addressVariable`
- `bool public boolVariable`

### Constants and Immutables
- `uint public constant CONSTANT_VALUE = 100`
- `uint public immutable immutableValue`

### Mappings
- `mapping(address => uint) public simpleMapping`
- `mapping(address => mapping(uint => bool)) public nestedMapping`

### Structs
- `struct InnerStruct { uint value; bool flag; }`
- `struct OuterStruct { uint id; InnerStruct inner; }`

### Mapping with Structs
- `mapping(address => OuterStruct) public structMapping`

### Dynamic Arrays
- `uint[] public dynamicArray`

### Array of Structs
- `OuterStruct[] public structArray`

### Modifiers
- `modifier onlyOwner()`
- `modifier notZeroAddress(address _address)`

### Contract Owner
- `address public owner`

## Functions

### Constructor
```solidity
constructor(uint _immutableValue) {
    owner = msg.sender;
    immutableValue = _immutableValue;
}
```
The constructor initializes the contract with the immutable value and sets the contract deployer as the owner.

### 1. Change the contract owner's address with a check for zero address
```solidity
function changeOwner(address _newOwner) public onlyOwner notZeroAddress(_newOwner) {
    owner = _newOwner;
}
```
Changes the owner of the contract to _newOwner ensuring the new address is not zero.

### 2. Set immutable value in the constructor
Handled by the constructor.

### 3. Add a value to the dynamic array
```solidity
function addToArray(uint _value) public {
    dynamicArray.push(_value);
}
```
Adds _value to the end of the dynamic array.

### 4. Remove a value from the array and decrease its length
```solidity
function removeFromArray(uint _index) public {
    require(_index < dynamicArray.length, "Index out of bounds");
    for (uint i = _index; i < dynamicArray.length - 1; i++) {
        dynamicArray[i] = dynamicArray[i + 1];
    }
    dynamicArray.pop();
}
```
Removes the value at _index from the dynamic array, shifting subsequent values to fill the gap.

### 5. Add a value to the nested mapping
```solidity
function addToNestedMapping(address _addr, uint _key, bool _value) public {
    nestedMapping[_addr][_key] = _value;
}
```
Adds _value to the nested mapping at _addr and _key.

### 6. Remove a value from the nested mapping
```solidity
function removeFromNestedMapping(address _addr, uint _key) public {
    delete nestedMapping[_addr][_key];
}
```
Removes the value at _addr and _key from the nested mapping.

### 7. Add values to the struct mapping
```solidity
function addToStructMapping(address _addr, uint _id, uint _value, bool _flag) public {
    structMapping[_addr] = OuterStruct(_id, InnerStruct(_value, _flag));
}
```
Adds values to the struct mapping for _addr.

### 8. Add a value to the array of structures
```solidity
function addToStructArray(uint _id, uint _value, bool _flag) public {
    structArray.push(OuterStruct(_id, InnerStruct(_value, _flag)));
}
```
Adds a new OuterStruct to the array of structures.

### 9. Add an entry to the simple mapping indicating that the user received ether
```solidity
function receiveEther(address _addr, uint _amount) public {
    simpleMapping[_addr] += _amount;
}
```
Records that _addr received _amount ether in the simple mapping.

## License
This project is licensed under the MIT License.
