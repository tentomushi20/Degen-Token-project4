// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TentoToken is ERC20 {
    struct oneItem {
        uint value;
        string name;
    }
    oneItem[] public alloneItems;
    address owner;
    mapping(address => oneItem[]) public userReddem;

    constructor() ERC20("TENOTO", "TTO") {
        owner = msg.sender;
        alloneItems.push(oneItem(200, "NFT BATMAN"));
        alloneItems.push(oneItem(300, "NFT KALKI"));
        alloneItems.push(oneItem(100, "NFT JON"));
    }

    function mint(address toAddress, uint supply) public {
        require(msg.sender == owner, "Only Owner can mint the tokens");
        _mint(toAddress, supply);
    }

    function burn(uint supply) public {
        if (balanceOf(msg.sender) < supply) {
            revert("You don't have enough Tokens");
        }
        _burn(msg.sender, supply);
    }

    function getoneItem() public view returns (oneItem[] memory) {
        return alloneItems;
    }

    function getUserReddem() public view returns (oneItem[] memory) {
        return userReddem[msg.sender];
    }

    function nowReddem(uint index) public {
        require(index >= 0 && index < 3, "Please enter index in range 0 to 2");
        require(balanceOf(msg.sender) >= alloneItems[index].value, "You don't have enough Tokens");

        userReddem[msg.sender].push(alloneItems[index]);
        burn(alloneItems[index].value);
    }

    function transferTokens(address to, uint256 amount) public {
        require(amount <= balanceOf(msg.sender), "Not enough tokens");
        _transfer(msg.sender, to, amount);
    }
}
