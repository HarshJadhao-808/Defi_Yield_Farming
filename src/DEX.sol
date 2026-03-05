import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX {
   uint256 public reserveHC;
   uint256 public reserveYT;

    IERC20 public HC;
    IERC20 public YT;

    constructor(address _HC,address _YT){
       HC = IERC20(_HC);
       YT = IERC20(_YT);
    }

    function getAmount (uint256 amountIn,uint256 reserveIn,uint256 reserveOut) internal pure returns(uint256){
        uint256 amountOut= amountIn * reserveOut/reserveIn + amountIn;
        return amountOut;

    }

    function SwapYT(uint256 _YT) public {
        require(_YT > 0 ,"0 YT cannot be swapped");
        uint256 amountOut = getAmount(_YT, reserveYT, reserveHC);
        YT.transferFrom(address(this),msg.sender,amountOut);
        HC.transfer(msg.sender, amountOut);

    }
}