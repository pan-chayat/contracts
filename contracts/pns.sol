// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract PNS {
    struct panchName {
        string registryName;
        string uri;
    }
    mapping(address => panchName) private addressToName;
    function createRegistry (string memory _registryname) public {
        addressToName[msg.sender].registryName = _registryname;
    }
    function createURI(string memory _uri) public {
        addressToName[msg.sender].uri = _uri;
    }
    function fetchPNS (address walletAddress) public view returns(string memory) {
        return (addressToName[walletAddress].registryName);
    }
    function fetchPNSwebsite(address walletAddress) public view returns(string memory) {
        return(addressToName[walletAddress].uri);
    }
}