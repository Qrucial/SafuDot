// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

contract AntiVoronoiNFT {
    address public admin;
    uint256 public maxNFTs;
    uint256 public NFTCount;
    mapping (uint256 => string) internal idToHash;
    mapping (uint256 => address) internal idToOwner;
    uint256 public blockTime;
    
    constructor() {
        admin = msg.sender;
        maxNFTs = 99;
        NFTCount = 0;
        blockTime = block.timestamp;
    }
    
    function mint() external {
        require(msg.sender == admin, 'You are not the central admin!');
        require(blockTime <= block.timestamp + 3 days, 'Chill bro!');
        blockTime = block.timestamp;
        maxNFTs = maxNFTs + 1;
        idToOwner[NFTCount] = msg.sender;
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

    fallback() external payable {}
    receive() external payable {}
}
