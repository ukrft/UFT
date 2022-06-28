// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, ERC20Burnable, Pausable, Ownable {
    uint constant COST = 10000000000000000; // 0.01ETH
    uint public maxCoinsSupply = 1000;
    uint public totalCoinsSupply;

    constructor() ERC20("Coin MTK", "CMTK") {
        _mint(msg.sender, 500 * 10 ** decimals());
        totalCoinsSupply = 500;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public payable {
        require(msg.value >= (amount * COST), "");
        require(totalCoinsSupply + amount <= maxCoinsSupply, "");
        _mint(to, 500 * 10 ** decimals());
        totalCoinsSupply += amount;
    }

    function withdraw(address payable target) public onlyOwner {
      target.transfer(address(this).balance);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}
