// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract HBIMysteryBox is ERC721Enumerable {
    uint256 private _tokenId;
    string private _tokenURI;

    mapping(address => bool) public _owners;

    event Mint(address indexed to, uint256 tokenId);

    constructor(string memory uri) ERC721("HBIMysteryBox", "HMB") {
        _owners[msg.sender] = true;
        _tokenURI = uri;
        _tokenId = 1;
    }

    function mint(address to) external onlyOwner {
        _mint(to, _tokenId);
        emit Mint(to, _tokenId);
        _tokenId++;
    }

    function tokenURI() public view returns (string memory) {
        return _tokenURI;
    }

    function addOwner(address to) external onlyOwner {
        _owners[to] = true;
    }

    function removeOwner(address to) external onlyOwner {
        _owners[to] = false;
    }

    modifier onlyOwner() {
        require(_owners[msg.sender], "Only owner can call this function");
        _;
    }
}
