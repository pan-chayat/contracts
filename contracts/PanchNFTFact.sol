// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./PanchNFT.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
contract PanchNFTFact is ReentrancyGuard{
  uint _contractIdCounter;
  event PanchFactoryCreated(address creator, address collectionAddress);
  struct EventItem {
    address creator;
    string collectionName;
    string collectionSymbol;
    address collectionAddress;
    string[] tokenURIs;
    address payable [] whitelisted; 
  }
  event EventItemCreated (
    string collectionName,
    string collectionSymbol,
    address collectionAddress,
    string [] tokenURIs,
    address payable [] whitelisted
  );
  mapping(uint256 => EventItem) private idToEvent;
  
  function createNewPanch(
    string memory collectionName,
    string memory collectionSymbol,
    string [] memory _tokenURIs,
    address payable [] calldata _whitelisted
    ) public{
      PanchNFT newCollectionAddress = new PanchNFT(
        collectionName,
        collectionSymbol,
        _tokenURIs,
        _whitelisted
        );
      emit PanchFactoryCreated(msg.sender, address(newCollectionAddress));

    _contractIdCounter++;
    uint256 contractId = _contractIdCounter;
  
    idToEvent[contractId] =  EventItem(
        msg.sender,
        collectionName,
        collectionSymbol,
        address(newCollectionAddress),
        _tokenURIs,
        _whitelisted
    );
  }
}