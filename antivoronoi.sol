// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

contract AntiVoronoiNFT {
    address public admin;
    uint256 public maxNFTs;
    uint256 public NFTCount;
    uint256 public NFTPrice;
    mapping (uint256 => string) internal idToHash;
    mapping (uint256 => address) internal idToOwner;
    uint256 public blockTime;
    
    constructor() {
        admin = msg.sender;
        maxNFTs = 99;
        NFTCount = 0;
        NFTPrice = 10000000000000000;
        blockTime = block.timestamp;
    }
    
    function mint(string memory _hashu) external payable {
        require(msg.sender == admin, 'You are not the central admin!');
        require(blockTime <= block.timestamp + 3 days, 'Chill bro!');
        require(NFTCount <= 99, 'You shall not pass! All NFTz are minted!');
        require(msg.value >= NFTPrice, 'Where are da fundz?');
        blockTime = block.timestamp;
        NFTCount = NFTCount + 1;
        NFTPrice = NFTPrice * 2;
        idToOwner[NFTCount] = msg.sender;
        idToHash[NFTCount] = _hashu;
    }

    function transfer(uint256 _tokenId, address _toAddress) external {
        require(msg.sender == idToOwner[_tokenId], 'But it is not yours!');
        idToOwner[_tokenId] = _toAddress;
    }

    function adminWithdraw(uint256 _amount, address payable _safuTo) external {
        require(msg.sender == admin, 'You are not the central admin!');
        _safuTo.transfer(_amount);
    }

    function WhoGotchaThat(uint256 _whichOne) public view returns (address) {
        return(idToOwner[_whichOne]);
    }

    function WhatIsTheHash(uint256 _tokenId) public view returns (string memory){
        return(idToHash[_tokenId]);
    }

    function adminChange(address _newAdmin) external returns (bool) {
        require(blockTime <= block.timestamp + 66 minutes, 'Welcome to the game!');
        admin = _newAdmin;
        return true;
    }

    fallback() external payable {}
    receive() external payable {}
}
