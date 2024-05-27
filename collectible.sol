contract Collectible {
    address owner;
    uint price;
    event Deployed(address indexed);
    event Transfer(address indexed, address indexed);
    event ForSale(uint, uint);
    event Purchase(uint, address indexed);

    constructor() {
        owner = msg.sender;
        emit Deployed(owner);
    }

    function transfer(address newOwner) external {
        require(msg.sender == owner, "not the owner");
        owner = newOwner;
        emit Transfer(msg.sender, newOwner);
    }

    function markPrice(uint _price) external {
        require(msg.sender == owner, "not the owner");
        price = _price;
        emit ForSale(price, block.timestamp);
    }

    function purchase() external payable {
        require(price > 0, "not for sale");
        require(msg.value >= price, "cheaper price");
        (bool success, ) = owner.call{value: msg.value}("");
        require(success);
        owner = msg.sender;
        price = 0;
        emit Purchase(msg.value, msg.sender);
    }
}
