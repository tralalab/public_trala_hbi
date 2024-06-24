// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./HBIMysteryBox.sol";

contract HBIPayment is Ownable, ReentrancyGuard {
    event Buy(address indexed buyer);

    uint256 public constant MYSTERY_BOX_PRICE = 0.008 ether;
    address _boxAddress;

    constructor(address boxAddress) Ownable(_msgSender()) ReentrancyGuard() {
        _boxAddress = boxAddress;
    }

    function buy() external payable nonReentrant {
        require(msg.value == MYSTERY_BOX_PRICE, "Incorrect ETH amount sent");
        HBIMysteryBox mysteryBox = HBIMysteryBox(_boxAddress);

        (bool success, ) = owner().call{value: msg.value}("");
        require(success, "ETH transfer failed");
        mysteryBox.mint(msg.sender);

        emit Buy(msg.sender);
    }
}
