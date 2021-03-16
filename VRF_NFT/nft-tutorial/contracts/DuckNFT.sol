// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol"; // 用于tokenId


contract DuckAsset is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(string => uint8) hashes;
    constructor() public ERC721("DuckAsset", "DCA") {
    }

    // hash是此NFT绑定的CID
    function awardItem(address recipient, string memory hash, string memory metadata) 
        public
        returns (uint256)
    {
        require(hashes[hash] != 1, "CID has been used before");
        hashes[hash] = 1;
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current(); // 获取当前可用的id
        _mint(recipient, newItemId); // 铸造新的代币，并将其发送给接收者
        _setTokenURI(newItemId, metadata); // 设置它绑定的元数据，即IPFS的CID
        return newItemId;
    }

}