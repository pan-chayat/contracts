// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PanchNFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    string [] tokenURIs;
    address [] whitelisted;

    constructor(string memory Name, 
    string memory Symbol,
    string [] memory _tokenURIs,
    address payable [] memory _whitelisted
    ) 
    ERC721(Name, Symbol) {
        tokenURIs = _tokenURIs;
        whitelisted = _whitelisted;
    }

    function isEligible(address _address) public view returns(bool) {
        bool eligible = false;
        for(uint i; i<whitelisted.length; i++)
        {
            if(_address == whitelisted[i])
            {
                eligible = true;
            }
        }
        return eligible;
    }

    function getURIs() public view returns(string[] memory){
        return tokenURIs;
    }

    modifier onlyWhitelisted() {
        require(isEligible(msg.sender),"You are not whitelisted");
        _;
    }

    function safeMint(uint uriIndex) public onlyWhitelisted {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURIs[uriIndex]);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}