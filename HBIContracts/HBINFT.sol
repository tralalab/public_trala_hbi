// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract HBINFT is ERC721URIStorage, ERC721Enumerable, Ownable {
    using Strings for uint256;

    string private _url;
    uint256 private _tokenId = 1;
    uint256 public _maxTokenId = 10000;

    event Mint(address indexed _to, uint indexed _tokenId);

    constructor(
        string memory url
    ) ERC721("Trala HeroBall Infinity NFT", "HBI") Ownable(_msgSender()) {
        _url = url;
    }

    function mint(address to) public onlyOwner {
        require(_tokenId <= _maxTokenId, "Minting is over.");
        _safeMint(to, _tokenId);
        _setTokenURI(_tokenId, getUrl(_tokenId));
        _tokenId++;
        emit Mint(to, _tokenId - 1);
    }

    function safeMultiMint(uint count) public onlyOwner {
        for (uint i = 0; i < count; i++) {
            require(_tokenId <= _maxTokenId, "Minting is over");
            _safeMint(msg.sender, _tokenId);
            _setTokenURI(_tokenId, getUrl(_tokenId));
            _tokenId++;
            emit Mint(msg.sender, _tokenId - 1);
        }
    }

    function getUrl(uint256 tokenId) internal view returns (string memory) {
        return string(abi.encodePacked(_url, tokenId.toString(), ".json"));
    }

    function _increaseBalance(
        address account,
        uint128 amount
    ) internal virtual override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, amount);
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal virtual override(ERC721, ERC721Enumerable) returns (address) {
        return ERC721Enumerable._update(to, tokenId, auth);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721Enumerable, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return ERC721URIStorage.tokenURI(tokenId);
    }
}
